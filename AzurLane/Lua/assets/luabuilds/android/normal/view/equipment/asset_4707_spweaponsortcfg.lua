local var_0_0 = {}
local var_0_1 = {}
local var_0_2 = {
	spr = "sort_rarity",
	type = 1
}

i18n = var_0_10003
var_0_2.tag = var_0_10003("word_equipment_rarity")
var_0_2.values = {
	"rarity",
	"id",
	"level"
}
var_0_1[1] = var_0_2

local var_0_3 = {
	spr = "sort_intensify",
	type = 2
}

i18n = var_3
var_0_3.tag = var_3("word_equipment_intensify")
var_0_3.values = {
	"level",
	"rarity",
	"id"
}
var_0_1[2] = var_0_3
var_0_0.sort = var_0_1

function var_0_0.getWeight(arg_1_0, arg_1_1)
	SpWeapon = var_1_10002

	return var_1_10002.bindConfigTable()[arg_1_0:GetConfigID()][arg_1_1]
end

function var_0_0.sortFunc(arg_2_0, arg_2_1)
	local var_2_0 = {}

	ipairs = var_1_10003

	for iter_2_0, iter_2_1 in var_1_10003(arg_2_0.values) do
		table = var_1_10008

		var_1_10008.insert(var_2_0, function(arg_3_0)
			return (arg_2_1 and -1 or 1) * -var_0_0.getWeight(arg_3_0, iter_2_1)
		end)
	end

	return var_2_0
end

return var_0_0
