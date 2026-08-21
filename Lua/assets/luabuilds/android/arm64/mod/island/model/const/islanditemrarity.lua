local var_0_0 = class("IslandItemRarity")

var_0_0.GREY = 1
var_0_0.BLUE = 2
var_0_0.PURPLE = 3
var_0_0.ORANGE = 4

function var_0_0.Rarity2FrameName(arg_1_0)
	var_0_0.RARITY2FRAME = var_0_0.RARITY2FRAME or {
		"rarity_grey",
		"rarity_blue",
		"rarity_purple",
		"rarity_orange"
	}

	return var_0_0.RARITY2FRAME[arg_1_0]
end

return var_0_0
