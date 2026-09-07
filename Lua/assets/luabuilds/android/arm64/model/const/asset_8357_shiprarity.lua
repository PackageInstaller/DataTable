local ShipRarity = class("ShipRarity")

ShipRarity.Gray = 2
ShipRarity.Blue = 3
ShipRarity.Purple = 4
ShipRarity.Gold = 5
ShipRarity.SSR = 6

function ShipRarity:Rarity2Print()
	return ItemRarity.Rarity2Print(self - 1)
end

function ShipRarity:SSRGradient()
	return "<material=outline c=#00000040 x=1 y=1><material=gradient from=#FF0000 to=#00FF00 x=1 y=1>" .. self .. "</material></material>"
end

function shipRarity2bgPrint(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {}

	table.insert(var_3_0, ShipRarity.Rarity2Print(arg_3_0))

	if arg_3_1 then
		table.insert(var_3_0, "0")
	end

	if arg_3_2 then
		table.insert(var_3_0, "1")
	end

	return table.concat(var_3_0, "_")
end

return ShipRarity
