local var_0_0 = class("ShipRarity")

var_0_0.Gray = 2
var_0_0.Blue = 3
var_0_0.Purple = 4
var_0_0.Gold = 5
var_0_0.SSR = 6

function var_0_0.Rarity2Print(arg_1_0)
	return ItemRarity.Rarity2Print(arg_1_0 - 1)
end

function var_0_0.SSRGradient(arg_2_0)
	return "<material=outline c=#00000040 x=1 y=1><material=gradient from=#FF0000 to=#00FF00 x=1 y=1>" .. arg_2_0 .. "</material></material>"
end

function shipRarity2bgPrint(arg_3_0, arg_3_1, arg_3_2)
	table.insert({}, var_0_0.Rarity2Print(arg_3_0))

	if arg_3_1 then
		table.insert({}, "0")
	end

	if arg_3_2 then
		table.insert({}, "1")
	end

	return table.concat({}, "_")
end

return var_0_0
