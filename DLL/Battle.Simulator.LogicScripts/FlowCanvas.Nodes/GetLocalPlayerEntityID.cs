using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取本地玩家实体ID(pure)", 0)]
[Category("Logic/PosAndRot")]
[Description("单机情况下就是操作者;\n没有或者死亡的时候返回0;\n变身后取变身后的那个entityID")]
public class GetLocalPlayerEntityID : PureFunctionNode<int>
{
	public override int Invoke()
	{
		int num = CommonProcessor.GetWorldState().mLocalPlayerID;
		if (num == 0)
		{
			Dictionary<MemberPosition, RemoteMember> mRoomMembers = CommonProcessor.GetWorldState().mRoomMembers;
			RemoteMember value = null;
			if (mRoomMembers.TryGetValue(MemberPosition.First, out value))
			{
				num = value.mEntityID;
			}
		}
		return num;
	}
}
