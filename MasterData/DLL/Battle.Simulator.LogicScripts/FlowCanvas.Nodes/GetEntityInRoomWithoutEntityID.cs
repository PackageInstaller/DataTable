using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历处理房间内的玩家(排除ID)", 0)]
[Category("Logic/PosAndRot")]
[Description("遍历处理房间内的玩家, AI也算, 只处理活着的实体啊")]
public class GetEntityInRoomWithoutEntityID : FlowNode
{
	private ValueInput<int> _WithoutEntityIDInput;

	protected override void RegisterPorts()
	{
		_WithoutEntityIDInput = AddValueInput<int>("排除实体ID", "withoutID").SetDefaultAndSerializedValue(-1);
		int res = 0;
		AddValueOutput("实体ID", () => res);
		ValueInput<bool> includeHpZoreInput = AddValueInput<bool>("包含血量为0的实体");
		FlowOutput doOut = AddFlowOutput("Do");
		FlowOutput doneOut = AddFlowOutput("Done");
		AddFlowInput("", delegate(Flow f)
		{
			int value = _WithoutEntityIDInput.GetValue();
			Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
			while (enumerator.MoveNext())
			{
				res = enumerator.Current.Value.mEntityID;
				if (res != value)
				{
					SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(res);
					if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard && (entityWithEntityID.entityBlackboard.var.mHP > 0 || includeHpZoreInput.value))
					{
						f.Call(doOut);
					}
				}
			}
			f.Call(doneOut);
		});
	}
}
