local IslandCheaterTavernBaseView = class("IslandCheaterTavernBaseView", import("view.base.BasePanel"))

function IslandCheaterTavernBaseView:AddListeners()
	return
end

function IslandCheaterTavernBaseView:RemoveListeners()
	return
end

function IslandCheaterTavernBaseView:SetActiveState(arg_3_1)
	setActive(self._tf, arg_3_1)

	return
end

function IslandCheaterTavernBaseView:OnCheaterEveryRoundStart()
	return
end

function IslandCheaterTavernBaseView:OnCheaterEveryRoundStartDone()
	return
end

function IslandCheaterTavernBaseView:IsSelf(arg_6_1)
	return getProxy(PlayerProxy):getRawData().id == arg_6_1
end

function IslandCheaterTavernBaseView:Hide()
	self:OnHide()

	return
end

function IslandCheaterTavernBaseView:Init()
	self.cheaterTavernAgency = self.parent:GetIsland():GetCheaterTavernAgency()

	self:OnInit()

	return
end

function IslandCheaterTavernBaseView:OnHide()
	return
end

function IslandCheaterTavernBaseView:OnInit()
	return
end

return IslandCheaterTavernBaseView
