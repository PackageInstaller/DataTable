-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/BattleRecordExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

dependencies.BattleExtension = require("logic.proto.BattleExtension_pb")

module("logic.proto.BattleRecordExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.GetBattleRecordRequest = protobuf.Descriptor()
field_descriptors.GetBattleRecordRequest_userId = protobuf.FieldDescriptor()
field_descriptors.GetBattleRecordRequest_recordId = protobuf.FieldDescriptor()
type_descriptors.GetBattleRecordListReply = protobuf.Descriptor()
field_descriptors.GetBattleRecordListReply_record = protobuf.FieldDescriptor()
type_descriptors.GetBattleRecordReply = protobuf.Descriptor()
field_descriptors.GetBattleRecordReply_battleInfo = protobuf.FieldDescriptor()
field_descriptors.GetBattleRecordReply_push = protobuf.FieldDescriptor()
type_descriptors.GetBattleRecordListRequest = protobuf.Descriptor()
field_descriptors.GetBattleRecordListRequest_userId = protobuf.FieldDescriptor()
type_descriptors.BattleRecordNO = protobuf.Descriptor()
field_descriptors.BattleRecordNO_recordId = protobuf.FieldDescriptor()
field_descriptors.BattleRecordNO_type = protobuf.FieldDescriptor()
field_descriptors.BattleRecordNO_time = protobuf.FieldDescriptor()
field_descriptors.BattleRecordNO_passId = protobuf.FieldDescriptor()
field_descriptors.BattleRecordNO_usersId = protobuf.FieldDescriptor()
field_descriptors.GetBattleRecordRequest_userId.name = "userId"
field_descriptors.GetBattleRecordRequest_userId.full_name = ".GetBattleRecordRequest.userId"
field_descriptors.GetBattleRecordRequest_userId.number = 1
field_descriptors.GetBattleRecordRequest_userId.index = 0
field_descriptors.GetBattleRecordRequest_userId.label = 2
field_descriptors.GetBattleRecordRequest_userId.has_default_value = false
field_descriptors.GetBattleRecordRequest_userId.default_value = 0
field_descriptors.GetBattleRecordRequest_userId.type = 3
field_descriptors.GetBattleRecordRequest_userId.cpp_type = 2
field_descriptors.GetBattleRecordRequest_recordId.name = "recordId"
field_descriptors.GetBattleRecordRequest_recordId.full_name = ".GetBattleRecordRequest.recordId"
field_descriptors.GetBattleRecordRequest_recordId.number = 2
field_descriptors.GetBattleRecordRequest_recordId.index = 1
field_descriptors.GetBattleRecordRequest_recordId.label = 2
field_descriptors.GetBattleRecordRequest_recordId.has_default_value = false
field_descriptors.GetBattleRecordRequest_recordId.default_value = 0
field_descriptors.GetBattleRecordRequest_recordId.type = 3
field_descriptors.GetBattleRecordRequest_recordId.cpp_type = 2
type_descriptors.GetBattleRecordRequest.name = "GetBattleRecordRequest"
type_descriptors.GetBattleRecordRequest.full_name = ".GetBattleRecordRequest"
type_descriptors.GetBattleRecordRequest.nested_types = {}
type_descriptors.GetBattleRecordRequest.enum_types = {}
type_descriptors.GetBattleRecordRequest.fields = {
	field_descriptors.GetBattleRecordRequest_userId,
	field_descriptors.GetBattleRecordRequest_recordId
}
type_descriptors.GetBattleRecordRequest.is_extendable = false
type_descriptors.GetBattleRecordRequest.extensions = {}
field_descriptors.GetBattleRecordListReply_record.name = "record"
field_descriptors.GetBattleRecordListReply_record.full_name = ".GetBattleRecordListReply.record"
field_descriptors.GetBattleRecordListReply_record.number = 1
field_descriptors.GetBattleRecordListReply_record.index = 0
field_descriptors.GetBattleRecordListReply_record.label = 3
field_descriptors.GetBattleRecordListReply_record.has_default_value = false
field_descriptors.GetBattleRecordListReply_record.default_value = {}
field_descriptors.GetBattleRecordListReply_record.message_type = type_descriptors.BattleRecordNO
field_descriptors.GetBattleRecordListReply_record.type = 11
field_descriptors.GetBattleRecordListReply_record.cpp_type = 10
type_descriptors.GetBattleRecordListReply.name = "GetBattleRecordListReply"
type_descriptors.GetBattleRecordListReply.full_name = ".GetBattleRecordListReply"
type_descriptors.GetBattleRecordListReply.nested_types = {}
type_descriptors.GetBattleRecordListReply.enum_types = {}
type_descriptors.GetBattleRecordListReply.fields = {
	field_descriptors.GetBattleRecordListReply_record
}
type_descriptors.GetBattleRecordListReply.is_extendable = false
type_descriptors.GetBattleRecordListReply.extensions = {}
field_descriptors.GetBattleRecordReply_battleInfo.name = "battleInfo"
field_descriptors.GetBattleRecordReply_battleInfo.full_name = ".GetBattleRecordReply.battleInfo"
field_descriptors.GetBattleRecordReply_battleInfo.number = 1
field_descriptors.GetBattleRecordReply_battleInfo.index = 0
field_descriptors.GetBattleRecordReply_battleInfo.label = 1
field_descriptors.GetBattleRecordReply_battleInfo.has_default_value = false
field_descriptors.GetBattleRecordReply_battleInfo.default_value = nil
field_descriptors.GetBattleRecordReply_battleInfo.message_type = dependencies.BattleExtension.type_descriptors.BattleInfoNO
field_descriptors.GetBattleRecordReply_battleInfo.type = 11
field_descriptors.GetBattleRecordReply_battleInfo.cpp_type = 10
field_descriptors.GetBattleRecordReply_push.name = "push"
field_descriptors.GetBattleRecordReply_push.full_name = ".GetBattleRecordReply.push"
field_descriptors.GetBattleRecordReply_push.number = 2
field_descriptors.GetBattleRecordReply_push.index = 1
field_descriptors.GetBattleRecordReply_push.label = 3
field_descriptors.GetBattleRecordReply_push.has_default_value = false
field_descriptors.GetBattleRecordReply_push.default_value = {}
field_descriptors.GetBattleRecordReply_push.message_type = dependencies.BattleExtension.type_descriptors.OnEventTriggeredPush
field_descriptors.GetBattleRecordReply_push.type = 11
field_descriptors.GetBattleRecordReply_push.cpp_type = 10
type_descriptors.GetBattleRecordReply.name = "GetBattleRecordReply"
type_descriptors.GetBattleRecordReply.full_name = ".GetBattleRecordReply"
type_descriptors.GetBattleRecordReply.nested_types = {}
type_descriptors.GetBattleRecordReply.enum_types = {}
type_descriptors.GetBattleRecordReply.fields = {
	field_descriptors.GetBattleRecordReply_battleInfo,
	field_descriptors.GetBattleRecordReply_push
}
type_descriptors.GetBattleRecordReply.is_extendable = false
type_descriptors.GetBattleRecordReply.extensions = {}
field_descriptors.GetBattleRecordListRequest_userId.name = "userId"
field_descriptors.GetBattleRecordListRequest_userId.full_name = ".GetBattleRecordListRequest.userId"
field_descriptors.GetBattleRecordListRequest_userId.number = 1
field_descriptors.GetBattleRecordListRequest_userId.index = 0
field_descriptors.GetBattleRecordListRequest_userId.label = 2
field_descriptors.GetBattleRecordListRequest_userId.has_default_value = false
field_descriptors.GetBattleRecordListRequest_userId.default_value = 0
field_descriptors.GetBattleRecordListRequest_userId.type = 3
field_descriptors.GetBattleRecordListRequest_userId.cpp_type = 2
type_descriptors.GetBattleRecordListRequest.name = "GetBattleRecordListRequest"
type_descriptors.GetBattleRecordListRequest.full_name = ".GetBattleRecordListRequest"
type_descriptors.GetBattleRecordListRequest.nested_types = {}
type_descriptors.GetBattleRecordListRequest.enum_types = {}
type_descriptors.GetBattleRecordListRequest.fields = {
	field_descriptors.GetBattleRecordListRequest_userId
}
type_descriptors.GetBattleRecordListRequest.is_extendable = false
type_descriptors.GetBattleRecordListRequest.extensions = {}
field_descriptors.BattleRecordNO_recordId.name = "recordId"
field_descriptors.BattleRecordNO_recordId.full_name = ".BattleRecordNO.recordId"
field_descriptors.BattleRecordNO_recordId.number = 1
field_descriptors.BattleRecordNO_recordId.index = 0
field_descriptors.BattleRecordNO_recordId.label = 2
field_descriptors.BattleRecordNO_recordId.has_default_value = false
field_descriptors.BattleRecordNO_recordId.default_value = 0
field_descriptors.BattleRecordNO_recordId.type = 3
field_descriptors.BattleRecordNO_recordId.cpp_type = 2
field_descriptors.BattleRecordNO_type.name = "type"
field_descriptors.BattleRecordNO_type.full_name = ".BattleRecordNO.type"
field_descriptors.BattleRecordNO_type.number = 2
field_descriptors.BattleRecordNO_type.index = 1
field_descriptors.BattleRecordNO_type.label = 2
field_descriptors.BattleRecordNO_type.has_default_value = false
field_descriptors.BattleRecordNO_type.default_value = nil
field_descriptors.BattleRecordNO_type.enum_type = dependencies.BattleExtension.type_descriptors.BattleType
field_descriptors.BattleRecordNO_type.type = 14
field_descriptors.BattleRecordNO_type.cpp_type = 8
field_descriptors.BattleRecordNO_time.name = "time"
field_descriptors.BattleRecordNO_time.full_name = ".BattleRecordNO.time"
field_descriptors.BattleRecordNO_time.number = 3
field_descriptors.BattleRecordNO_time.index = 2
field_descriptors.BattleRecordNO_time.label = 2
field_descriptors.BattleRecordNO_time.has_default_value = false
field_descriptors.BattleRecordNO_time.default_value = 0
field_descriptors.BattleRecordNO_time.type = 3
field_descriptors.BattleRecordNO_time.cpp_type = 2
field_descriptors.BattleRecordNO_passId.name = "passId"
field_descriptors.BattleRecordNO_passId.full_name = ".BattleRecordNO.passId"
field_descriptors.BattleRecordNO_passId.number = 4
field_descriptors.BattleRecordNO_passId.index = 3
field_descriptors.BattleRecordNO_passId.label = 1
field_descriptors.BattleRecordNO_passId.has_default_value = false
field_descriptors.BattleRecordNO_passId.default_value = 0
field_descriptors.BattleRecordNO_passId.type = 5
field_descriptors.BattleRecordNO_passId.cpp_type = 1
field_descriptors.BattleRecordNO_usersId.name = "usersId"
field_descriptors.BattleRecordNO_usersId.full_name = ".BattleRecordNO.usersId"
field_descriptors.BattleRecordNO_usersId.number = 5
field_descriptors.BattleRecordNO_usersId.index = 4
field_descriptors.BattleRecordNO_usersId.label = 3
field_descriptors.BattleRecordNO_usersId.has_default_value = false
field_descriptors.BattleRecordNO_usersId.default_value = {}
field_descriptors.BattleRecordNO_usersId.type = 3
field_descriptors.BattleRecordNO_usersId.cpp_type = 2
type_descriptors.BattleRecordNO.name = "BattleRecordNO"
type_descriptors.BattleRecordNO.full_name = ".BattleRecordNO"
type_descriptors.BattleRecordNO.nested_types = {}
type_descriptors.BattleRecordNO.enum_types = {}
type_descriptors.BattleRecordNO.fields = {
	field_descriptors.BattleRecordNO_recordId,
	field_descriptors.BattleRecordNO_type,
	field_descriptors.BattleRecordNO_time,
	field_descriptors.BattleRecordNO_passId,
	field_descriptors.BattleRecordNO_usersId
}
type_descriptors.BattleRecordNO.is_extendable = false
type_descriptors.BattleRecordNO.extensions = {}
BattleRecordNO = protobuf.Message(type_descriptors.BattleRecordNO)
GetBattleRecordListReply = protobuf.Message(type_descriptors.GetBattleRecordListReply)
GetBattleRecordListRequest = protobuf.Message(type_descriptors.GetBattleRecordListRequest)
GetBattleRecordReply = protobuf.Message(type_descriptors.GetBattleRecordReply)
GetBattleRecordRequest = protobuf.Message(type_descriptors.GetBattleRecordRequest)

return _G["logic.proto.BattleRecordExtension_pb"]
