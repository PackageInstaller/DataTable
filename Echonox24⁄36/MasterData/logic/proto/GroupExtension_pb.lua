-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/GroupExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.GroupExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.StartMatchReply = protobuf.Descriptor()
type_descriptors.StopMatchRequest = protobuf.Descriptor()
field_descriptors.StopMatchRequest_gameId = protobuf.FieldDescriptor()
type_descriptors.GroupInfoPush = protobuf.Descriptor()
field_descriptors.GroupInfoPush_gameId = protobuf.FieldDescriptor()
field_descriptors.GroupInfoPush_teams = protobuf.FieldDescriptor()
type_descriptors.GetMyInfoRequest = protobuf.Descriptor()
field_descriptors.GetMyInfoRequest_gameId = protobuf.FieldDescriptor()
type_descriptors.MatchCompletePush = protobuf.Descriptor()
field_descriptors.MatchCompletePush_gameId = protobuf.FieldDescriptor()
field_descriptors.MatchCompletePush_result = protobuf.FieldDescriptor()
field_descriptors.MatchCompletePush_teams = protobuf.FieldDescriptor()
type_descriptors.TeamNO = protobuf.Descriptor()
field_descriptors.TeamNO_teamId = protobuf.FieldDescriptor()
field_descriptors.TeamNO_members = protobuf.FieldDescriptor()
type_descriptors.StopMatchReply = protobuf.Descriptor()
type_descriptors.GetMyInfoReply = protobuf.Descriptor()
field_descriptors.GetMyInfoReply_gameId = protobuf.FieldDescriptor()
field_descriptors.GetMyInfoReply_info = protobuf.FieldDescriptor()
type_descriptors.StartMatchRequest = protobuf.Descriptor()
field_descriptors.StartMatchRequest_gameId = protobuf.FieldDescriptor()
type_descriptors.MemberNO = protobuf.Descriptor()
field_descriptors.MemberNO_userId = protobuf.FieldDescriptor()
field_descriptors.MemberNO_score = protobuf.FieldDescriptor()
field_descriptors.MemberNO_win = protobuf.FieldDescriptor()
field_descriptors.MemberNO_draw = protobuf.FieldDescriptor()
field_descriptors.MemberNO_fail = protobuf.FieldDescriptor()
field_descriptors.MemberNO_nickname = protobuf.FieldDescriptor()
field_descriptors.MemberNO_displayHero = protobuf.FieldDescriptor()
field_descriptors.MemberNO_displayHeroSkin = protobuf.FieldDescriptor()
type_descriptors.StartMatchReply.name = "StartMatchReply"
type_descriptors.StartMatchReply.full_name = ".StartMatchReply"
type_descriptors.StartMatchReply.nested_types = {}
type_descriptors.StartMatchReply.enum_types = {}
type_descriptors.StartMatchReply.fields = {}
type_descriptors.StartMatchReply.is_extendable = false
type_descriptors.StartMatchReply.extensions = {}
field_descriptors.StopMatchRequest_gameId.name = "gameId"
field_descriptors.StopMatchRequest_gameId.full_name = ".StopMatchRequest.gameId"
field_descriptors.StopMatchRequest_gameId.number = 1
field_descriptors.StopMatchRequest_gameId.index = 0
field_descriptors.StopMatchRequest_gameId.label = 2
field_descriptors.StopMatchRequest_gameId.has_default_value = false
field_descriptors.StopMatchRequest_gameId.default_value = 0
field_descriptors.StopMatchRequest_gameId.type = 5
field_descriptors.StopMatchRequest_gameId.cpp_type = 1
type_descriptors.StopMatchRequest.name = "StopMatchRequest"
type_descriptors.StopMatchRequest.full_name = ".StopMatchRequest"
type_descriptors.StopMatchRequest.nested_types = {}
type_descriptors.StopMatchRequest.enum_types = {}
type_descriptors.StopMatchRequest.fields = {
	field_descriptors.StopMatchRequest_gameId
}
type_descriptors.StopMatchRequest.is_extendable = false
type_descriptors.StopMatchRequest.extensions = {}
field_descriptors.GroupInfoPush_gameId.name = "gameId"
field_descriptors.GroupInfoPush_gameId.full_name = ".GroupInfoPush.gameId"
field_descriptors.GroupInfoPush_gameId.number = 1
field_descriptors.GroupInfoPush_gameId.index = 0
field_descriptors.GroupInfoPush_gameId.label = 2
field_descriptors.GroupInfoPush_gameId.has_default_value = false
field_descriptors.GroupInfoPush_gameId.default_value = 0
field_descriptors.GroupInfoPush_gameId.type = 5
field_descriptors.GroupInfoPush_gameId.cpp_type = 1
field_descriptors.GroupInfoPush_teams.name = "teams"
field_descriptors.GroupInfoPush_teams.full_name = ".GroupInfoPush.teams"
field_descriptors.GroupInfoPush_teams.number = 2
field_descriptors.GroupInfoPush_teams.index = 1
field_descriptors.GroupInfoPush_teams.label = 3
field_descriptors.GroupInfoPush_teams.has_default_value = false
field_descriptors.GroupInfoPush_teams.default_value = {}
field_descriptors.GroupInfoPush_teams.message_type = type_descriptors.TeamNO
field_descriptors.GroupInfoPush_teams.type = 11
field_descriptors.GroupInfoPush_teams.cpp_type = 10
type_descriptors.GroupInfoPush.name = "GroupInfoPush"
type_descriptors.GroupInfoPush.full_name = ".GroupInfoPush"
type_descriptors.GroupInfoPush.nested_types = {}
type_descriptors.GroupInfoPush.enum_types = {}
type_descriptors.GroupInfoPush.fields = {
	field_descriptors.GroupInfoPush_gameId,
	field_descriptors.GroupInfoPush_teams
}
type_descriptors.GroupInfoPush.is_extendable = false
type_descriptors.GroupInfoPush.extensions = {}
field_descriptors.GetMyInfoRequest_gameId.name = "gameId"
field_descriptors.GetMyInfoRequest_gameId.full_name = ".GetMyInfoRequest.gameId"
field_descriptors.GetMyInfoRequest_gameId.number = 1
field_descriptors.GetMyInfoRequest_gameId.index = 0
field_descriptors.GetMyInfoRequest_gameId.label = 2
field_descriptors.GetMyInfoRequest_gameId.has_default_value = false
field_descriptors.GetMyInfoRequest_gameId.default_value = 0
field_descriptors.GetMyInfoRequest_gameId.type = 5
field_descriptors.GetMyInfoRequest_gameId.cpp_type = 1
type_descriptors.GetMyInfoRequest.name = "GetMyInfoRequest"
type_descriptors.GetMyInfoRequest.full_name = ".GetMyInfoRequest"
type_descriptors.GetMyInfoRequest.nested_types = {}
type_descriptors.GetMyInfoRequest.enum_types = {}
type_descriptors.GetMyInfoRequest.fields = {
	field_descriptors.GetMyInfoRequest_gameId
}
type_descriptors.GetMyInfoRequest.is_extendable = false
type_descriptors.GetMyInfoRequest.extensions = {}
field_descriptors.MatchCompletePush_gameId.name = "gameId"
field_descriptors.MatchCompletePush_gameId.full_name = ".MatchCompletePush.gameId"
field_descriptors.MatchCompletePush_gameId.number = 1
field_descriptors.MatchCompletePush_gameId.index = 0
field_descriptors.MatchCompletePush_gameId.label = 2
field_descriptors.MatchCompletePush_gameId.has_default_value = false
field_descriptors.MatchCompletePush_gameId.default_value = 0
field_descriptors.MatchCompletePush_gameId.type = 5
field_descriptors.MatchCompletePush_gameId.cpp_type = 1
field_descriptors.MatchCompletePush_result.name = "result"
field_descriptors.MatchCompletePush_result.full_name = ".MatchCompletePush.result"
field_descriptors.MatchCompletePush_result.number = 2
field_descriptors.MatchCompletePush_result.index = 1
field_descriptors.MatchCompletePush_result.label = 2
field_descriptors.MatchCompletePush_result.has_default_value = false
field_descriptors.MatchCompletePush_result.default_value = 0
field_descriptors.MatchCompletePush_result.type = 5
field_descriptors.MatchCompletePush_result.cpp_type = 1
field_descriptors.MatchCompletePush_teams.name = "teams"
field_descriptors.MatchCompletePush_teams.full_name = ".MatchCompletePush.teams"
field_descriptors.MatchCompletePush_teams.number = 3
field_descriptors.MatchCompletePush_teams.index = 2
field_descriptors.MatchCompletePush_teams.label = 3
field_descriptors.MatchCompletePush_teams.has_default_value = false
field_descriptors.MatchCompletePush_teams.default_value = {}
field_descriptors.MatchCompletePush_teams.message_type = type_descriptors.TeamNO
field_descriptors.MatchCompletePush_teams.type = 11
field_descriptors.MatchCompletePush_teams.cpp_type = 10
type_descriptors.MatchCompletePush.name = "MatchCompletePush"
type_descriptors.MatchCompletePush.full_name = ".MatchCompletePush"
type_descriptors.MatchCompletePush.nested_types = {}
type_descriptors.MatchCompletePush.enum_types = {}
type_descriptors.MatchCompletePush.fields = {
	field_descriptors.MatchCompletePush_gameId,
	field_descriptors.MatchCompletePush_result,
	field_descriptors.MatchCompletePush_teams
}
type_descriptors.MatchCompletePush.is_extendable = false
type_descriptors.MatchCompletePush.extensions = {}
field_descriptors.TeamNO_teamId.name = "teamId"
field_descriptors.TeamNO_teamId.full_name = ".TeamNO.teamId"
field_descriptors.TeamNO_teamId.number = 1
field_descriptors.TeamNO_teamId.index = 0
field_descriptors.TeamNO_teamId.label = 2
field_descriptors.TeamNO_teamId.has_default_value = false
field_descriptors.TeamNO_teamId.default_value = 0
field_descriptors.TeamNO_teamId.type = 5
field_descriptors.TeamNO_teamId.cpp_type = 1
field_descriptors.TeamNO_members.name = "members"
field_descriptors.TeamNO_members.full_name = ".TeamNO.members"
field_descriptors.TeamNO_members.number = 2
field_descriptors.TeamNO_members.index = 1
field_descriptors.TeamNO_members.label = 3
field_descriptors.TeamNO_members.has_default_value = false
field_descriptors.TeamNO_members.default_value = {}
field_descriptors.TeamNO_members.message_type = type_descriptors.MemberNO
field_descriptors.TeamNO_members.type = 11
field_descriptors.TeamNO_members.cpp_type = 10
type_descriptors.TeamNO.name = "TeamNO"
type_descriptors.TeamNO.full_name = ".TeamNO"
type_descriptors.TeamNO.nested_types = {}
type_descriptors.TeamNO.enum_types = {}
type_descriptors.TeamNO.fields = {
	field_descriptors.TeamNO_teamId,
	field_descriptors.TeamNO_members
}
type_descriptors.TeamNO.is_extendable = false
type_descriptors.TeamNO.extensions = {}
type_descriptors.StopMatchReply.name = "StopMatchReply"
type_descriptors.StopMatchReply.full_name = ".StopMatchReply"
type_descriptors.StopMatchReply.nested_types = {}
type_descriptors.StopMatchReply.enum_types = {}
type_descriptors.StopMatchReply.fields = {}
type_descriptors.StopMatchReply.is_extendable = false
type_descriptors.StopMatchReply.extensions = {}
field_descriptors.GetMyInfoReply_gameId.name = "gameId"
field_descriptors.GetMyInfoReply_gameId.full_name = ".GetMyInfoReply.gameId"
field_descriptors.GetMyInfoReply_gameId.number = 1
field_descriptors.GetMyInfoReply_gameId.index = 0
field_descriptors.GetMyInfoReply_gameId.label = 2
field_descriptors.GetMyInfoReply_gameId.has_default_value = false
field_descriptors.GetMyInfoReply_gameId.default_value = 0
field_descriptors.GetMyInfoReply_gameId.type = 5
field_descriptors.GetMyInfoReply_gameId.cpp_type = 1
field_descriptors.GetMyInfoReply_info.name = "info"
field_descriptors.GetMyInfoReply_info.full_name = ".GetMyInfoReply.info"
field_descriptors.GetMyInfoReply_info.number = 2
field_descriptors.GetMyInfoReply_info.index = 1
field_descriptors.GetMyInfoReply_info.label = 2
field_descriptors.GetMyInfoReply_info.has_default_value = false
field_descriptors.GetMyInfoReply_info.default_value = nil
field_descriptors.GetMyInfoReply_info.message_type = type_descriptors.MemberNO
field_descriptors.GetMyInfoReply_info.type = 11
field_descriptors.GetMyInfoReply_info.cpp_type = 10
type_descriptors.GetMyInfoReply.name = "GetMyInfoReply"
type_descriptors.GetMyInfoReply.full_name = ".GetMyInfoReply"
type_descriptors.GetMyInfoReply.nested_types = {}
type_descriptors.GetMyInfoReply.enum_types = {}
type_descriptors.GetMyInfoReply.fields = {
	field_descriptors.GetMyInfoReply_gameId,
	field_descriptors.GetMyInfoReply_info
}
type_descriptors.GetMyInfoReply.is_extendable = false
type_descriptors.GetMyInfoReply.extensions = {}
field_descriptors.StartMatchRequest_gameId.name = "gameId"
field_descriptors.StartMatchRequest_gameId.full_name = ".StartMatchRequest.gameId"
field_descriptors.StartMatchRequest_gameId.number = 1
field_descriptors.StartMatchRequest_gameId.index = 0
field_descriptors.StartMatchRequest_gameId.label = 2
field_descriptors.StartMatchRequest_gameId.has_default_value = false
field_descriptors.StartMatchRequest_gameId.default_value = 0
field_descriptors.StartMatchRequest_gameId.type = 5
field_descriptors.StartMatchRequest_gameId.cpp_type = 1
type_descriptors.StartMatchRequest.name = "StartMatchRequest"
type_descriptors.StartMatchRequest.full_name = ".StartMatchRequest"
type_descriptors.StartMatchRequest.nested_types = {}
type_descriptors.StartMatchRequest.enum_types = {}
type_descriptors.StartMatchRequest.fields = {
	field_descriptors.StartMatchRequest_gameId
}
type_descriptors.StartMatchRequest.is_extendable = false
type_descriptors.StartMatchRequest.extensions = {}
field_descriptors.MemberNO_userId.name = "userId"
field_descriptors.MemberNO_userId.full_name = ".MemberNO.userId"
field_descriptors.MemberNO_userId.number = 1
field_descriptors.MemberNO_userId.index = 0
field_descriptors.MemberNO_userId.label = 2
field_descriptors.MemberNO_userId.has_default_value = false
field_descriptors.MemberNO_userId.default_value = 0
field_descriptors.MemberNO_userId.type = 3
field_descriptors.MemberNO_userId.cpp_type = 2
field_descriptors.MemberNO_score.name = "score"
field_descriptors.MemberNO_score.full_name = ".MemberNO.score"
field_descriptors.MemberNO_score.number = 2
field_descriptors.MemberNO_score.index = 1
field_descriptors.MemberNO_score.label = 1
field_descriptors.MemberNO_score.has_default_value = false
field_descriptors.MemberNO_score.default_value = 0
field_descriptors.MemberNO_score.type = 5
field_descriptors.MemberNO_score.cpp_type = 1
field_descriptors.MemberNO_win.name = "win"
field_descriptors.MemberNO_win.full_name = ".MemberNO.win"
field_descriptors.MemberNO_win.number = 3
field_descriptors.MemberNO_win.index = 2
field_descriptors.MemberNO_win.label = 1
field_descriptors.MemberNO_win.has_default_value = false
field_descriptors.MemberNO_win.default_value = 0
field_descriptors.MemberNO_win.type = 5
field_descriptors.MemberNO_win.cpp_type = 1
field_descriptors.MemberNO_draw.name = "draw"
field_descriptors.MemberNO_draw.full_name = ".MemberNO.draw"
field_descriptors.MemberNO_draw.number = 4
field_descriptors.MemberNO_draw.index = 3
field_descriptors.MemberNO_draw.label = 1
field_descriptors.MemberNO_draw.has_default_value = false
field_descriptors.MemberNO_draw.default_value = 0
field_descriptors.MemberNO_draw.type = 5
field_descriptors.MemberNO_draw.cpp_type = 1
field_descriptors.MemberNO_fail.name = "fail"
field_descriptors.MemberNO_fail.full_name = ".MemberNO.fail"
field_descriptors.MemberNO_fail.number = 5
field_descriptors.MemberNO_fail.index = 4
field_descriptors.MemberNO_fail.label = 1
field_descriptors.MemberNO_fail.has_default_value = false
field_descriptors.MemberNO_fail.default_value = 0
field_descriptors.MemberNO_fail.type = 5
field_descriptors.MemberNO_fail.cpp_type = 1
field_descriptors.MemberNO_nickname.name = "nickname"
field_descriptors.MemberNO_nickname.full_name = ".MemberNO.nickname"
field_descriptors.MemberNO_nickname.number = 6
field_descriptors.MemberNO_nickname.index = 5
field_descriptors.MemberNO_nickname.label = 1
field_descriptors.MemberNO_nickname.has_default_value = false
field_descriptors.MemberNO_nickname.default_value = ""
field_descriptors.MemberNO_nickname.type = 9
field_descriptors.MemberNO_nickname.cpp_type = 9
field_descriptors.MemberNO_displayHero.name = "displayHero"
field_descriptors.MemberNO_displayHero.full_name = ".MemberNO.displayHero"
field_descriptors.MemberNO_displayHero.number = 7
field_descriptors.MemberNO_displayHero.index = 6
field_descriptors.MemberNO_displayHero.label = 1
field_descriptors.MemberNO_displayHero.has_default_value = false
field_descriptors.MemberNO_displayHero.default_value = 0
field_descriptors.MemberNO_displayHero.type = 5
field_descriptors.MemberNO_displayHero.cpp_type = 1
field_descriptors.MemberNO_displayHeroSkin.name = "displayHeroSkin"
field_descriptors.MemberNO_displayHeroSkin.full_name = ".MemberNO.displayHeroSkin"
field_descriptors.MemberNO_displayHeroSkin.number = 8
field_descriptors.MemberNO_displayHeroSkin.index = 7
field_descriptors.MemberNO_displayHeroSkin.label = 1
field_descriptors.MemberNO_displayHeroSkin.has_default_value = false
field_descriptors.MemberNO_displayHeroSkin.default_value = 0
field_descriptors.MemberNO_displayHeroSkin.type = 5
field_descriptors.MemberNO_displayHeroSkin.cpp_type = 1
type_descriptors.MemberNO.name = "MemberNO"
type_descriptors.MemberNO.full_name = ".MemberNO"
type_descriptors.MemberNO.nested_types = {}
type_descriptors.MemberNO.enum_types = {}
type_descriptors.MemberNO.fields = {
	field_descriptors.MemberNO_userId,
	field_descriptors.MemberNO_score,
	field_descriptors.MemberNO_win,
	field_descriptors.MemberNO_draw,
	field_descriptors.MemberNO_fail,
	field_descriptors.MemberNO_nickname,
	field_descriptors.MemberNO_displayHero,
	field_descriptors.MemberNO_displayHeroSkin
}
type_descriptors.MemberNO.is_extendable = false
type_descriptors.MemberNO.extensions = {}
GetMyInfoReply = protobuf.Message(type_descriptors.GetMyInfoReply)
GetMyInfoRequest = protobuf.Message(type_descriptors.GetMyInfoRequest)
GroupInfoPush = protobuf.Message(type_descriptors.GroupInfoPush)
MatchCompletePush = protobuf.Message(type_descriptors.MatchCompletePush)
MemberNO = protobuf.Message(type_descriptors.MemberNO)
StartMatchReply = protobuf.Message(type_descriptors.StartMatchReply)
StartMatchRequest = protobuf.Message(type_descriptors.StartMatchRequest)
StopMatchReply = protobuf.Message(type_descriptors.StopMatchReply)
StopMatchRequest = protobuf.Message(type_descriptors.StopMatchRequest)
TeamNO = protobuf.Message(type_descriptors.TeamNO)

return _G["logic.proto.GroupExtension_pb"]
