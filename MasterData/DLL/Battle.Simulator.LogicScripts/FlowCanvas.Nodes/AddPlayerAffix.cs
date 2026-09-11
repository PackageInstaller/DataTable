using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("添加玩家方词缀", 0)]
[Category("Logic/Trigger")]
[Description("添加玩家方词缀")]
public class AddPlayerAffix : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int value = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
			if (entityWithEntityID != null && RoleCampProcessor.IsPlayer(entityWithEntityID.entityCamp.mRoleTypeCamp))
			{
				Dictionary<MemberPosition, RemoteMember> mRoomMembers = CommonProcessor.GetWorldState().mRoomMembers;
				List<GlobalAffix> mGlobalAffixes = CommonProcessor.GetWorldState().mGlobalAffixes;
				for (int i = 0; i < mGlobalAffixes.Count; i++)
				{
					if (entityWithEntityID.entityBlackboard.var.enemyType == mGlobalAffixes[i].targetLevel)
					{
						if (base.mSimContext.GetSimInterface().mAddAffixEvent != null)
						{
							base.mSimContext.GetSimInterface().mAddAffixEvent(value, mGlobalAffixes[i].affixTypeID, mGlobalAffixes[i].affixLevel);
						}
					}
					else if (mGlobalAffixes[i].targetLevel - 4 >= EnemyType.MonsterNormal)
					{
						MemberPosition key = (MemberPosition)(mGlobalAffixes[i].targetLevel - 4);
						if (mRoomMembers[key].mEntityID == value && base.mSimContext.GetSimInterface().mAddAffixEvent != null)
						{
							base.mSimContext.GetSimInterface().mAddAffixEvent(value, mGlobalAffixes[i].affixTypeID, mGlobalAffixes[i].affixLevel);
						}
					}
				}
			}
			output.Call(f);
		});
	}
}
