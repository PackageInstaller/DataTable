class = var_0_10000

local var_0_0 = "CardPuzzleGift"

BaseVO = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002)

var_0_1.TYPE = {
	GLOBAL = 1,
	USABLE = 3,
	BATTLE = 2
}
var_0_1.EFFECT_TYPE = {
	BATTLE_BUFF = 2,
	COIN_BONUS = 5,
	ROGUE_DROP_BONUS = 3,
	CARD_CLIPPING = 4,
	GLOBAL_ATTRIBUTE_BONUS = 1
}

function var_0_1.CreateByNetData(arg_1_0)
	local var_1_0 = {}

	for iter_1_0 = 1, arg_1_0.num do
		table = var_1_10006

		var_1_10006.insert(var_1_0, var_0_1.New({
			configId = arg_1_0.id
		}))
	end

	return var_1_0
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.puzzle_relics_template
end

function var_0_1.GetIconPath(arg_3_0)
	return "roguegifts/" .. arg_3_0:getConfig("icon")
end

function var_0_1.GetConfigId(arg_4_0)
	return arg_4_0.configId
end

function var_0_1.GetName(arg_5_0)
	return arg_5_0:getConfig("name")
end

function var_0_1.GetType(arg_6_0)
	return arg_6_0:getConfig("type")
end

function var_0_1.GetDesc(arg_7_0)
	return arg_7_0:getConfig("desc")
end

function var_0_1.GetRarity(arg_8_0)
	return arg_8_0:getConfig("rarity")
end

function var_0_1.GetEffects(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.getConfig(var_9_0, "arg_list")

	_ = var_9_0

	return var_9_0.map(var_9_1, function(arg_10_0)
		pg = var_2_10001

		local var_10_0 = var_2_10001.puzzle_relics_effect[arg_10_0]

		assert = var_2_10002

		var_2_10002(var_10_0)

		return var_10_0
	end)
end

function var_0_1.GetAttributeBonus(arg_11_0, arg_11_1)
	local var_11_0 = {}

	if arg_11_0:GetType() ~= var_0_1.TYPE.GLOBAL then
		return var_11_0
	end

	ipairs = var_3

	for iter_11_0, iter_11_1 in var_3(arg_11_0:GetEffects()) do
		if iter_11_1.type == var_0_1.EFFECT_TYPE.GLOBAL_ATTRIBUTE_BONUS then
			ipairs = var_8

			for iter_11_2, iter_11_3 in var_8(iter_11_1.arg_list) do
				local var_11_1 = iter_11_3[1]
				local var_11_2 = iter_11_3[2]
				local var_11_3 = iter_11_3[3]

				table = var_1_10016
				var_1_10016 = var_1_10016.contains

				local var_11_4 = var_11_1
				local var_11_5 = arg_11_1

				if var_1_10016(var_11_4, arg_11_1.getShipType(var_11_5)) then
					table = var_1_10016
					var_1_10016 = var_1_10016.insert

					local var_11_6 = var_11_0
					local var_11_7 = {}

					CardPuzzleShip = var_11_5
					var_11_7.type = var_11_5.PROPERTIES[var_11_2]
					var_11_7.value = var_11_3

					var_1_10016(var_11_6, var_11_7)
				end
			end
		end
	end

	return var_11_0
end

return var_0_1
