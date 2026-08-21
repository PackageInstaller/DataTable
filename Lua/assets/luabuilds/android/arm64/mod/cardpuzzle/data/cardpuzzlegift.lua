local var_0_0 = class("CardPuzzleGift", BaseVO)

var_0_0.TYPE = {
	GLOBAL = 1,
	USABLE = 3,
	BATTLE = 2
}
var_0_0.EFFECT_TYPE = {
	BATTLE_BUFF = 2,
	COIN_BONUS = 5,
	ROGUE_DROP_BONUS = 3,
	CARD_CLIPPING = 4,
	GLOBAL_ATTRIBUTE_BONUS = 1
}

function var_0_0.CreateByNetData(arg_1_0)
	for iter_1_0 = 1, arg_1_0.num do
		table.insert({}, var_0_0.New({
			configId = arg_1_0.id
		}))
	end

	return {}
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.puzzle_relics_template
end

function var_0_0.GetIconPath(arg_3_0)
	return "roguegifts/" .. arg_3_0:getConfig("icon")
end

function var_0_0.GetConfigId(arg_4_0)
	return arg_4_0.configId
end

function var_0_0.GetName(arg_5_0)
	return arg_5_0:getConfig("name")
end

function var_0_0.GetType(arg_6_0)
	return arg_6_0:getConfig("type")
end

function var_0_0.GetDesc(arg_7_0)
	return arg_7_0:getConfig("desc")
end

function var_0_0.GetRarity(arg_8_0)
	return arg_8_0:getConfig("rarity")
end

function var_0_0.GetEffects(arg_9_0)
	return _.map(arg_9_0:getConfig("arg_list"), function(arg_10_0)
		assert(pg.puzzle_relics_effect[arg_10_0])

		return pg.puzzle_relics_effect[arg_10_0]
	end)
end

function var_0_0.GetAttributeBonus(arg_11_0, arg_11_1)
	if arg_11_0:GetType() ~= var_0_0.TYPE.GLOBAL then
		return {}
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0:GetEffects()) do
		if iter_11_1.type == var_0_0.EFFECT_TYPE.GLOBAL_ATTRIBUTE_BONUS then
			for iter_11_2, iter_11_3 in ipairs(iter_11_1.arg_list) do
				if table.contains(iter_11_3[1], arg_11_1:getShipType()) then
					table.insert({}, {
						type = CardPuzzleShip.PROPERTIES[iter_11_3[2]],
						value = iter_11_3[3]
					})
				end
			end
		end
	end

	return {}
end

return var_0_0
