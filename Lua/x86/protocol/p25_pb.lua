local var_0_0 = require("protobuf")
local var_0_1 = require("protocol/chapter_hrl_pb")

module("p25_pb", package.seeall)

local var_0_2 = {
	SC_25009_FIELD_LIST = {}
}

SC_25009 = var_0_0.Descriptor()
var_0_2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD = var_0_0.FieldDescriptor()
var_0_2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.name = "daily_battle_list"
var_0_2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.full_name = ".common.sc_25009.daily_battle_list"
var_0_2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.number = 1
var_0_2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.index = 0
var_0_2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.label = 3
var_0_2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.has_default_value = false
var_0_2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.default_value = {}
var_0_2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.message_type = var_0_1.CHAPTER_INFO
var_0_2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.type = 11
var_0_2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD.cpp_type = 10
SC_25009.name = "sc_25009"
SC_25009.full_name = ".common.sc_25009"
SC_25009.nested_types = {}
SC_25009.enum_types = {}
SC_25009.fields = {
	var_0_2.SC_25009_FIELD_LIST.SC_25009_DAILY_BATTLE_LIST_FIELD
}
SC_25009.is_extendable = false
SC_25009.extensions = {}
sc_25009 = var_0_0.Message(SC_25009)

return p25_pb
