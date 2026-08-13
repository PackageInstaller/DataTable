class = var_0_10000

local var_0_0 = var_0_10000("ShipRarity")

var_0_0.Gray = 2
var_0_0.Blue = 3
var_0_0.Purple = 4
var_0_0.Gold = 5
var_0_0.SSR = 6

function var_0_0.Rarity2Print(arg_1_0)
	ItemRarity = var_1_10001

	return var_1_10001.Rarity2Print(arg_1_0 - 1)
end

function var_0_0.SSRGradient(arg_2_0)
	return "<material=outline c=#00000040 x=1 y=1><material=gradient from=#FF0000 to=#00FF00 x=1 y=1>" .. arg_2_0 .. "</material></material>"
end

local function var_0_1(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {}

	table = var_1_10004

	var_1_10004.insert(var_3_0, var_0_0.Rarity2Print(arg_3_0))

	if arg_3_1 then
		table = var_4

		var_4.insert(var_3_0, "0")
	end

	if arg_3_2 then
		table = var_4

		var_4.insert(var_3_0, "1")
	end

	table = var_4

	return var_4.concat(var_3_0, "_")
end

local var_0_2 = shipRarity2bgPrint

return var_0_0
