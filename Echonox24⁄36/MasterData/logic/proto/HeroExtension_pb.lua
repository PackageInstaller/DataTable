-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/HeroExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

dependencies.BattleExtension = require("logic.proto.BattleExtension_pb")

module("logic.proto.HeroExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.HeroWeight = protobuf.Descriptor()
field_descriptors.HeroWeight_heroId = protobuf.FieldDescriptor()
field_descriptors.HeroWeight_weight = protobuf.FieldDescriptor()
type_descriptors.HeroInfoPush = protobuf.Descriptor()
field_descriptors.HeroInfoPush_hero = protobuf.FieldDescriptor()
type_descriptors.LoadHerosReply = protobuf.Descriptor()
field_descriptors.LoadHerosReply_heros = protobuf.FieldDescriptor()
type_descriptors.AddHeroExpReply = protobuf.Descriptor()
type_descriptors.LoadHeroWeightRequest = protobuf.Descriptor()
type_descriptors.Entry = protobuf.Descriptor()
field_descriptors.Entry_key = protobuf.FieldDescriptor()
field_descriptors.Entry_value = protobuf.FieldDescriptor()
type_descriptors.HeroSkillEnhanceReply = protobuf.Descriptor()
field_descriptors.HeroSkillEnhanceReply_heroId = protobuf.FieldDescriptor()
field_descriptors.HeroSkillEnhanceReply_skillInfos = protobuf.FieldDescriptor()
type_descriptors.LoadHerosRequest = protobuf.Descriptor()
type_descriptors.Hero = protobuf.Descriptor()
field_descriptors.Hero_id = protobuf.FieldDescriptor()
field_descriptors.Hero_level = protobuf.FieldDescriptor()
field_descriptors.Hero_powerLv = protobuf.FieldDescriptor()
field_descriptors.Hero_breakLv = protobuf.FieldDescriptor()
field_descriptors.Hero_ccDegree = protobuf.FieldDescriptor()
field_descriptors.Hero_attrs = protobuf.FieldDescriptor()
field_descriptors.Hero_skills = protobuf.FieldDescriptor()
field_descriptors.Hero_talentSkill = protobuf.FieldDescriptor()
field_descriptors.Hero_treatyLv = protobuf.FieldDescriptor()
field_descriptors.Hero_status = protobuf.FieldDescriptor()
field_descriptors.Hero_lvExp = protobuf.FieldDescriptor()
field_descriptors.Hero_qua6 = protobuf.FieldDescriptor()
field_descriptors.Hero_expression = protobuf.FieldDescriptor()
field_descriptors.Hero_skinId = protobuf.FieldDescriptor()
field_descriptors.Hero_attrParts = protobuf.FieldDescriptor()
field_descriptors.Hero_tacitExp = protobuf.FieldDescriptor()
field_descriptors.Hero_wakeup = protobuf.FieldDescriptor()
field_descriptors.Hero_pveWinTimes = protobuf.FieldDescriptor()
field_descriptors.Hero_nodesInfo = protobuf.FieldDescriptor()
field_descriptors.Hero_extNodesInfo = protobuf.FieldDescriptor()
type_descriptors.HeroSkillEnhanceUpdatePush = protobuf.Descriptor()
field_descriptors.HeroSkillEnhanceUpdatePush_heroId = protobuf.FieldDescriptor()
field_descriptors.HeroSkillEnhanceUpdatePush_skillInfos = protobuf.FieldDescriptor()
type_descriptors.SkillEnhanceInfo = protobuf.Descriptor()
field_descriptors.SkillEnhanceInfo_skillId = protobuf.FieldDescriptor()
field_descriptors.SkillEnhanceInfo_enhanceIds = protobuf.FieldDescriptor()
type_descriptors.LoadHeroWeightReply = protobuf.Descriptor()
field_descriptors.LoadHeroWeightReply_info = protobuf.FieldDescriptor()
field_descriptors.LoadHeroWeightReply_expiredMillis = protobuf.FieldDescriptor()
type_descriptors.AddHeroExpRequest = protobuf.Descriptor()
field_descriptors.AddHeroExpRequest_heroId = protobuf.FieldDescriptor()
field_descriptors.AddHeroExpRequest_useItems = protobuf.FieldDescriptor()
type_descriptors.HeroSkillEnhanceRequest = protobuf.Descriptor()
field_descriptors.HeroSkillEnhanceRequest_heroId = protobuf.FieldDescriptor()
field_descriptors.HeroWeight_heroId.name = "heroId"
field_descriptors.HeroWeight_heroId.full_name = ".HeroWeight.heroId"
field_descriptors.HeroWeight_heroId.number = 1
field_descriptors.HeroWeight_heroId.index = 0
field_descriptors.HeroWeight_heroId.label = 2
field_descriptors.HeroWeight_heroId.has_default_value = false
field_descriptors.HeroWeight_heroId.default_value = 0
field_descriptors.HeroWeight_heroId.type = 5
field_descriptors.HeroWeight_heroId.cpp_type = 1
field_descriptors.HeroWeight_weight.name = "weight"
field_descriptors.HeroWeight_weight.full_name = ".HeroWeight.weight"
field_descriptors.HeroWeight_weight.number = 2
field_descriptors.HeroWeight_weight.index = 1
field_descriptors.HeroWeight_weight.label = 2
field_descriptors.HeroWeight_weight.has_default_value = false
field_descriptors.HeroWeight_weight.default_value = 0
field_descriptors.HeroWeight_weight.type = 1
field_descriptors.HeroWeight_weight.cpp_type = 5
type_descriptors.HeroWeight.name = "HeroWeight"
type_descriptors.HeroWeight.full_name = ".HeroWeight"
type_descriptors.HeroWeight.nested_types = {}
type_descriptors.HeroWeight.enum_types = {}
type_descriptors.HeroWeight.fields = {
	field_descriptors.HeroWeight_heroId,
	field_descriptors.HeroWeight_weight
}
type_descriptors.HeroWeight.is_extendable = false
type_descriptors.HeroWeight.extensions = {}
field_descriptors.HeroInfoPush_hero.name = "hero"
field_descriptors.HeroInfoPush_hero.full_name = ".HeroInfoPush.hero"
field_descriptors.HeroInfoPush_hero.number = 1
field_descriptors.HeroInfoPush_hero.index = 0
field_descriptors.HeroInfoPush_hero.label = 1
field_descriptors.HeroInfoPush_hero.has_default_value = false
field_descriptors.HeroInfoPush_hero.default_value = nil
field_descriptors.HeroInfoPush_hero.message_type = type_descriptors.Hero
field_descriptors.HeroInfoPush_hero.type = 11
field_descriptors.HeroInfoPush_hero.cpp_type = 10
type_descriptors.HeroInfoPush.name = "HeroInfoPush"
type_descriptors.HeroInfoPush.full_name = ".HeroInfoPush"
type_descriptors.HeroInfoPush.nested_types = {}
type_descriptors.HeroInfoPush.enum_types = {}
type_descriptors.HeroInfoPush.fields = {
	field_descriptors.HeroInfoPush_hero
}
type_descriptors.HeroInfoPush.is_extendable = false
type_descriptors.HeroInfoPush.extensions = {}
field_descriptors.LoadHerosReply_heros.name = "heros"
field_descriptors.LoadHerosReply_heros.full_name = ".LoadHerosReply.heros"
field_descriptors.LoadHerosReply_heros.number = 1
field_descriptors.LoadHerosReply_heros.index = 0
field_descriptors.LoadHerosReply_heros.label = 3
field_descriptors.LoadHerosReply_heros.has_default_value = false
field_descriptors.LoadHerosReply_heros.default_value = {}
field_descriptors.LoadHerosReply_heros.message_type = type_descriptors.Hero
field_descriptors.LoadHerosReply_heros.type = 11
field_descriptors.LoadHerosReply_heros.cpp_type = 10
type_descriptors.LoadHerosReply.name = "LoadHerosReply"
type_descriptors.LoadHerosReply.full_name = ".LoadHerosReply"
type_descriptors.LoadHerosReply.nested_types = {}
type_descriptors.LoadHerosReply.enum_types = {}
type_descriptors.LoadHerosReply.fields = {
	field_descriptors.LoadHerosReply_heros
}
type_descriptors.LoadHerosReply.is_extendable = false
type_descriptors.LoadHerosReply.extensions = {}
type_descriptors.AddHeroExpReply.name = "AddHeroExpReply"
type_descriptors.AddHeroExpReply.full_name = ".AddHeroExpReply"
type_descriptors.AddHeroExpReply.nested_types = {}
type_descriptors.AddHeroExpReply.enum_types = {}
type_descriptors.AddHeroExpReply.fields = {}
type_descriptors.AddHeroExpReply.is_extendable = false
type_descriptors.AddHeroExpReply.extensions = {}
type_descriptors.LoadHeroWeightRequest.name = "LoadHeroWeightRequest"
type_descriptors.LoadHeroWeightRequest.full_name = ".LoadHeroWeightRequest"
type_descriptors.LoadHeroWeightRequest.nested_types = {}
type_descriptors.LoadHeroWeightRequest.enum_types = {}
type_descriptors.LoadHeroWeightRequest.fields = {}
type_descriptors.LoadHeroWeightRequest.is_extendable = false
type_descriptors.LoadHeroWeightRequest.extensions = {}
field_descriptors.Entry_key.name = "key"
field_descriptors.Entry_key.full_name = ".Entry.key"
field_descriptors.Entry_key.number = 1
field_descriptors.Entry_key.index = 0
field_descriptors.Entry_key.label = 1
field_descriptors.Entry_key.has_default_value = false
field_descriptors.Entry_key.default_value = 0
field_descriptors.Entry_key.type = 5
field_descriptors.Entry_key.cpp_type = 1
field_descriptors.Entry_value.name = "value"
field_descriptors.Entry_value.full_name = ".Entry.value"
field_descriptors.Entry_value.number = 2
field_descriptors.Entry_value.index = 1
field_descriptors.Entry_value.label = 1
field_descriptors.Entry_value.has_default_value = false
field_descriptors.Entry_value.default_value = 0
field_descriptors.Entry_value.type = 5
field_descriptors.Entry_value.cpp_type = 1
type_descriptors.Entry.name = "Entry"
type_descriptors.Entry.full_name = ".Entry"
type_descriptors.Entry.nested_types = {}
type_descriptors.Entry.enum_types = {}
type_descriptors.Entry.fields = {
	field_descriptors.Entry_key,
	field_descriptors.Entry_value
}
type_descriptors.Entry.is_extendable = false
type_descriptors.Entry.extensions = {}
field_descriptors.HeroSkillEnhanceReply_heroId.name = "heroId"
field_descriptors.HeroSkillEnhanceReply_heroId.full_name = ".HeroSkillEnhanceReply.heroId"
field_descriptors.HeroSkillEnhanceReply_heroId.number = 1
field_descriptors.HeroSkillEnhanceReply_heroId.index = 0
field_descriptors.HeroSkillEnhanceReply_heroId.label = 1
field_descriptors.HeroSkillEnhanceReply_heroId.has_default_value = false
field_descriptors.HeroSkillEnhanceReply_heroId.default_value = 0
field_descriptors.HeroSkillEnhanceReply_heroId.type = 5
field_descriptors.HeroSkillEnhanceReply_heroId.cpp_type = 1
field_descriptors.HeroSkillEnhanceReply_skillInfos.name = "skillInfos"
field_descriptors.HeroSkillEnhanceReply_skillInfos.full_name = ".HeroSkillEnhanceReply.skillInfos"
field_descriptors.HeroSkillEnhanceReply_skillInfos.number = 2
field_descriptors.HeroSkillEnhanceReply_skillInfos.index = 1
field_descriptors.HeroSkillEnhanceReply_skillInfos.label = 3
field_descriptors.HeroSkillEnhanceReply_skillInfos.has_default_value = false
field_descriptors.HeroSkillEnhanceReply_skillInfos.default_value = {}
field_descriptors.HeroSkillEnhanceReply_skillInfos.message_type = type_descriptors.SkillEnhanceInfo
field_descriptors.HeroSkillEnhanceReply_skillInfos.type = 11
field_descriptors.HeroSkillEnhanceReply_skillInfos.cpp_type = 10
type_descriptors.HeroSkillEnhanceReply.name = "HeroSkillEnhanceReply"
type_descriptors.HeroSkillEnhanceReply.full_name = ".HeroSkillEnhanceReply"
type_descriptors.HeroSkillEnhanceReply.nested_types = {}
type_descriptors.HeroSkillEnhanceReply.enum_types = {}
type_descriptors.HeroSkillEnhanceReply.fields = {
	field_descriptors.HeroSkillEnhanceReply_heroId,
	field_descriptors.HeroSkillEnhanceReply_skillInfos
}
type_descriptors.HeroSkillEnhanceReply.is_extendable = false
type_descriptors.HeroSkillEnhanceReply.extensions = {}
type_descriptors.LoadHerosRequest.name = "LoadHerosRequest"
type_descriptors.LoadHerosRequest.full_name = ".LoadHerosRequest"
type_descriptors.LoadHerosRequest.nested_types = {}
type_descriptors.LoadHerosRequest.enum_types = {}
type_descriptors.LoadHerosRequest.fields = {}
type_descriptors.LoadHerosRequest.is_extendable = false
type_descriptors.LoadHerosRequest.extensions = {}
field_descriptors.Hero_id.name = "id"
field_descriptors.Hero_id.full_name = ".Hero.id"
field_descriptors.Hero_id.number = 1
field_descriptors.Hero_id.index = 0
field_descriptors.Hero_id.label = 1
field_descriptors.Hero_id.has_default_value = false
field_descriptors.Hero_id.default_value = 0
field_descriptors.Hero_id.type = 5
field_descriptors.Hero_id.cpp_type = 1
field_descriptors.Hero_level.name = "level"
field_descriptors.Hero_level.full_name = ".Hero.level"
field_descriptors.Hero_level.number = 2
field_descriptors.Hero_level.index = 1
field_descriptors.Hero_level.label = 1
field_descriptors.Hero_level.has_default_value = false
field_descriptors.Hero_level.default_value = 0
field_descriptors.Hero_level.type = 5
field_descriptors.Hero_level.cpp_type = 1
field_descriptors.Hero_powerLv.name = "powerLv"
field_descriptors.Hero_powerLv.full_name = ".Hero.powerLv"
field_descriptors.Hero_powerLv.number = 3
field_descriptors.Hero_powerLv.index = 2
field_descriptors.Hero_powerLv.label = 1
field_descriptors.Hero_powerLv.has_default_value = false
field_descriptors.Hero_powerLv.default_value = 0
field_descriptors.Hero_powerLv.type = 5
field_descriptors.Hero_powerLv.cpp_type = 1
field_descriptors.Hero_breakLv.name = "breakLv"
field_descriptors.Hero_breakLv.full_name = ".Hero.breakLv"
field_descriptors.Hero_breakLv.number = 4
field_descriptors.Hero_breakLv.index = 3
field_descriptors.Hero_breakLv.label = 1
field_descriptors.Hero_breakLv.has_default_value = false
field_descriptors.Hero_breakLv.default_value = 0
field_descriptors.Hero_breakLv.type = 5
field_descriptors.Hero_breakLv.cpp_type = 1
field_descriptors.Hero_ccDegree.name = "ccDegree"
field_descriptors.Hero_ccDegree.full_name = ".Hero.ccDegree"
field_descriptors.Hero_ccDegree.number = 5
field_descriptors.Hero_ccDegree.index = 4
field_descriptors.Hero_ccDegree.label = 1
field_descriptors.Hero_ccDegree.has_default_value = false
field_descriptors.Hero_ccDegree.default_value = 0
field_descriptors.Hero_ccDegree.type = 5
field_descriptors.Hero_ccDegree.cpp_type = 1
field_descriptors.Hero_attrs.name = "attrs"
field_descriptors.Hero_attrs.full_name = ".Hero.attrs"
field_descriptors.Hero_attrs.number = 7
field_descriptors.Hero_attrs.index = 5
field_descriptors.Hero_attrs.label = 3
field_descriptors.Hero_attrs.has_default_value = false
field_descriptors.Hero_attrs.default_value = {}
field_descriptors.Hero_attrs.message_type = dependencies.BattleExtension.type_descriptors.AttributeNO
field_descriptors.Hero_attrs.type = 11
field_descriptors.Hero_attrs.cpp_type = 10
field_descriptors.Hero_skills.name = "skills"
field_descriptors.Hero_skills.full_name = ".Hero.skills"
field_descriptors.Hero_skills.number = 8
field_descriptors.Hero_skills.index = 6
field_descriptors.Hero_skills.label = 3
field_descriptors.Hero_skills.has_default_value = false
field_descriptors.Hero_skills.default_value = {}
field_descriptors.Hero_skills.message_type = type_descriptors.Entry
field_descriptors.Hero_skills.type = 11
field_descriptors.Hero_skills.cpp_type = 10
field_descriptors.Hero_talentSkill.name = "talentSkill"
field_descriptors.Hero_talentSkill.full_name = ".Hero.talentSkill"
field_descriptors.Hero_talentSkill.number = 9
field_descriptors.Hero_talentSkill.index = 7
field_descriptors.Hero_talentSkill.label = 1
field_descriptors.Hero_talentSkill.has_default_value = false
field_descriptors.Hero_talentSkill.default_value = nil
field_descriptors.Hero_talentSkill.message_type = type_descriptors.Entry
field_descriptors.Hero_talentSkill.type = 11
field_descriptors.Hero_talentSkill.cpp_type = 10
field_descriptors.Hero_treatyLv.name = "treatyLv"
field_descriptors.Hero_treatyLv.full_name = ".Hero.treatyLv"
field_descriptors.Hero_treatyLv.number = 10
field_descriptors.Hero_treatyLv.index = 8
field_descriptors.Hero_treatyLv.label = 1
field_descriptors.Hero_treatyLv.has_default_value = false
field_descriptors.Hero_treatyLv.default_value = 0
field_descriptors.Hero_treatyLv.type = 5
field_descriptors.Hero_treatyLv.cpp_type = 1
field_descriptors.Hero_status.name = "status"
field_descriptors.Hero_status.full_name = ".Hero.status"
field_descriptors.Hero_status.number = 11
field_descriptors.Hero_status.index = 9
field_descriptors.Hero_status.label = 1
field_descriptors.Hero_status.has_default_value = false
field_descriptors.Hero_status.default_value = 0
field_descriptors.Hero_status.type = 5
field_descriptors.Hero_status.cpp_type = 1
field_descriptors.Hero_lvExp.name = "lvExp"
field_descriptors.Hero_lvExp.full_name = ".Hero.lvExp"
field_descriptors.Hero_lvExp.number = 12
field_descriptors.Hero_lvExp.index = 10
field_descriptors.Hero_lvExp.label = 1
field_descriptors.Hero_lvExp.has_default_value = false
field_descriptors.Hero_lvExp.default_value = 0
field_descriptors.Hero_lvExp.type = 5
field_descriptors.Hero_lvExp.cpp_type = 1
field_descriptors.Hero_qua6.name = "qua6"
field_descriptors.Hero_qua6.full_name = ".Hero.qua6"
field_descriptors.Hero_qua6.number = 14
field_descriptors.Hero_qua6.index = 11
field_descriptors.Hero_qua6.label = 3
field_descriptors.Hero_qua6.has_default_value = false
field_descriptors.Hero_qua6.default_value = {}
field_descriptors.Hero_qua6.type = 5
field_descriptors.Hero_qua6.cpp_type = 1
field_descriptors.Hero_expression.name = "expression"
field_descriptors.Hero_expression.full_name = ".Hero.expression"
field_descriptors.Hero_expression.number = 15
field_descriptors.Hero_expression.index = 12
field_descriptors.Hero_expression.label = 1
field_descriptors.Hero_expression.has_default_value = false
field_descriptors.Hero_expression.default_value = 0
field_descriptors.Hero_expression.type = 5
field_descriptors.Hero_expression.cpp_type = 1
field_descriptors.Hero_skinId.name = "skinId"
field_descriptors.Hero_skinId.full_name = ".Hero.skinId"
field_descriptors.Hero_skinId.number = 16
field_descriptors.Hero_skinId.index = 13
field_descriptors.Hero_skinId.label = 1
field_descriptors.Hero_skinId.has_default_value = false
field_descriptors.Hero_skinId.default_value = 0
field_descriptors.Hero_skinId.type = 5
field_descriptors.Hero_skinId.cpp_type = 1
field_descriptors.Hero_attrParts.name = "attrParts"
field_descriptors.Hero_attrParts.full_name = ".Hero.attrParts"
field_descriptors.Hero_attrParts.number = 17
field_descriptors.Hero_attrParts.index = 14
field_descriptors.Hero_attrParts.label = 3
field_descriptors.Hero_attrParts.has_default_value = false
field_descriptors.Hero_attrParts.default_value = {}
field_descriptors.Hero_attrParts.message_type = dependencies.BattleExtension.type_descriptors.AttributePartNO
field_descriptors.Hero_attrParts.type = 11
field_descriptors.Hero_attrParts.cpp_type = 10
field_descriptors.Hero_tacitExp.name = "tacitExp"
field_descriptors.Hero_tacitExp.full_name = ".Hero.tacitExp"
field_descriptors.Hero_tacitExp.number = 19
field_descriptors.Hero_tacitExp.index = 15
field_descriptors.Hero_tacitExp.label = 1
field_descriptors.Hero_tacitExp.has_default_value = false
field_descriptors.Hero_tacitExp.default_value = 0
field_descriptors.Hero_tacitExp.type = 5
field_descriptors.Hero_tacitExp.cpp_type = 1
field_descriptors.Hero_wakeup.name = "wakeup"
field_descriptors.Hero_wakeup.full_name = ".Hero.wakeup"
field_descriptors.Hero_wakeup.number = 20
field_descriptors.Hero_wakeup.index = 16
field_descriptors.Hero_wakeup.label = 1
field_descriptors.Hero_wakeup.has_default_value = false
field_descriptors.Hero_wakeup.default_value = false
field_descriptors.Hero_wakeup.type = 8
field_descriptors.Hero_wakeup.cpp_type = 7
field_descriptors.Hero_pveWinTimes.name = "pveWinTimes"
field_descriptors.Hero_pveWinTimes.full_name = ".Hero.pveWinTimes"
field_descriptors.Hero_pveWinTimes.number = 21
field_descriptors.Hero_pveWinTimes.index = 17
field_descriptors.Hero_pveWinTimes.label = 1
field_descriptors.Hero_pveWinTimes.has_default_value = false
field_descriptors.Hero_pveWinTimes.default_value = 0
field_descriptors.Hero_pveWinTimes.type = 5
field_descriptors.Hero_pveWinTimes.cpp_type = 1
field_descriptors.Hero_nodesInfo.name = "nodesInfo"
field_descriptors.Hero_nodesInfo.full_name = ".Hero.nodesInfo"
field_descriptors.Hero_nodesInfo.number = 22
field_descriptors.Hero_nodesInfo.index = 18
field_descriptors.Hero_nodesInfo.label = 3
field_descriptors.Hero_nodesInfo.has_default_value = false
field_descriptors.Hero_nodesInfo.default_value = {}
field_descriptors.Hero_nodesInfo.type = 5
field_descriptors.Hero_nodesInfo.cpp_type = 1
field_descriptors.Hero_extNodesInfo.name = "extNodesInfo"
field_descriptors.Hero_extNodesInfo.full_name = ".Hero.extNodesInfo"
field_descriptors.Hero_extNodesInfo.number = 23
field_descriptors.Hero_extNodesInfo.index = 19
field_descriptors.Hero_extNodesInfo.label = 3
field_descriptors.Hero_extNodesInfo.has_default_value = false
field_descriptors.Hero_extNodesInfo.default_value = {}
field_descriptors.Hero_extNodesInfo.type = 5
field_descriptors.Hero_extNodesInfo.cpp_type = 1
type_descriptors.Hero.name = "Hero"
type_descriptors.Hero.full_name = ".Hero"
type_descriptors.Hero.nested_types = {}
type_descriptors.Hero.enum_types = {}
type_descriptors.Hero.fields = {
	field_descriptors.Hero_id,
	field_descriptors.Hero_level,
	field_descriptors.Hero_powerLv,
	field_descriptors.Hero_breakLv,
	field_descriptors.Hero_ccDegree,
	field_descriptors.Hero_attrs,
	field_descriptors.Hero_skills,
	field_descriptors.Hero_talentSkill,
	field_descriptors.Hero_treatyLv,
	field_descriptors.Hero_status,
	field_descriptors.Hero_lvExp,
	field_descriptors.Hero_qua6,
	field_descriptors.Hero_expression,
	field_descriptors.Hero_skinId,
	field_descriptors.Hero_attrParts,
	field_descriptors.Hero_tacitExp,
	field_descriptors.Hero_wakeup,
	field_descriptors.Hero_pveWinTimes,
	field_descriptors.Hero_nodesInfo,
	field_descriptors.Hero_extNodesInfo
}
type_descriptors.Hero.is_extendable = false
type_descriptors.Hero.extensions = {}
field_descriptors.HeroSkillEnhanceUpdatePush_heroId.name = "heroId"
field_descriptors.HeroSkillEnhanceUpdatePush_heroId.full_name = ".HeroSkillEnhanceUpdatePush.heroId"
field_descriptors.HeroSkillEnhanceUpdatePush_heroId.number = 1
field_descriptors.HeroSkillEnhanceUpdatePush_heroId.index = 0
field_descriptors.HeroSkillEnhanceUpdatePush_heroId.label = 1
field_descriptors.HeroSkillEnhanceUpdatePush_heroId.has_default_value = false
field_descriptors.HeroSkillEnhanceUpdatePush_heroId.default_value = 0
field_descriptors.HeroSkillEnhanceUpdatePush_heroId.type = 5
field_descriptors.HeroSkillEnhanceUpdatePush_heroId.cpp_type = 1
field_descriptors.HeroSkillEnhanceUpdatePush_skillInfos.name = "skillInfos"
field_descriptors.HeroSkillEnhanceUpdatePush_skillInfos.full_name = ".HeroSkillEnhanceUpdatePush.skillInfos"
field_descriptors.HeroSkillEnhanceUpdatePush_skillInfos.number = 2
field_descriptors.HeroSkillEnhanceUpdatePush_skillInfos.index = 1
field_descriptors.HeroSkillEnhanceUpdatePush_skillInfos.label = 3
field_descriptors.HeroSkillEnhanceUpdatePush_skillInfos.has_default_value = false
field_descriptors.HeroSkillEnhanceUpdatePush_skillInfos.default_value = {}
field_descriptors.HeroSkillEnhanceUpdatePush_skillInfos.message_type = type_descriptors.SkillEnhanceInfo
field_descriptors.HeroSkillEnhanceUpdatePush_skillInfos.type = 11
field_descriptors.HeroSkillEnhanceUpdatePush_skillInfos.cpp_type = 10
type_descriptors.HeroSkillEnhanceUpdatePush.name = "HeroSkillEnhanceUpdatePush"
type_descriptors.HeroSkillEnhanceUpdatePush.full_name = ".HeroSkillEnhanceUpdatePush"
type_descriptors.HeroSkillEnhanceUpdatePush.nested_types = {}
type_descriptors.HeroSkillEnhanceUpdatePush.enum_types = {}
type_descriptors.HeroSkillEnhanceUpdatePush.fields = {
	field_descriptors.HeroSkillEnhanceUpdatePush_heroId,
	field_descriptors.HeroSkillEnhanceUpdatePush_skillInfos
}
type_descriptors.HeroSkillEnhanceUpdatePush.is_extendable = false
type_descriptors.HeroSkillEnhanceUpdatePush.extensions = {}
field_descriptors.SkillEnhanceInfo_skillId.name = "skillId"
field_descriptors.SkillEnhanceInfo_skillId.full_name = ".SkillEnhanceInfo.skillId"
field_descriptors.SkillEnhanceInfo_skillId.number = 1
field_descriptors.SkillEnhanceInfo_skillId.index = 0
field_descriptors.SkillEnhanceInfo_skillId.label = 1
field_descriptors.SkillEnhanceInfo_skillId.has_default_value = false
field_descriptors.SkillEnhanceInfo_skillId.default_value = 0
field_descriptors.SkillEnhanceInfo_skillId.type = 5
field_descriptors.SkillEnhanceInfo_skillId.cpp_type = 1
field_descriptors.SkillEnhanceInfo_enhanceIds.name = "enhanceIds"
field_descriptors.SkillEnhanceInfo_enhanceIds.full_name = ".SkillEnhanceInfo.enhanceIds"
field_descriptors.SkillEnhanceInfo_enhanceIds.number = 2
field_descriptors.SkillEnhanceInfo_enhanceIds.index = 1
field_descriptors.SkillEnhanceInfo_enhanceIds.label = 3
field_descriptors.SkillEnhanceInfo_enhanceIds.has_default_value = false
field_descriptors.SkillEnhanceInfo_enhanceIds.default_value = {}
field_descriptors.SkillEnhanceInfo_enhanceIds.type = 5
field_descriptors.SkillEnhanceInfo_enhanceIds.cpp_type = 1
type_descriptors.SkillEnhanceInfo.name = "SkillEnhanceInfo"
type_descriptors.SkillEnhanceInfo.full_name = ".SkillEnhanceInfo"
type_descriptors.SkillEnhanceInfo.nested_types = {}
type_descriptors.SkillEnhanceInfo.enum_types = {}
type_descriptors.SkillEnhanceInfo.fields = {
	field_descriptors.SkillEnhanceInfo_skillId,
	field_descriptors.SkillEnhanceInfo_enhanceIds
}
type_descriptors.SkillEnhanceInfo.is_extendable = false
type_descriptors.SkillEnhanceInfo.extensions = {}
field_descriptors.LoadHeroWeightReply_info.name = "info"
field_descriptors.LoadHeroWeightReply_info.full_name = ".LoadHeroWeightReply.info"
field_descriptors.LoadHeroWeightReply_info.number = 1
field_descriptors.LoadHeroWeightReply_info.index = 0
field_descriptors.LoadHeroWeightReply_info.label = 3
field_descriptors.LoadHeroWeightReply_info.has_default_value = false
field_descriptors.LoadHeroWeightReply_info.default_value = {}
field_descriptors.LoadHeroWeightReply_info.message_type = type_descriptors.HeroWeight
field_descriptors.LoadHeroWeightReply_info.type = 11
field_descriptors.LoadHeroWeightReply_info.cpp_type = 10
field_descriptors.LoadHeroWeightReply_expiredMillis.name = "expiredMillis"
field_descriptors.LoadHeroWeightReply_expiredMillis.full_name = ".LoadHeroWeightReply.expiredMillis"
field_descriptors.LoadHeroWeightReply_expiredMillis.number = 2
field_descriptors.LoadHeroWeightReply_expiredMillis.index = 1
field_descriptors.LoadHeroWeightReply_expiredMillis.label = 2
field_descriptors.LoadHeroWeightReply_expiredMillis.has_default_value = false
field_descriptors.LoadHeroWeightReply_expiredMillis.default_value = 0
field_descriptors.LoadHeroWeightReply_expiredMillis.type = 3
field_descriptors.LoadHeroWeightReply_expiredMillis.cpp_type = 2
type_descriptors.LoadHeroWeightReply.name = "LoadHeroWeightReply"
type_descriptors.LoadHeroWeightReply.full_name = ".LoadHeroWeightReply"
type_descriptors.LoadHeroWeightReply.nested_types = {}
type_descriptors.LoadHeroWeightReply.enum_types = {}
type_descriptors.LoadHeroWeightReply.fields = {
	field_descriptors.LoadHeroWeightReply_info,
	field_descriptors.LoadHeroWeightReply_expiredMillis
}
type_descriptors.LoadHeroWeightReply.is_extendable = false
type_descriptors.LoadHeroWeightReply.extensions = {}
field_descriptors.AddHeroExpRequest_heroId.name = "heroId"
field_descriptors.AddHeroExpRequest_heroId.full_name = ".AddHeroExpRequest.heroId"
field_descriptors.AddHeroExpRequest_heroId.number = 1
field_descriptors.AddHeroExpRequest_heroId.index = 0
field_descriptors.AddHeroExpRequest_heroId.label = 1
field_descriptors.AddHeroExpRequest_heroId.has_default_value = false
field_descriptors.AddHeroExpRequest_heroId.default_value = 0
field_descriptors.AddHeroExpRequest_heroId.type = 5
field_descriptors.AddHeroExpRequest_heroId.cpp_type = 1
field_descriptors.AddHeroExpRequest_useItems.name = "useItems"
field_descriptors.AddHeroExpRequest_useItems.full_name = ".AddHeroExpRequest.useItems"
field_descriptors.AddHeroExpRequest_useItems.number = 2
field_descriptors.AddHeroExpRequest_useItems.index = 1
field_descriptors.AddHeroExpRequest_useItems.label = 1
field_descriptors.AddHeroExpRequest_useItems.has_default_value = false
field_descriptors.AddHeroExpRequest_useItems.default_value = ""
field_descriptors.AddHeroExpRequest_useItems.type = 9
field_descriptors.AddHeroExpRequest_useItems.cpp_type = 9
type_descriptors.AddHeroExpRequest.name = "AddHeroExpRequest"
type_descriptors.AddHeroExpRequest.full_name = ".AddHeroExpRequest"
type_descriptors.AddHeroExpRequest.nested_types = {}
type_descriptors.AddHeroExpRequest.enum_types = {}
type_descriptors.AddHeroExpRequest.fields = {
	field_descriptors.AddHeroExpRequest_heroId,
	field_descriptors.AddHeroExpRequest_useItems
}
type_descriptors.AddHeroExpRequest.is_extendable = false
type_descriptors.AddHeroExpRequest.extensions = {}
field_descriptors.HeroSkillEnhanceRequest_heroId.name = "heroId"
field_descriptors.HeroSkillEnhanceRequest_heroId.full_name = ".HeroSkillEnhanceRequest.heroId"
field_descriptors.HeroSkillEnhanceRequest_heroId.number = 1
field_descriptors.HeroSkillEnhanceRequest_heroId.index = 0
field_descriptors.HeroSkillEnhanceRequest_heroId.label = 1
field_descriptors.HeroSkillEnhanceRequest_heroId.has_default_value = false
field_descriptors.HeroSkillEnhanceRequest_heroId.default_value = 0
field_descriptors.HeroSkillEnhanceRequest_heroId.type = 5
field_descriptors.HeroSkillEnhanceRequest_heroId.cpp_type = 1
type_descriptors.HeroSkillEnhanceRequest.name = "HeroSkillEnhanceRequest"
type_descriptors.HeroSkillEnhanceRequest.full_name = ".HeroSkillEnhanceRequest"
type_descriptors.HeroSkillEnhanceRequest.nested_types = {}
type_descriptors.HeroSkillEnhanceRequest.enum_types = {}
type_descriptors.HeroSkillEnhanceRequest.fields = {
	field_descriptors.HeroSkillEnhanceRequest_heroId
}
type_descriptors.HeroSkillEnhanceRequest.is_extendable = false
type_descriptors.HeroSkillEnhanceRequest.extensions = {}
AddHeroExpReply = protobuf.Message(type_descriptors.AddHeroExpReply)
AddHeroExpRequest = protobuf.Message(type_descriptors.AddHeroExpRequest)
Entry = protobuf.Message(type_descriptors.Entry)
Hero = protobuf.Message(type_descriptors.Hero)
HeroInfoPush = protobuf.Message(type_descriptors.HeroInfoPush)
HeroSkillEnhanceReply = protobuf.Message(type_descriptors.HeroSkillEnhanceReply)
HeroSkillEnhanceRequest = protobuf.Message(type_descriptors.HeroSkillEnhanceRequest)
HeroSkillEnhanceUpdatePush = protobuf.Message(type_descriptors.HeroSkillEnhanceUpdatePush)
HeroWeight = protobuf.Message(type_descriptors.HeroWeight)
LoadHeroWeightReply = protobuf.Message(type_descriptors.LoadHeroWeightReply)
LoadHeroWeightRequest = protobuf.Message(type_descriptors.LoadHeroWeightRequest)
LoadHerosReply = protobuf.Message(type_descriptors.LoadHerosReply)
LoadHerosRequest = protobuf.Message(type_descriptors.LoadHerosRequest)
SkillEnhanceInfo = protobuf.Message(type_descriptors.SkillEnhanceInfo)

return _G["logic.proto.HeroExtension_pb"]
