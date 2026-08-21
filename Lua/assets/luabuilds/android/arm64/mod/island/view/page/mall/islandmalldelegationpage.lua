local var_0_0 = class("IslandMallDelegationPage", import("Mod.Island.View.page.building.IslandRoleDelegationPage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandMallDelegationUI"
end

function var_0_0.OnInit(arg_2_0)
	var_0_0.super.OnInit(arg_2_0)
	onButton(arg_2_0, arg_2_0._tf:Find("handbookBtn"), function()
		arg_2_0:OpenPage(IslandSetMealHandbookPage)

		return
	end)
	setActive(arg_2_0._tf:Find("handbookBtn"), getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(29001))

	return
end

return var_0_0
