class = var_0_10000

local var_0_0 = var_0_10000("IslandBookHelper")

function var_0_0.OnAddNewShip(arg_1_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.GetIsland(var_1_0)
	local var_1_2 = var_1.GetBookAgency(var_1_1)

	var_1.OnAddNewShip(var_1_2, arg_1_0)

	return
end

function var_0_0.OnShipUpgradeOrBreakOut(arg_2_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)
	local var_2_1 = var_1.GetIsland(var_2_0)
	local var_2_2 = var_1.GetBookAgency(var_2_1)

	var_1.OnShipUpgradeOrBreakOut(var_2_2, arg_2_0)

	return
end

function var_0_0.OnNpcInteract(arg_3_0)
	pg = var_1_10001

	if not var_1_10001.island_unit_character[arg_3_0] then
		return
	end

	IslandIllustration = var_1

	local var_3_0 = var_1.TYPES.NPC

	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_3_1 = var_1_10002(var_1_10004)
	local var_3_2 = var_2.GetIsland(var_3_1)
	local var_3_3 = var_2.GetBookAgency(var_3_2)

	if var_2.GetIllustration(var_3_3, var_3_0, arg_3_0) then
		var_3_2 = var_3:GetStatus()
		IslandIllustration = var_3_3

		if var_3_2 ~= var_3_3.STATUS.LOCK then
			return
		end

		pg = var_3_2

		local var_3_4 = var_3_2.m02
		local var_3_5 = var_4.sendNotification

		GAME = var_7

		var_3_5(var_3_4, var_7.ISLAND_UPDATE_ILLUSTRATION, {
			type = var_3_0,
			linkId = arg_3_0
		})

		return
	end
end

function var_0_0.OnFishingEnd(arg_4_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)
	local var_4_1 = var_1.GetIsland(var_4_0)
	local var_4_2 = var_1.GetBookAgency(var_4_1)

	var_1.OnFishingEnd(var_4_2, arg_4_0)

	return
end

return var_0_0
