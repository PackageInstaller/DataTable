local var_0_0 = class("IslandBookHelper")

function var_0_0.OnAddNewShip(arg_1_0)
	getProxy(IslandProxy):GetIsland():GetBookAgency():OnAddNewShip(arg_1_0)

	return
end

function var_0_0.OnShipUpgradeOrBreakOut(arg_2_0)
	getProxy(IslandProxy):GetIsland():GetBookAgency():OnShipUpgradeOrBreakOut(arg_2_0)

	return
end

function var_0_0.OnNpcInteract(arg_3_0)
	if not pg.island_unit_character[arg_3_0] then
		return
	end

	local var_3_0 = IslandIllustration.TYPES.NPC
	local var_3_1 = getProxy(IslandProxy):GetIsland():GetBookAgency():GetIllustration(IslandIllustration.TYPES.NPC, arg_3_0)

	if not var_3_1 or var_3_1:GetStatus() ~= IslandIllustration.STATUS.LOCK then
		return
	end

	pg.m02:sendNotification(GAME.ISLAND_UPDATE_ILLUSTRATION, {
		type = var_3_0,
		linkId = arg_3_0
	})

	return
end

function var_0_0.OnFishingEnd(arg_4_0)
	getProxy(IslandProxy):GetIsland():GetBookAgency():OnFishingEnd(arg_4_0)

	return
end

return var_0_0
