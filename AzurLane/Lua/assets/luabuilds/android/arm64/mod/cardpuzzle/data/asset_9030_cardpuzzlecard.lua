class = var_0_10000

local var_0_0 = "CardPuzzleCard"

BaseVO = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003)

var_0_1.CARD_TYPE = {
	ATTACK = 1,
	ABILITY = 3,
	TACTIC = 2
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

	return var_1_10001.card_template
end

function var_0_1.GetIconPath(arg_3_0)
	return var_0_1.GetCardIconPath(arg_3_0:getConfig("icon"))
end

function var_0_1.GetConfigId(arg_4_0)
	return arg_4_0.configId
end

function var_0_1.GetName(arg_5_0)
	return arg_5_0:getConfig("name")
end

function var_0_1.GetCost(arg_6_0)
	return arg_6_0:getConfig("cost")
end

function var_0_1.GetType(arg_7_0)
	return arg_7_0:getConfig("card_type")
end

function var_0_1.GetDesc(arg_8_0)
	return arg_8_0:getConfig("discript")
end

function var_0_1.GetRarity(arg_9_0)
	return arg_9_0:getConfig("rarity")
end

function var_0_1.GetEffects(arg_10_0)
	return {
		{
			keywords = {}
		}
	}
end

function var_0_1.GetKeywords(arg_11_0)
	return var_0_1.GetCardKeyWord(arg_11_0:getConfig("label"))
end

function var_0_1.GetCardKeyWord(arg_12_0)
	_ = var_1_10001

	return var_1_10001.map(arg_12_0, function(arg_13_0)
		pg = var_2_10001

		return var_2_10001.puzzle_card_affix[arg_13_0]
	end)
end

function var_0_1.GetCardIconPath(arg_14_0)
	return "RogueCards/" .. arg_14_0
end

return var_0_1
