class = var_0_10000

local var_0_0 = var_0_10000("EquipmentRarity")

var_0_0.Gray = 2
var_0_0.Blue = 3
var_0_0.Purple = 4
var_0_0.Gold = 5
var_0_0.SSR = 6

function var_0_0.Rarity2Print(arg_1_0)
	ItemRarity = var_1_10001

	return var_1_10001.Rarity2Print(arg_1_0 - 1)
end

var_0_0.correctedLevel = {
	{
		0
	},
	{
		0
	},
	{
		0,
		7
	},
	{
		0,
		11
	},
	{
		0,
		11,
		12,
		13
	},
	{
		0,
		11,
		12,
		13
	}
}

function var_0_0.Rarity2CorrectedLevel(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.correctedLevel[arg_2_0]
	local var_2_1

	ipairs = var_1_10004

	for iter_2_0, iter_2_1 in var_1_10004(var_2_0) do
		if iter_2_1 > arg_2_1 - 1 then
			break
		else
			var_2_1 = iter_2_0 - 1
		end
	end

	i18n = var_4

	return var_4("equip_info_extralevel_" .. var_2_1)
end

return var_0_0
