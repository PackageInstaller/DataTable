-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/FriendExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.FriendExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.RefuseApplyRequest = protobuf.Descriptor()
field_descriptors.RefuseApplyRequest_userId = protobuf.FieldDescriptor()
type_descriptors.ApplyFriendReply = protobuf.Descriptor()
field_descriptors.ApplyFriendReply_userId = protobuf.FieldDescriptor()
type_descriptors.RefuseApplyReply = protobuf.Descriptor()
field_descriptors.RefuseApplyReply_userId = protobuf.FieldDescriptor()
type_descriptors.FeedbackPicture = protobuf.Descriptor()
field_descriptors.FeedbackPicture_name = protobuf.FieldDescriptor()
field_descriptors.FeedbackPicture_data = protobuf.FieldDescriptor()
type_descriptors.GetUserListReply = protobuf.Descriptor()
field_descriptors.GetUserListReply_type = protobuf.FieldDescriptor()
field_descriptors.GetUserListReply_user = protobuf.FieldDescriptor()
type_descriptors.SearchUserRequest = protobuf.Descriptor()
field_descriptors.SearchUserRequest_keyword = protobuf.FieldDescriptor()
field_descriptors.SearchUserRequest_pageIndex = protobuf.FieldDescriptor()
type_descriptors.AgreeApplyReply = protobuf.Descriptor()
field_descriptors.AgreeApplyReply_result = protobuf.FieldDescriptor()
type_descriptors.ChangeAliasReply = protobuf.Descriptor()
field_descriptors.ChangeAliasReply_userId = protobuf.FieldDescriptor()
field_descriptors.ChangeAliasReply_alias = protobuf.FieldDescriptor()
type_descriptors.ApplyFriendRequest = protobuf.Descriptor()
field_descriptors.ApplyFriendRequest_userId = protobuf.FieldDescriptor()
type_descriptors.PlayerMetaNO = protobuf.Descriptor()
field_descriptors.PlayerMetaNO_userId = protobuf.FieldDescriptor()
field_descriptors.PlayerMetaNO_nickname = protobuf.FieldDescriptor()
field_descriptors.PlayerMetaNO_lv = protobuf.FieldDescriptor()
field_descriptors.PlayerMetaNO_portrait = protobuf.FieldDescriptor()
field_descriptors.PlayerMetaNO_displayCard = protobuf.FieldDescriptor()
field_descriptors.PlayerMetaNO_lastLoginTime = protobuf.FieldDescriptor()
field_descriptors.PlayerMetaNO_alias = protobuf.FieldDescriptor()
field_descriptors.PlayerMetaNO_sign = protobuf.FieldDescriptor()
field_descriptors.PlayerMetaNO_beApplyTime = protobuf.FieldDescriptor()
field_descriptors.PlayerMetaNO_applied = protobuf.FieldDescriptor()
type_descriptors.RemoveFriendReply = protobuf.Descriptor()
field_descriptors.RemoveFriendReply_userId = protobuf.FieldDescriptor()
type_descriptors.ReportUserReply = protobuf.Descriptor()
field_descriptors.ReportUserReply_userId = protobuf.FieldDescriptor()
type_descriptors.GetUserListRequest = protobuf.Descriptor()
field_descriptors.GetUserListRequest_type = protobuf.FieldDescriptor()
type_descriptors.ReportUserRequest = protobuf.Descriptor()
field_descriptors.ReportUserRequest_userId = protobuf.FieldDescriptor()
field_descriptors.ReportUserRequest_reportType = protobuf.FieldDescriptor()
field_descriptors.ReportUserRequest_cause = protobuf.FieldDescriptor()
field_descriptors.ReportUserRequest_content = protobuf.FieldDescriptor()
type_descriptors.SearchUserReply = protobuf.Descriptor()
field_descriptors.SearchUserReply_user = protobuf.FieldDescriptor()
type_descriptors.BlockUserRequest = protobuf.Descriptor()
field_descriptors.BlockUserRequest_userId = protobuf.FieldDescriptor()
type_descriptors.UnBlockUserReply = protobuf.Descriptor()
field_descriptors.UnBlockUserReply_userId = protobuf.FieldDescriptor()
type_descriptors.FeedbackReply = protobuf.Descriptor()
type_descriptors.AgreeResultNO = protobuf.Descriptor()
field_descriptors.AgreeResultNO_userId = protobuf.FieldDescriptor()
field_descriptors.AgreeResultNO_result = protobuf.FieldDescriptor()
type_descriptors.ChangeAliasRequest = protobuf.Descriptor()
field_descriptors.ChangeAliasRequest_userId = protobuf.FieldDescriptor()
field_descriptors.ChangeAliasRequest_alias = protobuf.FieldDescriptor()
type_descriptors.AgreeApplyRequest = protobuf.Descriptor()
field_descriptors.AgreeApplyRequest_userId = protobuf.FieldDescriptor()
type_descriptors.FeedbackRequest = protobuf.Descriptor()
field_descriptors.FeedbackRequest_type = protobuf.FieldDescriptor()
field_descriptors.FeedbackRequest_title = protobuf.FieldDescriptor()
field_descriptors.FeedbackRequest_content = protobuf.FieldDescriptor()
field_descriptors.FeedbackRequest_picture = protobuf.FieldDescriptor()
type_descriptors.UnBlockUserRequest = protobuf.Descriptor()
field_descriptors.UnBlockUserRequest_userId = protobuf.FieldDescriptor()
type_descriptors.UserListUpdatePush = protobuf.Descriptor()
field_descriptors.UserListUpdatePush_type = protobuf.FieldDescriptor()
field_descriptors.UserListUpdatePush_user = protobuf.FieldDescriptor()
type_descriptors.BlockUserReply = protobuf.Descriptor()
field_descriptors.BlockUserReply_userId = protobuf.FieldDescriptor()
type_descriptors.RemoveFriendRequest = protobuf.Descriptor()
field_descriptors.RemoveFriendRequest_userId = protobuf.FieldDescriptor()
field_descriptors.RefuseApplyRequest_userId.name = "userId"
field_descriptors.RefuseApplyRequest_userId.full_name = ".RefuseApplyRequest.userId"
field_descriptors.RefuseApplyRequest_userId.number = 1
field_descriptors.RefuseApplyRequest_userId.index = 0
field_descriptors.RefuseApplyRequest_userId.label = 3
field_descriptors.RefuseApplyRequest_userId.has_default_value = false
field_descriptors.RefuseApplyRequest_userId.default_value = {}
field_descriptors.RefuseApplyRequest_userId.type = 3
field_descriptors.RefuseApplyRequest_userId.cpp_type = 2
type_descriptors.RefuseApplyRequest.name = "RefuseApplyRequest"
type_descriptors.RefuseApplyRequest.full_name = ".RefuseApplyRequest"
type_descriptors.RefuseApplyRequest.nested_types = {}
type_descriptors.RefuseApplyRequest.enum_types = {}
type_descriptors.RefuseApplyRequest.fields = {
	field_descriptors.RefuseApplyRequest_userId
}
type_descriptors.RefuseApplyRequest.is_extendable = false
type_descriptors.RefuseApplyRequest.extensions = {}
field_descriptors.ApplyFriendReply_userId.name = "userId"
field_descriptors.ApplyFriendReply_userId.full_name = ".ApplyFriendReply.userId"
field_descriptors.ApplyFriendReply_userId.number = 1
field_descriptors.ApplyFriendReply_userId.index = 0
field_descriptors.ApplyFriendReply_userId.label = 2
field_descriptors.ApplyFriendReply_userId.has_default_value = false
field_descriptors.ApplyFriendReply_userId.default_value = 0
field_descriptors.ApplyFriendReply_userId.type = 3
field_descriptors.ApplyFriendReply_userId.cpp_type = 2
type_descriptors.ApplyFriendReply.name = "ApplyFriendReply"
type_descriptors.ApplyFriendReply.full_name = ".ApplyFriendReply"
type_descriptors.ApplyFriendReply.nested_types = {}
type_descriptors.ApplyFriendReply.enum_types = {}
type_descriptors.ApplyFriendReply.fields = {
	field_descriptors.ApplyFriendReply_userId
}
type_descriptors.ApplyFriendReply.is_extendable = false
type_descriptors.ApplyFriendReply.extensions = {}
field_descriptors.RefuseApplyReply_userId.name = "userId"
field_descriptors.RefuseApplyReply_userId.full_name = ".RefuseApplyReply.userId"
field_descriptors.RefuseApplyReply_userId.number = 1
field_descriptors.RefuseApplyReply_userId.index = 0
field_descriptors.RefuseApplyReply_userId.label = 3
field_descriptors.RefuseApplyReply_userId.has_default_value = false
field_descriptors.RefuseApplyReply_userId.default_value = {}
field_descriptors.RefuseApplyReply_userId.type = 3
field_descriptors.RefuseApplyReply_userId.cpp_type = 2
type_descriptors.RefuseApplyReply.name = "RefuseApplyReply"
type_descriptors.RefuseApplyReply.full_name = ".RefuseApplyReply"
type_descriptors.RefuseApplyReply.nested_types = {}
type_descriptors.RefuseApplyReply.enum_types = {}
type_descriptors.RefuseApplyReply.fields = {
	field_descriptors.RefuseApplyReply_userId
}
type_descriptors.RefuseApplyReply.is_extendable = false
type_descriptors.RefuseApplyReply.extensions = {}
field_descriptors.FeedbackPicture_name.name = "name"
field_descriptors.FeedbackPicture_name.full_name = ".FeedbackPicture.name"
field_descriptors.FeedbackPicture_name.number = 1
field_descriptors.FeedbackPicture_name.index = 0
field_descriptors.FeedbackPicture_name.label = 2
field_descriptors.FeedbackPicture_name.has_default_value = false
field_descriptors.FeedbackPicture_name.default_value = ""
field_descriptors.FeedbackPicture_name.type = 9
field_descriptors.FeedbackPicture_name.cpp_type = 9
field_descriptors.FeedbackPicture_data.name = "data"
field_descriptors.FeedbackPicture_data.full_name = ".FeedbackPicture.data"
field_descriptors.FeedbackPicture_data.number = 2
field_descriptors.FeedbackPicture_data.index = 1
field_descriptors.FeedbackPicture_data.label = 2
field_descriptors.FeedbackPicture_data.has_default_value = false
field_descriptors.FeedbackPicture_data.default_value = ""
field_descriptors.FeedbackPicture_data.type = 12
field_descriptors.FeedbackPicture_data.cpp_type = 9
type_descriptors.FeedbackPicture.name = "FeedbackPicture"
type_descriptors.FeedbackPicture.full_name = ".FeedbackPicture"
type_descriptors.FeedbackPicture.nested_types = {}
type_descriptors.FeedbackPicture.enum_types = {}
type_descriptors.FeedbackPicture.fields = {
	field_descriptors.FeedbackPicture_name,
	field_descriptors.FeedbackPicture_data
}
type_descriptors.FeedbackPicture.is_extendable = false
type_descriptors.FeedbackPicture.extensions = {}
field_descriptors.GetUserListReply_type.name = "type"
field_descriptors.GetUserListReply_type.full_name = ".GetUserListReply.type"
field_descriptors.GetUserListReply_type.number = 1
field_descriptors.GetUserListReply_type.index = 0
field_descriptors.GetUserListReply_type.label = 2
field_descriptors.GetUserListReply_type.has_default_value = false
field_descriptors.GetUserListReply_type.default_value = 0
field_descriptors.GetUserListReply_type.type = 5
field_descriptors.GetUserListReply_type.cpp_type = 1
field_descriptors.GetUserListReply_user.name = "user"
field_descriptors.GetUserListReply_user.full_name = ".GetUserListReply.user"
field_descriptors.GetUserListReply_user.number = 2
field_descriptors.GetUserListReply_user.index = 1
field_descriptors.GetUserListReply_user.label = 3
field_descriptors.GetUserListReply_user.has_default_value = false
field_descriptors.GetUserListReply_user.default_value = {}
field_descriptors.GetUserListReply_user.message_type = type_descriptors.PlayerMetaNO
field_descriptors.GetUserListReply_user.type = 11
field_descriptors.GetUserListReply_user.cpp_type = 10
type_descriptors.GetUserListReply.name = "GetUserListReply"
type_descriptors.GetUserListReply.full_name = ".GetUserListReply"
type_descriptors.GetUserListReply.nested_types = {}
type_descriptors.GetUserListReply.enum_types = {}
type_descriptors.GetUserListReply.fields = {
	field_descriptors.GetUserListReply_type,
	field_descriptors.GetUserListReply_user
}
type_descriptors.GetUserListReply.is_extendable = false
type_descriptors.GetUserListReply.extensions = {}
field_descriptors.SearchUserRequest_keyword.name = "keyword"
field_descriptors.SearchUserRequest_keyword.full_name = ".SearchUserRequest.keyword"
field_descriptors.SearchUserRequest_keyword.number = 1
field_descriptors.SearchUserRequest_keyword.index = 0
field_descriptors.SearchUserRequest_keyword.label = 2
field_descriptors.SearchUserRequest_keyword.has_default_value = false
field_descriptors.SearchUserRequest_keyword.default_value = ""
field_descriptors.SearchUserRequest_keyword.type = 9
field_descriptors.SearchUserRequest_keyword.cpp_type = 9
field_descriptors.SearchUserRequest_pageIndex.name = "pageIndex"
field_descriptors.SearchUserRequest_pageIndex.full_name = ".SearchUserRequest.pageIndex"
field_descriptors.SearchUserRequest_pageIndex.number = 2
field_descriptors.SearchUserRequest_pageIndex.index = 1
field_descriptors.SearchUserRequest_pageIndex.label = 2
field_descriptors.SearchUserRequest_pageIndex.has_default_value = false
field_descriptors.SearchUserRequest_pageIndex.default_value = 0
field_descriptors.SearchUserRequest_pageIndex.type = 5
field_descriptors.SearchUserRequest_pageIndex.cpp_type = 1
type_descriptors.SearchUserRequest.name = "SearchUserRequest"
type_descriptors.SearchUserRequest.full_name = ".SearchUserRequest"
type_descriptors.SearchUserRequest.nested_types = {}
type_descriptors.SearchUserRequest.enum_types = {}
type_descriptors.SearchUserRequest.fields = {
	field_descriptors.SearchUserRequest_keyword,
	field_descriptors.SearchUserRequest_pageIndex
}
type_descriptors.SearchUserRequest.is_extendable = false
type_descriptors.SearchUserRequest.extensions = {}
field_descriptors.AgreeApplyReply_result.name = "result"
field_descriptors.AgreeApplyReply_result.full_name = ".AgreeApplyReply.result"
field_descriptors.AgreeApplyReply_result.number = 1
field_descriptors.AgreeApplyReply_result.index = 0
field_descriptors.AgreeApplyReply_result.label = 3
field_descriptors.AgreeApplyReply_result.has_default_value = false
field_descriptors.AgreeApplyReply_result.default_value = {}
field_descriptors.AgreeApplyReply_result.message_type = type_descriptors.AgreeResultNO
field_descriptors.AgreeApplyReply_result.type = 11
field_descriptors.AgreeApplyReply_result.cpp_type = 10
type_descriptors.AgreeApplyReply.name = "AgreeApplyReply"
type_descriptors.AgreeApplyReply.full_name = ".AgreeApplyReply"
type_descriptors.AgreeApplyReply.nested_types = {}
type_descriptors.AgreeApplyReply.enum_types = {}
type_descriptors.AgreeApplyReply.fields = {
	field_descriptors.AgreeApplyReply_result
}
type_descriptors.AgreeApplyReply.is_extendable = false
type_descriptors.AgreeApplyReply.extensions = {}
field_descriptors.ChangeAliasReply_userId.name = "userId"
field_descriptors.ChangeAliasReply_userId.full_name = ".ChangeAliasReply.userId"
field_descriptors.ChangeAliasReply_userId.number = 1
field_descriptors.ChangeAliasReply_userId.index = 0
field_descriptors.ChangeAliasReply_userId.label = 2
field_descriptors.ChangeAliasReply_userId.has_default_value = false
field_descriptors.ChangeAliasReply_userId.default_value = 0
field_descriptors.ChangeAliasReply_userId.type = 3
field_descriptors.ChangeAliasReply_userId.cpp_type = 2
field_descriptors.ChangeAliasReply_alias.name = "alias"
field_descriptors.ChangeAliasReply_alias.full_name = ".ChangeAliasReply.alias"
field_descriptors.ChangeAliasReply_alias.number = 2
field_descriptors.ChangeAliasReply_alias.index = 1
field_descriptors.ChangeAliasReply_alias.label = 1
field_descriptors.ChangeAliasReply_alias.has_default_value = false
field_descriptors.ChangeAliasReply_alias.default_value = ""
field_descriptors.ChangeAliasReply_alias.type = 9
field_descriptors.ChangeAliasReply_alias.cpp_type = 9
type_descriptors.ChangeAliasReply.name = "ChangeAliasReply"
type_descriptors.ChangeAliasReply.full_name = ".ChangeAliasReply"
type_descriptors.ChangeAliasReply.nested_types = {}
type_descriptors.ChangeAliasReply.enum_types = {}
type_descriptors.ChangeAliasReply.fields = {
	field_descriptors.ChangeAliasReply_userId,
	field_descriptors.ChangeAliasReply_alias
}
type_descriptors.ChangeAliasReply.is_extendable = false
type_descriptors.ChangeAliasReply.extensions = {}
field_descriptors.ApplyFriendRequest_userId.name = "userId"
field_descriptors.ApplyFriendRequest_userId.full_name = ".ApplyFriendRequest.userId"
field_descriptors.ApplyFriendRequest_userId.number = 1
field_descriptors.ApplyFriendRequest_userId.index = 0
field_descriptors.ApplyFriendRequest_userId.label = 2
field_descriptors.ApplyFriendRequest_userId.has_default_value = false
field_descriptors.ApplyFriendRequest_userId.default_value = 0
field_descriptors.ApplyFriendRequest_userId.type = 3
field_descriptors.ApplyFriendRequest_userId.cpp_type = 2
type_descriptors.ApplyFriendRequest.name = "ApplyFriendRequest"
type_descriptors.ApplyFriendRequest.full_name = ".ApplyFriendRequest"
type_descriptors.ApplyFriendRequest.nested_types = {}
type_descriptors.ApplyFriendRequest.enum_types = {}
type_descriptors.ApplyFriendRequest.fields = {
	field_descriptors.ApplyFriendRequest_userId
}
type_descriptors.ApplyFriendRequest.is_extendable = false
type_descriptors.ApplyFriendRequest.extensions = {}
field_descriptors.PlayerMetaNO_userId.name = "userId"
field_descriptors.PlayerMetaNO_userId.full_name = ".PlayerMetaNO.userId"
field_descriptors.PlayerMetaNO_userId.number = 1
field_descriptors.PlayerMetaNO_userId.index = 0
field_descriptors.PlayerMetaNO_userId.label = 2
field_descriptors.PlayerMetaNO_userId.has_default_value = false
field_descriptors.PlayerMetaNO_userId.default_value = 0
field_descriptors.PlayerMetaNO_userId.type = 3
field_descriptors.PlayerMetaNO_userId.cpp_type = 2
field_descriptors.PlayerMetaNO_nickname.name = "nickname"
field_descriptors.PlayerMetaNO_nickname.full_name = ".PlayerMetaNO.nickname"
field_descriptors.PlayerMetaNO_nickname.number = 2
field_descriptors.PlayerMetaNO_nickname.index = 1
field_descriptors.PlayerMetaNO_nickname.label = 2
field_descriptors.PlayerMetaNO_nickname.has_default_value = false
field_descriptors.PlayerMetaNO_nickname.default_value = ""
field_descriptors.PlayerMetaNO_nickname.type = 9
field_descriptors.PlayerMetaNO_nickname.cpp_type = 9
field_descriptors.PlayerMetaNO_lv.name = "lv"
field_descriptors.PlayerMetaNO_lv.full_name = ".PlayerMetaNO.lv"
field_descriptors.PlayerMetaNO_lv.number = 3
field_descriptors.PlayerMetaNO_lv.index = 2
field_descriptors.PlayerMetaNO_lv.label = 2
field_descriptors.PlayerMetaNO_lv.has_default_value = false
field_descriptors.PlayerMetaNO_lv.default_value = 0
field_descriptors.PlayerMetaNO_lv.type = 5
field_descriptors.PlayerMetaNO_lv.cpp_type = 1
field_descriptors.PlayerMetaNO_portrait.name = "portrait"
field_descriptors.PlayerMetaNO_portrait.full_name = ".PlayerMetaNO.portrait"
field_descriptors.PlayerMetaNO_portrait.number = 4
field_descriptors.PlayerMetaNO_portrait.index = 3
field_descriptors.PlayerMetaNO_portrait.label = 2
field_descriptors.PlayerMetaNO_portrait.has_default_value = false
field_descriptors.PlayerMetaNO_portrait.default_value = 0
field_descriptors.PlayerMetaNO_portrait.type = 5
field_descriptors.PlayerMetaNO_portrait.cpp_type = 1
field_descriptors.PlayerMetaNO_displayCard.name = "displayCard"
field_descriptors.PlayerMetaNO_displayCard.full_name = ".PlayerMetaNO.displayCard"
field_descriptors.PlayerMetaNO_displayCard.number = 5
field_descriptors.PlayerMetaNO_displayCard.index = 4
field_descriptors.PlayerMetaNO_displayCard.label = 3
field_descriptors.PlayerMetaNO_displayCard.has_default_value = false
field_descriptors.PlayerMetaNO_displayCard.default_value = {}
field_descriptors.PlayerMetaNO_displayCard.type = 5
field_descriptors.PlayerMetaNO_displayCard.cpp_type = 1
field_descriptors.PlayerMetaNO_lastLoginTime.name = "lastLoginTime"
field_descriptors.PlayerMetaNO_lastLoginTime.full_name = ".PlayerMetaNO.lastLoginTime"
field_descriptors.PlayerMetaNO_lastLoginTime.number = 6
field_descriptors.PlayerMetaNO_lastLoginTime.index = 5
field_descriptors.PlayerMetaNO_lastLoginTime.label = 2
field_descriptors.PlayerMetaNO_lastLoginTime.has_default_value = false
field_descriptors.PlayerMetaNO_lastLoginTime.default_value = 0
field_descriptors.PlayerMetaNO_lastLoginTime.type = 3
field_descriptors.PlayerMetaNO_lastLoginTime.cpp_type = 2
field_descriptors.PlayerMetaNO_alias.name = "alias"
field_descriptors.PlayerMetaNO_alias.full_name = ".PlayerMetaNO.alias"
field_descriptors.PlayerMetaNO_alias.number = 7
field_descriptors.PlayerMetaNO_alias.index = 6
field_descriptors.PlayerMetaNO_alias.label = 1
field_descriptors.PlayerMetaNO_alias.has_default_value = false
field_descriptors.PlayerMetaNO_alias.default_value = ""
field_descriptors.PlayerMetaNO_alias.type = 9
field_descriptors.PlayerMetaNO_alias.cpp_type = 9
field_descriptors.PlayerMetaNO_sign.name = "sign"
field_descriptors.PlayerMetaNO_sign.full_name = ".PlayerMetaNO.sign"
field_descriptors.PlayerMetaNO_sign.number = 8
field_descriptors.PlayerMetaNO_sign.index = 7
field_descriptors.PlayerMetaNO_sign.label = 1
field_descriptors.PlayerMetaNO_sign.has_default_value = false
field_descriptors.PlayerMetaNO_sign.default_value = ""
field_descriptors.PlayerMetaNO_sign.type = 9
field_descriptors.PlayerMetaNO_sign.cpp_type = 9
field_descriptors.PlayerMetaNO_beApplyTime.name = "beApplyTime"
field_descriptors.PlayerMetaNO_beApplyTime.full_name = ".PlayerMetaNO.beApplyTime"
field_descriptors.PlayerMetaNO_beApplyTime.number = 9
field_descriptors.PlayerMetaNO_beApplyTime.index = 8
field_descriptors.PlayerMetaNO_beApplyTime.label = 1
field_descriptors.PlayerMetaNO_beApplyTime.has_default_value = false
field_descriptors.PlayerMetaNO_beApplyTime.default_value = 0
field_descriptors.PlayerMetaNO_beApplyTime.type = 3
field_descriptors.PlayerMetaNO_beApplyTime.cpp_type = 2
field_descriptors.PlayerMetaNO_applied.name = "applied"
field_descriptors.PlayerMetaNO_applied.full_name = ".PlayerMetaNO.applied"
field_descriptors.PlayerMetaNO_applied.number = 10
field_descriptors.PlayerMetaNO_applied.index = 9
field_descriptors.PlayerMetaNO_applied.label = 1
field_descriptors.PlayerMetaNO_applied.has_default_value = false
field_descriptors.PlayerMetaNO_applied.default_value = false
field_descriptors.PlayerMetaNO_applied.type = 8
field_descriptors.PlayerMetaNO_applied.cpp_type = 7
type_descriptors.PlayerMetaNO.name = "PlayerMetaNO"
type_descriptors.PlayerMetaNO.full_name = ".PlayerMetaNO"
type_descriptors.PlayerMetaNO.nested_types = {}
type_descriptors.PlayerMetaNO.enum_types = {}
type_descriptors.PlayerMetaNO.fields = {
	field_descriptors.PlayerMetaNO_userId,
	field_descriptors.PlayerMetaNO_nickname,
	field_descriptors.PlayerMetaNO_lv,
	field_descriptors.PlayerMetaNO_portrait,
	field_descriptors.PlayerMetaNO_displayCard,
	field_descriptors.PlayerMetaNO_lastLoginTime,
	field_descriptors.PlayerMetaNO_alias,
	field_descriptors.PlayerMetaNO_sign,
	field_descriptors.PlayerMetaNO_beApplyTime,
	field_descriptors.PlayerMetaNO_applied
}
type_descriptors.PlayerMetaNO.is_extendable = false
type_descriptors.PlayerMetaNO.extensions = {}
field_descriptors.RemoveFriendReply_userId.name = "userId"
field_descriptors.RemoveFriendReply_userId.full_name = ".RemoveFriendReply.userId"
field_descriptors.RemoveFriendReply_userId.number = 1
field_descriptors.RemoveFriendReply_userId.index = 0
field_descriptors.RemoveFriendReply_userId.label = 2
field_descriptors.RemoveFriendReply_userId.has_default_value = false
field_descriptors.RemoveFriendReply_userId.default_value = 0
field_descriptors.RemoveFriendReply_userId.type = 3
field_descriptors.RemoveFriendReply_userId.cpp_type = 2
type_descriptors.RemoveFriendReply.name = "RemoveFriendReply"
type_descriptors.RemoveFriendReply.full_name = ".RemoveFriendReply"
type_descriptors.RemoveFriendReply.nested_types = {}
type_descriptors.RemoveFriendReply.enum_types = {}
type_descriptors.RemoveFriendReply.fields = {
	field_descriptors.RemoveFriendReply_userId
}
type_descriptors.RemoveFriendReply.is_extendable = false
type_descriptors.RemoveFriendReply.extensions = {}
field_descriptors.ReportUserReply_userId.name = "userId"
field_descriptors.ReportUserReply_userId.full_name = ".ReportUserReply.userId"
field_descriptors.ReportUserReply_userId.number = 1
field_descriptors.ReportUserReply_userId.index = 0
field_descriptors.ReportUserReply_userId.label = 2
field_descriptors.ReportUserReply_userId.has_default_value = false
field_descriptors.ReportUserReply_userId.default_value = 0
field_descriptors.ReportUserReply_userId.type = 3
field_descriptors.ReportUserReply_userId.cpp_type = 2
type_descriptors.ReportUserReply.name = "ReportUserReply"
type_descriptors.ReportUserReply.full_name = ".ReportUserReply"
type_descriptors.ReportUserReply.nested_types = {}
type_descriptors.ReportUserReply.enum_types = {}
type_descriptors.ReportUserReply.fields = {
	field_descriptors.ReportUserReply_userId
}
type_descriptors.ReportUserReply.is_extendable = false
type_descriptors.ReportUserReply.extensions = {}
field_descriptors.GetUserListRequest_type.name = "type"
field_descriptors.GetUserListRequest_type.full_name = ".GetUserListRequest.type"
field_descriptors.GetUserListRequest_type.number = 1
field_descriptors.GetUserListRequest_type.index = 0
field_descriptors.GetUserListRequest_type.label = 2
field_descriptors.GetUserListRequest_type.has_default_value = false
field_descriptors.GetUserListRequest_type.default_value = 0
field_descriptors.GetUserListRequest_type.type = 5
field_descriptors.GetUserListRequest_type.cpp_type = 1
type_descriptors.GetUserListRequest.name = "GetUserListRequest"
type_descriptors.GetUserListRequest.full_name = ".GetUserListRequest"
type_descriptors.GetUserListRequest.nested_types = {}
type_descriptors.GetUserListRequest.enum_types = {}
type_descriptors.GetUserListRequest.fields = {
	field_descriptors.GetUserListRequest_type
}
type_descriptors.GetUserListRequest.is_extendable = false
type_descriptors.GetUserListRequest.extensions = {}
field_descriptors.ReportUserRequest_userId.name = "userId"
field_descriptors.ReportUserRequest_userId.full_name = ".ReportUserRequest.userId"
field_descriptors.ReportUserRequest_userId.number = 1
field_descriptors.ReportUserRequest_userId.index = 0
field_descriptors.ReportUserRequest_userId.label = 2
field_descriptors.ReportUserRequest_userId.has_default_value = false
field_descriptors.ReportUserRequest_userId.default_value = 0
field_descriptors.ReportUserRequest_userId.type = 3
field_descriptors.ReportUserRequest_userId.cpp_type = 2
field_descriptors.ReportUserRequest_reportType.name = "reportType"
field_descriptors.ReportUserRequest_reportType.full_name = ".ReportUserRequest.reportType"
field_descriptors.ReportUserRequest_reportType.number = 2
field_descriptors.ReportUserRequest_reportType.index = 1
field_descriptors.ReportUserRequest_reportType.label = 2
field_descriptors.ReportUserRequest_reportType.has_default_value = false
field_descriptors.ReportUserRequest_reportType.default_value = 0
field_descriptors.ReportUserRequest_reportType.type = 5
field_descriptors.ReportUserRequest_reportType.cpp_type = 1
field_descriptors.ReportUserRequest_cause.name = "cause"
field_descriptors.ReportUserRequest_cause.full_name = ".ReportUserRequest.cause"
field_descriptors.ReportUserRequest_cause.number = 3
field_descriptors.ReportUserRequest_cause.index = 2
field_descriptors.ReportUserRequest_cause.label = 1
field_descriptors.ReportUserRequest_cause.has_default_value = false
field_descriptors.ReportUserRequest_cause.default_value = ""
field_descriptors.ReportUserRequest_cause.type = 9
field_descriptors.ReportUserRequest_cause.cpp_type = 9
field_descriptors.ReportUserRequest_content.name = "content"
field_descriptors.ReportUserRequest_content.full_name = ".ReportUserRequest.content"
field_descriptors.ReportUserRequest_content.number = 4
field_descriptors.ReportUserRequest_content.index = 3
field_descriptors.ReportUserRequest_content.label = 1
field_descriptors.ReportUserRequest_content.has_default_value = false
field_descriptors.ReportUserRequest_content.default_value = ""
field_descriptors.ReportUserRequest_content.type = 9
field_descriptors.ReportUserRequest_content.cpp_type = 9
type_descriptors.ReportUserRequest.name = "ReportUserRequest"
type_descriptors.ReportUserRequest.full_name = ".ReportUserRequest"
type_descriptors.ReportUserRequest.nested_types = {}
type_descriptors.ReportUserRequest.enum_types = {}
type_descriptors.ReportUserRequest.fields = {
	field_descriptors.ReportUserRequest_userId,
	field_descriptors.ReportUserRequest_reportType,
	field_descriptors.ReportUserRequest_cause,
	field_descriptors.ReportUserRequest_content
}
type_descriptors.ReportUserRequest.is_extendable = false
type_descriptors.ReportUserRequest.extensions = {}
field_descriptors.SearchUserReply_user.name = "user"
field_descriptors.SearchUserReply_user.full_name = ".SearchUserReply.user"
field_descriptors.SearchUserReply_user.number = 1
field_descriptors.SearchUserReply_user.index = 0
field_descriptors.SearchUserReply_user.label = 3
field_descriptors.SearchUserReply_user.has_default_value = false
field_descriptors.SearchUserReply_user.default_value = {}
field_descriptors.SearchUserReply_user.message_type = type_descriptors.PlayerMetaNO
field_descriptors.SearchUserReply_user.type = 11
field_descriptors.SearchUserReply_user.cpp_type = 10
type_descriptors.SearchUserReply.name = "SearchUserReply"
type_descriptors.SearchUserReply.full_name = ".SearchUserReply"
type_descriptors.SearchUserReply.nested_types = {}
type_descriptors.SearchUserReply.enum_types = {}
type_descriptors.SearchUserReply.fields = {
	field_descriptors.SearchUserReply_user
}
type_descriptors.SearchUserReply.is_extendable = false
type_descriptors.SearchUserReply.extensions = {}
field_descriptors.BlockUserRequest_userId.name = "userId"
field_descriptors.BlockUserRequest_userId.full_name = ".BlockUserRequest.userId"
field_descriptors.BlockUserRequest_userId.number = 1
field_descriptors.BlockUserRequest_userId.index = 0
field_descriptors.BlockUserRequest_userId.label = 2
field_descriptors.BlockUserRequest_userId.has_default_value = false
field_descriptors.BlockUserRequest_userId.default_value = 0
field_descriptors.BlockUserRequest_userId.type = 3
field_descriptors.BlockUserRequest_userId.cpp_type = 2
type_descriptors.BlockUserRequest.name = "BlockUserRequest"
type_descriptors.BlockUserRequest.full_name = ".BlockUserRequest"
type_descriptors.BlockUserRequest.nested_types = {}
type_descriptors.BlockUserRequest.enum_types = {}
type_descriptors.BlockUserRequest.fields = {
	field_descriptors.BlockUserRequest_userId
}
type_descriptors.BlockUserRequest.is_extendable = false
type_descriptors.BlockUserRequest.extensions = {}
field_descriptors.UnBlockUserReply_userId.name = "userId"
field_descriptors.UnBlockUserReply_userId.full_name = ".UnBlockUserReply.userId"
field_descriptors.UnBlockUserReply_userId.number = 1
field_descriptors.UnBlockUserReply_userId.index = 0
field_descriptors.UnBlockUserReply_userId.label = 2
field_descriptors.UnBlockUserReply_userId.has_default_value = false
field_descriptors.UnBlockUserReply_userId.default_value = 0
field_descriptors.UnBlockUserReply_userId.type = 3
field_descriptors.UnBlockUserReply_userId.cpp_type = 2
type_descriptors.UnBlockUserReply.name = "UnBlockUserReply"
type_descriptors.UnBlockUserReply.full_name = ".UnBlockUserReply"
type_descriptors.UnBlockUserReply.nested_types = {}
type_descriptors.UnBlockUserReply.enum_types = {}
type_descriptors.UnBlockUserReply.fields = {
	field_descriptors.UnBlockUserReply_userId
}
type_descriptors.UnBlockUserReply.is_extendable = false
type_descriptors.UnBlockUserReply.extensions = {}
type_descriptors.FeedbackReply.name = "FeedbackReply"
type_descriptors.FeedbackReply.full_name = ".FeedbackReply"
type_descriptors.FeedbackReply.nested_types = {}
type_descriptors.FeedbackReply.enum_types = {}
type_descriptors.FeedbackReply.fields = {}
type_descriptors.FeedbackReply.is_extendable = false
type_descriptors.FeedbackReply.extensions = {}
field_descriptors.AgreeResultNO_userId.name = "userId"
field_descriptors.AgreeResultNO_userId.full_name = ".AgreeResultNO.userId"
field_descriptors.AgreeResultNO_userId.number = 1
field_descriptors.AgreeResultNO_userId.index = 0
field_descriptors.AgreeResultNO_userId.label = 2
field_descriptors.AgreeResultNO_userId.has_default_value = false
field_descriptors.AgreeResultNO_userId.default_value = 0
field_descriptors.AgreeResultNO_userId.type = 3
field_descriptors.AgreeResultNO_userId.cpp_type = 2
field_descriptors.AgreeResultNO_result.name = "result"
field_descriptors.AgreeResultNO_result.full_name = ".AgreeResultNO.result"
field_descriptors.AgreeResultNO_result.number = 2
field_descriptors.AgreeResultNO_result.index = 1
field_descriptors.AgreeResultNO_result.label = 2
field_descriptors.AgreeResultNO_result.has_default_value = false
field_descriptors.AgreeResultNO_result.default_value = 0
field_descriptors.AgreeResultNO_result.type = 5
field_descriptors.AgreeResultNO_result.cpp_type = 1
type_descriptors.AgreeResultNO.name = "AgreeResultNO"
type_descriptors.AgreeResultNO.full_name = ".AgreeResultNO"
type_descriptors.AgreeResultNO.nested_types = {}
type_descriptors.AgreeResultNO.enum_types = {}
type_descriptors.AgreeResultNO.fields = {
	field_descriptors.AgreeResultNO_userId,
	field_descriptors.AgreeResultNO_result
}
type_descriptors.AgreeResultNO.is_extendable = false
type_descriptors.AgreeResultNO.extensions = {}
field_descriptors.ChangeAliasRequest_userId.name = "userId"
field_descriptors.ChangeAliasRequest_userId.full_name = ".ChangeAliasRequest.userId"
field_descriptors.ChangeAliasRequest_userId.number = 1
field_descriptors.ChangeAliasRequest_userId.index = 0
field_descriptors.ChangeAliasRequest_userId.label = 2
field_descriptors.ChangeAliasRequest_userId.has_default_value = false
field_descriptors.ChangeAliasRequest_userId.default_value = 0
field_descriptors.ChangeAliasRequest_userId.type = 3
field_descriptors.ChangeAliasRequest_userId.cpp_type = 2
field_descriptors.ChangeAliasRequest_alias.name = "alias"
field_descriptors.ChangeAliasRequest_alias.full_name = ".ChangeAliasRequest.alias"
field_descriptors.ChangeAliasRequest_alias.number = 2
field_descriptors.ChangeAliasRequest_alias.index = 1
field_descriptors.ChangeAliasRequest_alias.label = 1
field_descriptors.ChangeAliasRequest_alias.has_default_value = false
field_descriptors.ChangeAliasRequest_alias.default_value = ""
field_descriptors.ChangeAliasRequest_alias.type = 9
field_descriptors.ChangeAliasRequest_alias.cpp_type = 9
type_descriptors.ChangeAliasRequest.name = "ChangeAliasRequest"
type_descriptors.ChangeAliasRequest.full_name = ".ChangeAliasRequest"
type_descriptors.ChangeAliasRequest.nested_types = {}
type_descriptors.ChangeAliasRequest.enum_types = {}
type_descriptors.ChangeAliasRequest.fields = {
	field_descriptors.ChangeAliasRequest_userId,
	field_descriptors.ChangeAliasRequest_alias
}
type_descriptors.ChangeAliasRequest.is_extendable = false
type_descriptors.ChangeAliasRequest.extensions = {}
field_descriptors.AgreeApplyRequest_userId.name = "userId"
field_descriptors.AgreeApplyRequest_userId.full_name = ".AgreeApplyRequest.userId"
field_descriptors.AgreeApplyRequest_userId.number = 1
field_descriptors.AgreeApplyRequest_userId.index = 0
field_descriptors.AgreeApplyRequest_userId.label = 3
field_descriptors.AgreeApplyRequest_userId.has_default_value = false
field_descriptors.AgreeApplyRequest_userId.default_value = {}
field_descriptors.AgreeApplyRequest_userId.type = 3
field_descriptors.AgreeApplyRequest_userId.cpp_type = 2
type_descriptors.AgreeApplyRequest.name = "AgreeApplyRequest"
type_descriptors.AgreeApplyRequest.full_name = ".AgreeApplyRequest"
type_descriptors.AgreeApplyRequest.nested_types = {}
type_descriptors.AgreeApplyRequest.enum_types = {}
type_descriptors.AgreeApplyRequest.fields = {
	field_descriptors.AgreeApplyRequest_userId
}
type_descriptors.AgreeApplyRequest.is_extendable = false
type_descriptors.AgreeApplyRequest.extensions = {}
field_descriptors.FeedbackRequest_type.name = "type"
field_descriptors.FeedbackRequest_type.full_name = ".FeedbackRequest.type"
field_descriptors.FeedbackRequest_type.number = 1
field_descriptors.FeedbackRequest_type.index = 0
field_descriptors.FeedbackRequest_type.label = 2
field_descriptors.FeedbackRequest_type.has_default_value = false
field_descriptors.FeedbackRequest_type.default_value = ""
field_descriptors.FeedbackRequest_type.type = 9
field_descriptors.FeedbackRequest_type.cpp_type = 9
field_descriptors.FeedbackRequest_title.name = "title"
field_descriptors.FeedbackRequest_title.full_name = ".FeedbackRequest.title"
field_descriptors.FeedbackRequest_title.number = 2
field_descriptors.FeedbackRequest_title.index = 1
field_descriptors.FeedbackRequest_title.label = 2
field_descriptors.FeedbackRequest_title.has_default_value = false
field_descriptors.FeedbackRequest_title.default_value = ""
field_descriptors.FeedbackRequest_title.type = 9
field_descriptors.FeedbackRequest_title.cpp_type = 9
field_descriptors.FeedbackRequest_content.name = "content"
field_descriptors.FeedbackRequest_content.full_name = ".FeedbackRequest.content"
field_descriptors.FeedbackRequest_content.number = 3
field_descriptors.FeedbackRequest_content.index = 2
field_descriptors.FeedbackRequest_content.label = 2
field_descriptors.FeedbackRequest_content.has_default_value = false
field_descriptors.FeedbackRequest_content.default_value = ""
field_descriptors.FeedbackRequest_content.type = 9
field_descriptors.FeedbackRequest_content.cpp_type = 9
field_descriptors.FeedbackRequest_picture.name = "picture"
field_descriptors.FeedbackRequest_picture.full_name = ".FeedbackRequest.picture"
field_descriptors.FeedbackRequest_picture.number = 4
field_descriptors.FeedbackRequest_picture.index = 3
field_descriptors.FeedbackRequest_picture.label = 3
field_descriptors.FeedbackRequest_picture.has_default_value = false
field_descriptors.FeedbackRequest_picture.default_value = {}
field_descriptors.FeedbackRequest_picture.message_type = type_descriptors.FeedbackPicture
field_descriptors.FeedbackRequest_picture.type = 11
field_descriptors.FeedbackRequest_picture.cpp_type = 10
type_descriptors.FeedbackRequest.name = "FeedbackRequest"
type_descriptors.FeedbackRequest.full_name = ".FeedbackRequest"
type_descriptors.FeedbackRequest.nested_types = {}
type_descriptors.FeedbackRequest.enum_types = {}
type_descriptors.FeedbackRequest.fields = {
	field_descriptors.FeedbackRequest_type,
	field_descriptors.FeedbackRequest_title,
	field_descriptors.FeedbackRequest_content,
	field_descriptors.FeedbackRequest_picture
}
type_descriptors.FeedbackRequest.is_extendable = false
type_descriptors.FeedbackRequest.extensions = {}
field_descriptors.UnBlockUserRequest_userId.name = "userId"
field_descriptors.UnBlockUserRequest_userId.full_name = ".UnBlockUserRequest.userId"
field_descriptors.UnBlockUserRequest_userId.number = 1
field_descriptors.UnBlockUserRequest_userId.index = 0
field_descriptors.UnBlockUserRequest_userId.label = 2
field_descriptors.UnBlockUserRequest_userId.has_default_value = false
field_descriptors.UnBlockUserRequest_userId.default_value = 0
field_descriptors.UnBlockUserRequest_userId.type = 3
field_descriptors.UnBlockUserRequest_userId.cpp_type = 2
type_descriptors.UnBlockUserRequest.name = "UnBlockUserRequest"
type_descriptors.UnBlockUserRequest.full_name = ".UnBlockUserRequest"
type_descriptors.UnBlockUserRequest.nested_types = {}
type_descriptors.UnBlockUserRequest.enum_types = {}
type_descriptors.UnBlockUserRequest.fields = {
	field_descriptors.UnBlockUserRequest_userId
}
type_descriptors.UnBlockUserRequest.is_extendable = false
type_descriptors.UnBlockUserRequest.extensions = {}
field_descriptors.UserListUpdatePush_type.name = "type"
field_descriptors.UserListUpdatePush_type.full_name = ".UserListUpdatePush.type"
field_descriptors.UserListUpdatePush_type.number = 1
field_descriptors.UserListUpdatePush_type.index = 0
field_descriptors.UserListUpdatePush_type.label = 2
field_descriptors.UserListUpdatePush_type.has_default_value = false
field_descriptors.UserListUpdatePush_type.default_value = 0
field_descriptors.UserListUpdatePush_type.type = 5
field_descriptors.UserListUpdatePush_type.cpp_type = 1
field_descriptors.UserListUpdatePush_user.name = "user"
field_descriptors.UserListUpdatePush_user.full_name = ".UserListUpdatePush.user"
field_descriptors.UserListUpdatePush_user.number = 2
field_descriptors.UserListUpdatePush_user.index = 1
field_descriptors.UserListUpdatePush_user.label = 3
field_descriptors.UserListUpdatePush_user.has_default_value = false
field_descriptors.UserListUpdatePush_user.default_value = {}
field_descriptors.UserListUpdatePush_user.message_type = type_descriptors.PlayerMetaNO
field_descriptors.UserListUpdatePush_user.type = 11
field_descriptors.UserListUpdatePush_user.cpp_type = 10
type_descriptors.UserListUpdatePush.name = "UserListUpdatePush"
type_descriptors.UserListUpdatePush.full_name = ".UserListUpdatePush"
type_descriptors.UserListUpdatePush.nested_types = {}
type_descriptors.UserListUpdatePush.enum_types = {}
type_descriptors.UserListUpdatePush.fields = {
	field_descriptors.UserListUpdatePush_type,
	field_descriptors.UserListUpdatePush_user
}
type_descriptors.UserListUpdatePush.is_extendable = false
type_descriptors.UserListUpdatePush.extensions = {}
field_descriptors.BlockUserReply_userId.name = "userId"
field_descriptors.BlockUserReply_userId.full_name = ".BlockUserReply.userId"
field_descriptors.BlockUserReply_userId.number = 1
field_descriptors.BlockUserReply_userId.index = 0
field_descriptors.BlockUserReply_userId.label = 2
field_descriptors.BlockUserReply_userId.has_default_value = false
field_descriptors.BlockUserReply_userId.default_value = 0
field_descriptors.BlockUserReply_userId.type = 3
field_descriptors.BlockUserReply_userId.cpp_type = 2
type_descriptors.BlockUserReply.name = "BlockUserReply"
type_descriptors.BlockUserReply.full_name = ".BlockUserReply"
type_descriptors.BlockUserReply.nested_types = {}
type_descriptors.BlockUserReply.enum_types = {}
type_descriptors.BlockUserReply.fields = {
	field_descriptors.BlockUserReply_userId
}
type_descriptors.BlockUserReply.is_extendable = false
type_descriptors.BlockUserReply.extensions = {}
field_descriptors.RemoveFriendRequest_userId.name = "userId"
field_descriptors.RemoveFriendRequest_userId.full_name = ".RemoveFriendRequest.userId"
field_descriptors.RemoveFriendRequest_userId.number = 1
field_descriptors.RemoveFriendRequest_userId.index = 0
field_descriptors.RemoveFriendRequest_userId.label = 2
field_descriptors.RemoveFriendRequest_userId.has_default_value = false
field_descriptors.RemoveFriendRequest_userId.default_value = 0
field_descriptors.RemoveFriendRequest_userId.type = 3
field_descriptors.RemoveFriendRequest_userId.cpp_type = 2
type_descriptors.RemoveFriendRequest.name = "RemoveFriendRequest"
type_descriptors.RemoveFriendRequest.full_name = ".RemoveFriendRequest"
type_descriptors.RemoveFriendRequest.nested_types = {}
type_descriptors.RemoveFriendRequest.enum_types = {}
type_descriptors.RemoveFriendRequest.fields = {
	field_descriptors.RemoveFriendRequest_userId
}
type_descriptors.RemoveFriendRequest.is_extendable = false
type_descriptors.RemoveFriendRequest.extensions = {}
AgreeApplyReply = protobuf.Message(type_descriptors.AgreeApplyReply)
AgreeApplyRequest = protobuf.Message(type_descriptors.AgreeApplyRequest)
AgreeResultNO = protobuf.Message(type_descriptors.AgreeResultNO)
ApplyFriendReply = protobuf.Message(type_descriptors.ApplyFriendReply)
ApplyFriendRequest = protobuf.Message(type_descriptors.ApplyFriendRequest)
BlockUserReply = protobuf.Message(type_descriptors.BlockUserReply)
BlockUserRequest = protobuf.Message(type_descriptors.BlockUserRequest)
ChangeAliasReply = protobuf.Message(type_descriptors.ChangeAliasReply)
ChangeAliasRequest = protobuf.Message(type_descriptors.ChangeAliasRequest)
FeedbackPicture = protobuf.Message(type_descriptors.FeedbackPicture)
FeedbackReply = protobuf.Message(type_descriptors.FeedbackReply)
FeedbackRequest = protobuf.Message(type_descriptors.FeedbackRequest)
GetUserListReply = protobuf.Message(type_descriptors.GetUserListReply)
GetUserListRequest = protobuf.Message(type_descriptors.GetUserListRequest)
PlayerMetaNO = protobuf.Message(type_descriptors.PlayerMetaNO)
RefuseApplyReply = protobuf.Message(type_descriptors.RefuseApplyReply)
RefuseApplyRequest = protobuf.Message(type_descriptors.RefuseApplyRequest)
RemoveFriendReply = protobuf.Message(type_descriptors.RemoveFriendReply)
RemoveFriendRequest = protobuf.Message(type_descriptors.RemoveFriendRequest)
ReportUserReply = protobuf.Message(type_descriptors.ReportUserReply)
ReportUserRequest = protobuf.Message(type_descriptors.ReportUserRequest)
SearchUserReply = protobuf.Message(type_descriptors.SearchUserReply)
SearchUserRequest = protobuf.Message(type_descriptors.SearchUserRequest)
UnBlockUserReply = protobuf.Message(type_descriptors.UnBlockUserReply)
UnBlockUserRequest = protobuf.Message(type_descriptors.UnBlockUserRequest)
UserListUpdatePush = protobuf.Message(type_descriptors.UserListUpdatePush)

return _G["logic.proto.FriendExtension_pb"]
