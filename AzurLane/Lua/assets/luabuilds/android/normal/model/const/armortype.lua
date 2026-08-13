class = var_0_10000

local var_0_0 = var_0_10000("ArmorType")

var_0_0.Light = 1
var_0_0.Medium = 2
var_0_0.Heavy = 3

function var_0_0.Type2Name(arg_1_0)
	if not var_0_0.names then
		local var_1_0 = var_0_0
		local var_1_1 = {}

		i18n = var_1_10003
		var_1_1[1] = var_1_10003("word_lightArmor")
		i18n = var_3
		var_1_1[2] = var_3("word_mediumArmor")
		i18n = var_3
		var_1_1[3] = var_3("word_heavyarmor")
		var_1_0.names = var_1_1
	end

	return var_0_0.names[arg_1_0]
end

return var_0_0
