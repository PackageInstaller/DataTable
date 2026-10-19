using Google.Protobuf.Reflection;

namespace Pb;

public enum FriendOperation
{
	[OriginalName("ADD_FRIEND")]
	AddFriend,
	[OriginalName("DELETE_FRIEND")]
	DeleteFriend
}
