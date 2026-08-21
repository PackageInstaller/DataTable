local var_0_0 = class("EquipmentRarity")

var_0_0.Gray = 2
var_0_0.Blue = 3
var_0_0.Purple = 4
var_0_0.Gold = 5
var_0_0.SSR = 6

function var_0_0.Rarity2Print(arg_1_0)
	return ItemRarity.Rarity2Print(arg_1_0 - 1)
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
	local var_2_0

	for iter_2_0, iter_2_1 in ipairs(var_0_0.correctedLevel[arg_2_0]) do
		if iter_2_1 > arg_2_1 - 1 then
			break
		else
			var_2_0 = iter_2_0 - 1
		end
	end

	return i18n("equip_info_extralevel_" .. var_2_0)
end

return var_0_0
