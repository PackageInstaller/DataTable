-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/NotifyExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.NotifyExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.UploadCidRequest = protobuf.Descriptor()
field_descriptors.UploadCidRequest_cid = protobuf.FieldDescriptor()
type_descriptors.NotifyEntryNO = protobuf.Descriptor()
field_descriptors.NotifyEntryNO_type = protobuf.FieldDescriptor()
field_descriptors.NotifyEntryNO_data = protobuf.FieldDescriptor()
type_descriptors.UploadCidReply = protobuf.Descriptor()
type_descriptors.NotifyPush = protobuf.Descriptor()
field_descriptors.NotifyPush_notify = protobuf.FieldDescriptor()
field_descriptors.UploadCidRequest_cid.name = "cid"
field_descriptors.UploadCidRequest_cid.full_name = ".UploadCidRequest.cid"
field_descriptors.UploadCidRequest_cid.number = 1
field_descriptors.UploadCidRequest_cid.index = 0
field_descriptors.UploadCidRequest_cid.label = 2
field_descriptors.UploadCidRequest_cid.has_default_value = false
field_descriptors.UploadCidRequest_cid.default_value = ""
field_descriptors.UploadCidRequest_cid.type = 9
field_descriptors.UploadCidRequest_cid.cpp_type = 9
type_descriptors.UploadCidRequest.name = "UploadCidRequest"
type_descriptors.UploadCidRequest.full_name = ".UploadCidRequest"
type_descriptors.UploadCidRequest.nested_types = {}
type_descriptors.UploadCidRequest.enum_types = {}
type_descriptors.UploadCidRequest.fields = {
	field_descriptors.UploadCidRequest_cid
}
type_descriptors.UploadCidRequest.is_extendable = false
type_descriptors.UploadCidRequest.extensions = {}
field_descriptors.NotifyEntryNO_type.name = "type"
field_descriptors.NotifyEntryNO_type.full_name = ".NotifyEntryNO.type"
field_descriptors.NotifyEntryNO_type.number = 1
field_descriptors.NotifyEntryNO_type.index = 0
field_descriptors.NotifyEntryNO_type.label = 2
field_descriptors.NotifyEntryNO_type.has_default_value = false
field_descriptors.NotifyEntryNO_type.default_value = 0
field_descriptors.NotifyEntryNO_type.type = 5
field_descriptors.NotifyEntryNO_type.cpp_type = 1
field_descriptors.NotifyEntryNO_data.name = "data"
field_descriptors.NotifyEntryNO_data.full_name = ".NotifyEntryNO.data"
field_descriptors.NotifyEntryNO_data.number = 2
field_descriptors.NotifyEntryNO_data.index = 1
field_descriptors.NotifyEntryNO_data.label = 1
field_descriptors.NotifyEntryNO_data.has_default_value = false
field_descriptors.NotifyEntryNO_data.default_value = ""
field_descriptors.NotifyEntryNO_data.type = 9
field_descriptors.NotifyEntryNO_data.cpp_type = 9
type_descriptors.NotifyEntryNO.name = "NotifyEntryNO"
type_descriptors.NotifyEntryNO.full_name = ".NotifyEntryNO"
type_descriptors.NotifyEntryNO.nested_types = {}
type_descriptors.NotifyEntryNO.enum_types = {}
type_descriptors.NotifyEntryNO.fields = {
	field_descriptors.NotifyEntryNO_type,
	field_descriptors.NotifyEntryNO_data
}
type_descriptors.NotifyEntryNO.is_extendable = false
type_descriptors.NotifyEntryNO.extensions = {}
type_descriptors.UploadCidReply.name = "UploadCidReply"
type_descriptors.UploadCidReply.full_name = ".UploadCidReply"
type_descriptors.UploadCidReply.nested_types = {}
type_descriptors.UploadCidReply.enum_types = {}
type_descriptors.UploadCidReply.fields = {}
type_descriptors.UploadCidReply.is_extendable = false
type_descriptors.UploadCidReply.extensions = {}
field_descriptors.NotifyPush_notify.name = "notify"
field_descriptors.NotifyPush_notify.full_name = ".NotifyPush.notify"
field_descriptors.NotifyPush_notify.number = 1
field_descriptors.NotifyPush_notify.index = 0
field_descriptors.NotifyPush_notify.label = 3
field_descriptors.NotifyPush_notify.has_default_value = false
field_descriptors.NotifyPush_notify.default_value = {}
field_descriptors.NotifyPush_notify.message_type = type_descriptors.NotifyEntryNO
field_descriptors.NotifyPush_notify.type = 11
field_descriptors.NotifyPush_notify.cpp_type = 10
type_descriptors.NotifyPush.name = "NotifyPush"
type_descriptors.NotifyPush.full_name = ".NotifyPush"
type_descriptors.NotifyPush.nested_types = {}
type_descriptors.NotifyPush.enum_types = {}
type_descriptors.NotifyPush.fields = {
	field_descriptors.NotifyPush_notify
}
type_descriptors.NotifyPush.is_extendable = false
type_descriptors.NotifyPush.extensions = {}
NotifyEntryNO = protobuf.Message(type_descriptors.NotifyEntryNO)
NotifyPush = protobuf.Message(type_descriptors.NotifyPush)
UploadCidReply = protobuf.Message(type_descriptors.UploadCidReply)
UploadCidRequest = protobuf.Message(type_descriptors.UploadCidRequest)

return _G["logic.proto.NotifyExtension_pb"]
