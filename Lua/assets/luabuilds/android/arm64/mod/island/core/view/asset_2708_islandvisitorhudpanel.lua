local IslandVisitorHudPanel = class("IslandVisitorHudPanel", import("Mod.Island.Core.View.IslandBaseHudPanel"))

function IslandVisitorHudPanel:GetUIName()
	return "IslandVisitorHud"
end

function IslandVisitorHudPanel:OnInit()
	self.nameTF = self._tf:Find("name")
	self.playerId = tonumber(self.param1)

	if not self.playerId then
		return
	end

	local var_2_0 = getProxy(IslandProxy):GetIsland():GetVisitorAgency():GetPlayer(self.playerId)

	var_2_0 = var_2_0 or getProxy(IslandProxy):GetSharedIsland():GetVisitorAgency():GetPlayer(self.playerId)
	self.name = var_2_0:GetName()

	setText(self.nameTF, self.name)

	return
end

return IslandVisitorHudPanel
