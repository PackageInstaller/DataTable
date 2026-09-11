using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取队长实体ID(pure)", 0)]
[Category("Logic/PosAndRot")]
[Description("队长是房间的房主，单机情况下就是操作者;\n没有或者死亡的时候返回0;\n变身后取变身后的那个entityID")]
public class GetLeaderEntityID : PureFunctionNode<int>
{
	public override int Invoke()
	{
		Dictionary<MemberPosition, RemoteMember> mRoomMembers = CommonProcessor.GetWorldState().mRoomMembers;
		RemoteMember value = null;
		if (mRoomMembers.TryGetValue(MemberPosition.First, out value))
		{
			return value.mEntityID;
		}
		return 0;
	}
}
