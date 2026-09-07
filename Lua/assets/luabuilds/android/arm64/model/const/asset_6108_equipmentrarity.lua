local EquipmentRarity = class("EquipmentRarity")

EquipmentRarity.Gray = 2
EquipmentRarity.Blue = 3
EquipmentRarity.Purple = 4
EquipmentRarity.Gold = 5
EquipmentRarity.SSR = 6

function EquipmentRarity:Rarity2Print()
	return ItemRarity.Rarity2Print(self - 1)
end

EquipmentRarity.correctedLevel = {
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

function EquipmentRarity:Rarity2CorrectedLevel(arg_2_1)
	local var_2_0

	for iter_2_0, iter_2_1 in ipairs(EquipmentRarity.correctedLevel[self]) do
		if iter_2_1 > arg_2_1 - 1 then
			break
		else
			var_2_0 = iter_2_0 - 1
		end
	end

	return i18n("equip_info_extralevel_" .. var_2_0)
end

return EquipmentRarity
