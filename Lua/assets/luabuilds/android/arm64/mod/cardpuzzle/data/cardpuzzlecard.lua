local var_0_0 = class("CardPuzzleCard", BaseVO)

var_0_0.CARD_TYPE = {
	ATTACK = 1,
	ABILITY = 3,
	TACTIC = 2
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
	return pg.card_template
end

function var_0_0.GetIconPath(arg_3_0)
	return var_0_0.GetCardIconPath(arg_3_0:getConfig("icon"))
end

function var_0_0.GetConfigId(arg_4_0)
	return arg_4_0.configId
end

function var_0_0.GetName(arg_5_0)
	return arg_5_0:getConfig("name")
end

function var_0_0.GetCost(arg_6_0)
	return arg_6_0:getConfig("cost")
end

function var_0_0.GetType(arg_7_0)
	return arg_7_0:getConfig("card_type")
end

function var_0_0.GetDesc(arg_8_0)
	return arg_8_0:getConfig("discript")
end

function var_0_0.GetRarity(arg_9_0)
	return arg_9_0:getConfig("rarity")
end

function var_0_0.GetEffects(arg_10_0)
	return {
		{
			keywords = {}
		}
	}
end

function var_0_0.GetKeywords(arg_11_0)
	return var_0_0.GetCardKeyWord(arg_11_0:getConfig("label"))
end

function var_0_0.GetCardKeyWord(arg_12_0)
	return _.map(arg_12_0, function(arg_13_0)
		return pg.puzzle_card_affix[arg_13_0]
	end)
end

function var_0_0.GetCardIconPath(arg_14_0)
	return "RogueCards/" .. arg_14_0
end

return var_0_0
