-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/RedPointExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.RedPointExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.RedPointNO = protobuf.Descriptor()
field_descriptors.RedPointNO_type = protobuf.FieldDescriptor()
field_descriptors.RedPointNO_detail = protobuf.FieldDescriptor()
type_descriptors.ChangeRedPointPush = protobuf.Descriptor()
field_descriptors.ChangeRedPointPush_add = protobuf.FieldDescriptor()
field_descriptors.ChangeRedPointPush_remove = protobuf.FieldDescriptor()
type_descriptors.RemoveRedPointRequest = protobuf.Descriptor()
field_descriptors.RemoveRedPointRequest_redPoint = protobuf.FieldDescriptor()
type_descriptors.LoadAllRedPointRequest = protobuf.Descriptor()
type_descriptors.LoadAllRedPointReply = protobuf.Descriptor()
field_descriptors.LoadAllRedPointReply_redPoints = protobuf.FieldDescriptor()
type_descriptors.RemoveRedPointReply = protobuf.Descriptor()
field_descriptors.RedPointNO_type.name = "type"
field_descriptors.RedPointNO_type.full_name = ".RedPointNO.type"
field_descriptors.RedPointNO_type.number = 1
field_descriptors.RedPointNO_type.index = 0
field_descriptors.RedPointNO_type.label = 2
field_descriptors.RedPointNO_type.has_default_value = false
field_descriptors.RedPointNO_type.default_value = 0
field_descriptors.RedPointNO_type.type = 5
field_descriptors.RedPointNO_type.cpp_type = 1
field_descriptors.RedPointNO_detail.name = "detail"
field_descriptors.RedPointNO_detail.full_name = ".RedPointNO.detail"
field_descriptors.RedPointNO_detail.number = 2
field_descriptors.RedPointNO_detail.index = 1
field_descriptors.RedPointNO_detail.label = 1
field_descriptors.RedPointNO_detail.has_default_value = false
field_descriptors.RedPointNO_detail.default_value = ""
field_descriptors.RedPointNO_detail.type = 9
field_descriptors.RedPointNO_detail.cpp_type = 9
type_descriptors.RedPointNO.name = "RedPointNO"
type_descriptors.RedPointNO.full_name = ".RedPointNO"
type_descriptors.RedPointNO.nested_types = {}
type_descriptors.RedPointNO.enum_types = {}
type_descriptors.RedPointNO.fields = {
	field_descriptors.RedPointNO_type,
	field_descriptors.RedPointNO_detail
}
type_descriptors.RedPointNO.is_extendable = false
type_descriptors.RedPointNO.extensions = {}
field_descriptors.ChangeRedPointPush_add.name = "add"
field_descriptors.ChangeRedPointPush_add.full_name = ".ChangeRedPointPush.add"
field_descriptors.ChangeRedPointPush_add.number = 1
field_descriptors.ChangeRedPointPush_add.index = 0
field_descriptors.ChangeRedPointPush_add.label = 1
field_descriptors.ChangeRedPointPush_add.has_default_value = false
field_descriptors.ChangeRedPointPush_add.default_value = nil
field_descriptors.ChangeRedPointPush_add.message_type = type_descriptors.RedPointNO
field_descriptors.ChangeRedPointPush_add.type = 11
field_descriptors.ChangeRedPointPush_add.cpp_type = 10
field_descriptors.ChangeRedPointPush_remove.name = "remove"
field_descriptors.ChangeRedPointPush_remove.full_name = ".ChangeRedPointPush.remove"
field_descriptors.ChangeRedPointPush_remove.number = 2
field_descriptors.ChangeRedPointPush_remove.index = 1
field_descriptors.ChangeRedPointPush_remove.label = 1
field_descriptors.ChangeRedPointPush_remove.has_default_value = false
field_descriptors.ChangeRedPointPush_remove.default_value = nil
field_descriptors.ChangeRedPointPush_remove.message_type = type_descriptors.RedPointNO
field_descriptors.ChangeRedPointPush_remove.type = 11
field_descriptors.ChangeRedPointPush_remove.cpp_type = 10
type_descriptors.ChangeRedPointPush.name = "ChangeRedPointPush"
type_descriptors.ChangeRedPointPush.full_name = ".ChangeRedPointPush"
type_descriptors.ChangeRedPointPush.nested_types = {}
type_descriptors.ChangeRedPointPush.enum_types = {}
type_descriptors.ChangeRedPointPush.fields = {
	field_descriptors.ChangeRedPointPush_add,
	field_descriptors.ChangeRedPointPush_remove
}
type_descriptors.ChangeRedPointPush.is_extendable = false
type_descriptors.ChangeRedPointPush.extensions = {}
field_descriptors.RemoveRedPointRequest_redPoint.name = "redPoint"
field_descriptors.RemoveRedPointRequest_redPoint.full_name = ".RemoveRedPointRequest.redPoint"
field_descriptors.RemoveRedPointRequest_redPoint.number = 1
field_descriptors.RemoveRedPointRequest_redPoint.index = 0
field_descriptors.RemoveRedPointRequest_redPoint.label = 2
field_descriptors.RemoveRedPointRequest_redPoint.has_default_value = false
field_descriptors.RemoveRedPointRequest_redPoint.default_value = nil
field_descriptors.RemoveRedPointRequest_redPoint.message_type = type_descriptors.RedPointNO
field_descriptors.RemoveRedPointRequest_redPoint.type = 11
field_descriptors.RemoveRedPointRequest_redPoint.cpp_type = 10
type_descriptors.RemoveRedPointRequest.name = "RemoveRedPointRequest"
type_descriptors.RemoveRedPointRequest.full_name = ".RemoveRedPointRequest"
type_descriptors.RemoveRedPointRequest.nested_types = {}
type_descriptors.RemoveRedPointRequest.enum_types = {}
type_descriptors.RemoveRedPointRequest.fields = {
	field_descriptors.RemoveRedPointRequest_redPoint
}
type_descriptors.RemoveRedPointRequest.is_extendable = false
type_descriptors.RemoveRedPointRequest.extensions = {}
type_descriptors.LoadAllRedPointRequest.name = "LoadAllRedPointRequest"
type_descriptors.LoadAllRedPointRequest.full_name = ".LoadAllRedPointRequest"
type_descriptors.LoadAllRedPointRequest.nested_types = {}
type_descriptors.LoadAllRedPointRequest.enum_types = {}
type_descriptors.LoadAllRedPointRequest.fields = {}
type_descriptors.LoadAllRedPointRequest.is_extendable = false
type_descriptors.LoadAllRedPointRequest.extensions = {}
field_descriptors.LoadAllRedPointReply_redPoints.name = "redPoints"
field_descriptors.LoadAllRedPointReply_redPoints.full_name = ".LoadAllRedPointReply.redPoints"
field_descriptors.LoadAllRedPointReply_redPoints.number = 1
field_descriptors.LoadAllRedPointReply_redPoints.index = 0
field_descriptors.LoadAllRedPointReply_redPoints.label = 3
field_descriptors.LoadAllRedPointReply_redPoints.has_default_value = false
field_descriptors.LoadAllRedPointReply_redPoints.default_value = {}
field_descriptors.LoadAllRedPointReply_redPoints.message_type = type_descriptors.RedPointNO
field_descriptors.LoadAllRedPointReply_redPoints.type = 11
field_descriptors.LoadAllRedPointReply_redPoints.cpp_type = 10
type_descriptors.LoadAllRedPointReply.name = "LoadAllRedPointReply"
type_descriptors.LoadAllRedPointReply.full_name = ".LoadAllRedPointReply"
type_descriptors.LoadAllRedPointReply.nested_types = {}
type_descriptors.LoadAllRedPointReply.enum_types = {}
type_descriptors.LoadAllRedPointReply.fields = {
	field_descriptors.LoadAllRedPointReply_redPoints
}
type_descriptors.LoadAllRedPointReply.is_extendable = false
type_descriptors.LoadAllRedPointReply.extensions = {}
type_descriptors.RemoveRedPointReply.name = "RemoveRedPointReply"
type_descriptors.RemoveRedPointReply.full_name = ".RemoveRedPointReply"
type_descriptors.RemoveRedPointReply.nested_types = {}
type_descriptors.RemoveRedPointReply.enum_types = {}
type_descriptors.RemoveRedPointReply.fields = {}
type_descriptors.RemoveRedPointReply.is_extendable = false
type_descriptors.RemoveRedPointReply.extensions = {}
ChangeRedPointPush = protobuf.Message(type_descriptors.ChangeRedPointPush)
LoadAllRedPointReply = protobuf.Message(type_descriptors.LoadAllRedPointReply)
LoadAllRedPointRequest = protobuf.Message(type_descriptors.LoadAllRedPointRequest)
RedPointNO = protobuf.Message(type_descriptors.RedPointNO)
RemoveRedPointReply = protobuf.Message(type_descriptors.RemoveRedPointReply)
RemoveRedPointRequest = protobuf.Message(type_descriptors.RemoveRedPointRequest)

return _G["logic.proto.RedPointExtension_pb"]
