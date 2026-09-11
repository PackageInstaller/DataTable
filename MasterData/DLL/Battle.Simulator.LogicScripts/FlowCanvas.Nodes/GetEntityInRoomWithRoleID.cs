using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历处理房间内的玩家(实体类型ID)(逻辑)", 0)]
[Category("Logic/PosAndRot")]
[Description("遍历处理房间内的玩家, AI也算, 只处理活着的实体啊")]
public class GetEntityInRoomWithRoleID : FlowControlNodeOfLogic
{
	private int _ret;

	protected override void RegisterPorts()
	{
		ValueInput<int> roleID = AddValueInput<int>("实体类型ID", "roleID");
		FlowOutput doOut = AddFlowOutput("Do");
		FlowOutput doneOut = AddFlowOutput("Done");
		AddFlowInput("", delegate(Flow f)
		{
			Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
			while (enumerator.MoveNext())
			{
				_ret = 0;
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(enumerator.Current.Value.mEntityID);
				if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard && entityWithEntityID.entityBlackboard.var.mHP > 0 && entityWithEntityID.hasEntityConfig && entityWithEntityID.entityConfig.mId == roleID.value)
				{
					_ret = entityWithEntityID.creationIndex;
					f.Call(doOut);
				}
			}
			_ret = 0;
			f.Call(doneOut);
		});
		AddValueOutput("实体ID", () => _ret);
	}
}
