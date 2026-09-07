local IslandCheaterTavernMenuPage = class("IslandCheaterTavernMenuPage", import("...base.IslandBasePage"))

function IslandCheaterTavernMenuPage:getUIName()
	return "IslandCheaterTavernMenuUI"
end

function IslandCheaterTavernMenuPage:OnLoaded()
	return
end

function IslandCheaterTavernMenuPage:AddListeners()
	return
end

function IslandCheaterTavernMenuPage:RemoveListeners()
	return
end

function IslandCheaterTavernMenuPage:OnInit()
	return
end

function IslandCheaterTavernMenuPage:Show()
	IslandCheaterTavernMenuPage.super.Show(self)
	self:Flush()

	return
end

function IslandCheaterTavernMenuPage:Flush()
	return
end

function IslandCheaterTavernMenuPage:OnDestroy()
	IslandCheaterTavernMenuPage.super.OnDestroy(self)

	return
end

function IslandCheaterTavernMenuPage:OnHide()
	return
end

return IslandCheaterTavernMenuPage
