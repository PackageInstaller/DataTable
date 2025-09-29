-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/EchoItemExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.EchoItemExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.LockEchoItemRequest = protobuf.Descriptor()
field_descriptors.LockEchoItemRequest_uuid = protobuf.FieldDescriptor()
field_descriptors.LockEchoItemRequest_locked = protobuf.FieldDescriptor()
type_descriptors.DecomposeEchoItemRequest = protobuf.Descriptor()
field_descriptors.DecomposeEchoItemRequest_uuids = protobuf.FieldDescriptor()
type_descriptors.GetEchoItemInfoReply = protobuf.Descriptor()
field_descriptors.GetEchoItemInfoReply_items = protobuf.FieldDescriptor()
type_descriptors.UpgradeEchoItemReply = protobuf.Descriptor()
type_descriptors.GetEchoItemInfoRequest = protobuf.Descriptor()
type_descriptors.ChangeEchoItemPush = protobuf.Descriptor()
field_descriptors.ChangeEchoItemPush_items = protobuf.FieldDescriptor()
type_descriptors.EchoItemNO = protobuf.Descriptor()
field_descriptors.EchoItemNO_uuid = protobuf.FieldDescriptor()
field_descriptors.EchoItemNO_level = protobuf.FieldDescriptor()
field_descriptors.EchoItemNO_hero = protobuf.FieldDescriptor()
type_descriptors.DecomposeEchoItemReply = protobuf.Descriptor()
type_descriptors.WearEchoItemRequest = protobuf.Descriptor()
field_descriptors.WearEchoItemRequest_uuid = protobuf.FieldDescriptor()
field_descriptors.WearEchoItemRequest_hero = protobuf.FieldDescriptor()
type_descriptors.WearEchoItemReply = protobuf.Descriptor()
type_descriptors.LockEchoItemReply = protobuf.Descriptor()
type_descriptors.UpgradeEchoItemRequest = protobuf.Descriptor()
field_descriptors.UpgradeEchoItemRequest_target = protobuf.FieldDescriptor()
field_descriptors.UpgradeEchoItemRequest_sources = protobuf.FieldDescriptor()
field_descriptors.LockEchoItemRequest_uuid.name = "uuid"
field_descriptors.LockEchoItemRequest_uuid.full_name = ".LockEchoItemRequest.uuid"
field_descriptors.LockEchoItemRequest_uuid.number = 1
field_descriptors.LockEchoItemRequest_uuid.index = 0
field_descriptors.LockEchoItemRequest_uuid.label = 1
field_descriptors.LockEchoItemRequest_uuid.has_default_value = false
field_descriptors.LockEchoItemRequest_uuid.default_value = 0
field_descriptors.LockEchoItemRequest_uuid.type = 3
field_descriptors.LockEchoItemRequest_uuid.cpp_type = 2
field_descriptors.LockEchoItemRequest_locked.name = "locked"
field_descriptors.LockEchoItemRequest_locked.full_name = ".LockEchoItemRequest.locked"
field_descriptors.LockEchoItemRequest_locked.number = 2
field_descriptors.LockEchoItemRequest_locked.index = 1
field_descriptors.LockEchoItemRequest_locked.label = 1
field_descriptors.LockEchoItemRequest_locked.has_default_value = false
field_descriptors.LockEchoItemRequest_locked.default_value = false
field_descriptors.LockEchoItemRequest_locked.type = 8
field_descriptors.LockEchoItemRequest_locked.cpp_type = 7
type_descriptors.LockEchoItemRequest.name = "LockEchoItemRequest"
type_descriptors.LockEchoItemRequest.full_name = ".LockEchoItemRequest"
type_descriptors.LockEchoItemRequest.nested_types = {}
type_descriptors.LockEchoItemRequest.enum_types = {}
type_descriptors.LockEchoItemRequest.fields = {
	field_descriptors.LockEchoItemRequest_uuid,
	field_descriptors.LockEchoItemRequest_locked
}
type_descriptors.LockEchoItemRequest.is_extendable = false
type_descriptors.LockEchoItemRequest.extensions = {}
field_descriptors.DecomposeEchoItemRequest_uuids.name = "uuids"
field_descriptors.DecomposeEchoItemRequest_uuids.full_name = ".DecomposeEchoItemRequest.uuids"
field_descriptors.DecomposeEchoItemRequest_uuids.number = 1
field_descriptors.DecomposeEchoItemRequest_uuids.index = 0
field_descriptors.DecomposeEchoItemRequest_uuids.label = 3
field_descriptors.DecomposeEchoItemRequest_uuids.has_default_value = false
field_descriptors.DecomposeEchoItemRequest_uuids.default_value = {}
field_descriptors.DecomposeEchoItemRequest_uuids.type = 3
field_descriptors.DecomposeEchoItemRequest_uuids.cpp_type = 2
type_descriptors.DecomposeEchoItemRequest.name = "DecomposeEchoItemRequest"
type_descriptors.DecomposeEchoItemRequest.full_name = ".DecomposeEchoItemRequest"
type_descriptors.DecomposeEchoItemRequest.nested_types = {}
type_descriptors.DecomposeEchoItemRequest.enum_types = {}
type_descriptors.DecomposeEchoItemRequest.fields = {
	field_descriptors.DecomposeEchoItemRequest_uuids
}
type_descriptors.DecomposeEchoItemRequest.is_extendable = false
type_descriptors.DecomposeEchoItemRequest.extensions = {}
field_descriptors.GetEchoItemInfoReply_items.name = "items"
field_descriptors.GetEchoItemInfoReply_items.full_name = ".GetEchoItemInfoReply.items"
field_descriptors.GetEchoItemInfoReply_items.number = 1
field_descriptors.GetEchoItemInfoReply_items.index = 0
field_descriptors.GetEchoItemInfoReply_items.label = 3
field_descriptors.GetEchoItemInfoReply_items.has_default_value = false
field_descriptors.GetEchoItemInfoReply_items.default_value = {}
field_descriptors.GetEchoItemInfoReply_items.message_type = type_descriptors.EchoItemNO
field_descriptors.GetEchoItemInfoReply_items.type = 11
field_descriptors.GetEchoItemInfoReply_items.cpp_type = 10
type_descriptors.GetEchoItemInfoReply.name = "GetEchoItemInfoReply"
type_descriptors.GetEchoItemInfoReply.full_name = ".GetEchoItemInfoReply"
type_descriptors.GetEchoItemInfoReply.nested_types = {}
type_descriptors.GetEchoItemInfoReply.enum_types = {}
type_descriptors.GetEchoItemInfoReply.fields = {
	field_descriptors.GetEchoItemInfoReply_items
}
type_descriptors.GetEchoItemInfoReply.is_extendable = false
type_descriptors.GetEchoItemInfoReply.extensions = {}
type_descriptors.UpgradeEchoItemReply.name = "UpgradeEchoItemReply"
type_descriptors.UpgradeEchoItemReply.full_name = ".UpgradeEchoItemReply"
type_descriptors.UpgradeEchoItemReply.nested_types = {}
type_descriptors.UpgradeEchoItemReply.enum_types = {}
type_descriptors.UpgradeEchoItemReply.fields = {}
type_descriptors.UpgradeEchoItemReply.is_extendable = false
type_descriptors.UpgradeEchoItemReply.extensions = {}
type_descriptors.GetEchoItemInfoRequest.name = "GetEchoItemInfoRequest"
type_descriptors.GetEchoItemInfoRequest.full_name = ".GetEchoItemInfoRequest"
type_descriptors.GetEchoItemInfoRequest.nested_types = {}
type_descriptors.GetEchoItemInfoRequest.enum_types = {}
type_descriptors.GetEchoItemInfoRequest.fields = {}
type_descriptors.GetEchoItemInfoRequest.is_extendable = false
type_descriptors.GetEchoItemInfoRequest.extensions = {}
field_descriptors.ChangeEchoItemPush_items.name = "items"
field_descriptors.ChangeEchoItemPush_items.full_name = ".ChangeEchoItemPush.items"
field_descriptors.ChangeEchoItemPush_items.number = 1
field_descriptors.ChangeEchoItemPush_items.index = 0
field_descriptors.ChangeEchoItemPush_items.label = 3
field_descriptors.ChangeEchoItemPush_items.has_default_value = false
field_descriptors.ChangeEchoItemPush_items.default_value = {}
field_descriptors.ChangeEchoItemPush_items.message_type = type_descriptors.EchoItemNO
field_descriptors.ChangeEchoItemPush_items.type = 11
field_descriptors.ChangeEchoItemPush_items.cpp_type = 10
type_descriptors.ChangeEchoItemPush.name = "ChangeEchoItemPush"
type_descriptors.ChangeEchoItemPush.full_name = ".ChangeEchoItemPush"
type_descriptors.ChangeEchoItemPush.nested_types = {}
type_descriptors.ChangeEchoItemPush.enum_types = {}
type_descriptors.ChangeEchoItemPush.fields = {
	field_descriptors.ChangeEchoItemPush_items
}
type_descriptors.ChangeEchoItemPush.is_extendable = false
type_descriptors.ChangeEchoItemPush.extensions = {}
field_descriptors.EchoItemNO_uuid.name = "uuid"
field_descriptors.EchoItemNO_uuid.full_name = ".EchoItemNO.uuid"
field_descriptors.EchoItemNO_uuid.number = 1
field_descriptors.EchoItemNO_uuid.index = 0
field_descriptors.EchoItemNO_uuid.label = 1
field_descriptors.EchoItemNO_uuid.has_default_value = false
field_descriptors.EchoItemNO_uuid.default_value = 0
field_descriptors.EchoItemNO_uuid.type = 3
field_descriptors.EchoItemNO_uuid.cpp_type = 2
field_descriptors.EchoItemNO_level.name = "level"
field_descriptors.EchoItemNO_level.full_name = ".EchoItemNO.level"
field_descriptors.EchoItemNO_level.number = 2
field_descriptors.EchoItemNO_level.index = 1
field_descriptors.EchoItemNO_level.label = 1
field_descriptors.EchoItemNO_level.has_default_value = false
field_descriptors.EchoItemNO_level.default_value = 0
field_descriptors.EchoItemNO_level.type = 5
field_descriptors.EchoItemNO_level.cpp_type = 1
field_descriptors.EchoItemNO_hero.name = "hero"
field_descriptors.EchoItemNO_hero.full_name = ".EchoItemNO.hero"
field_descriptors.EchoItemNO_hero.number = 3
field_descriptors.EchoItemNO_hero.index = 2
field_descriptors.EchoItemNO_hero.label = 1
field_descriptors.EchoItemNO_hero.has_default_value = false
field_descriptors.EchoItemNO_hero.default_value = 0
field_descriptors.EchoItemNO_hero.type = 5
field_descriptors.EchoItemNO_hero.cpp_type = 1
type_descriptors.EchoItemNO.name = "EchoItemNO"
type_descriptors.EchoItemNO.full_name = ".EchoItemNO"
type_descriptors.EchoItemNO.nested_types = {}
type_descriptors.EchoItemNO.enum_types = {}
type_descriptors.EchoItemNO.fields = {
	field_descriptors.EchoItemNO_uuid,
	field_descriptors.EchoItemNO_level,
	field_descriptors.EchoItemNO_hero
}
type_descriptors.EchoItemNO.is_extendable = false
type_descriptors.EchoItemNO.extensions = {}
type_descriptors.DecomposeEchoItemReply.name = "DecomposeEchoItemReply"
type_descriptors.DecomposeEchoItemReply.full_name = ".DecomposeEchoItemReply"
type_descriptors.DecomposeEchoItemReply.nested_types = {}
type_descriptors.DecomposeEchoItemReply.enum_types = {}
type_descriptors.DecomposeEchoItemReply.fields = {}
type_descriptors.DecomposeEchoItemReply.is_extendable = false
type_descriptors.DecomposeEchoItemReply.extensions = {}
field_descriptors.WearEchoItemRequest_uuid.name = "uuid"
field_descriptors.WearEchoItemRequest_uuid.full_name = ".WearEchoItemRequest.uuid"
field_descriptors.WearEchoItemRequest_uuid.number = 1
field_descriptors.WearEchoItemRequest_uuid.index = 0
field_descriptors.WearEchoItemRequest_uuid.label = 1
field_descriptors.WearEchoItemRequest_uuid.has_default_value = false
field_descriptors.WearEchoItemRequest_uuid.default_value = 0
field_descriptors.WearEchoItemRequest_uuid.type = 3
field_descriptors.WearEchoItemRequest_uuid.cpp_type = 2
field_descriptors.WearEchoItemRequest_hero.name = "hero"
field_descriptors.WearEchoItemRequest_hero.full_name = ".WearEchoItemRequest.hero"
field_descriptors.WearEchoItemRequest_hero.number = 2
field_descriptors.WearEchoItemRequest_hero.index = 1
field_descriptors.WearEchoItemRequest_hero.label = 1
field_descriptors.WearEchoItemRequest_hero.has_default_value = false
field_descriptors.WearEchoItemRequest_hero.default_value = 0
field_descriptors.WearEchoItemRequest_hero.type = 5
field_descriptors.WearEchoItemRequest_hero.cpp_type = 1
type_descriptors.WearEchoItemRequest.name = "WearEchoItemRequest"
type_descriptors.WearEchoItemRequest.full_name = ".WearEchoItemRequest"
type_descriptors.WearEchoItemRequest.nested_types = {}
type_descriptors.WearEchoItemRequest.enum_types = {}
type_descriptors.WearEchoItemRequest.fields = {
	field_descriptors.WearEchoItemRequest_uuid,
	field_descriptors.WearEchoItemRequest_hero
}
type_descriptors.WearEchoItemRequest.is_extendable = false
type_descriptors.WearEchoItemRequest.extensions = {}
type_descriptors.WearEchoItemReply.name = "WearEchoItemReply"
type_descriptors.WearEchoItemReply.full_name = ".WearEchoItemReply"
type_descriptors.WearEchoItemReply.nested_types = {}
type_descriptors.WearEchoItemReply.enum_types = {}
type_descriptors.WearEchoItemReply.fields = {}
type_descriptors.WearEchoItemReply.is_extendable = false
type_descriptors.WearEchoItemReply.extensions = {}
type_descriptors.LockEchoItemReply.name = "LockEchoItemReply"
type_descriptors.LockEchoItemReply.full_name = ".LockEchoItemReply"
type_descriptors.LockEchoItemReply.nested_types = {}
type_descriptors.LockEchoItemReply.enum_types = {}
type_descriptors.LockEchoItemReply.fields = {}
type_descriptors.LockEchoItemReply.is_extendable = false
type_descriptors.LockEchoItemReply.extensions = {}
field_descriptors.UpgradeEchoItemRequest_target.name = "target"
field_descriptors.UpgradeEchoItemRequest_target.full_name = ".UpgradeEchoItemRequest.target"
field_descriptors.UpgradeEchoItemRequest_target.number = 1
field_descriptors.UpgradeEchoItemRequest_target.index = 0
field_descriptors.UpgradeEchoItemRequest_target.label = 1
field_descriptors.UpgradeEchoItemRequest_target.has_default_value = false
field_descriptors.UpgradeEchoItemRequest_target.default_value = 0
field_descriptors.UpgradeEchoItemRequest_target.type = 3
field_descriptors.UpgradeEchoItemRequest_target.cpp_type = 2
field_descriptors.UpgradeEchoItemRequest_sources.name = "sources"
field_descriptors.UpgradeEchoItemRequest_sources.full_name = ".UpgradeEchoItemRequest.sources"
field_descriptors.UpgradeEchoItemRequest_sources.number = 2
field_descriptors.UpgradeEchoItemRequest_sources.index = 1
field_descriptors.UpgradeEchoItemRequest_sources.label = 3
field_descriptors.UpgradeEchoItemRequest_sources.has_default_value = false
field_descriptors.UpgradeEchoItemRequest_sources.default_value = {}
field_descriptors.UpgradeEchoItemRequest_sources.type = 3
field_descriptors.UpgradeEchoItemRequest_sources.cpp_type = 2
type_descriptors.UpgradeEchoItemRequest.name = "UpgradeEchoItemRequest"
type_descriptors.UpgradeEchoItemRequest.full_name = ".UpgradeEchoItemRequest"
type_descriptors.UpgradeEchoItemRequest.nested_types = {}
type_descriptors.UpgradeEchoItemRequest.enum_types = {}
type_descriptors.UpgradeEchoItemRequest.fields = {
	field_descriptors.UpgradeEchoItemRequest_target,
	field_descriptors.UpgradeEchoItemRequest_sources
}
type_descriptors.UpgradeEchoItemRequest.is_extendable = false
type_descriptors.UpgradeEchoItemRequest.extensions = {}
ChangeEchoItemPush = protobuf.Message(type_descriptors.ChangeEchoItemPush)
DecomposeEchoItemReply = protobuf.Message(type_descriptors.DecomposeEchoItemReply)
DecomposeEchoItemRequest = protobuf.Message(type_descriptors.DecomposeEchoItemRequest)
EchoItemNO = protobuf.Message(type_descriptors.EchoItemNO)
GetEchoItemInfoReply = protobuf.Message(type_descriptors.GetEchoItemInfoReply)
GetEchoItemInfoRequest = protobuf.Message(type_descriptors.GetEchoItemInfoRequest)
LockEchoItemReply = protobuf.Message(type_descriptors.LockEchoItemReply)
LockEchoItemRequest = protobuf.Message(type_descriptors.LockEchoItemRequest)
UpgradeEchoItemReply = protobuf.Message(type_descriptors.UpgradeEchoItemReply)
UpgradeEchoItemRequest = protobuf.Message(type_descriptors.UpgradeEchoItemRequest)
WearEchoItemReply = protobuf.Message(type_descriptors.WearEchoItemReply)
WearEchoItemRequest = protobuf.Message(type_descriptors.WearEchoItemRequest)

return _G["logic.proto.EchoItemExtension_pb"]
