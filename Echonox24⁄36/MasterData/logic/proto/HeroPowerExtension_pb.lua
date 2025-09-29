-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/HeroPowerExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.HeroPowerExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.HeroPowerActRecord = protobuf.Descriptor()
field_descriptors.HeroPowerActRecord_nodeId = protobuf.FieldDescriptor()
field_descriptors.HeroPowerActRecord_powerLv = protobuf.FieldDescriptor()
field_descriptors.HeroPowerActRecord_timestamp = protobuf.FieldDescriptor()
type_descriptors.HeroPowerInfoReply = protobuf.Descriptor()
field_descriptors.HeroPowerInfoReply_heroId = protobuf.FieldDescriptor()
field_descriptors.HeroPowerInfoReply_nodesInfo = protobuf.FieldDescriptor()
field_descriptors.HeroPowerInfoReply_extNodesInfo = protobuf.FieldDescriptor()
field_descriptors.HeroPowerInfoReply_records = protobuf.FieldDescriptor()
type_descriptors.HeroPowerInfoPush = protobuf.Descriptor()
field_descriptors.HeroPowerInfoPush_heroId = protobuf.FieldDescriptor()
field_descriptors.HeroPowerInfoPush_nodesInfo = protobuf.FieldDescriptor()
field_descriptors.HeroPowerInfoPush_extNodesInfo = protobuf.FieldDescriptor()
field_descriptors.HeroPowerInfoPush_records = protobuf.FieldDescriptor()
type_descriptors.HeroExtNodeActRequest = protobuf.Descriptor()
field_descriptors.HeroExtNodeActRequest_heroId = protobuf.FieldDescriptor()
field_descriptors.HeroExtNodeActRequest_nodeId = protobuf.FieldDescriptor()
type_descriptors.HeroPowerInfoRequest = protobuf.Descriptor()
field_descriptors.HeroPowerInfoRequest_heroId = protobuf.FieldDescriptor()
type_descriptors.HeroExtNodeActReply = protobuf.Descriptor()
type_descriptors.HeroNodeActRequest = protobuf.Descriptor()
field_descriptors.HeroNodeActRequest_heroId = protobuf.FieldDescriptor()
field_descriptors.HeroNodeActRequest_nodeId = protobuf.FieldDescriptor()
type_descriptors.HeroNodeActReply = protobuf.Descriptor()
field_descriptors.HeroPowerActRecord_nodeId.name = "nodeId"
field_descriptors.HeroPowerActRecord_nodeId.full_name = ".HeroPowerActRecord.nodeId"
field_descriptors.HeroPowerActRecord_nodeId.number = 1
field_descriptors.HeroPowerActRecord_nodeId.index = 0
field_descriptors.HeroPowerActRecord_nodeId.label = 1
field_descriptors.HeroPowerActRecord_nodeId.has_default_value = false
field_descriptors.HeroPowerActRecord_nodeId.default_value = 0
field_descriptors.HeroPowerActRecord_nodeId.type = 5
field_descriptors.HeroPowerActRecord_nodeId.cpp_type = 1
field_descriptors.HeroPowerActRecord_powerLv.name = "powerLv"
field_descriptors.HeroPowerActRecord_powerLv.full_name = ".HeroPowerActRecord.powerLv"
field_descriptors.HeroPowerActRecord_powerLv.number = 2
field_descriptors.HeroPowerActRecord_powerLv.index = 1
field_descriptors.HeroPowerActRecord_powerLv.label = 1
field_descriptors.HeroPowerActRecord_powerLv.has_default_value = false
field_descriptors.HeroPowerActRecord_powerLv.default_value = 0
field_descriptors.HeroPowerActRecord_powerLv.type = 5
field_descriptors.HeroPowerActRecord_powerLv.cpp_type = 1
field_descriptors.HeroPowerActRecord_timestamp.name = "timestamp"
field_descriptors.HeroPowerActRecord_timestamp.full_name = ".HeroPowerActRecord.timestamp"
field_descriptors.HeroPowerActRecord_timestamp.number = 3
field_descriptors.HeroPowerActRecord_timestamp.index = 2
field_descriptors.HeroPowerActRecord_timestamp.label = 1
field_descriptors.HeroPowerActRecord_timestamp.has_default_value = false
field_descriptors.HeroPowerActRecord_timestamp.default_value = 0
field_descriptors.HeroPowerActRecord_timestamp.type = 5
field_descriptors.HeroPowerActRecord_timestamp.cpp_type = 1
type_descriptors.HeroPowerActRecord.name = "HeroPowerActRecord"
type_descriptors.HeroPowerActRecord.full_name = ".HeroPowerActRecord"
type_descriptors.HeroPowerActRecord.nested_types = {}
type_descriptors.HeroPowerActRecord.enum_types = {}
type_descriptors.HeroPowerActRecord.fields = {
	field_descriptors.HeroPowerActRecord_nodeId,
	field_descriptors.HeroPowerActRecord_powerLv,
	field_descriptors.HeroPowerActRecord_timestamp
}
type_descriptors.HeroPowerActRecord.is_extendable = false
type_descriptors.HeroPowerActRecord.extensions = {}
field_descriptors.HeroPowerInfoReply_heroId.name = "heroId"
field_descriptors.HeroPowerInfoReply_heroId.full_name = ".HeroPowerInfoReply.heroId"
field_descriptors.HeroPowerInfoReply_heroId.number = 1
field_descriptors.HeroPowerInfoReply_heroId.index = 0
field_descriptors.HeroPowerInfoReply_heroId.label = 1
field_descriptors.HeroPowerInfoReply_heroId.has_default_value = false
field_descriptors.HeroPowerInfoReply_heroId.default_value = 0
field_descriptors.HeroPowerInfoReply_heroId.type = 5
field_descriptors.HeroPowerInfoReply_heroId.cpp_type = 1
field_descriptors.HeroPowerInfoReply_nodesInfo.name = "nodesInfo"
field_descriptors.HeroPowerInfoReply_nodesInfo.full_name = ".HeroPowerInfoReply.nodesInfo"
field_descriptors.HeroPowerInfoReply_nodesInfo.number = 2
field_descriptors.HeroPowerInfoReply_nodesInfo.index = 1
field_descriptors.HeroPowerInfoReply_nodesInfo.label = 3
field_descriptors.HeroPowerInfoReply_nodesInfo.has_default_value = false
field_descriptors.HeroPowerInfoReply_nodesInfo.default_value = {}
field_descriptors.HeroPowerInfoReply_nodesInfo.type = 5
field_descriptors.HeroPowerInfoReply_nodesInfo.cpp_type = 1
field_descriptors.HeroPowerInfoReply_extNodesInfo.name = "extNodesInfo"
field_descriptors.HeroPowerInfoReply_extNodesInfo.full_name = ".HeroPowerInfoReply.extNodesInfo"
field_descriptors.HeroPowerInfoReply_extNodesInfo.number = 3
field_descriptors.HeroPowerInfoReply_extNodesInfo.index = 2
field_descriptors.HeroPowerInfoReply_extNodesInfo.label = 3
field_descriptors.HeroPowerInfoReply_extNodesInfo.has_default_value = false
field_descriptors.HeroPowerInfoReply_extNodesInfo.default_value = {}
field_descriptors.HeroPowerInfoReply_extNodesInfo.type = 5
field_descriptors.HeroPowerInfoReply_extNodesInfo.cpp_type = 1
field_descriptors.HeroPowerInfoReply_records.name = "records"
field_descriptors.HeroPowerInfoReply_records.full_name = ".HeroPowerInfoReply.records"
field_descriptors.HeroPowerInfoReply_records.number = 4
field_descriptors.HeroPowerInfoReply_records.index = 3
field_descriptors.HeroPowerInfoReply_records.label = 3
field_descriptors.HeroPowerInfoReply_records.has_default_value = false
field_descriptors.HeroPowerInfoReply_records.default_value = {}
field_descriptors.HeroPowerInfoReply_records.message_type = type_descriptors.HeroPowerActRecord
field_descriptors.HeroPowerInfoReply_records.type = 11
field_descriptors.HeroPowerInfoReply_records.cpp_type = 10
type_descriptors.HeroPowerInfoReply.name = "HeroPowerInfoReply"
type_descriptors.HeroPowerInfoReply.full_name = ".HeroPowerInfoReply"
type_descriptors.HeroPowerInfoReply.nested_types = {}
type_descriptors.HeroPowerInfoReply.enum_types = {}
type_descriptors.HeroPowerInfoReply.fields = {
	field_descriptors.HeroPowerInfoReply_heroId,
	field_descriptors.HeroPowerInfoReply_nodesInfo,
	field_descriptors.HeroPowerInfoReply_extNodesInfo,
	field_descriptors.HeroPowerInfoReply_records
}
type_descriptors.HeroPowerInfoReply.is_extendable = false
type_descriptors.HeroPowerInfoReply.extensions = {}
field_descriptors.HeroPowerInfoPush_heroId.name = "heroId"
field_descriptors.HeroPowerInfoPush_heroId.full_name = ".HeroPowerInfoPush.heroId"
field_descriptors.HeroPowerInfoPush_heroId.number = 1
field_descriptors.HeroPowerInfoPush_heroId.index = 0
field_descriptors.HeroPowerInfoPush_heroId.label = 1
field_descriptors.HeroPowerInfoPush_heroId.has_default_value = false
field_descriptors.HeroPowerInfoPush_heroId.default_value = 0
field_descriptors.HeroPowerInfoPush_heroId.type = 5
field_descriptors.HeroPowerInfoPush_heroId.cpp_type = 1
field_descriptors.HeroPowerInfoPush_nodesInfo.name = "nodesInfo"
field_descriptors.HeroPowerInfoPush_nodesInfo.full_name = ".HeroPowerInfoPush.nodesInfo"
field_descriptors.HeroPowerInfoPush_nodesInfo.number = 2
field_descriptors.HeroPowerInfoPush_nodesInfo.index = 1
field_descriptors.HeroPowerInfoPush_nodesInfo.label = 3
field_descriptors.HeroPowerInfoPush_nodesInfo.has_default_value = false
field_descriptors.HeroPowerInfoPush_nodesInfo.default_value = {}
field_descriptors.HeroPowerInfoPush_nodesInfo.type = 5
field_descriptors.HeroPowerInfoPush_nodesInfo.cpp_type = 1
field_descriptors.HeroPowerInfoPush_extNodesInfo.name = "extNodesInfo"
field_descriptors.HeroPowerInfoPush_extNodesInfo.full_name = ".HeroPowerInfoPush.extNodesInfo"
field_descriptors.HeroPowerInfoPush_extNodesInfo.number = 3
field_descriptors.HeroPowerInfoPush_extNodesInfo.index = 2
field_descriptors.HeroPowerInfoPush_extNodesInfo.label = 3
field_descriptors.HeroPowerInfoPush_extNodesInfo.has_default_value = false
field_descriptors.HeroPowerInfoPush_extNodesInfo.default_value = {}
field_descriptors.HeroPowerInfoPush_extNodesInfo.type = 5
field_descriptors.HeroPowerInfoPush_extNodesInfo.cpp_type = 1
field_descriptors.HeroPowerInfoPush_records.name = "records"
field_descriptors.HeroPowerInfoPush_records.full_name = ".HeroPowerInfoPush.records"
field_descriptors.HeroPowerInfoPush_records.number = 4
field_descriptors.HeroPowerInfoPush_records.index = 3
field_descriptors.HeroPowerInfoPush_records.label = 3
field_descriptors.HeroPowerInfoPush_records.has_default_value = false
field_descriptors.HeroPowerInfoPush_records.default_value = {}
field_descriptors.HeroPowerInfoPush_records.message_type = type_descriptors.HeroPowerActRecord
field_descriptors.HeroPowerInfoPush_records.type = 11
field_descriptors.HeroPowerInfoPush_records.cpp_type = 10
type_descriptors.HeroPowerInfoPush.name = "HeroPowerInfoPush"
type_descriptors.HeroPowerInfoPush.full_name = ".HeroPowerInfoPush"
type_descriptors.HeroPowerInfoPush.nested_types = {}
type_descriptors.HeroPowerInfoPush.enum_types = {}
type_descriptors.HeroPowerInfoPush.fields = {
	field_descriptors.HeroPowerInfoPush_heroId,
	field_descriptors.HeroPowerInfoPush_nodesInfo,
	field_descriptors.HeroPowerInfoPush_extNodesInfo,
	field_descriptors.HeroPowerInfoPush_records
}
type_descriptors.HeroPowerInfoPush.is_extendable = false
type_descriptors.HeroPowerInfoPush.extensions = {}
field_descriptors.HeroExtNodeActRequest_heroId.name = "heroId"
field_descriptors.HeroExtNodeActRequest_heroId.full_name = ".HeroExtNodeActRequest.heroId"
field_descriptors.HeroExtNodeActRequest_heroId.number = 1
field_descriptors.HeroExtNodeActRequest_heroId.index = 0
field_descriptors.HeroExtNodeActRequest_heroId.label = 1
field_descriptors.HeroExtNodeActRequest_heroId.has_default_value = false
field_descriptors.HeroExtNodeActRequest_heroId.default_value = 0
field_descriptors.HeroExtNodeActRequest_heroId.type = 5
field_descriptors.HeroExtNodeActRequest_heroId.cpp_type = 1
field_descriptors.HeroExtNodeActRequest_nodeId.name = "nodeId"
field_descriptors.HeroExtNodeActRequest_nodeId.full_name = ".HeroExtNodeActRequest.nodeId"
field_descriptors.HeroExtNodeActRequest_nodeId.number = 2
field_descriptors.HeroExtNodeActRequest_nodeId.index = 1
field_descriptors.HeroExtNodeActRequest_nodeId.label = 1
field_descriptors.HeroExtNodeActRequest_nodeId.has_default_value = false
field_descriptors.HeroExtNodeActRequest_nodeId.default_value = 0
field_descriptors.HeroExtNodeActRequest_nodeId.type = 5
field_descriptors.HeroExtNodeActRequest_nodeId.cpp_type = 1
type_descriptors.HeroExtNodeActRequest.name = "HeroExtNodeActRequest"
type_descriptors.HeroExtNodeActRequest.full_name = ".HeroExtNodeActRequest"
type_descriptors.HeroExtNodeActRequest.nested_types = {}
type_descriptors.HeroExtNodeActRequest.enum_types = {}
type_descriptors.HeroExtNodeActRequest.fields = {
	field_descriptors.HeroExtNodeActRequest_heroId,
	field_descriptors.HeroExtNodeActRequest_nodeId
}
type_descriptors.HeroExtNodeActRequest.is_extendable = false
type_descriptors.HeroExtNodeActRequest.extensions = {}
field_descriptors.HeroPowerInfoRequest_heroId.name = "heroId"
field_descriptors.HeroPowerInfoRequest_heroId.full_name = ".HeroPowerInfoRequest.heroId"
field_descriptors.HeroPowerInfoRequest_heroId.number = 1
field_descriptors.HeroPowerInfoRequest_heroId.index = 0
field_descriptors.HeroPowerInfoRequest_heroId.label = 1
field_descriptors.HeroPowerInfoRequest_heroId.has_default_value = false
field_descriptors.HeroPowerInfoRequest_heroId.default_value = 0
field_descriptors.HeroPowerInfoRequest_heroId.type = 5
field_descriptors.HeroPowerInfoRequest_heroId.cpp_type = 1
type_descriptors.HeroPowerInfoRequest.name = "HeroPowerInfoRequest"
type_descriptors.HeroPowerInfoRequest.full_name = ".HeroPowerInfoRequest"
type_descriptors.HeroPowerInfoRequest.nested_types = {}
type_descriptors.HeroPowerInfoRequest.enum_types = {}
type_descriptors.HeroPowerInfoRequest.fields = {
	field_descriptors.HeroPowerInfoRequest_heroId
}
type_descriptors.HeroPowerInfoRequest.is_extendable = false
type_descriptors.HeroPowerInfoRequest.extensions = {}
type_descriptors.HeroExtNodeActReply.name = "HeroExtNodeActReply"
type_descriptors.HeroExtNodeActReply.full_name = ".HeroExtNodeActReply"
type_descriptors.HeroExtNodeActReply.nested_types = {}
type_descriptors.HeroExtNodeActReply.enum_types = {}
type_descriptors.HeroExtNodeActReply.fields = {}
type_descriptors.HeroExtNodeActReply.is_extendable = false
type_descriptors.HeroExtNodeActReply.extensions = {}
field_descriptors.HeroNodeActRequest_heroId.name = "heroId"
field_descriptors.HeroNodeActRequest_heroId.full_name = ".HeroNodeActRequest.heroId"
field_descriptors.HeroNodeActRequest_heroId.number = 1
field_descriptors.HeroNodeActRequest_heroId.index = 0
field_descriptors.HeroNodeActRequest_heroId.label = 1
field_descriptors.HeroNodeActRequest_heroId.has_default_value = false
field_descriptors.HeroNodeActRequest_heroId.default_value = 0
field_descriptors.HeroNodeActRequest_heroId.type = 5
field_descriptors.HeroNodeActRequest_heroId.cpp_type = 1
field_descriptors.HeroNodeActRequest_nodeId.name = "nodeId"
field_descriptors.HeroNodeActRequest_nodeId.full_name = ".HeroNodeActRequest.nodeId"
field_descriptors.HeroNodeActRequest_nodeId.number = 2
field_descriptors.HeroNodeActRequest_nodeId.index = 1
field_descriptors.HeroNodeActRequest_nodeId.label = 1
field_descriptors.HeroNodeActRequest_nodeId.has_default_value = false
field_descriptors.HeroNodeActRequest_nodeId.default_value = 0
field_descriptors.HeroNodeActRequest_nodeId.type = 5
field_descriptors.HeroNodeActRequest_nodeId.cpp_type = 1
type_descriptors.HeroNodeActRequest.name = "HeroNodeActRequest"
type_descriptors.HeroNodeActRequest.full_name = ".HeroNodeActRequest"
type_descriptors.HeroNodeActRequest.nested_types = {}
type_descriptors.HeroNodeActRequest.enum_types = {}
type_descriptors.HeroNodeActRequest.fields = {
	field_descriptors.HeroNodeActRequest_heroId,
	field_descriptors.HeroNodeActRequest_nodeId
}
type_descriptors.HeroNodeActRequest.is_extendable = false
type_descriptors.HeroNodeActRequest.extensions = {}
type_descriptors.HeroNodeActReply.name = "HeroNodeActReply"
type_descriptors.HeroNodeActReply.full_name = ".HeroNodeActReply"
type_descriptors.HeroNodeActReply.nested_types = {}
type_descriptors.HeroNodeActReply.enum_types = {}
type_descriptors.HeroNodeActReply.fields = {}
type_descriptors.HeroNodeActReply.is_extendable = false
type_descriptors.HeroNodeActReply.extensions = {}
HeroExtNodeActReply = protobuf.Message(type_descriptors.HeroExtNodeActReply)
HeroExtNodeActRequest = protobuf.Message(type_descriptors.HeroExtNodeActRequest)
HeroNodeActReply = protobuf.Message(type_descriptors.HeroNodeActReply)
HeroNodeActRequest = protobuf.Message(type_descriptors.HeroNodeActRequest)
HeroPowerActRecord = protobuf.Message(type_descriptors.HeroPowerActRecord)
HeroPowerInfoPush = protobuf.Message(type_descriptors.HeroPowerInfoPush)
HeroPowerInfoReply = protobuf.Message(type_descriptors.HeroPowerInfoReply)
HeroPowerInfoRequest = protobuf.Message(type_descriptors.HeroPowerInfoRequest)

return _G["logic.proto.HeroPowerExtension_pb"]
