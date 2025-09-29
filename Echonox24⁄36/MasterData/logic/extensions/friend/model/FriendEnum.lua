-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/model/FriendEnum.lua

module("logic.extensions.friend.model.FriendEnum", package.seeall)

local FriendEnum = {}

FriendEnum.Relation2Event = {
	[GameEnum.RelationTypeEnum.Friend] = EventType.UPDATE_FRIEND_LIST,
	[GameEnum.RelationTypeEnum.BeApply] = EventType.UPDATE_FRIEND_APPLY_LIST,
	[GameEnum.RelationTypeEnum.Block] = EventType.UPDATE_BLACKLIST_LIST
}
FriendEnum.OnLineStatus = {
	OffLine = 2,
	OnLine = 1
}

return FriendEnum
