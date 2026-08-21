using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI队友判断是否需要回复", 0)]
[Category("Logic/AI")]
[Description("判断是否需要回复, 填的两个是黑板变量名")]
public class AIJudgeIsNeedRecover : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		ValueInput<int> hpThresholdInput = AddValueInput<int>("血量阈值");
		ValueInput<int> needRecoverNameInput = AddValueInput<int>("是否有人需要回复(变量名)");
		ValueInput<int> needRecoverEntityIDNameInput = AddValueInput<int>("需要回复的实体ID(变量名)");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int value = needRecoverNameInput.value;
			int value2 = needRecoverEntityIDNameInput.value;
			entityID = entityIDInput.value;
			int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(entityID);
			AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, value, out var baseValue, out var _, out var _);
			bool flag = baseValue == 1;
			if (!flag)
			{
				int value3 = hpThresholdInput.value;
				int num = 0;
				Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
				while (enumerator.MoveNext())
				{
					SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(enumerator.Current.Value.mEntityID);
					if (entityWithEntityID != null && entityWithEntityID.hasEntityCamp && RoleCampProcessor.IsPlayer(entityWithEntityID.entityCamp.mRoleTypeCamp) && entityWithEntityID.hasEntityBlackboard && entityWithEntityID.entityBlackboard.var.mHP * 100 / entityWithEntityID.entityBlackboard.var.mMaxHP < value3)
					{
						num = enumerator.Current.Value.mEntityID;
						flag = true;
						if (!entityWithEntityID.hasEntityAIThink)
						{
							break;
						}
					}
				}
				if (flag)
				{
					AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, value, 1L, 0L, 0L);
					AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, value2, num, 0L, 0L);
				}
			}
			f.Call(output);
		});
	}
}
