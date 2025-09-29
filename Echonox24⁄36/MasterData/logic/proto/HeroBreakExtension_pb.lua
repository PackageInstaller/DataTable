-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/HeroBreakExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.HeroBreakExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.HeroBreakUpRequest = protobuf.Descriptor()
field_descriptors.HeroBreakUpRequest_heroId = protobuf.FieldDescriptor()
field_descriptors.HeroBreakUpRequest_useUniver = protobuf.FieldDescriptor()
type_descriptors.HeroComposeRequest = protobuf.Descriptor()
field_descriptors.HeroComposeRequest_itemId = protobuf.FieldDescriptor()
field_descriptors.HeroComposeRequest_multiple = protobuf.FieldDescriptor()
type_descriptors.HeroBreakUpReply = protobuf.Descriptor()
type_descriptors.HeroComposeReply = protobuf.Descriptor()
field_descriptors.HeroBreakUpRequest_heroId.name = "heroId"
field_descriptors.HeroBreakUpRequest_heroId.full_name = ".HeroBreakUpRequest.heroId"
field_descriptors.HeroBreakUpRequest_heroId.number = 1
field_descriptors.HeroBreakUpRequest_heroId.index = 0
field_descriptors.HeroBreakUpRequest_heroId.label = 1
field_descriptors.HeroBreakUpRequest_heroId.has_default_value = false
field_descriptors.HeroBreakUpRequest_heroId.default_value = 0
field_descriptors.HeroBreakUpRequest_heroId.type = 5
field_descriptors.HeroBreakUpRequest_heroId.cpp_type = 1
field_descriptors.HeroBreakUpRequest_useUniver.name = "useUniver"
field_descriptors.HeroBreakUpRequest_useUniver.full_name = ".HeroBreakUpRequest.useUniver"
field_descriptors.HeroBreakUpRequest_useUniver.number = 2
field_descriptors.HeroBreakUpRequest_useUniver.index = 1
field_descriptors.HeroBreakUpRequest_useUniver.label = 1
field_descriptors.HeroBreakUpRequest_useUniver.has_default_value = false
field_descriptors.HeroBreakUpRequest_useUniver.default_value = false
field_descriptors.HeroBreakUpRequest_useUniver.type = 8
field_descriptors.HeroBreakUpRequest_useUniver.cpp_type = 7
type_descriptors.HeroBreakUpRequest.name = "HeroBreakUpRequest"
type_descriptors.HeroBreakUpRequest.full_name = ".HeroBreakUpRequest"
type_descriptors.HeroBreakUpRequest.nested_types = {}
type_descriptors.HeroBreakUpRequest.enum_types = {}
type_descriptors.HeroBreakUpRequest.fields = {
	field_descriptors.HeroBreakUpRequest_heroId,
	field_descriptors.HeroBreakUpRequest_useUniver
}
type_descriptors.HeroBreakUpRequest.is_extendable = false
type_descriptors.HeroBreakUpRequest.extensions = {}
field_descriptors.HeroComposeRequest_itemId.name = "itemId"
field_descriptors.HeroComposeRequest_itemId.full_name = ".HeroComposeRequest.itemId"
field_descriptors.HeroComposeRequest_itemId.number = 1
field_descriptors.HeroComposeRequest_itemId.index = 0
field_descriptors.HeroComposeRequest_itemId.label = 1
field_descriptors.HeroComposeRequest_itemId.has_default_value = false
field_descriptors.HeroComposeRequest_itemId.default_value = 0
field_descriptors.HeroComposeRequest_itemId.type = 5
field_descriptors.HeroComposeRequest_itemId.cpp_type = 1
field_descriptors.HeroComposeRequest_multiple.name = "multiple"
field_descriptors.HeroComposeRequest_multiple.full_name = ".HeroComposeRequest.multiple"
field_descriptors.HeroComposeRequest_multiple.number = 2
field_descriptors.HeroComposeRequest_multiple.index = 1
field_descriptors.HeroComposeRequest_multiple.label = 1
field_descriptors.HeroComposeRequest_multiple.has_default_value = false
field_descriptors.HeroComposeRequest_multiple.default_value = 0
field_descriptors.HeroComposeRequest_multiple.type = 5
field_descriptors.HeroComposeRequest_multiple.cpp_type = 1
type_descriptors.HeroComposeRequest.name = "HeroComposeRequest"
type_descriptors.HeroComposeRequest.full_name = ".HeroComposeRequest"
type_descriptors.HeroComposeRequest.nested_types = {}
type_descriptors.HeroComposeRequest.enum_types = {}
type_descriptors.HeroComposeRequest.fields = {
	field_descriptors.HeroComposeRequest_itemId,
	field_descriptors.HeroComposeRequest_multiple
}
type_descriptors.HeroComposeRequest.is_extendable = false
type_descriptors.HeroComposeRequest.extensions = {}
type_descriptors.HeroBreakUpReply.name = "HeroBreakUpReply"
type_descriptors.HeroBreakUpReply.full_name = ".HeroBreakUpReply"
type_descriptors.HeroBreakUpReply.nested_types = {}
type_descriptors.HeroBreakUpReply.enum_types = {}
type_descriptors.HeroBreakUpReply.fields = {}
type_descriptors.HeroBreakUpReply.is_extendable = false
type_descriptors.HeroBreakUpReply.extensions = {}
type_descriptors.HeroComposeReply.name = "HeroComposeReply"
type_descriptors.HeroComposeReply.full_name = ".HeroComposeReply"
type_descriptors.HeroComposeReply.nested_types = {}
type_descriptors.HeroComposeReply.enum_types = {}
type_descriptors.HeroComposeReply.fields = {}
type_descriptors.HeroComposeReply.is_extendable = false
type_descriptors.HeroComposeReply.extensions = {}
HeroBreakUpReply = protobuf.Message(type_descriptors.HeroBreakUpReply)
HeroBreakUpRequest = protobuf.Message(type_descriptors.HeroBreakUpRequest)
HeroComposeReply = protobuf.Message(type_descriptors.HeroComposeReply)
HeroComposeRequest = protobuf.Message(type_descriptors.HeroComposeRequest)

return _G["logic.proto.HeroBreakExtension_pb"]
