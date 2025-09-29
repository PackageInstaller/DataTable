-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/AirtightRoomExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.AirtightRoomExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.ExperienceAirtightRoomReply = protobuf.Descriptor()
type_descriptors.GetAirtightRoomInfoReply = protobuf.Descriptor()
field_descriptors.GetAirtightRoomInfoReply_exitTime = protobuf.FieldDescriptor()
type_descriptors.AirtightRoomStatusChangePush = protobuf.Descriptor()
field_descriptors.AirtightRoomStatusChangePush_exitTime = protobuf.FieldDescriptor()
type_descriptors.ExperienceAirtightRoomRequest = protobuf.Descriptor()
type_descriptors.GetAirtightRoomInfoRequest = protobuf.Descriptor()
type_descriptors.EnterAirtightRoomReply = protobuf.Descriptor()
type_descriptors.EnterAirtightRoomRequest = protobuf.Descriptor()
type_descriptors.ExperienceAirtightRoomReply.name = "ExperienceAirtightRoomReply"
type_descriptors.ExperienceAirtightRoomReply.full_name = ".ExperienceAirtightRoomReply"
type_descriptors.ExperienceAirtightRoomReply.nested_types = {}
type_descriptors.ExperienceAirtightRoomReply.enum_types = {}
type_descriptors.ExperienceAirtightRoomReply.fields = {}
type_descriptors.ExperienceAirtightRoomReply.is_extendable = false
type_descriptors.ExperienceAirtightRoomReply.extensions = {}
field_descriptors.GetAirtightRoomInfoReply_exitTime.name = "exitTime"
field_descriptors.GetAirtightRoomInfoReply_exitTime.full_name = ".GetAirtightRoomInfoReply.exitTime"
field_descriptors.GetAirtightRoomInfoReply_exitTime.number = 1
field_descriptors.GetAirtightRoomInfoReply_exitTime.index = 0
field_descriptors.GetAirtightRoomInfoReply_exitTime.label = 1
field_descriptors.GetAirtightRoomInfoReply_exitTime.has_default_value = false
field_descriptors.GetAirtightRoomInfoReply_exitTime.default_value = 0
field_descriptors.GetAirtightRoomInfoReply_exitTime.type = 3
field_descriptors.GetAirtightRoomInfoReply_exitTime.cpp_type = 2
type_descriptors.GetAirtightRoomInfoReply.name = "GetAirtightRoomInfoReply"
type_descriptors.GetAirtightRoomInfoReply.full_name = ".GetAirtightRoomInfoReply"
type_descriptors.GetAirtightRoomInfoReply.nested_types = {}
type_descriptors.GetAirtightRoomInfoReply.enum_types = {}
type_descriptors.GetAirtightRoomInfoReply.fields = {
	field_descriptors.GetAirtightRoomInfoReply_exitTime
}
type_descriptors.GetAirtightRoomInfoReply.is_extendable = false
type_descriptors.GetAirtightRoomInfoReply.extensions = {}
field_descriptors.AirtightRoomStatusChangePush_exitTime.name = "exitTime"
field_descriptors.AirtightRoomStatusChangePush_exitTime.full_name = ".AirtightRoomStatusChangePush.exitTime"
field_descriptors.AirtightRoomStatusChangePush_exitTime.number = 1
field_descriptors.AirtightRoomStatusChangePush_exitTime.index = 0
field_descriptors.AirtightRoomStatusChangePush_exitTime.label = 1
field_descriptors.AirtightRoomStatusChangePush_exitTime.has_default_value = false
field_descriptors.AirtightRoomStatusChangePush_exitTime.default_value = 0
field_descriptors.AirtightRoomStatusChangePush_exitTime.type = 3
field_descriptors.AirtightRoomStatusChangePush_exitTime.cpp_type = 2
type_descriptors.AirtightRoomStatusChangePush.name = "AirtightRoomStatusChangePush"
type_descriptors.AirtightRoomStatusChangePush.full_name = ".AirtightRoomStatusChangePush"
type_descriptors.AirtightRoomStatusChangePush.nested_types = {}
type_descriptors.AirtightRoomStatusChangePush.enum_types = {}
type_descriptors.AirtightRoomStatusChangePush.fields = {
	field_descriptors.AirtightRoomStatusChangePush_exitTime
}
type_descriptors.AirtightRoomStatusChangePush.is_extendable = false
type_descriptors.AirtightRoomStatusChangePush.extensions = {}
type_descriptors.ExperienceAirtightRoomRequest.name = "ExperienceAirtightRoomRequest"
type_descriptors.ExperienceAirtightRoomRequest.full_name = ".ExperienceAirtightRoomRequest"
type_descriptors.ExperienceAirtightRoomRequest.nested_types = {}
type_descriptors.ExperienceAirtightRoomRequest.enum_types = {}
type_descriptors.ExperienceAirtightRoomRequest.fields = {}
type_descriptors.ExperienceAirtightRoomRequest.is_extendable = false
type_descriptors.ExperienceAirtightRoomRequest.extensions = {}
type_descriptors.GetAirtightRoomInfoRequest.name = "GetAirtightRoomInfoRequest"
type_descriptors.GetAirtightRoomInfoRequest.full_name = ".GetAirtightRoomInfoRequest"
type_descriptors.GetAirtightRoomInfoRequest.nested_types = {}
type_descriptors.GetAirtightRoomInfoRequest.enum_types = {}
type_descriptors.GetAirtightRoomInfoRequest.fields = {}
type_descriptors.GetAirtightRoomInfoRequest.is_extendable = false
type_descriptors.GetAirtightRoomInfoRequest.extensions = {}
type_descriptors.EnterAirtightRoomReply.name = "EnterAirtightRoomReply"
type_descriptors.EnterAirtightRoomReply.full_name = ".EnterAirtightRoomReply"
type_descriptors.EnterAirtightRoomReply.nested_types = {}
type_descriptors.EnterAirtightRoomReply.enum_types = {}
type_descriptors.EnterAirtightRoomReply.fields = {}
type_descriptors.EnterAirtightRoomReply.is_extendable = false
type_descriptors.EnterAirtightRoomReply.extensions = {}
type_descriptors.EnterAirtightRoomRequest.name = "EnterAirtightRoomRequest"
type_descriptors.EnterAirtightRoomRequest.full_name = ".EnterAirtightRoomRequest"
type_descriptors.EnterAirtightRoomRequest.nested_types = {}
type_descriptors.EnterAirtightRoomRequest.enum_types = {}
type_descriptors.EnterAirtightRoomRequest.fields = {}
type_descriptors.EnterAirtightRoomRequest.is_extendable = false
type_descriptors.EnterAirtightRoomRequest.extensions = {}
AirtightRoomStatusChangePush = protobuf.Message(type_descriptors.AirtightRoomStatusChangePush)
EnterAirtightRoomReply = protobuf.Message(type_descriptors.EnterAirtightRoomReply)
EnterAirtightRoomRequest = protobuf.Message(type_descriptors.EnterAirtightRoomRequest)
ExperienceAirtightRoomReply = protobuf.Message(type_descriptors.ExperienceAirtightRoomReply)
ExperienceAirtightRoomRequest = protobuf.Message(type_descriptors.ExperienceAirtightRoomRequest)
GetAirtightRoomInfoReply = protobuf.Message(type_descriptors.GetAirtightRoomInfoReply)
GetAirtightRoomInfoRequest = protobuf.Message(type_descriptors.GetAirtightRoomInfoRequest)

return _G["logic.proto.AirtightRoomExtension_pb"]
