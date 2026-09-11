using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到玩家实体ID(实体类型ID)(逻辑)", 0)]
[Category("Logic/PosAndRot")]
[Description("得到传入值对应的实体ID,遍历处理房间内的玩家（AI也算）,如果则按照顺序取第一个, 只处理活着的实体")]
public class GetEntityIDByRoleIDInRoom : FlowControlNodeOfLogic
{
	private int _ret;

	protected override void RegisterPorts()
	{
		ValueInput<int> roleID = AddValueInput<int>("实体类型ID", "roleID");
		FlowOutput output = AddFlowOutput("找到", "output");
		FlowOutput noneOut = AddFlowOutput("没找到", "none");
		AddFlowInput("In", delegate(Flow f)
		{
			_ret = 0;
			Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
			while (enumerator.MoveNext())
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(enumerator.Current.Value.mEntityID);
				if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard && entityWithEntityID.entityBlackboard.var.mHP > 0 && entityWithEntityID.hasEntityConfig && entityWithEntityID.entityConfig.mId == roleID.value)
				{
					_ret = entityWithEntityID.creationIndex;
					break;
				}
			}
			if (_ret != 0)
			{
				output.Call(f);
			}
			else
			{
				noneOut.Call(f);
			}
		});
		AddValueOutput("实体ID", () => _ret);
	}
}
