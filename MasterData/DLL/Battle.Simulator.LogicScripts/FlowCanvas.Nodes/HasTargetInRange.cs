using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断范围内是否存在玩家方角色", 0)]
[Category("Logic/PosAndRot")]
[Description("判断实体间距离，不考虑多碰撞盒的情况")]
public class HasTargetInRange : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> rangeInput = AddValueInput<int>("范围");
		ValueInput<HitHeight> heightInput = AddValueInput<HitHeight>("覆盖的高度标签").SetDefaultAndSerializedValue((HitHeight)(-1));
		FlowOutput trueOut = AddFlowOutput("存在");
		FlowOutput falseOut = AddFlowOutput("不存在");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOut.Call(f);
			}
			else
			{
				Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
				bool flag = false;
				while (enumerator.MoveNext())
				{
					int mEntityID = enumerator.Current.Value.mEntityID;
					if (mEntityID != entityWithEntityID.creationIndex)
					{
						SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(mEntityID);
						if (entityWithEntityID2 != null && entityWithEntityID2.hasEntityBlackboard && entityWithEntityID2.entityBlackboard.var.mHP > 0)
						{
							long num = MovementProcessor.SqrDistance(entityWithEntityID, entityWithEntityID2);
							int value = rangeInput.value;
							if (num <= value * value)
							{
								HitHeight curHitHeight = ConfigProcessor.GetCurHitHeight(entityWithEntityID2);
								if (curHitHeight == HitHeight.None || heightInput.value.HasFlag(curHitHeight))
								{
									flag = true;
									break;
								}
							}
						}
					}
				}
				if (flag)
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
		});
	}
}
