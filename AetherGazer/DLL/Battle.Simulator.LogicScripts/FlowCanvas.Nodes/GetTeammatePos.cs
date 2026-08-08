using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取队友序号", 0)]
[Category("Logic/Spawn")]
[Description("获取队友序号")]
public class GetTeammatePos : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		int res = 0;
		AddValueOutput("站位", () => res);
		FlowOutput trueOut = AddFlowOutput("True");
		FlowOutput falseOut = AddFlowOutput("Flase");
		AddFlowInput("", delegate(Flow f)
		{
			Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
			while (enumerator.MoveNext())
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(enumerator.Current.Value.mEntityID);
				if (entityWithEntityID != null && entityWithEntityID.entityBlackboard.var.mHP > 0 && enumerator.Current.Value.mEntityID == entityIDInput.value)
				{
					res = (int)enumerator.Current.Value.mEntityPosition;
					f.Call(trueOut);
					return;
				}
			}
			f.Call(falseOut);
		});
	}
}
