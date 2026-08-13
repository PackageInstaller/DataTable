class = var_0_10000

local var_0_0 = "Island"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseIsland"))

var_0_1.EXP_ADD = "Island:EXP_ADD"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1.public_data)

	IslandInventoryAgency = var_2
	arg_1_0.inventoryAgency = var_2.New(arg_1_0, arg_1_1.private_data)
	IslandOrderAgency = var_2
	arg_1_0.orderAgency = var_2.New(arg_1_0, arg_1_1.private_data)
	IslandShopAgency = var_2
	arg_1_0.shopAgency = var_2.New(arg_1_0, arg_1_1.private_data)
	IslandSeasonAgency = var_2
	arg_1_0.seasonAgency = var_2.New(arg_1_0, arg_1_1.private_data)
	IslandDressUpAgency = var_2
	arg_1_0.dressUpAgency = var_2.New(arg_1_0, arg_1_1.private_data)
	IslandAchievementAgency = var_2
	arg_1_0.achievementAgency = var_2.New(arg_1_0, arg_1_1.private_data)
	IslandGlobalBuffAgency = var_2
	arg_1_0.globalBuffAgency = var_2.New(arg_1_0, arg_1_1.private_data)
	IslandActionAgency = var_2
	arg_1_0.actionAgency = var_2.New(arg_1_0, arg_1_1.private_data)
	IslandNpcFeedbackAgency = var_2
	arg_1_0.npcFeedbackAgency = var_2.New(arg_1_0, arg_1_1.private_data)
	IslandFishingAgency = var_2
	arg_1_0.fishingAgency = var_2.New(arg_1_0, arg_1_1.private_data)
	IslandSettingsAgency = var_2
	arg_1_0.settingsAgency = var_2.New(arg_1_0, arg_1_1.private_data)
	IslandBookAgency = var_2
	arg_1_0.bookAgency = var_2.New(arg_1_0, arg_1_1.private_data)
	IslandCardDiyAgency = var_2
	arg_1_0.cardDiyAgency = var_2.New(arg_1_0, arg_1_1.private_data)
	IslandTicketAgency = var_2
	arg_1_0.ticketAgency = var_2.New(arg_1_0, arg_1_1.private_data)

	local var_1_0 = arg_1_0:GetAgoraAgency()

	var_2.InitPrivateData(var_1_0, arg_1_1.private_data)
	arg_1_0:AddDefaultAgoraData()

	local var_1_1 = arg_1_0:GetFollowerAgency()

	var_2.InitPrivateData(var_1_1, arg_1_1.private_data)

	local var_1_2 = arg_1_0:GetInventoryAgency()

	var_2.InitPrivateData(var_1_2, arg_1_1.public_data)

	local var_1_3 = arg_1_0:GetSignInAgency()

	var_2.InitPrivateData(var_1_3, arg_1_1.private_data)

	local var_1_4 = arg_1_0:GetAccessAgency()

	var_2.InitPrivateData(var_1_4, arg_1_1.private_data)

	local var_1_5 = arg_1_0:GetBuildingAgency()

	var_2.InitPrivateData(var_1_5, arg_1_1.private_data)

	local var_1_6 = arg_1_0:GetWildCollectAgency()

	var_2.InitPrivateData(var_1_6, arg_1_1.private_data)

	return
end

function var_0_1.IsPrivate(arg_2_0)
	return true
end

function var_0_1.AddExp(arg_3_0, arg_3_1)
	var_0_1.super.AddExp(arg_3_0, arg_3_1)
	arg_3_0:DispatchEvent(var_0_1.EXP_ADD)

	return
end

function var_0_1.AddDefaultAgoraData(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.island_set.initial_furniture.key_value_varchar
	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0.GetAgoraAgency(var_4_1)

	ipairs = var_4_1

	for iter_4_0, iter_4_1 in var_4_1(var_4_0) do
		local var_4_3 = var_4_2
		local var_4_4 = var_4_2.RawAddFurniture

		IslandFurniture = var_1_10010

		var_4_4(var_4_3, var_1_10010.New({
			id = iter_4_1[1],
			count = iter_4_1[2]
		}))
	end

	return
end

function var_0_1.GetInventoryAgency(arg_5_0)
	return arg_5_0.inventoryAgency
end

function var_0_1.GetFishingAgency(arg_6_0)
	return arg_6_0.fishingAgency
end

function var_0_1.GetOrderAgency(arg_7_0)
	return arg_7_0.orderAgency
end

function var_0_1.GetActionAgency(arg_8_0)
	return arg_8_0.actionAgency
end

function var_0_1.GetNpcFeedbackAgency(arg_9_0)
	return arg_9_0.npcFeedbackAgency
end

function var_0_1.GetShopAgency(arg_10_0)
	return arg_10_0.shopAgency
end

function var_0_1.GetSeasonAgency(arg_11_0)
	return arg_11_0.seasonAgency
end

function var_0_1.GetDressUpAgency(arg_12_0)
	return arg_12_0.dressUpAgency
end

function var_0_1.GetAchievementAgency(arg_13_0)
	return arg_13_0.achievementAgency
end

function var_0_1.GetGlobalBuffAgency(arg_14_0)
	return arg_14_0.globalBuffAgency
end

function var_0_1.GetSettingsAgency(arg_15_0)
	return arg_15_0.settingsAgency
end

function var_0_1.GetBookAgency(arg_16_0)
	return arg_16_0.bookAgency
end

function var_0_1.GetCardDiyAgency(arg_17_0)
	return arg_17_0.cardDiyAgency
end

function var_0_1.GetTicketAgency(arg_18_0)
	return arg_18_0.ticketAgency
end

function var_0_1.GetSystemTipInfos(arg_19_0)
	local var_19_0 = arg_19_0:GetAblityAgency()

	if not var_1.IsUnlockPostManage(var_19_0) then
		return {
			awardCnt = 0,
			emptyCnt = 0,
			postFlag = 0,
			timestamps = {}
		}
	else
		local var_19_1 = arg_19_0:GetBuildingAgency()
		local var_19_2 = var_2.GetTipInfos(var_19_1)
		local var_19_3 = arg_19_0:GetManageAgency()
		local var_19_4 = var_3.GetTipInfos(var_19_3)
		local var_19_5 = {
			postFlag = 1,
			awardCnt = var_19_2.awardCnt + var_19_4.awardCnt,
			emptyCnt = var_19_2.emptyCnt + var_19_4.emptyCnt
		}

		table = var_5
		var_19_5.timestamps = var_5.mergeArray(var_19_2.timestamps, var_19_4.timestamps)

		return var_19_5
	end

	return
end

function var_0_1.UpdatePerDay(arg_20_0)
	var_0_1.super.UpdatePerDay(arg_20_0)

	local var_20_0 = arg_20_0:GetOrderAgency()

	var_1.UpdatePerDay(var_20_0)

	local var_20_1 = arg_20_0:GetTaskAgency()

	var_1.UpdatePerDay(var_20_1)

	local var_20_2 = arg_20_0:GetNpcFeedbackAgency()

	var_1.UpdatePerDay(var_20_2)

	local var_20_3 = arg_20_0:GetSignInAgency()

	var_1.UpdatePerDay(var_20_3)

	return
end

function var_0_1.UpdatePerSecond(arg_21_0)
	var_0_1.super.UpdatePerSecond(arg_21_0)

	local var_21_0 = arg_21_0:GetTaskAgency()

	var_1.UpdatePerSecond(var_21_0)

	return
end

return var_0_1
