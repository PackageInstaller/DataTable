class = var_0_10000

local var_0_0 = var_0_10000("IslandSeasonRedDotHelper")
local var_0_1 = "IslandSeasonRedDotHelper.FirstEnter_11111"
local var_0_2 = "IslandSeasonRedDotHelper.FirstEnterShopPhase_1111111"
local var_0_3 = "IslandSeasonRedDotHelper.FirstEnterReview_1111111"

function var_0_0.TipActivity(arg_1_0)
	local var_1_0

	if not arg_1_0:readyToAchieve() then
		var_1_0 = var_0_0.IsFirstEnterAct(arg_1_0)
	end

	return var_1_0
end

function var_0_0.IsFirstEnterAct(arg_2_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)
	local var_2_1 = var_1.getRawData(var_2_0).id

	PlayerPrefs = var_1_10002

	return var_1_10002.GetInt(var_0_1 .. var_2_1 .. "_" .. arg_2_0.id, 0) == 0
end

function var_0_0.UpdateActEnterTip(arg_3_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)
	local var_3_1 = var_1.getRawData(var_3_0).id

	PlayerPrefs = var_1_10002

	var_1_10002.SetInt(var_0_1 .. var_3_1 .. "_" .. arg_3_0.id, 1)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_0.AnyActShouldTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_4_0 = var_1_10000(var_1_10002)
	local var_4_1 = var_0.getIslandPanelActivities(var_4_0)

	ipairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(var_4_1) do
		if var_0_0.TipActivity(iter_4_1) then
			return true
		end
	end

	return false
end

function var_0_0.TipShopShowPhase(arg_5_0)
	if arg_5_0 == 1 then
		return var_0_0.IsFirstEnterShopPhase(arg_5_0)
	else
		local var_5_0

		if var_0_0.UnlockShopPhase(arg_5_0) then
			var_5_0 = var_0_0.IsFirstEnterShopPhase(arg_5_0)
		end

		return var_5_0
	end

	return
end

function var_0_0.UnlockShopPhase(arg_6_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.GetIsland(var_6_0)
	local var_6_2 = var_1.GetSeasonAgency(var_6_1)
	local var_6_3 = var_1.GetSeason(var_6_2)
	local var_6_4 = var_1.getConfig(var_6_3, "shop_id")[arg_6_0]

	getProxy = var_6_3
	IslandProxy = var_1_10006

	local var_6_5 = var_6_3(var_1_10006)
	local var_6_6 = var_4.GetIsland(var_6_5)
	local var_6_7 = var_4.GetShopAgency(var_6_6)

	return var_4.GetSeasonShops(var_6_7)[var_6_4] and var_4:IsInTime()
end

function var_0_0.IsFirstEnterShopPhase(arg_7_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_7_0 = var_1_10001(var_1_10003)
	local var_7_1 = var_1.getRawData(var_7_0).id

	PlayerPrefs = var_1_10002

	return var_1_10002.GetInt(var_0_2 .. var_7_1 .. "_" .. arg_7_0, 0) == 0
end

function var_0_0.UpdateEnterShopPhase(arg_8_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_8_0 = var_1_10001(var_1_10003)
	local var_8_1 = var_1.getRawData(var_8_0).id

	PlayerPrefs = var_1_10002

	var_1_10002.SetInt(var_0_2 .. var_8_1 .. "_" .. arg_8_0, 1)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_0.AnyShopShouldTip()
	getProxy = var_1_10000
	IslandProxy = var_1_10002

	local var_9_0 = var_1_10000(var_1_10002)
	local var_9_1 = var_0.GetIsland(var_9_0)
	local var_9_2 = var_0.GetSeasonAgency(var_9_1)
	local var_9_3 = var_0.GetSeason(var_9_2)
	local var_9_4 = var_0.getConfig(var_9_3, "shop_id")

	for iter_9_0 = 1, #var_9_4 do
		if var_0_0.TipShopShowPhase(iter_9_0) then
			return true
		end
	end

	return false
end

function var_0_0.AnyPtCanGet()
	getProxy = var_1_10000
	IslandProxy = var_1_10002

	local var_10_0 = var_1_10000(var_1_10002)
	local var_10_1 = var_0.GetIsland(var_10_0)
	local var_10_2 = var_0.GetSeasonAgency(var_10_1)
	local var_10_3 = var_0.GetSeason(var_10_2)

	return var_0.GanGetPtAward(var_10_3)
end

function var_0_0.AnyTaskCanGet()
	getProxy = var_1_10000
	IslandProxy = var_1_10002

	local var_11_0 = var_1_10000(var_1_10002)
	local var_11_1 = var_0.GetIsland(var_11_0)
	local var_11_2 = var_0.GetTaskAgency(var_11_1)
	local var_11_3 = var_0:GetSeasonAgency()
	local var_11_4 = var_2.GetSeason(var_11_3)
	local var_11_5 = var_2.GetTaskIds(var_11_4)

	for iter_11_0 = 1, #var_11_5 do
		if var_11_2:GetTask(var_11_5[iter_11_0]) and var_7:IsSubmitOnUI() and var_7:IsFinish() then
			return true
		end
	end

	return false
end

function var_0_0.TipRank()
	return false
end

function var_0_0.TipReview()
	return var_0_0.IsFirstEnterReview()
end

function var_0_0.IsFirstEnterReview()
	getProxy = var_1_10000
	PlayerProxy = var_1_10002

	local var_14_0 = var_1_10000(var_1_10002)
	local var_14_1 = var_0.getRawData(var_14_0).id

	PlayerPrefs = var_1_10001

	return var_1_10001.GetInt(var_0_3 .. var_14_1, 0) == 0
end

function var_0_0.UpdateEnterReview()
	getProxy = var_1_10000
	PlayerProxy = var_1_10002

	local var_15_0 = var_1_10000(var_1_10002)
	local var_15_1 = var_0.getRawData(var_15_0).id

	PlayerPrefs = var_1_10001

	var_1_10001.SetInt(var_0_3 .. var_15_1, 1)

	PlayerPrefs = var_1

	var_1.Save()

	return
end

function var_0_0.TipTag(arg_16_0)
	IslandSeasonPage = var_1_10001

	if arg_16_0 == var_1_10001.PAGE_ACTIVITY then
		return var_0_0.AnyActShouldTip()
	else
		IslandSeasonPage = var_1

		if arg_16_0 == var_1.PAGE_PT then
			return var_0_0.AnyPtCanGet()
		else
			IslandSeasonPage = var_1

			if arg_16_0 == var_1.PAGE_TASK then
				return var_0_0.AnyTaskCanGet()
			else
				IslandSeasonPage = var_1

				if arg_16_0 == var_1.PAGE_SHOP then
					return var_0_0.AnyShopShouldTip()
				else
					IslandSeasonPage = var_1

					if arg_16_0 == var_1.PAGE_RANK then
						return var_0_0.TipRank()
					else
						IslandSeasonPage = var_1

						if arg_16_0 == var_1.PAGE_REVIEW then
							return var_0_0.TipReview()
						end
					end
				end
			end
		end
	end

	return false
end

function var_0_0.TipSeason()
	local var_17_0

	if not var_0_0.AnyActShouldTip() and not var_0_0.AnyShopShouldTip() and not var_0_0.AnyPtCanGet() and not var_0_0.AnyTaskCanGet() and not var_0_0.TipRank() then
		var_17_0 = var_0_0.TipReview()
	end

	return var_17_0
end

return var_0_0
