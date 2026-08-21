local var_0_0 = require("protobuf")
local var_0_1 = require("common_pb")

module("p70_pb")

SC_70000 = var_0_0.Descriptor()

local var_0_2 = var_0_0.FieldDescriptor()

CS_70001 = var_0_0.Descriptor()

local var_0_3 = var_0_0.FieldDescriptor()
local var_0_4 = var_0_0.FieldDescriptor()

SC_70002 = var_0_0.Descriptor()

local var_0_5 = var_0_0.FieldDescriptor()

CS_70003 = var_0_0.Descriptor()

local var_0_6 = var_0_0.FieldDescriptor()

SC_70004 = var_0_0.Descriptor()

local var_0_7 = var_0_0.FieldDescriptor()

CS_70005 = var_0_0.Descriptor()

local var_0_8 = var_0_0.FieldDescriptor()

SC_70006 = var_0_0.Descriptor()

local var_0_9 = var_0_0.FieldDescriptor()
local var_0_10 = var_0_0.FieldDescriptor()

var_0_2.name = "meta_char_list"
var_0_2.full_name = ".p70.sc_70000.meta_char_list"
var_0_2.number = 1
var_0_2.index = 0
var_0_2.label = 3
var_0_2.has_default_value = false
var_0_2.default_value = {}
var_0_2.message_type = var_0_1.METACHARINFO
var_0_2.type = 11
var_0_2.cpp_type = 10
SC_70000.name = "sc_70000"
SC_70000.full_name = ".p70.sc_70000"
SC_70000.nested_types = {}
SC_70000.enum_types = {}
SC_70000.fields = {
	var_0_2
}
SC_70000.is_extendable = false
SC_70000.extensions = {}
var_0_3.name = "id"
var_0_3.full_name = ".p70.cs_70001.id"
var_0_3.number = 1
var_0_3.index = 0
var_0_3.label = 2
var_0_3.has_default_value = false
var_0_3.default_value = 0
var_0_3.type = 13
var_0_3.cpp_type = 3
var_0_4.name = "attr_list"
var_0_4.full_name = ".p70.cs_70001.attr_list"
var_0_4.number = 2
var_0_4.index = 1
var_0_4.label = 3
var_0_4.has_default_value = false
var_0_4.default_value = {}
var_0_4.type = 13
var_0_4.cpp_type = 3
CS_70001.name = "cs_70001"
CS_70001.full_name = ".p70.cs_70001"
CS_70001.nested_types = {}
CS_70001.enum_types = {}
CS_70001.fields = {
	var_0_3,
	var_0_4
}
CS_70001.is_extendable = false
CS_70001.extensions = {}
var_0_5.name = "result"
var_0_5.full_name = ".p70.sc_70002.result"
var_0_5.number = 1
var_0_5.index = 0
var_0_5.label = 2
var_0_5.has_default_value = false
var_0_5.default_value = 0
var_0_5.type = 13
var_0_5.cpp_type = 3
SC_70002.name = "sc_70002"
SC_70002.full_name = ".p70.sc_70002"
SC_70002.nested_types = {}
SC_70002.enum_types = {}
SC_70002.fields = {
	var_0_5
}
SC_70002.is_extendable = false
SC_70002.extensions = {}
var_0_6.name = "id"
var_0_6.full_name = ".p70.cs_70003.id"
var_0_6.number = 1
var_0_6.index = 0
var_0_6.label = 2
var_0_6.has_default_value = false
var_0_6.default_value = 0
var_0_6.type = 13
var_0_6.cpp_type = 3
CS_70003.name = "cs_70003"
CS_70003.full_name = ".p70.cs_70003"
CS_70003.nested_types = {}
CS_70003.enum_types = {}
CS_70003.fields = {
	var_0_6
}
CS_70003.is_extendable = false
CS_70003.extensions = {}
var_0_7.name = "result"
var_0_7.full_name = ".p70.sc_70004.result"
var_0_7.number = 1
var_0_7.index = 0
var_0_7.label = 2
var_0_7.has_default_value = false
var_0_7.default_value = 0
var_0_7.type = 13
var_0_7.cpp_type = 3
SC_70004.name = "sc_70004"
SC_70004.full_name = ".p70.sc_70004"
SC_70004.nested_types = {}
SC_70004.enum_types = {}
SC_70004.fields = {
	var_0_7
}
SC_70004.is_extendable = false
SC_70004.extensions = {}
var_0_8.name = "id"
var_0_8.full_name = ".p70.cs_70005.id"
var_0_8.number = 1
var_0_8.index = 0
var_0_8.label = 2
var_0_8.has_default_value = false
var_0_8.default_value = 0
var_0_8.type = 13
var_0_8.cpp_type = 3
CS_70005.name = "cs_70005"
CS_70005.full_name = ".p70.cs_70005"
CS_70005.nested_types = {}
CS_70005.enum_types = {}
CS_70005.fields = {
	var_0_8
}
CS_70005.is_extendable = false
CS_70005.extensions = {}
var_0_9.name = "result"
var_0_9.full_name = ".p70.sc_70006.result"
var_0_9.number = 1
var_0_9.index = 0
var_0_9.label = 2
var_0_9.has_default_value = false
var_0_9.default_value = 0
var_0_9.type = 13
var_0_9.cpp_type = 3
var_0_10.name = "ship"
var_0_10.full_name = ".p70.sc_70006.ship"
var_0_10.number = 2
var_0_10.index = 1
var_0_10.label = 1
var_0_10.has_default_value = false
var_0_10.default_value = nil
var_0_10.message_type = var_0_1.SHIPINFO
var_0_10.type = 11
var_0_10.cpp_type = 10
SC_70006.name = "sc_70006"
SC_70006.full_name = ".p70.sc_70006"
SC_70006.nested_types = {}
SC_70006.enum_types = {}
SC_70006.fields = {
	var_0_9,
	var_0_10
}
SC_70006.is_extendable = false
SC_70006.extensions = {}
cs_70001 = var_0_0.Message(CS_70001)
cs_70003 = var_0_0.Message(CS_70003)
cs_70005 = var_0_0.Message(CS_70005)
sc_70000 = var_0_0.Message(SC_70000)
sc_70002 = var_0_0.Message(SC_70002)
sc_70004 = var_0_0.Message(SC_70004)
sc_70006 = var_0_0.Message(SC_70006)

return
