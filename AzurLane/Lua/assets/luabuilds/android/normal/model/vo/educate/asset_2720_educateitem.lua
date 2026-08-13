class = var_0_10000

local var_0_0 = "EducateItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.TYPE_BOOK = 1
var_0_1.TYPE_MUSICAL = 2
var_0_1.TYPE_TOOL = 3
var_0_1.TYPE_SUDRIES = 4
var_0_1.RARITY2FRAME = {
	"rarity_grey",
	"rarity_green",
	"rarity_blue",
	"rarity_purple",
	"rarity_orange"
}
var_0_1.USE_TYPE_UNDEFINED = "usage_undefined"
var_0_1.USE_TYPE_DROP = "usage_drop"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	local var_1_0

	if not arg_1_1.num then
		var_1_0 = 0
	end

	arg_1_0.count = var_1_0

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.child_item
end

function var_0_1.CanUse(arg_3_0)
	return arg_3_0:getConfig("usage") ~= var_0_1.USE_TYPE_UNDEFINED
end

function var_0_1.IsEnough(arg_4_0, arg_4_1)
	return arg_4_1 <= arg_4_0.count
end

function var_0_1.Consume(arg_5_0, arg_5_1)
	arg_5_0.count = arg_5_0.count - arg_5_1

	return
end

function var_0_1.AddCount(arg_6_0, arg_6_1)
	arg_6_0.count = arg_6_0.count + arg_6_1

	return
end

function var_0_1.GetType(arg_7_0)
	return arg_7_0:getConfig("type")
end

function var_0_1.GetIcon(arg_8_0)
	return arg_8_0:getConfig("icon")
end

function var_0_1.GetName(arg_9_0)
	return arg_9_0:getConfig("name")
end

function var_0_1.GetRarity(arg_10_0)
	return arg_10_0:getConfig("rarity")
end

function var_0_1.GetFrameName(arg_11_0)
	return var_0_1.RARITY2FRAME[arg_11_0:GetRarity()]
end

function var_0_1.IsShow(arg_12_0)
	return arg_12_0:getConfig("is_show") == 1
end

function var_0_1.GetShowInfo(arg_13_0)
	local var_13_0 = {}

	EducateConst = var_1_10002
	var_13_0.type = var_1_10002.DROP_TYPE_ITEM
	var_13_0.id = arg_13_0.id
	var_13_0.number = arg_13_0.count

	return var_13_0
end

return var_0_1
