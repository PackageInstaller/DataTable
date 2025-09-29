-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/FootballExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.FootballExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.SettleResultPush = protobuf.Descriptor()
field_descriptors.SettleResultPush_result = protobuf.FieldDescriptor()
field_descriptors.SettleResultPush_info = protobuf.FieldDescriptor()
type_descriptors.RecordNO = protobuf.Descriptor()
field_descriptors.RecordNO_recordId = protobuf.FieldDescriptor()
field_descriptors.RecordNO_opponent = protobuf.FieldDescriptor()
field_descriptors.RecordNO_myPoint = protobuf.FieldDescriptor()
field_descriptors.RecordNO_opponentPoint = protobuf.FieldDescriptor()
field_descriptors.RecordNO_oldScore = protobuf.FieldDescriptor()
field_descriptors.RecordNO_newScore = protobuf.FieldDescriptor()
field_descriptors.RecordNO_gameResult = protobuf.FieldDescriptor()
field_descriptors.RecordNO_gameResultReason = protobuf.FieldDescriptor()
field_descriptors.RecordNO_timestamp = protobuf.FieldDescriptor()
type_descriptors.GetRecordListRequest = protobuf.Descriptor()
type_descriptors.PointNO = protobuf.Descriptor()
field_descriptors.PointNO_teamId = protobuf.FieldDescriptor()
field_descriptors.PointNO_total = protobuf.FieldDescriptor()
type_descriptors.GetRecordListReply = protobuf.Descriptor()
field_descriptors.GetRecordListReply_record = protobuf.FieldDescriptor()
type_descriptors.ResetPush = protobuf.Descriptor()
type_descriptors.SettleInfoNO = protobuf.Descriptor()
field_descriptors.SettleInfoNO_userId = protobuf.FieldDescriptor()
field_descriptors.SettleInfoNO_gameResult = protobuf.FieldDescriptor()
field_descriptors.SettleInfoNO_gameResultReason = protobuf.FieldDescriptor()
field_descriptors.SettleInfoNO_oldScore = protobuf.FieldDescriptor()
field_descriptors.SettleInfoNO_newScore = protobuf.FieldDescriptor()
type_descriptors.BingoPush = protobuf.Descriptor()
field_descriptors.BingoPush_point = protobuf.FieldDescriptor()
type_descriptors.FootballPlayerNO = protobuf.Descriptor()
field_descriptors.FootballPlayerNO_userId = protobuf.FieldDescriptor()
field_descriptors.FootballPlayerNO_nickname = protobuf.FieldDescriptor()
field_descriptors.FootballPlayerNO_portrait = protobuf.FieldDescriptor()
field_descriptors.SettleResultPush_result.name = "result"
field_descriptors.SettleResultPush_result.full_name = ".SettleResultPush.result"
field_descriptors.SettleResultPush_result.number = 1
field_descriptors.SettleResultPush_result.index = 0
field_descriptors.SettleResultPush_result.label = 2
field_descriptors.SettleResultPush_result.has_default_value = false
field_descriptors.SettleResultPush_result.default_value = 0
field_descriptors.SettleResultPush_result.type = 5
field_descriptors.SettleResultPush_result.cpp_type = 1
field_descriptors.SettleResultPush_info.name = "info"
field_descriptors.SettleResultPush_info.full_name = ".SettleResultPush.info"
field_descriptors.SettleResultPush_info.number = 2
field_descriptors.SettleResultPush_info.index = 1
field_descriptors.SettleResultPush_info.label = 3
field_descriptors.SettleResultPush_info.has_default_value = false
field_descriptors.SettleResultPush_info.default_value = {}
field_descriptors.SettleResultPush_info.message_type = type_descriptors.SettleInfoNO
field_descriptors.SettleResultPush_info.type = 11
field_descriptors.SettleResultPush_info.cpp_type = 10
type_descriptors.SettleResultPush.name = "SettleResultPush"
type_descriptors.SettleResultPush.full_name = ".SettleResultPush"
type_descriptors.SettleResultPush.nested_types = {}
type_descriptors.SettleResultPush.enum_types = {}
type_descriptors.SettleResultPush.fields = {
	field_descriptors.SettleResultPush_result,
	field_descriptors.SettleResultPush_info
}
type_descriptors.SettleResultPush.is_extendable = false
type_descriptors.SettleResultPush.extensions = {}
field_descriptors.RecordNO_recordId.name = "recordId"
field_descriptors.RecordNO_recordId.full_name = ".RecordNO.recordId"
field_descriptors.RecordNO_recordId.number = 1
field_descriptors.RecordNO_recordId.index = 0
field_descriptors.RecordNO_recordId.label = 2
field_descriptors.RecordNO_recordId.has_default_value = false
field_descriptors.RecordNO_recordId.default_value = 0
field_descriptors.RecordNO_recordId.type = 3
field_descriptors.RecordNO_recordId.cpp_type = 2
field_descriptors.RecordNO_opponent.name = "opponent"
field_descriptors.RecordNO_opponent.full_name = ".RecordNO.opponent"
field_descriptors.RecordNO_opponent.number = 2
field_descriptors.RecordNO_opponent.index = 1
field_descriptors.RecordNO_opponent.label = 2
field_descriptors.RecordNO_opponent.has_default_value = false
field_descriptors.RecordNO_opponent.default_value = nil
field_descriptors.RecordNO_opponent.message_type = type_descriptors.FootballPlayerNO
field_descriptors.RecordNO_opponent.type = 11
field_descriptors.RecordNO_opponent.cpp_type = 10
field_descriptors.RecordNO_myPoint.name = "myPoint"
field_descriptors.RecordNO_myPoint.full_name = ".RecordNO.myPoint"
field_descriptors.RecordNO_myPoint.number = 3
field_descriptors.RecordNO_myPoint.index = 2
field_descriptors.RecordNO_myPoint.label = 2
field_descriptors.RecordNO_myPoint.has_default_value = false
field_descriptors.RecordNO_myPoint.default_value = 0
field_descriptors.RecordNO_myPoint.type = 5
field_descriptors.RecordNO_myPoint.cpp_type = 1
field_descriptors.RecordNO_opponentPoint.name = "opponentPoint"
field_descriptors.RecordNO_opponentPoint.full_name = ".RecordNO.opponentPoint"
field_descriptors.RecordNO_opponentPoint.number = 4
field_descriptors.RecordNO_opponentPoint.index = 3
field_descriptors.RecordNO_opponentPoint.label = 2
field_descriptors.RecordNO_opponentPoint.has_default_value = false
field_descriptors.RecordNO_opponentPoint.default_value = 0
field_descriptors.RecordNO_opponentPoint.type = 5
field_descriptors.RecordNO_opponentPoint.cpp_type = 1
field_descriptors.RecordNO_oldScore.name = "oldScore"
field_descriptors.RecordNO_oldScore.full_name = ".RecordNO.oldScore"
field_descriptors.RecordNO_oldScore.number = 5
field_descriptors.RecordNO_oldScore.index = 4
field_descriptors.RecordNO_oldScore.label = 2
field_descriptors.RecordNO_oldScore.has_default_value = false
field_descriptors.RecordNO_oldScore.default_value = 0
field_descriptors.RecordNO_oldScore.type = 5
field_descriptors.RecordNO_oldScore.cpp_type = 1
field_descriptors.RecordNO_newScore.name = "newScore"
field_descriptors.RecordNO_newScore.full_name = ".RecordNO.newScore"
field_descriptors.RecordNO_newScore.number = 6
field_descriptors.RecordNO_newScore.index = 5
field_descriptors.RecordNO_newScore.label = 2
field_descriptors.RecordNO_newScore.has_default_value = false
field_descriptors.RecordNO_newScore.default_value = 0
field_descriptors.RecordNO_newScore.type = 5
field_descriptors.RecordNO_newScore.cpp_type = 1
field_descriptors.RecordNO_gameResult.name = "gameResult"
field_descriptors.RecordNO_gameResult.full_name = ".RecordNO.gameResult"
field_descriptors.RecordNO_gameResult.number = 7
field_descriptors.RecordNO_gameResult.index = 6
field_descriptors.RecordNO_gameResult.label = 2
field_descriptors.RecordNO_gameResult.has_default_value = false
field_descriptors.RecordNO_gameResult.default_value = 0
field_descriptors.RecordNO_gameResult.type = 5
field_descriptors.RecordNO_gameResult.cpp_type = 1
field_descriptors.RecordNO_gameResultReason.name = "gameResultReason"
field_descriptors.RecordNO_gameResultReason.full_name = ".RecordNO.gameResultReason"
field_descriptors.RecordNO_gameResultReason.number = 8
field_descriptors.RecordNO_gameResultReason.index = 7
field_descriptors.RecordNO_gameResultReason.label = 2
field_descriptors.RecordNO_gameResultReason.has_default_value = false
field_descriptors.RecordNO_gameResultReason.default_value = 0
field_descriptors.RecordNO_gameResultReason.type = 5
field_descriptors.RecordNO_gameResultReason.cpp_type = 1
field_descriptors.RecordNO_timestamp.name = "timestamp"
field_descriptors.RecordNO_timestamp.full_name = ".RecordNO.timestamp"
field_descriptors.RecordNO_timestamp.number = 9
field_descriptors.RecordNO_timestamp.index = 8
field_descriptors.RecordNO_timestamp.label = 2
field_descriptors.RecordNO_timestamp.has_default_value = false
field_descriptors.RecordNO_timestamp.default_value = 0
field_descriptors.RecordNO_timestamp.type = 3
field_descriptors.RecordNO_timestamp.cpp_type = 2
type_descriptors.RecordNO.name = "RecordNO"
type_descriptors.RecordNO.full_name = ".RecordNO"
type_descriptors.RecordNO.nested_types = {}
type_descriptors.RecordNO.enum_types = {}
type_descriptors.RecordNO.fields = {
	field_descriptors.RecordNO_recordId,
	field_descriptors.RecordNO_opponent,
	field_descriptors.RecordNO_myPoint,
	field_descriptors.RecordNO_opponentPoint,
	field_descriptors.RecordNO_oldScore,
	field_descriptors.RecordNO_newScore,
	field_descriptors.RecordNO_gameResult,
	field_descriptors.RecordNO_gameResultReason,
	field_descriptors.RecordNO_timestamp
}
type_descriptors.RecordNO.is_extendable = false
type_descriptors.RecordNO.extensions = {}
type_descriptors.GetRecordListRequest.name = "GetRecordListRequest"
type_descriptors.GetRecordListRequest.full_name = ".GetRecordListRequest"
type_descriptors.GetRecordListRequest.nested_types = {}
type_descriptors.GetRecordListRequest.enum_types = {}
type_descriptors.GetRecordListRequest.fields = {}
type_descriptors.GetRecordListRequest.is_extendable = false
type_descriptors.GetRecordListRequest.extensions = {}
field_descriptors.PointNO_teamId.name = "teamId"
field_descriptors.PointNO_teamId.full_name = ".PointNO.teamId"
field_descriptors.PointNO_teamId.number = 1
field_descriptors.PointNO_teamId.index = 0
field_descriptors.PointNO_teamId.label = 1
field_descriptors.PointNO_teamId.has_default_value = false
field_descriptors.PointNO_teamId.default_value = 0
field_descriptors.PointNO_teamId.type = 5
field_descriptors.PointNO_teamId.cpp_type = 1
field_descriptors.PointNO_total.name = "total"
field_descriptors.PointNO_total.full_name = ".PointNO.total"
field_descriptors.PointNO_total.number = 2
field_descriptors.PointNO_total.index = 1
field_descriptors.PointNO_total.label = 1
field_descriptors.PointNO_total.has_default_value = false
field_descriptors.PointNO_total.default_value = 0
field_descriptors.PointNO_total.type = 5
field_descriptors.PointNO_total.cpp_type = 1
type_descriptors.PointNO.name = "PointNO"
type_descriptors.PointNO.full_name = ".PointNO"
type_descriptors.PointNO.nested_types = {}
type_descriptors.PointNO.enum_types = {}
type_descriptors.PointNO.fields = {
	field_descriptors.PointNO_teamId,
	field_descriptors.PointNO_total
}
type_descriptors.PointNO.is_extendable = false
type_descriptors.PointNO.extensions = {}
field_descriptors.GetRecordListReply_record.name = "record"
field_descriptors.GetRecordListReply_record.full_name = ".GetRecordListReply.record"
field_descriptors.GetRecordListReply_record.number = 1
field_descriptors.GetRecordListReply_record.index = 0
field_descriptors.GetRecordListReply_record.label = 3
field_descriptors.GetRecordListReply_record.has_default_value = false
field_descriptors.GetRecordListReply_record.default_value = {}
field_descriptors.GetRecordListReply_record.message_type = type_descriptors.RecordNO
field_descriptors.GetRecordListReply_record.type = 11
field_descriptors.GetRecordListReply_record.cpp_type = 10
type_descriptors.GetRecordListReply.name = "GetRecordListReply"
type_descriptors.GetRecordListReply.full_name = ".GetRecordListReply"
type_descriptors.GetRecordListReply.nested_types = {}
type_descriptors.GetRecordListReply.enum_types = {}
type_descriptors.GetRecordListReply.fields = {
	field_descriptors.GetRecordListReply_record
}
type_descriptors.GetRecordListReply.is_extendable = false
type_descriptors.GetRecordListReply.extensions = {}
type_descriptors.ResetPush.name = "ResetPush"
type_descriptors.ResetPush.full_name = ".ResetPush"
type_descriptors.ResetPush.nested_types = {}
type_descriptors.ResetPush.enum_types = {}
type_descriptors.ResetPush.fields = {}
type_descriptors.ResetPush.is_extendable = false
type_descriptors.ResetPush.extensions = {}
field_descriptors.SettleInfoNO_userId.name = "userId"
field_descriptors.SettleInfoNO_userId.full_name = ".SettleInfoNO.userId"
field_descriptors.SettleInfoNO_userId.number = 1
field_descriptors.SettleInfoNO_userId.index = 0
field_descriptors.SettleInfoNO_userId.label = 2
field_descriptors.SettleInfoNO_userId.has_default_value = false
field_descriptors.SettleInfoNO_userId.default_value = 0
field_descriptors.SettleInfoNO_userId.type = 3
field_descriptors.SettleInfoNO_userId.cpp_type = 2
field_descriptors.SettleInfoNO_gameResult.name = "gameResult"
field_descriptors.SettleInfoNO_gameResult.full_name = ".SettleInfoNO.gameResult"
field_descriptors.SettleInfoNO_gameResult.number = 2
field_descriptors.SettleInfoNO_gameResult.index = 1
field_descriptors.SettleInfoNO_gameResult.label = 2
field_descriptors.SettleInfoNO_gameResult.has_default_value = false
field_descriptors.SettleInfoNO_gameResult.default_value = 0
field_descriptors.SettleInfoNO_gameResult.type = 5
field_descriptors.SettleInfoNO_gameResult.cpp_type = 1
field_descriptors.SettleInfoNO_gameResultReason.name = "gameResultReason"
field_descriptors.SettleInfoNO_gameResultReason.full_name = ".SettleInfoNO.gameResultReason"
field_descriptors.SettleInfoNO_gameResultReason.number = 3
field_descriptors.SettleInfoNO_gameResultReason.index = 2
field_descriptors.SettleInfoNO_gameResultReason.label = 2
field_descriptors.SettleInfoNO_gameResultReason.has_default_value = false
field_descriptors.SettleInfoNO_gameResultReason.default_value = 0
field_descriptors.SettleInfoNO_gameResultReason.type = 5
field_descriptors.SettleInfoNO_gameResultReason.cpp_type = 1
field_descriptors.SettleInfoNO_oldScore.name = "oldScore"
field_descriptors.SettleInfoNO_oldScore.full_name = ".SettleInfoNO.oldScore"
field_descriptors.SettleInfoNO_oldScore.number = 4
field_descriptors.SettleInfoNO_oldScore.index = 3
field_descriptors.SettleInfoNO_oldScore.label = 2
field_descriptors.SettleInfoNO_oldScore.has_default_value = false
field_descriptors.SettleInfoNO_oldScore.default_value = 0
field_descriptors.SettleInfoNO_oldScore.type = 5
field_descriptors.SettleInfoNO_oldScore.cpp_type = 1
field_descriptors.SettleInfoNO_newScore.name = "newScore"
field_descriptors.SettleInfoNO_newScore.full_name = ".SettleInfoNO.newScore"
field_descriptors.SettleInfoNO_newScore.number = 5
field_descriptors.SettleInfoNO_newScore.index = 4
field_descriptors.SettleInfoNO_newScore.label = 2
field_descriptors.SettleInfoNO_newScore.has_default_value = false
field_descriptors.SettleInfoNO_newScore.default_value = 0
field_descriptors.SettleInfoNO_newScore.type = 5
field_descriptors.SettleInfoNO_newScore.cpp_type = 1
type_descriptors.SettleInfoNO.name = "SettleInfoNO"
type_descriptors.SettleInfoNO.full_name = ".SettleInfoNO"
type_descriptors.SettleInfoNO.nested_types = {}
type_descriptors.SettleInfoNO.enum_types = {}
type_descriptors.SettleInfoNO.fields = {
	field_descriptors.SettleInfoNO_userId,
	field_descriptors.SettleInfoNO_gameResult,
	field_descriptors.SettleInfoNO_gameResultReason,
	field_descriptors.SettleInfoNO_oldScore,
	field_descriptors.SettleInfoNO_newScore
}
type_descriptors.SettleInfoNO.is_extendable = false
type_descriptors.SettleInfoNO.extensions = {}
field_descriptors.BingoPush_point.name = "point"
field_descriptors.BingoPush_point.full_name = ".BingoPush.point"
field_descriptors.BingoPush_point.number = 1
field_descriptors.BingoPush_point.index = 0
field_descriptors.BingoPush_point.label = 3
field_descriptors.BingoPush_point.has_default_value = false
field_descriptors.BingoPush_point.default_value = {}
field_descriptors.BingoPush_point.message_type = type_descriptors.PointNO
field_descriptors.BingoPush_point.type = 11
field_descriptors.BingoPush_point.cpp_type = 10
type_descriptors.BingoPush.name = "BingoPush"
type_descriptors.BingoPush.full_name = ".BingoPush"
type_descriptors.BingoPush.nested_types = {}
type_descriptors.BingoPush.enum_types = {}
type_descriptors.BingoPush.fields = {
	field_descriptors.BingoPush_point
}
type_descriptors.BingoPush.is_extendable = false
type_descriptors.BingoPush.extensions = {}
field_descriptors.FootballPlayerNO_userId.name = "userId"
field_descriptors.FootballPlayerNO_userId.full_name = ".FootballPlayerNO.userId"
field_descriptors.FootballPlayerNO_userId.number = 1
field_descriptors.FootballPlayerNO_userId.index = 0
field_descriptors.FootballPlayerNO_userId.label = 2
field_descriptors.FootballPlayerNO_userId.has_default_value = false
field_descriptors.FootballPlayerNO_userId.default_value = 0
field_descriptors.FootballPlayerNO_userId.type = 3
field_descriptors.FootballPlayerNO_userId.cpp_type = 2
field_descriptors.FootballPlayerNO_nickname.name = "nickname"
field_descriptors.FootballPlayerNO_nickname.full_name = ".FootballPlayerNO.nickname"
field_descriptors.FootballPlayerNO_nickname.number = 2
field_descriptors.FootballPlayerNO_nickname.index = 1
field_descriptors.FootballPlayerNO_nickname.label = 2
field_descriptors.FootballPlayerNO_nickname.has_default_value = false
field_descriptors.FootballPlayerNO_nickname.default_value = ""
field_descriptors.FootballPlayerNO_nickname.type = 9
field_descriptors.FootballPlayerNO_nickname.cpp_type = 9
field_descriptors.FootballPlayerNO_portrait.name = "portrait"
field_descriptors.FootballPlayerNO_portrait.full_name = ".FootballPlayerNO.portrait"
field_descriptors.FootballPlayerNO_portrait.number = 3
field_descriptors.FootballPlayerNO_portrait.index = 2
field_descriptors.FootballPlayerNO_portrait.label = 2
field_descriptors.FootballPlayerNO_portrait.has_default_value = false
field_descriptors.FootballPlayerNO_portrait.default_value = 0
field_descriptors.FootballPlayerNO_portrait.type = 5
field_descriptors.FootballPlayerNO_portrait.cpp_type = 1
type_descriptors.FootballPlayerNO.name = "FootballPlayerNO"
type_descriptors.FootballPlayerNO.full_name = ".FootballPlayerNO"
type_descriptors.FootballPlayerNO.nested_types = {}
type_descriptors.FootballPlayerNO.enum_types = {}
type_descriptors.FootballPlayerNO.fields = {
	field_descriptors.FootballPlayerNO_userId,
	field_descriptors.FootballPlayerNO_nickname,
	field_descriptors.FootballPlayerNO_portrait
}
type_descriptors.FootballPlayerNO.is_extendable = false
type_descriptors.FootballPlayerNO.extensions = {}
BingoPush = protobuf.Message(type_descriptors.BingoPush)
FootballPlayerNO = protobuf.Message(type_descriptors.FootballPlayerNO)
GetRecordListReply = protobuf.Message(type_descriptors.GetRecordListReply)
GetRecordListRequest = protobuf.Message(type_descriptors.GetRecordListRequest)
PointNO = protobuf.Message(type_descriptors.PointNO)
RecordNO = protobuf.Message(type_descriptors.RecordNO)
ResetPush = protobuf.Message(type_descriptors.ResetPush)
SettleInfoNO = protobuf.Message(type_descriptors.SettleInfoNO)
SettleResultPush = protobuf.Message(type_descriptors.SettleResultPush)

return _G["logic.proto.FootballExtension_pb"]
