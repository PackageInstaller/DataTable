local var_0_0 = class("IslandSeasonRedDotHelper")
local var_0_1 = "IslandSeasonRedDotHelper.FirstEnter_11111"
local var_0_2 = "IslandSeasonRedDotHelper.FirstEnterShopPhase_1111111"
local var_0_3 = "IslandSeasonRedDotHelper.FirstEnterReview_1111111"

function var_0_0.TipActivity(arg_1_0)
	return arg_1_0:readyToAchieve() or var_0_0.IsFirstEnterAct(arg_1_0)
end

function var_0_0.IsFirstEnterAct(arg_2_0)
	local var_2_0 = getProxy(PlayerProxy)

	return PlayerPrefs.GetInt(var_0_1 .. var_2_0:getRawData().id .. "_" .. arg_2_0.id, 0) == 0
end

function var_0_0.UpdateActEnterTip(arg_3_0)
	PlayerPrefs.SetInt(var_0_1 .. getProxy(PlayerProxy):getRawData().id .. "_" .. arg_3_0.id, 1)
	PlayerPrefs.Save()

	return
end

function var_0_0.AnyActShouldTip()
	for iter_4_0, iter_4_1 in ipairs((getProxy(ActivityProxy):getIslandPanelActivities())) do
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
		return var_0_0.UnlockShopPhase(arg_5_0) and var_0_0.IsFirstEnterShopPhase(arg_5_0)
	end

	return
end

function var_0_0.UnlockShopPhase(arg_6_0)
	local var_6_0 = getProxy(IslandProxy):GetIsland():GetShopAgency():GetSeasonShops()[getProxy(IslandProxy):GetIsland():GetSeasonAgency():GetSeason():getConfig("shop_id")[arg_6_0]]

	return var_6_0 and var_6_0:IsInTime()
end

function var_0_0.IsFirstEnterShopPhase(arg_7_0)
	local var_7_0 = getProxy(PlayerProxy)

	return PlayerPrefs.GetInt(var_0_2 .. var_7_0:getRawData().id .. "_" .. arg_7_0, 0) == 0
end

function var_0_0.UpdateEnterShopPhase(arg_8_0)
	PlayerPrefs.SetInt(var_0_2 .. getProxy(PlayerProxy):getRawData().id .. "_" .. arg_8_0, 1)
	PlayerPrefs.Save()

	return
end

function var_0_0.AnyShopShouldTip()
	for iter_9_0 = 1, #getProxy(IslandProxy):GetIsland():GetSeasonAgency():GetSeason():getConfig("shop_id") do
		if var_0_0.TipShopShowPhase(iter_9_0) then
			return true
		end
	end

	return false
end

function var_0_0.AnyPtCanGet()
	return getProxy(IslandProxy):GetIsland():GetSeasonAgency():GetSeason():GanGetPtAward()
end

function var_0_0.AnyTaskCanGet()
	local var_11_9000
	local var_11_0 = getProxy(IslandProxy)
	local var_11_1 = var_11_0.GetIsland(var_11_9000)
	local var_11_2 = var_11_1:GetTaskAgency()
	local var_11_3 = var_11_1:GetSeasonAgency().GetSeason(var_11_0):GetTaskIds()

	for iter_11_0 = 1, #var_11_3 do
		local var_11_4 = var_11_2:GetTask(var_11_3[iter_11_0])

		if var_11_4 and var_11_4:IsSubmitOnUI() and var_11_4:IsFinish() then
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
	local var_14_0 = getProxy(PlayerProxy)

	return PlayerPrefs.GetInt(var_0_3 .. var_14_0:getRawData().id, 0) == 0
end

function var_0_0.UpdateEnterReview()
	PlayerPrefs.SetInt(var_0_3 .. getProxy(PlayerProxy):getRawData().id, 1)
	PlayerPrefs.Save()

	return
end

function var_0_0.TipTag(arg_16_0)
	if arg_16_0 == IslandSeasonPage.PAGE_ACTIVITY then
		return var_0_0.AnyActShouldTip()
	elseif arg_16_0 == IslandSeasonPage.PAGE_PT then
		return var_0_0.AnyPtCanGet()
	elseif arg_16_0 == IslandSeasonPage.PAGE_TASK then
		return var_0_0.AnyTaskCanGet()
	elseif arg_16_0 == IslandSeasonPage.PAGE_SHOP then
		return var_0_0.AnyShopShouldTip()
	elseif arg_16_0 == IslandSeasonPage.PAGE_RANK then
		return var_0_0.TipRank()
	elseif arg_16_0 == IslandSeasonPage.PAGE_REVIEW then
		return var_0_0.TipReview()
	end

	return false
end

function var_0_0.TipSeason()
	return var_0_0.AnyActShouldTip() or var_0_0.AnyShopShouldTip() or var_0_0.AnyPtCanGet() or var_0_0.AnyTaskCanGet() or var_0_0.TipRank() or var_0_0.TipReview()
end

return var_0_0
