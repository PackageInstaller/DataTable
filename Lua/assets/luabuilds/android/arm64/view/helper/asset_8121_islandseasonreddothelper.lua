local IslandSeasonRedDotHelper = class("IslandSeasonRedDotHelper")
local var_0_1 = "IslandSeasonRedDotHelper.FirstEnter_11111"
local var_0_2 = "IslandSeasonRedDotHelper.FirstEnterShopPhase_1111111"
local var_0_3 = "IslandSeasonRedDotHelper.FirstEnterReview_1111111"

function IslandSeasonRedDotHelper:TipActivity()
	return self:readyToAchieve() or IslandSeasonRedDotHelper.IsFirstEnterAct(self)
end

function IslandSeasonRedDotHelper:IsFirstEnterAct()
	return PlayerPrefs.GetInt(var_0_1 .. getProxy(PlayerProxy):getRawData().id .. "_" .. self.id, 0) == 0
end

function IslandSeasonRedDotHelper:UpdateActEnterTip()
	PlayerPrefs.SetInt(var_0_1 .. getProxy(PlayerProxy):getRawData().id .. "_" .. self.id, 1)
	PlayerPrefs.Save()

	return
end

function IslandSeasonRedDotHelper.AnyActShouldTip()
	for iter_4_0, iter_4_1 in ipairs((getProxy(ActivityProxy):getIslandPanelActivities())) do
		if IslandSeasonRedDotHelper.TipActivity(iter_4_1) then
			return true
		end
	end

	return false
end

function IslandSeasonRedDotHelper:TipShopShowPhase()
	if self == 1 then
		return IslandSeasonRedDotHelper.IsFirstEnterShopPhase(self)
	else
		return IslandSeasonRedDotHelper.UnlockShopPhase(self) and IslandSeasonRedDotHelper.IsFirstEnterShopPhase(self)
	end

	return
end

function IslandSeasonRedDotHelper:UnlockShopPhase()
	local var_6_0 = getProxy(IslandProxy):GetIsland():GetShopAgency():GetSeasonShops()[getProxy(IslandProxy):GetIsland():GetSeasonAgency():GetSeason():getConfig("shop_id")[self]]

	return var_6_0 and var_6_0:IsInTime()
end

function IslandSeasonRedDotHelper:IsFirstEnterShopPhase()
	return PlayerPrefs.GetInt(var_0_2 .. getProxy(PlayerProxy):getRawData().id .. "_" .. self, 0) == 0
end

function IslandSeasonRedDotHelper:UpdateEnterShopPhase()
	PlayerPrefs.SetInt(var_0_2 .. getProxy(PlayerProxy):getRawData().id .. "_" .. self, 1)
	PlayerPrefs.Save()

	return
end

function IslandSeasonRedDotHelper.AnyShopShouldTip()
	for iter_9_0 = 1, #getProxy(IslandProxy):GetIsland():GetSeasonAgency():GetSeason():getConfig("shop_id") do
		if IslandSeasonRedDotHelper.TipShopShowPhase(iter_9_0) then
			return true
		end
	end

	return false
end

function IslandSeasonRedDotHelper.AnyPtCanGet()
	return getProxy(IslandProxy):GetIsland():GetSeasonAgency():GetSeason():GanGetPtAward()
end

function IslandSeasonRedDotHelper.AnyTaskCanGet()
	local var_11_0 = getProxy(IslandProxy)
	local var_11_1 = var_11_0:GetIsland()
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

function IslandSeasonRedDotHelper.TipRank()
	return false
end

function IslandSeasonRedDotHelper.TipReview()
	return IslandSeasonRedDotHelper.IsFirstEnterReview()
end

function IslandSeasonRedDotHelper.IsFirstEnterReview()
	return PlayerPrefs.GetInt(var_0_3 .. getProxy(PlayerProxy):getRawData().id, 0) == 0
end

function IslandSeasonRedDotHelper.UpdateEnterReview()
	PlayerPrefs.SetInt(var_0_3 .. getProxy(PlayerProxy):getRawData().id, 1)
	PlayerPrefs.Save()

	return
end

function IslandSeasonRedDotHelper:TipTag()
	if self == IslandSeasonPage.PAGE_ACTIVITY then
		return IslandSeasonRedDotHelper.AnyActShouldTip()
	elseif self == IslandSeasonPage.PAGE_PT then
		return IslandSeasonRedDotHelper.AnyPtCanGet()
	elseif self == IslandSeasonPage.PAGE_TASK then
		return IslandSeasonRedDotHelper.AnyTaskCanGet()
	elseif self == IslandSeasonPage.PAGE_SHOP then
		return IslandSeasonRedDotHelper.AnyShopShouldTip()
	elseif self == IslandSeasonPage.PAGE_RANK then
		return IslandSeasonRedDotHelper.TipRank()
	elseif self == IslandSeasonPage.PAGE_REVIEW then
		return IslandSeasonRedDotHelper.TipReview()
	end

	return false
end

function IslandSeasonRedDotHelper.TipSeason()
	return IslandSeasonRedDotHelper.AnyActShouldTip() or IslandSeasonRedDotHelper.AnyShopShouldTip() or IslandSeasonRedDotHelper.AnyPtCanGet() or IslandSeasonRedDotHelper.AnyTaskCanGet() or IslandSeasonRedDotHelper.TipRank() or IslandSeasonRedDotHelper.TipReview()
end

return IslandSeasonRedDotHelper
