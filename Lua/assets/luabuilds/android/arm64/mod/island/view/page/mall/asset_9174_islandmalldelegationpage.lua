local IslandMallDelegationPage = class("IslandMallDelegationPage", import("Mod.Island.View.page.building.IslandRoleDelegationPage"))

function IslandMallDelegationPage:getUIName()
	return "IslandMallDelegationUI"
end

function IslandMallDelegationPage:OnInit()
	IslandMallDelegationPage.super.OnInit(self)
	onButton(self, self._tf:Find("handbookBtn"), function()
		self:OpenPage(IslandSetMealHandbookPage)

		return
	end)
	setActive(self._tf:Find("handbookBtn"), getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(29001))

	return
end

return IslandMallDelegationPage
