using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取可锁定玩家方ID", 0)]
[Category("Logic/AI")]
[Description("找打可以锁定的玩家方ID，如果都不可以被锁定，则返回一号位")]
public class GetPlayerIDOfCanLock : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("实体ID", delegate
		{
			int num = 0;
			Dictionary<MemberPosition, RemoteMember> mRoomMembers = CommonProcessor.GetWorldState().mRoomMembers;
			Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = mRoomMembers.GetEnumerator();
			while (enumerator.MoveNext())
			{
				int mEntityID = enumerator.Current.Value.mEntityID;
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(mEntityID);
				if (entityWithEntityID != null && entityWithEntityID.hasEntityCamp && RoleCampProcessor.IsPlayer(entityWithEntityID.entityCamp.mRoleTypeCamp) && AIProcessor.CanLockOfEntity(entityWithEntityID))
				{
					num = mEntityID;
					break;
				}
			}
			if (num == 0)
			{
				RemoteMember value = null;
				if (mRoomMembers.TryGetValue(MemberPosition.First, out value))
				{
					num = value.mEntityID;
				}
			}
			return num;
		});
	}
}
