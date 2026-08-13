class = var_0_10000

local var_0_0 = "IslandMallDelegationPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.View.page.building.IslandRoleDelegationPage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandMallDelegationUI"
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf

	var_1(var_2_0, var_3.Find(var_2_1, "handbookBtn"), function()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.OpenPage

		IslandSetMealHandbookPage = var_2_10002

		var_3_1(var_3_0, var_2_10002)

		return
	end)

	getProxy = var_1
	IslandProxy = var_2_0

	local var_2_2 = var_1(var_2_0)
	local var_2_3 = var_1.GetIsland(var_2_2)
	local var_2_4 = var_1.GetAblityAgency(var_2_3)

	setActive = var_2_3

	local var_2_5 = arg_2_0._tf

	var_2_3(var_3.Find(var_2_5, "handbookBtn"), var_2_4:HasAbility(29001))

	return
end

return var_0_1
