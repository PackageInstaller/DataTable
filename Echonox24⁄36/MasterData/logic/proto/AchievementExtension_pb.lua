-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/AchievementExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.AchievementExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.TakeRewardRequest = protobuf.Descriptor()
field_descriptors.TakeRewardRequest_ids = protobuf.FieldDescriptor()
type_descriptors.TakeRewardReply = protobuf.Descriptor()
field_descriptors.TakeRewardReply_achievements = protobuf.FieldDescriptor()
field_descriptors.TakeRewardReply_skill = protobuf.FieldDescriptor()
type_descriptors.TakeAchievementSkillLevelRewardReply = protobuf.Descriptor()
field_descriptors.TakeAchievementSkillLevelRewardReply_skill = protobuf.FieldDescriptor()
type_descriptors.TakeAchievementSkillLevelRewardRequest = protobuf.Descriptor()
field_descriptors.TakeAchievementSkillLevelRewardRequest_skillId = protobuf.FieldDescriptor()
field_descriptors.TakeAchievementSkillLevelRewardRequest_levels = protobuf.FieldDescriptor()
type_descriptors.GetAllCupReply = protobuf.Descriptor()
field_descriptors.GetAllCupReply_cups = protobuf.FieldDescriptor()
type_descriptors.AchievementNO = protobuf.Descriptor()
field_descriptors.AchievementNO_id = protobuf.FieldDescriptor()
field_descriptors.AchievementNO_count = protobuf.FieldDescriptor()
field_descriptors.AchievementNO_finish = protobuf.FieldDescriptor()
type_descriptors.AchievementSkillNO = protobuf.Descriptor()
field_descriptors.AchievementSkillNO_skillId = protobuf.FieldDescriptor()
field_descriptors.AchievementSkillNO_level = protobuf.FieldDescriptor()
field_descriptors.AchievementSkillNO_exp = protobuf.FieldDescriptor()
field_descriptors.AchievementSkillNO_gainedRewardLevels = protobuf.FieldDescriptor()
type_descriptors.GetAllAchievementRequest = protobuf.Descriptor()
type_descriptors.CupNO = protobuf.Descriptor()
field_descriptors.CupNO_id = protobuf.FieldDescriptor()
field_descriptors.CupNO_count = protobuf.FieldDescriptor()
field_descriptors.CupNO_finish = protobuf.FieldDescriptor()
field_descriptors.CupNO_time = protobuf.FieldDescriptor()
field_descriptors.CupNO_rate = protobuf.FieldDescriptor()
type_descriptors.GetAllAchievementReply = protobuf.Descriptor()
field_descriptors.GetAllAchievementReply_achievements = protobuf.FieldDescriptor()
field_descriptors.GetAllAchievementReply_skill = protobuf.FieldDescriptor()
type_descriptors.GetAllCupRequest = protobuf.Descriptor()
type_descriptors.FinishPush = protobuf.Descriptor()
field_descriptors.FinishPush_cup = protobuf.FieldDescriptor()
field_descriptors.TakeRewardRequest_ids.name = "ids"
field_descriptors.TakeRewardRequest_ids.full_name = ".TakeRewardRequest.ids"
field_descriptors.TakeRewardRequest_ids.number = 1
field_descriptors.TakeRewardRequest_ids.index = 0
field_descriptors.TakeRewardRequest_ids.label = 3
field_descriptors.TakeRewardRequest_ids.has_default_value = false
field_descriptors.TakeRewardRequest_ids.default_value = {}
field_descriptors.TakeRewardRequest_ids.type = 5
field_descriptors.TakeRewardRequest_ids.cpp_type = 1
type_descriptors.TakeRewardRequest.name = "TakeRewardRequest"
type_descriptors.TakeRewardRequest.full_name = ".TakeRewardRequest"
type_descriptors.TakeRewardRequest.nested_types = {}
type_descriptors.TakeRewardRequest.enum_types = {}
type_descriptors.TakeRewardRequest.fields = {
	field_descriptors.TakeRewardRequest_ids
}
type_descriptors.TakeRewardRequest.is_extendable = false
type_descriptors.TakeRewardRequest.extensions = {}
field_descriptors.TakeRewardReply_achievements.name = "achievements"
field_descriptors.TakeRewardReply_achievements.full_name = ".TakeRewardReply.achievements"
field_descriptors.TakeRewardReply_achievements.number = 1
field_descriptors.TakeRewardReply_achievements.index = 0
field_descriptors.TakeRewardReply_achievements.label = 3
field_descriptors.TakeRewardReply_achievements.has_default_value = false
field_descriptors.TakeRewardReply_achievements.default_value = {}
field_descriptors.TakeRewardReply_achievements.message_type = type_descriptors.AchievementNO
field_descriptors.TakeRewardReply_achievements.type = 11
field_descriptors.TakeRewardReply_achievements.cpp_type = 10
field_descriptors.TakeRewardReply_skill.name = "skill"
field_descriptors.TakeRewardReply_skill.full_name = ".TakeRewardReply.skill"
field_descriptors.TakeRewardReply_skill.number = 2
field_descriptors.TakeRewardReply_skill.index = 1
field_descriptors.TakeRewardReply_skill.label = 2
field_descriptors.TakeRewardReply_skill.has_default_value = false
field_descriptors.TakeRewardReply_skill.default_value = nil
field_descriptors.TakeRewardReply_skill.message_type = type_descriptors.AchievementSkillNO
field_descriptors.TakeRewardReply_skill.type = 11
field_descriptors.TakeRewardReply_skill.cpp_type = 10
type_descriptors.TakeRewardReply.name = "TakeRewardReply"
type_descriptors.TakeRewardReply.full_name = ".TakeRewardReply"
type_descriptors.TakeRewardReply.nested_types = {}
type_descriptors.TakeRewardReply.enum_types = {}
type_descriptors.TakeRewardReply.fields = {
	field_descriptors.TakeRewardReply_achievements,
	field_descriptors.TakeRewardReply_skill
}
type_descriptors.TakeRewardReply.is_extendable = false
type_descriptors.TakeRewardReply.extensions = {}
field_descriptors.TakeAchievementSkillLevelRewardReply_skill.name = "skill"
field_descriptors.TakeAchievementSkillLevelRewardReply_skill.full_name = ".TakeAchievementSkillLevelRewardReply.skill"
field_descriptors.TakeAchievementSkillLevelRewardReply_skill.number = 1
field_descriptors.TakeAchievementSkillLevelRewardReply_skill.index = 0
field_descriptors.TakeAchievementSkillLevelRewardReply_skill.label = 1
field_descriptors.TakeAchievementSkillLevelRewardReply_skill.has_default_value = false
field_descriptors.TakeAchievementSkillLevelRewardReply_skill.default_value = nil
field_descriptors.TakeAchievementSkillLevelRewardReply_skill.message_type = type_descriptors.AchievementSkillNO
field_descriptors.TakeAchievementSkillLevelRewardReply_skill.type = 11
field_descriptors.TakeAchievementSkillLevelRewardReply_skill.cpp_type = 10
type_descriptors.TakeAchievementSkillLevelRewardReply.name = "TakeAchievementSkillLevelRewardReply"
type_descriptors.TakeAchievementSkillLevelRewardReply.full_name = ".TakeAchievementSkillLevelRewardReply"
type_descriptors.TakeAchievementSkillLevelRewardReply.nested_types = {}
type_descriptors.TakeAchievementSkillLevelRewardReply.enum_types = {}
type_descriptors.TakeAchievementSkillLevelRewardReply.fields = {
	field_descriptors.TakeAchievementSkillLevelRewardReply_skill
}
type_descriptors.TakeAchievementSkillLevelRewardReply.is_extendable = false
type_descriptors.TakeAchievementSkillLevelRewardReply.extensions = {}
field_descriptors.TakeAchievementSkillLevelRewardRequest_skillId.name = "skillId"
field_descriptors.TakeAchievementSkillLevelRewardRequest_skillId.full_name = ".TakeAchievementSkillLevelRewardRequest.skillId"
field_descriptors.TakeAchievementSkillLevelRewardRequest_skillId.number = 1
field_descriptors.TakeAchievementSkillLevelRewardRequest_skillId.index = 0
field_descriptors.TakeAchievementSkillLevelRewardRequest_skillId.label = 1
field_descriptors.TakeAchievementSkillLevelRewardRequest_skillId.has_default_value = false
field_descriptors.TakeAchievementSkillLevelRewardRequest_skillId.default_value = 0
field_descriptors.TakeAchievementSkillLevelRewardRequest_skillId.type = 5
field_descriptors.TakeAchievementSkillLevelRewardRequest_skillId.cpp_type = 1
field_descriptors.TakeAchievementSkillLevelRewardRequest_levels.name = "levels"
field_descriptors.TakeAchievementSkillLevelRewardRequest_levels.full_name = ".TakeAchievementSkillLevelRewardRequest.levels"
field_descriptors.TakeAchievementSkillLevelRewardRequest_levels.number = 2
field_descriptors.TakeAchievementSkillLevelRewardRequest_levels.index = 1
field_descriptors.TakeAchievementSkillLevelRewardRequest_levels.label = 3
field_descriptors.TakeAchievementSkillLevelRewardRequest_levels.has_default_value = false
field_descriptors.TakeAchievementSkillLevelRewardRequest_levels.default_value = {}
field_descriptors.TakeAchievementSkillLevelRewardRequest_levels.type = 5
field_descriptors.TakeAchievementSkillLevelRewardRequest_levels.cpp_type = 1
type_descriptors.TakeAchievementSkillLevelRewardRequest.name = "TakeAchievementSkillLevelRewardRequest"
type_descriptors.TakeAchievementSkillLevelRewardRequest.full_name = ".TakeAchievementSkillLevelRewardRequest"
type_descriptors.TakeAchievementSkillLevelRewardRequest.nested_types = {}
type_descriptors.TakeAchievementSkillLevelRewardRequest.enum_types = {}
type_descriptors.TakeAchievementSkillLevelRewardRequest.fields = {
	field_descriptors.TakeAchievementSkillLevelRewardRequest_skillId,
	field_descriptors.TakeAchievementSkillLevelRewardRequest_levels
}
type_descriptors.TakeAchievementSkillLevelRewardRequest.is_extendable = false
type_descriptors.TakeAchievementSkillLevelRewardRequest.extensions = {}
field_descriptors.GetAllCupReply_cups.name = "cups"
field_descriptors.GetAllCupReply_cups.full_name = ".GetAllCupReply.cups"
field_descriptors.GetAllCupReply_cups.number = 1
field_descriptors.GetAllCupReply_cups.index = 0
field_descriptors.GetAllCupReply_cups.label = 3
field_descriptors.GetAllCupReply_cups.has_default_value = false
field_descriptors.GetAllCupReply_cups.default_value = {}
field_descriptors.GetAllCupReply_cups.message_type = type_descriptors.CupNO
field_descriptors.GetAllCupReply_cups.type = 11
field_descriptors.GetAllCupReply_cups.cpp_type = 10
type_descriptors.GetAllCupReply.name = "GetAllCupReply"
type_descriptors.GetAllCupReply.full_name = ".GetAllCupReply"
type_descriptors.GetAllCupReply.nested_types = {}
type_descriptors.GetAllCupReply.enum_types = {}
type_descriptors.GetAllCupReply.fields = {
	field_descriptors.GetAllCupReply_cups
}
type_descriptors.GetAllCupReply.is_extendable = false
type_descriptors.GetAllCupReply.extensions = {}
field_descriptors.AchievementNO_id.name = "id"
field_descriptors.AchievementNO_id.full_name = ".AchievementNO.id"
field_descriptors.AchievementNO_id.number = 1
field_descriptors.AchievementNO_id.index = 0
field_descriptors.AchievementNO_id.label = 1
field_descriptors.AchievementNO_id.has_default_value = false
field_descriptors.AchievementNO_id.default_value = 0
field_descriptors.AchievementNO_id.type = 5
field_descriptors.AchievementNO_id.cpp_type = 1
field_descriptors.AchievementNO_count.name = "count"
field_descriptors.AchievementNO_count.full_name = ".AchievementNO.count"
field_descriptors.AchievementNO_count.number = 2
field_descriptors.AchievementNO_count.index = 1
field_descriptors.AchievementNO_count.label = 1
field_descriptors.AchievementNO_count.has_default_value = false
field_descriptors.AchievementNO_count.default_value = 0
field_descriptors.AchievementNO_count.type = 5
field_descriptors.AchievementNO_count.cpp_type = 1
field_descriptors.AchievementNO_finish.name = "finish"
field_descriptors.AchievementNO_finish.full_name = ".AchievementNO.finish"
field_descriptors.AchievementNO_finish.number = 3
field_descriptors.AchievementNO_finish.index = 2
field_descriptors.AchievementNO_finish.label = 1
field_descriptors.AchievementNO_finish.has_default_value = false
field_descriptors.AchievementNO_finish.default_value = false
field_descriptors.AchievementNO_finish.type = 8
field_descriptors.AchievementNO_finish.cpp_type = 7
type_descriptors.AchievementNO.name = "AchievementNO"
type_descriptors.AchievementNO.full_name = ".AchievementNO"
type_descriptors.AchievementNO.nested_types = {}
type_descriptors.AchievementNO.enum_types = {}
type_descriptors.AchievementNO.fields = {
	field_descriptors.AchievementNO_id,
	field_descriptors.AchievementNO_count,
	field_descriptors.AchievementNO_finish
}
type_descriptors.AchievementNO.is_extendable = false
type_descriptors.AchievementNO.extensions = {}
field_descriptors.AchievementSkillNO_skillId.name = "skillId"
field_descriptors.AchievementSkillNO_skillId.full_name = ".AchievementSkillNO.skillId"
field_descriptors.AchievementSkillNO_skillId.number = 1
field_descriptors.AchievementSkillNO_skillId.index = 0
field_descriptors.AchievementSkillNO_skillId.label = 2
field_descriptors.AchievementSkillNO_skillId.has_default_value = false
field_descriptors.AchievementSkillNO_skillId.default_value = 0
field_descriptors.AchievementSkillNO_skillId.type = 5
field_descriptors.AchievementSkillNO_skillId.cpp_type = 1
field_descriptors.AchievementSkillNO_level.name = "level"
field_descriptors.AchievementSkillNO_level.full_name = ".AchievementSkillNO.level"
field_descriptors.AchievementSkillNO_level.number = 2
field_descriptors.AchievementSkillNO_level.index = 1
field_descriptors.AchievementSkillNO_level.label = 2
field_descriptors.AchievementSkillNO_level.has_default_value = false
field_descriptors.AchievementSkillNO_level.default_value = 0
field_descriptors.AchievementSkillNO_level.type = 5
field_descriptors.AchievementSkillNO_level.cpp_type = 1
field_descriptors.AchievementSkillNO_exp.name = "exp"
field_descriptors.AchievementSkillNO_exp.full_name = ".AchievementSkillNO.exp"
field_descriptors.AchievementSkillNO_exp.number = 3
field_descriptors.AchievementSkillNO_exp.index = 2
field_descriptors.AchievementSkillNO_exp.label = 2
field_descriptors.AchievementSkillNO_exp.has_default_value = false
field_descriptors.AchievementSkillNO_exp.default_value = 0
field_descriptors.AchievementSkillNO_exp.type = 5
field_descriptors.AchievementSkillNO_exp.cpp_type = 1
field_descriptors.AchievementSkillNO_gainedRewardLevels.name = "gainedRewardLevels"
field_descriptors.AchievementSkillNO_gainedRewardLevels.full_name = ".AchievementSkillNO.gainedRewardLevels"
field_descriptors.AchievementSkillNO_gainedRewardLevels.number = 4
field_descriptors.AchievementSkillNO_gainedRewardLevels.index = 3
field_descriptors.AchievementSkillNO_gainedRewardLevels.label = 3
field_descriptors.AchievementSkillNO_gainedRewardLevels.has_default_value = false
field_descriptors.AchievementSkillNO_gainedRewardLevels.default_value = {}
field_descriptors.AchievementSkillNO_gainedRewardLevels.type = 5
field_descriptors.AchievementSkillNO_gainedRewardLevels.cpp_type = 1
type_descriptors.AchievementSkillNO.name = "AchievementSkillNO"
type_descriptors.AchievementSkillNO.full_name = ".AchievementSkillNO"
type_descriptors.AchievementSkillNO.nested_types = {}
type_descriptors.AchievementSkillNO.enum_types = {}
type_descriptors.AchievementSkillNO.fields = {
	field_descriptors.AchievementSkillNO_skillId,
	field_descriptors.AchievementSkillNO_level,
	field_descriptors.AchievementSkillNO_exp,
	field_descriptors.AchievementSkillNO_gainedRewardLevels
}
type_descriptors.AchievementSkillNO.is_extendable = false
type_descriptors.AchievementSkillNO.extensions = {}
type_descriptors.GetAllAchievementRequest.name = "GetAllAchievementRequest"
type_descriptors.GetAllAchievementRequest.full_name = ".GetAllAchievementRequest"
type_descriptors.GetAllAchievementRequest.nested_types = {}
type_descriptors.GetAllAchievementRequest.enum_types = {}
type_descriptors.GetAllAchievementRequest.fields = {}
type_descriptors.GetAllAchievementRequest.is_extendable = false
type_descriptors.GetAllAchievementRequest.extensions = {}
field_descriptors.CupNO_id.name = "id"
field_descriptors.CupNO_id.full_name = ".CupNO.id"
field_descriptors.CupNO_id.number = 1
field_descriptors.CupNO_id.index = 0
field_descriptors.CupNO_id.label = 1
field_descriptors.CupNO_id.has_default_value = false
field_descriptors.CupNO_id.default_value = 0
field_descriptors.CupNO_id.type = 5
field_descriptors.CupNO_id.cpp_type = 1
field_descriptors.CupNO_count.name = "count"
field_descriptors.CupNO_count.full_name = ".CupNO.count"
field_descriptors.CupNO_count.number = 2
field_descriptors.CupNO_count.index = 1
field_descriptors.CupNO_count.label = 1
field_descriptors.CupNO_count.has_default_value = false
field_descriptors.CupNO_count.default_value = 0
field_descriptors.CupNO_count.type = 5
field_descriptors.CupNO_count.cpp_type = 1
field_descriptors.CupNO_finish.name = "finish"
field_descriptors.CupNO_finish.full_name = ".CupNO.finish"
field_descriptors.CupNO_finish.number = 3
field_descriptors.CupNO_finish.index = 2
field_descriptors.CupNO_finish.label = 1
field_descriptors.CupNO_finish.has_default_value = false
field_descriptors.CupNO_finish.default_value = false
field_descriptors.CupNO_finish.type = 8
field_descriptors.CupNO_finish.cpp_type = 7
field_descriptors.CupNO_time.name = "time"
field_descriptors.CupNO_time.full_name = ".CupNO.time"
field_descriptors.CupNO_time.number = 4
field_descriptors.CupNO_time.index = 3
field_descriptors.CupNO_time.label = 1
field_descriptors.CupNO_time.has_default_value = false
field_descriptors.CupNO_time.default_value = 0
field_descriptors.CupNO_time.type = 3
field_descriptors.CupNO_time.cpp_type = 2
field_descriptors.CupNO_rate.name = "rate"
field_descriptors.CupNO_rate.full_name = ".CupNO.rate"
field_descriptors.CupNO_rate.number = 5
field_descriptors.CupNO_rate.index = 4
field_descriptors.CupNO_rate.label = 1
field_descriptors.CupNO_rate.has_default_value = false
field_descriptors.CupNO_rate.default_value = 0
field_descriptors.CupNO_rate.type = 2
field_descriptors.CupNO_rate.cpp_type = 6
type_descriptors.CupNO.name = "CupNO"
type_descriptors.CupNO.full_name = ".CupNO"
type_descriptors.CupNO.nested_types = {}
type_descriptors.CupNO.enum_types = {}
type_descriptors.CupNO.fields = {
	field_descriptors.CupNO_id,
	field_descriptors.CupNO_count,
	field_descriptors.CupNO_finish,
	field_descriptors.CupNO_time,
	field_descriptors.CupNO_rate
}
type_descriptors.CupNO.is_extendable = false
type_descriptors.CupNO.extensions = {}
field_descriptors.GetAllAchievementReply_achievements.name = "achievements"
field_descriptors.GetAllAchievementReply_achievements.full_name = ".GetAllAchievementReply.achievements"
field_descriptors.GetAllAchievementReply_achievements.number = 1
field_descriptors.GetAllAchievementReply_achievements.index = 0
field_descriptors.GetAllAchievementReply_achievements.label = 3
field_descriptors.GetAllAchievementReply_achievements.has_default_value = false
field_descriptors.GetAllAchievementReply_achievements.default_value = {}
field_descriptors.GetAllAchievementReply_achievements.message_type = type_descriptors.AchievementNO
field_descriptors.GetAllAchievementReply_achievements.type = 11
field_descriptors.GetAllAchievementReply_achievements.cpp_type = 10
field_descriptors.GetAllAchievementReply_skill.name = "skill"
field_descriptors.GetAllAchievementReply_skill.full_name = ".GetAllAchievementReply.skill"
field_descriptors.GetAllAchievementReply_skill.number = 2
field_descriptors.GetAllAchievementReply_skill.index = 1
field_descriptors.GetAllAchievementReply_skill.label = 3
field_descriptors.GetAllAchievementReply_skill.has_default_value = false
field_descriptors.GetAllAchievementReply_skill.default_value = {}
field_descriptors.GetAllAchievementReply_skill.message_type = type_descriptors.AchievementSkillNO
field_descriptors.GetAllAchievementReply_skill.type = 11
field_descriptors.GetAllAchievementReply_skill.cpp_type = 10
type_descriptors.GetAllAchievementReply.name = "GetAllAchievementReply"
type_descriptors.GetAllAchievementReply.full_name = ".GetAllAchievementReply"
type_descriptors.GetAllAchievementReply.nested_types = {}
type_descriptors.GetAllAchievementReply.enum_types = {}
type_descriptors.GetAllAchievementReply.fields = {
	field_descriptors.GetAllAchievementReply_achievements,
	field_descriptors.GetAllAchievementReply_skill
}
type_descriptors.GetAllAchievementReply.is_extendable = false
type_descriptors.GetAllAchievementReply.extensions = {}
type_descriptors.GetAllCupRequest.name = "GetAllCupRequest"
type_descriptors.GetAllCupRequest.full_name = ".GetAllCupRequest"
type_descriptors.GetAllCupRequest.nested_types = {}
type_descriptors.GetAllCupRequest.enum_types = {}
type_descriptors.GetAllCupRequest.fields = {}
type_descriptors.GetAllCupRequest.is_extendable = false
type_descriptors.GetAllCupRequest.extensions = {}
field_descriptors.FinishPush_cup.name = "cup"
field_descriptors.FinishPush_cup.full_name = ".FinishPush.cup"
field_descriptors.FinishPush_cup.number = 1
field_descriptors.FinishPush_cup.index = 0
field_descriptors.FinishPush_cup.label = 1
field_descriptors.FinishPush_cup.has_default_value = false
field_descriptors.FinishPush_cup.default_value = nil
field_descriptors.FinishPush_cup.message_type = type_descriptors.CupNO
field_descriptors.FinishPush_cup.type = 11
field_descriptors.FinishPush_cup.cpp_type = 10
type_descriptors.FinishPush.name = "FinishPush"
type_descriptors.FinishPush.full_name = ".FinishPush"
type_descriptors.FinishPush.nested_types = {}
type_descriptors.FinishPush.enum_types = {}
type_descriptors.FinishPush.fields = {
	field_descriptors.FinishPush_cup
}
type_descriptors.FinishPush.is_extendable = false
type_descriptors.FinishPush.extensions = {}
AchievementNO = protobuf.Message(type_descriptors.AchievementNO)
AchievementSkillNO = protobuf.Message(type_descriptors.AchievementSkillNO)
CupNO = protobuf.Message(type_descriptors.CupNO)
FinishPush = protobuf.Message(type_descriptors.FinishPush)
GetAllAchievementReply = protobuf.Message(type_descriptors.GetAllAchievementReply)
GetAllAchievementRequest = protobuf.Message(type_descriptors.GetAllAchievementRequest)
GetAllCupReply = protobuf.Message(type_descriptors.GetAllCupReply)
GetAllCupRequest = protobuf.Message(type_descriptors.GetAllCupRequest)
TakeAchievementSkillLevelRewardReply = protobuf.Message(type_descriptors.TakeAchievementSkillLevelRewardReply)
TakeAchievementSkillLevelRewardRequest = protobuf.Message(type_descriptors.TakeAchievementSkillLevelRewardRequest)
TakeRewardReply = protobuf.Message(type_descriptors.TakeRewardReply)
TakeRewardRequest = protobuf.Message(type_descriptors.TakeRewardRequest)

return _G["logic.proto.AchievementExtension_pb"]
