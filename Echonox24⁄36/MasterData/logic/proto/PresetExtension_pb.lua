-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/PresetExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.PresetExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.PresetNO = protobuf.Descriptor()
field_descriptors.PresetNO_hero = protobuf.FieldDescriptor()
field_descriptors.PresetNO_id = protobuf.FieldDescriptor()
field_descriptors.PresetNO_name = protobuf.FieldDescriptor()
field_descriptors.PresetNO_echo = protobuf.FieldDescriptor()
field_descriptors.PresetNO_equip1 = protobuf.FieldDescriptor()
field_descriptors.PresetNO_equip2 = protobuf.FieldDescriptor()
field_descriptors.PresetNO_equip3 = protobuf.FieldDescriptor()
field_descriptors.PresetNO_thinking = protobuf.FieldDescriptor()
field_descriptors.PresetNO_skill = protobuf.FieldDescriptor()
field_descriptors.PresetNO_lastModifyTime = protobuf.FieldDescriptor()
type_descriptors.SavePresetRequest = protobuf.Descriptor()
field_descriptors.SavePresetRequest_presets = protobuf.FieldDescriptor()
type_descriptors.PresetsChangedPush = protobuf.Descriptor()
field_descriptors.PresetsChangedPush_added = protobuf.FieldDescriptor()
field_descriptors.PresetsChangedPush_deleted = protobuf.FieldDescriptor()
type_descriptors.ApplyPresetRequest = protobuf.Descriptor()
field_descriptors.ApplyPresetRequest_presets = protobuf.FieldDescriptor()
type_descriptors.ApplyPresetReply = protobuf.Descriptor()
type_descriptors.HeroPresetNO = protobuf.Descriptor()
field_descriptors.HeroPresetNO_hero = protobuf.FieldDescriptor()
field_descriptors.HeroPresetNO_presets = protobuf.FieldDescriptor()
type_descriptors.SavePresetReply = protobuf.Descriptor()
type_descriptors.DeletePresetRequest = protobuf.Descriptor()
field_descriptors.DeletePresetRequest_presets = protobuf.FieldDescriptor()
type_descriptors.DeletePresetReply = protobuf.Descriptor()
field_descriptors.PresetNO_hero.name = "hero"
field_descriptors.PresetNO_hero.full_name = ".PresetNO.hero"
field_descriptors.PresetNO_hero.number = 1
field_descriptors.PresetNO_hero.index = 0
field_descriptors.PresetNO_hero.label = 1
field_descriptors.PresetNO_hero.has_default_value = false
field_descriptors.PresetNO_hero.default_value = 0
field_descriptors.PresetNO_hero.type = 5
field_descriptors.PresetNO_hero.cpp_type = 1
field_descriptors.PresetNO_id.name = "id"
field_descriptors.PresetNO_id.full_name = ".PresetNO.id"
field_descriptors.PresetNO_id.number = 2
field_descriptors.PresetNO_id.index = 1
field_descriptors.PresetNO_id.label = 1
field_descriptors.PresetNO_id.has_default_value = false
field_descriptors.PresetNO_id.default_value = 0
field_descriptors.PresetNO_id.type = 3
field_descriptors.PresetNO_id.cpp_type = 2
field_descriptors.PresetNO_name.name = "name"
field_descriptors.PresetNO_name.full_name = ".PresetNO.name"
field_descriptors.PresetNO_name.number = 3
field_descriptors.PresetNO_name.index = 2
field_descriptors.PresetNO_name.label = 1
field_descriptors.PresetNO_name.has_default_value = false
field_descriptors.PresetNO_name.default_value = ""
field_descriptors.PresetNO_name.type = 9
field_descriptors.PresetNO_name.cpp_type = 9
field_descriptors.PresetNO_echo.name = "echo"
field_descriptors.PresetNO_echo.full_name = ".PresetNO.echo"
field_descriptors.PresetNO_echo.number = 4
field_descriptors.PresetNO_echo.index = 3
field_descriptors.PresetNO_echo.label = 1
field_descriptors.PresetNO_echo.has_default_value = false
field_descriptors.PresetNO_echo.default_value = 0
field_descriptors.PresetNO_echo.type = 3
field_descriptors.PresetNO_echo.cpp_type = 2
field_descriptors.PresetNO_equip1.name = "equip1"
field_descriptors.PresetNO_equip1.full_name = ".PresetNO.equip1"
field_descriptors.PresetNO_equip1.number = 5
field_descriptors.PresetNO_equip1.index = 4
field_descriptors.PresetNO_equip1.label = 1
field_descriptors.PresetNO_equip1.has_default_value = false
field_descriptors.PresetNO_equip1.default_value = 0
field_descriptors.PresetNO_equip1.type = 3
field_descriptors.PresetNO_equip1.cpp_type = 2
field_descriptors.PresetNO_equip2.name = "equip2"
field_descriptors.PresetNO_equip2.full_name = ".PresetNO.equip2"
field_descriptors.PresetNO_equip2.number = 6
field_descriptors.PresetNO_equip2.index = 5
field_descriptors.PresetNO_equip2.label = 1
field_descriptors.PresetNO_equip2.has_default_value = false
field_descriptors.PresetNO_equip2.default_value = 0
field_descriptors.PresetNO_equip2.type = 3
field_descriptors.PresetNO_equip2.cpp_type = 2
field_descriptors.PresetNO_equip3.name = "equip3"
field_descriptors.PresetNO_equip3.full_name = ".PresetNO.equip3"
field_descriptors.PresetNO_equip3.number = 7
field_descriptors.PresetNO_equip3.index = 6
field_descriptors.PresetNO_equip3.label = 1
field_descriptors.PresetNO_equip3.has_default_value = false
field_descriptors.PresetNO_equip3.default_value = 0
field_descriptors.PresetNO_equip3.type = 3
field_descriptors.PresetNO_equip3.cpp_type = 2
field_descriptors.PresetNO_thinking.name = "thinking"
field_descriptors.PresetNO_thinking.full_name = ".PresetNO.thinking"
field_descriptors.PresetNO_thinking.number = 8
field_descriptors.PresetNO_thinking.index = 7
field_descriptors.PresetNO_thinking.label = 1
field_descriptors.PresetNO_thinking.has_default_value = false
field_descriptors.PresetNO_thinking.default_value = 0
field_descriptors.PresetNO_thinking.type = 5
field_descriptors.PresetNO_thinking.cpp_type = 1
field_descriptors.PresetNO_skill.name = "skill"
field_descriptors.PresetNO_skill.full_name = ".PresetNO.skill"
field_descriptors.PresetNO_skill.number = 9
field_descriptors.PresetNO_skill.index = 8
field_descriptors.PresetNO_skill.label = 1
field_descriptors.PresetNO_skill.has_default_value = false
field_descriptors.PresetNO_skill.default_value = 0
field_descriptors.PresetNO_skill.type = 5
field_descriptors.PresetNO_skill.cpp_type = 1
field_descriptors.PresetNO_lastModifyTime.name = "lastModifyTime"
field_descriptors.PresetNO_lastModifyTime.full_name = ".PresetNO.lastModifyTime"
field_descriptors.PresetNO_lastModifyTime.number = 10
field_descriptors.PresetNO_lastModifyTime.index = 9
field_descriptors.PresetNO_lastModifyTime.label = 1
field_descriptors.PresetNO_lastModifyTime.has_default_value = false
field_descriptors.PresetNO_lastModifyTime.default_value = 0
field_descriptors.PresetNO_lastModifyTime.type = 3
field_descriptors.PresetNO_lastModifyTime.cpp_type = 2
type_descriptors.PresetNO.name = "PresetNO"
type_descriptors.PresetNO.full_name = ".PresetNO"
type_descriptors.PresetNO.nested_types = {}
type_descriptors.PresetNO.enum_types = {}
type_descriptors.PresetNO.fields = {
	field_descriptors.PresetNO_hero,
	field_descriptors.PresetNO_id,
	field_descriptors.PresetNO_name,
	field_descriptors.PresetNO_echo,
	field_descriptors.PresetNO_equip1,
	field_descriptors.PresetNO_equip2,
	field_descriptors.PresetNO_equip3,
	field_descriptors.PresetNO_thinking,
	field_descriptors.PresetNO_skill,
	field_descriptors.PresetNO_lastModifyTime
}
type_descriptors.PresetNO.is_extendable = false
type_descriptors.PresetNO.extensions = {}
field_descriptors.SavePresetRequest_presets.name = "presets"
field_descriptors.SavePresetRequest_presets.full_name = ".SavePresetRequest.presets"
field_descriptors.SavePresetRequest_presets.number = 1
field_descriptors.SavePresetRequest_presets.index = 0
field_descriptors.SavePresetRequest_presets.label = 1
field_descriptors.SavePresetRequest_presets.has_default_value = false
field_descriptors.SavePresetRequest_presets.default_value = nil
field_descriptors.SavePresetRequest_presets.message_type = type_descriptors.PresetNO
field_descriptors.SavePresetRequest_presets.type = 11
field_descriptors.SavePresetRequest_presets.cpp_type = 10
type_descriptors.SavePresetRequest.name = "SavePresetRequest"
type_descriptors.SavePresetRequest.full_name = ".SavePresetRequest"
type_descriptors.SavePresetRequest.nested_types = {}
type_descriptors.SavePresetRequest.enum_types = {}
type_descriptors.SavePresetRequest.fields = {
	field_descriptors.SavePresetRequest_presets
}
type_descriptors.SavePresetRequest.is_extendable = false
type_descriptors.SavePresetRequest.extensions = {}
field_descriptors.PresetsChangedPush_added.name = "added"
field_descriptors.PresetsChangedPush_added.full_name = ".PresetsChangedPush.added"
field_descriptors.PresetsChangedPush_added.number = 1
field_descriptors.PresetsChangedPush_added.index = 0
field_descriptors.PresetsChangedPush_added.label = 3
field_descriptors.PresetsChangedPush_added.has_default_value = false
field_descriptors.PresetsChangedPush_added.default_value = {}
field_descriptors.PresetsChangedPush_added.message_type = type_descriptors.HeroPresetNO
field_descriptors.PresetsChangedPush_added.type = 11
field_descriptors.PresetsChangedPush_added.cpp_type = 10
field_descriptors.PresetsChangedPush_deleted.name = "deleted"
field_descriptors.PresetsChangedPush_deleted.full_name = ".PresetsChangedPush.deleted"
field_descriptors.PresetsChangedPush_deleted.number = 2
field_descriptors.PresetsChangedPush_deleted.index = 1
field_descriptors.PresetsChangedPush_deleted.label = 3
field_descriptors.PresetsChangedPush_deleted.has_default_value = false
field_descriptors.PresetsChangedPush_deleted.default_value = {}
field_descriptors.PresetsChangedPush_deleted.message_type = type_descriptors.HeroPresetNO
field_descriptors.PresetsChangedPush_deleted.type = 11
field_descriptors.PresetsChangedPush_deleted.cpp_type = 10
type_descriptors.PresetsChangedPush.name = "PresetsChangedPush"
type_descriptors.PresetsChangedPush.full_name = ".PresetsChangedPush"
type_descriptors.PresetsChangedPush.nested_types = {}
type_descriptors.PresetsChangedPush.enum_types = {}
type_descriptors.PresetsChangedPush.fields = {
	field_descriptors.PresetsChangedPush_added,
	field_descriptors.PresetsChangedPush_deleted
}
type_descriptors.PresetsChangedPush.is_extendable = false
type_descriptors.PresetsChangedPush.extensions = {}
field_descriptors.ApplyPresetRequest_presets.name = "presets"
field_descriptors.ApplyPresetRequest_presets.full_name = ".ApplyPresetRequest.presets"
field_descriptors.ApplyPresetRequest_presets.number = 1
field_descriptors.ApplyPresetRequest_presets.index = 0
field_descriptors.ApplyPresetRequest_presets.label = 1
field_descriptors.ApplyPresetRequest_presets.has_default_value = false
field_descriptors.ApplyPresetRequest_presets.default_value = nil
field_descriptors.ApplyPresetRequest_presets.message_type = type_descriptors.PresetNO
field_descriptors.ApplyPresetRequest_presets.type = 11
field_descriptors.ApplyPresetRequest_presets.cpp_type = 10
type_descriptors.ApplyPresetRequest.name = "ApplyPresetRequest"
type_descriptors.ApplyPresetRequest.full_name = ".ApplyPresetRequest"
type_descriptors.ApplyPresetRequest.nested_types = {}
type_descriptors.ApplyPresetRequest.enum_types = {}
type_descriptors.ApplyPresetRequest.fields = {
	field_descriptors.ApplyPresetRequest_presets
}
type_descriptors.ApplyPresetRequest.is_extendable = false
type_descriptors.ApplyPresetRequest.extensions = {}
type_descriptors.ApplyPresetReply.name = "ApplyPresetReply"
type_descriptors.ApplyPresetReply.full_name = ".ApplyPresetReply"
type_descriptors.ApplyPresetReply.nested_types = {}
type_descriptors.ApplyPresetReply.enum_types = {}
type_descriptors.ApplyPresetReply.fields = {}
type_descriptors.ApplyPresetReply.is_extendable = false
type_descriptors.ApplyPresetReply.extensions = {}
field_descriptors.HeroPresetNO_hero.name = "hero"
field_descriptors.HeroPresetNO_hero.full_name = ".HeroPresetNO.hero"
field_descriptors.HeroPresetNO_hero.number = 1
field_descriptors.HeroPresetNO_hero.index = 0
field_descriptors.HeroPresetNO_hero.label = 1
field_descriptors.HeroPresetNO_hero.has_default_value = false
field_descriptors.HeroPresetNO_hero.default_value = 0
field_descriptors.HeroPresetNO_hero.type = 5
field_descriptors.HeroPresetNO_hero.cpp_type = 1
field_descriptors.HeroPresetNO_presets.name = "presets"
field_descriptors.HeroPresetNO_presets.full_name = ".HeroPresetNO.presets"
field_descriptors.HeroPresetNO_presets.number = 2
field_descriptors.HeroPresetNO_presets.index = 1
field_descriptors.HeroPresetNO_presets.label = 3
field_descriptors.HeroPresetNO_presets.has_default_value = false
field_descriptors.HeroPresetNO_presets.default_value = {}
field_descriptors.HeroPresetNO_presets.message_type = type_descriptors.PresetNO
field_descriptors.HeroPresetNO_presets.type = 11
field_descriptors.HeroPresetNO_presets.cpp_type = 10
type_descriptors.HeroPresetNO.name = "HeroPresetNO"
type_descriptors.HeroPresetNO.full_name = ".HeroPresetNO"
type_descriptors.HeroPresetNO.nested_types = {}
type_descriptors.HeroPresetNO.enum_types = {}
type_descriptors.HeroPresetNO.fields = {
	field_descriptors.HeroPresetNO_hero,
	field_descriptors.HeroPresetNO_presets
}
type_descriptors.HeroPresetNO.is_extendable = false
type_descriptors.HeroPresetNO.extensions = {}
type_descriptors.SavePresetReply.name = "SavePresetReply"
type_descriptors.SavePresetReply.full_name = ".SavePresetReply"
type_descriptors.SavePresetReply.nested_types = {}
type_descriptors.SavePresetReply.enum_types = {}
type_descriptors.SavePresetReply.fields = {}
type_descriptors.SavePresetReply.is_extendable = false
type_descriptors.SavePresetReply.extensions = {}
field_descriptors.DeletePresetRequest_presets.name = "presets"
field_descriptors.DeletePresetRequest_presets.full_name = ".DeletePresetRequest.presets"
field_descriptors.DeletePresetRequest_presets.number = 1
field_descriptors.DeletePresetRequest_presets.index = 0
field_descriptors.DeletePresetRequest_presets.label = 1
field_descriptors.DeletePresetRequest_presets.has_default_value = false
field_descriptors.DeletePresetRequest_presets.default_value = nil
field_descriptors.DeletePresetRequest_presets.message_type = type_descriptors.PresetNO
field_descriptors.DeletePresetRequest_presets.type = 11
field_descriptors.DeletePresetRequest_presets.cpp_type = 10
type_descriptors.DeletePresetRequest.name = "DeletePresetRequest"
type_descriptors.DeletePresetRequest.full_name = ".DeletePresetRequest"
type_descriptors.DeletePresetRequest.nested_types = {}
type_descriptors.DeletePresetRequest.enum_types = {}
type_descriptors.DeletePresetRequest.fields = {
	field_descriptors.DeletePresetRequest_presets
}
type_descriptors.DeletePresetRequest.is_extendable = false
type_descriptors.DeletePresetRequest.extensions = {}
type_descriptors.DeletePresetReply.name = "DeletePresetReply"
type_descriptors.DeletePresetReply.full_name = ".DeletePresetReply"
type_descriptors.DeletePresetReply.nested_types = {}
type_descriptors.DeletePresetReply.enum_types = {}
type_descriptors.DeletePresetReply.fields = {}
type_descriptors.DeletePresetReply.is_extendable = false
type_descriptors.DeletePresetReply.extensions = {}
ApplyPresetReply = protobuf.Message(type_descriptors.ApplyPresetReply)
ApplyPresetRequest = protobuf.Message(type_descriptors.ApplyPresetRequest)
DeletePresetReply = protobuf.Message(type_descriptors.DeletePresetReply)
DeletePresetRequest = protobuf.Message(type_descriptors.DeletePresetRequest)
HeroPresetNO = protobuf.Message(type_descriptors.HeroPresetNO)
PresetNO = protobuf.Message(type_descriptors.PresetNO)
PresetsChangedPush = protobuf.Message(type_descriptors.PresetsChangedPush)
SavePresetReply = protobuf.Message(type_descriptors.SavePresetReply)
SavePresetRequest = protobuf.Message(type_descriptors.SavePresetRequest)

return _G["logic.proto.PresetExtension_pb"]
