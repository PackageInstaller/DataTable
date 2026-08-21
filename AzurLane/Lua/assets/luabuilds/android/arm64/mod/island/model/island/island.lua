local var_0_0 = class("Island", import(".BaseIsland"))

var_0_0.EXP_ADD = "Island:EXP_ADD"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1.public_data)

	arg_1_0.inventoryAgency = IslandInventoryAgency.New(arg_1_0, arg_1_1.private_data)
	arg_1_0.orderAgency = IslandOrderAgency.New(arg_1_0, arg_1_1.private_data)
	arg_1_0.shopAgency = IslandShopAgency.New(arg_1_0, arg_1_1.private_data)
	arg_1_0.seasonAgency = IslandSeasonAgency.New(arg_1_0, arg_1_1.private_data)
	arg_1_0.dressUpAgency = IslandDressUpAgency.New(arg_1_0, arg_1_1.private_data)
	arg_1_0.achievementAgency = IslandAchievementAgency.New(arg_1_0, arg_1_1.private_data)
	arg_1_0.globalBuffAgency = IslandGlobalBuffAgency.New(arg_1_0, arg_1_1.private_data)
	arg_1_0.actionAgency = IslandActionAgency.New(arg_1_0, arg_1_1.private_data)
	arg_1_0.npcFeedbackAgency = IslandNpcFeedbackAgency.New(arg_1_0, arg_1_1.private_data)
	arg_1_0.fishingAgency = IslandFishingAgency.New(arg_1_0, arg_1_1.private_data)
	arg_1_0.settingsAgency = IslandSettingsAgency.New(arg_1_0, arg_1_1.private_data)
	arg_1_0.bookAgency = IslandBookAgency.New(arg_1_0, arg_1_1.private_data)
	arg_1_0.cardDiyAgency = IslandCardDiyAgency.New(arg_1_0, arg_1_1.private_data)
	arg_1_0.ticketAgency = IslandTicketAgency.New(arg_1_0, arg_1_1.private_data)

	arg_1_0:GetAgoraAgency():InitPrivateData(arg_1_1.private_data)
	arg_1_0:AddDefaultAgoraData()
	arg_1_0:GetFollowerAgency():InitPrivateData(arg_1_1.private_data)
	arg_1_0:GetInventoryAgency():InitPrivateData(arg_1_1.public_data)
	arg_1_0:GetSignInAgency():InitPrivateData(arg_1_1.private_data)
	arg_1_0:GetAccessAgency():InitPrivateData(arg_1_1.private_data)
	arg_1_0:GetBuildingAgency():InitPrivateData(arg_1_1.private_data)
	arg_1_0:GetWildCollectAgency():InitPrivateData(arg_1_1.private_data)

	return
end

function var_0_0.IsPrivate(arg_2_0)
	return true
end

function var_0_0.AddExp(arg_3_0, arg_3_1)
	var_0_0.super.AddExp(arg_3_0, arg_3_1)
	arg_3_0:DispatchEvent(var_0_0.EXP_ADD)

	return
end

function var_0_0.AddDefaultAgoraData(arg_4_0)
	local var_4_0 = arg_4_0:GetAgoraAgency()

	for iter_4_0, iter_4_1 in ipairs(pg.island_set.initial_furniture.key_value_varchar) do
		var_4_0:RawAddFurniture(IslandFurniture.New({
			id = iter_4_1[1],
			count = iter_4_1[2]
		}))
	end

	return
end

function var_0_0.GetInventoryAgency(arg_5_0)
	return arg_5_0.inventoryAgency
end

function var_0_0.GetFishingAgency(arg_6_0)
	return arg_6_0.fishingAgency
end

function var_0_0.GetOrderAgency(arg_7_0)
	return arg_7_0.orderAgency
end

function var_0_0.GetActionAgency(arg_8_0)
	return arg_8_0.actionAgency
end

function var_0_0.GetNpcFeedbackAgency(arg_9_0)
	return arg_9_0.npcFeedbackAgency
end

function var_0_0.GetShopAgency(arg_10_0)
	return arg_10_0.shopAgency
end

function var_0_0.GetSeasonAgency(arg_11_0)
	return arg_11_0.seasonAgency
end

function var_0_0.GetDressUpAgency(arg_12_0)
	return arg_12_0.dressUpAgency
end

function var_0_0.GetAchievementAgency(arg_13_0)
	return arg_13_0.achievementAgency
end

function var_0_0.GetGlobalBuffAgency(arg_14_0)
	return arg_14_0.globalBuffAgency
end

function var_0_0.GetSettingsAgency(arg_15_0)
	return arg_15_0.settingsAgency
end

function var_0_0.GetBookAgency(arg_16_0)
	return arg_16_0.bookAgency
end

function var_0_0.GetCardDiyAgency(arg_17_0)
	return arg_17_0.cardDiyAgency
end

function var_0_0.GetTicketAgency(arg_18_0)
	return arg_18_0.ticketAgency
end

function var_0_0.GetSystemTipInfos(arg_19_0)
	if not arg_19_0:GetAblityAgency():IsUnlockPostManage() then
		return {
			awardCnt = 0,
			emptyCnt = 0,
			postFlag = 0,
			timestamps = {}
		}
	else
		local var_19_0 = arg_19_0:GetBuildingAgency():GetTipInfos()
		local var_19_1 = arg_19_0:GetManageAgency():GetTipInfos()

		return {
			postFlag = 1,
			awardCnt = var_19_0.awardCnt + var_19_1.awardCnt,
			emptyCnt = var_19_0.emptyCnt + var_19_1.emptyCnt,
			timestamps = table.mergeArray(var_19_0.timestamps, var_19_1.timestamps)
		}
	end

	return
end

function var_0_0.UpdatePerDay(arg_20_0)
	var_0_0.super.UpdatePerDay(arg_20_0)
	arg_20_0:GetOrderAgency():UpdatePerDay()
	arg_20_0:GetTaskAgency():UpdatePerDay()
	arg_20_0:GetNpcFeedbackAgency():UpdatePerDay()
	arg_20_0:GetSignInAgency():UpdatePerDay()

	return
end

function var_0_0.UpdatePerSecond(arg_21_0)
	var_0_0.super.UpdatePerSecond(arg_21_0)
	arg_21_0:GetTaskAgency():UpdatePerSecond()

	return
end

return var_0_0
