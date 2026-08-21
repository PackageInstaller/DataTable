local var_0_0 = class("EducateItem", import("model.vo.BaseVO"))

var_0_0.TYPE_BOOK = 1
var_0_0.TYPE_MUSICAL = 2
var_0_0.TYPE_TOOL = 3
var_0_0.TYPE_SUDRIES = 4
var_0_0.RARITY2FRAME = {
	"rarity_grey",
	"rarity_green",
	"rarity_blue",
	"rarity_purple",
	"rarity_orange"
}
var_0_0.USE_TYPE_UNDEFINED = "usage_undefined"
var_0_0.USE_TYPE_DROP = "usage_drop"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.count = arg_1_1.num or 0

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.child_item
end

function var_0_0.CanUse(arg_3_0)
	return arg_3_0:getConfig("usage") ~= var_0_0.USE_TYPE_UNDEFINED
end

function var_0_0.IsEnough(arg_4_0, arg_4_1)
	return arg_4_1 <= arg_4_0.count
end

function var_0_0.Consume(arg_5_0, arg_5_1)
	arg_5_0.count = arg_5_0.count - arg_5_1

	return
end

function var_0_0.AddCount(arg_6_0, arg_6_1)
	arg_6_0.count = arg_6_0.count + arg_6_1

	return
end

function var_0_0.GetType(arg_7_0)
	return arg_7_0:getConfig("type")
end

function var_0_0.GetIcon(arg_8_0)
	return arg_8_0:getConfig("icon")
end

function var_0_0.GetName(arg_9_0)
	return arg_9_0:getConfig("name")
end

function var_0_0.GetRarity(arg_10_0)
	return arg_10_0:getConfig("rarity")
end

function var_0_0.GetFrameName(arg_11_0)
	return var_0_0.RARITY2FRAME[arg_11_0:GetRarity()]
end

function var_0_0.IsShow(arg_12_0)
	return arg_12_0:getConfig("is_show") == 1
end

function var_0_0.GetShowInfo(arg_13_0)
	return {
		type = EducateConst.DROP_TYPE_ITEM,
		id = arg_13_0.id,
		number = arg_13_0.count
	}
end

return var_0_0
