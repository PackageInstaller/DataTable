local FactorySkinTrialActivityView = class("FactorySkinTrialActivityView", (import("game.views.skinTrialActivity.SkinTrialActivityView")))

function FactorySkinTrialActivityView:UIName()
	if SDKTools.GetIsOverSea() then
		return "UI/MardukUI/skinTrial/MardukSkinTrialMainUI_oversea"
	end

	if self.params_.activityID == ActivityConst.FACTORY_SKIN_TRIAL then
		return "UI/MardukUI/skinTrial/MardukSkinTrialMainUI_1"
	else
		return "UI/MardukUI/skinTrial/MardukSkinTrialMainUI_2"
	end
end

function FactorySkinTrialActivityView:RefreshSkinItem()
	for iter_2_0, iter_2_1 in ipairs(self.skinTrialIDList_) do
		if self.skinItemList_[iter_2_0] then
			self.skinItemList_[iter_2_0]:SetSkinTrialID(iter_2_1)
		else
			local var_2_1 = self:GetItemClass().New

			self.skinItemList_[iter_2_0] = self:GetItemClass().New(self:GetSkinItemObj(iter_2_0), iter_2_1)
		end
	end

	for iter_2_2 = #self.skinItemList_, #self.skinTrialIDList_ + 1, -1 do
		self.skinItemList_[iter_2_2]:Dispose()

		self.skinItemList_[iter_2_2] = nil
	end
end

function FactorySkinTrialActivityView:GetSkinItemObj(arg_3_1)
	if not SDKTools.GetIsOverSea() then
		return self.skinItemPanel_:GetChild(arg_3_1 - 1).gameObject
	else
		return Object.Instantiate(self.skinItem_, self.skinItemPanel_)
	end
end

function FactorySkinTrialActivityView:GetskinTrialIDList()
	local var_4_0 = {}
	local var_4_1 = {}
	local var_4_2 = {}

	if SDKTools.GetIsOverSea() then
		if ActivityData:GetActivityIsOpen(ActivityConst.FACTORY_SKIN_TRIAL_1_OVERSEA) then
			var_4_1[#var_4_1 + 1] = ActivityConst.FACTORY_SKIN_TRIAL_1_OVERSEA
		end

		if ActivityData:GetActivityIsOpen(ActivityConst.FACTORY_SKIN_TRIAL_2_OVERSEA) then
			var_4_1[#var_4_1 + 1] = ActivityConst.FACTORY_SKIN_TRIAL_2_OVERSEA
		end
	else
		var_4_1[#var_4_1 + 1] = self.activityID_
	end

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		table.insertto(var_4_2, ActivityData:GetActivityData(iter_4_1).subActivityIdList)
	end

	for iter_4_2, iter_4_3 in ipairs(var_4_2) do
		for iter_4_4, iter_4_5 in ipairs(ActivitySkinTrialCfg.get_id_list_by_activity_id[iter_4_3]) do
			table.insert(var_4_0, iter_4_5)
		end
	end

	return var_4_0
end

function FactorySkinTrialActivityView:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		return
	end

	for iter_5_0, iter_5_1 in ipairs(self.skinTrialIDList_) do
		if self.skinItemList_[iter_5_0] and self.skinItemList_[iter_5_0].RefreshTime ~= nil then
			self.skinItemList_[iter_5_0]:RefreshTime()
		end
	end

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			return
		end

		for iter_6_0, iter_6_1 in ipairs(self.skinTrialIDList_) do
			if self.skinItemList_[iter_6_0] and self.skinItemList_[iter_6_0].RefreshTime ~= nil then
				self.skinItemList_[iter_6_0]:RefreshTime()
			end
		end
	end, 1, -1)

	self.timer_:Start()
end

function FactorySkinTrialActivityView:GetItemClass()
	return FactorySkinTrialActivityItem
end

return FactorySkinTrialActivityView
