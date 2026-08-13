class = var_0_10000

local var_0_0 = var_0_10000("IslandItemRarity")

var_0_0.GREY = 1
var_0_0.BLUE = 2
var_0_0.PURPLE = 3
var_0_0.ORANGE = 4

function var_0_0.Rarity2FrameName(arg_1_0)
	if not var_0_0.RARITY2FRAME then
		var_0_0.RARITY2FRAME = {
			"rarity_grey",
			"rarity_blue",
			"rarity_purple",
			"rarity_orange"
		}
	end

	return var_0_0.RARITY2FRAME[arg_1_0]
end

return var_0_0
