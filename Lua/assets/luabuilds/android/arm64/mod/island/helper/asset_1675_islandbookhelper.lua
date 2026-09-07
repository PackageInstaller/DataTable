local IslandBookHelper = class("IslandBookHelper")

function IslandBookHelper:OnAddNewShip()
	getProxy(IslandProxy):GetIsland():GetBookAgency():OnAddNewShip(self)

	return
end

function IslandBookHelper:OnShipUpgradeOrBreakOut()
	getProxy(IslandProxy):GetIsland():GetBookAgency():OnShipUpgradeOrBreakOut(self)

	return
end

function IslandBookHelper:OnNpcInteract()
	if not pg.island_unit_character[self] then
		return
	end

	local var_3_0 = IslandIllustration.TYPES.NPC
	local var_3_1 = getProxy(IslandProxy):GetIsland():GetBookAgency():GetIllustration(IslandIllustration.TYPES.NPC, self)

	if not var_3_1 or var_3_1:GetStatus() ~= IslandIllustration.STATUS.LOCK then
		return
	end

	pg.m02:sendNotification(GAME.ISLAND_UPDATE_ILLUSTRATION, {
		type = var_3_0,
		linkId = self
	})

	return
end

function IslandBookHelper:OnFishingEnd()
	getProxy(IslandProxy):GetIsland():GetBookAgency():OnFishingEnd(self)

	return
end

return IslandBookHelper
