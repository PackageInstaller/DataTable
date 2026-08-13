class = var_0_10000

local var_0_0 = "IslandVisitorHudPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.Core.View.IslandBaseHudPanel"))

function var_0_1.GetUIName(arg_1_0)
	return "IslandVisitorHud"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.nameTF = var_1.Find(var_2_0, "name")
	tonumber = var_1
	arg_2_0.playerId = var_1(arg_2_0.param1)

	if not arg_2_0.playerId then
		return
	end

	getProxy = var_1
	IslandProxy = var_2

	local var_2_1 = var_1(var_2)
	local var_2_2 = var_1.GetIsland(var_2_1)

	getProxy = var_2_1
	IslandProxy = var_3

	local var_2_3 = var_2_1(var_3)
	local var_2_4 = var_2.GetSharedIsland(var_2_3)
	local var_2_5 = var_2_2:GetVisitorAgency()
	local var_2_7

	if not var_3.GetPlayer(var_2_5, arg_2_0.playerId) then
		local var_2_6 = var_2_4:GetVisitorAgency()

		var_2_7 = var_3.GetPlayer(var_2_6, arg_2_0.playerId)
	end

	arg_2_0.name = var_2_7:GetName()
	setText = var_4

	var_4(arg_2_0.nameTF, arg_2_0.name)

	return
end

return var_0_1
