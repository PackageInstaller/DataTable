local var_0_0 = import("game.views.skinTrialActivity.SkinTrialActivityView")
local var_0_1 = class("FactorySkinTrialActivityView", var_0_0)

function var_0_1.UIName(arg_1_0)
	if SDKTools.GetIsOverSea() then
		return "UI/MardukUI/skinTrial/MardukSkinTrialMainUI_oversea"
	end

	if arg_1_0.params_.activityID == ActivityConst.FACTORY_SKIN_TRIAL then
		return "UI/MardukUI/skinTrial/MardukSkinTrialMainUI_1"
	else
		return "UI/MardukUI/skinTrial/MardukSkinTrialMainUI_2"
	end
end

function var_0_1.RefreshSkinItem(arg_2_0)
	local var_2_0

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.skinTrialIDList_) do
		if arg_2_0.skinItemList_[iter_2_0] then
			arg_2_0.skinItemList_[iter_2_0]:SetSkinTrialID(iter_2_1)
		else
			local var_2_1 = arg_2_0:GetSkinItemObj(iter_2_0)

			arg_2_0.skinItemList_[iter_2_0] = arg_2_0:GetItemClass().New(var_2_1, iter_2_1)
		end
	end

	for iter_2_2 = #arg_2_0.skinItemList_, #arg_2_0.skinTrialIDList_ + 1, -1 do
		arg_2_0.skinItemList_[iter_2_2]:Dispose()

		arg_2_0.skinItemList_[iter_2_2] = nil
	end
end

function var_0_1.GetSkinItemObj(arg_3_0, arg_3_1)
	if not SDKTools.GetIsOverSea() then
		return arg_3_0.skinItemPanel_:GetChild(arg_3_1 - 1).gameObject
	else
		return Object.Instantiate(arg_3_0.skinItem_, arg_3_0.skinItemPanel_)
	end
end

function var_0_1.GetskinTrialIDList(arg_4_0)
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
		var_4_1[#var_4_1 + 1] = arg_4_0.activityID_
	end

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		table.insertto(var_4_2, ActivityData:GetActivityData(iter_4_1).subActivityIdList)
	end

	for iter_4_2, iter_4_3 in ipairs(var_4_2) do
		local var_4_3 = ActivitySkinTrialCfg.get_id_list_by_activity_id[iter_4_3]

		for iter_4_4, iter_4_5 in ipairs(var_4_3) do
			table.insert(var_4_0, iter_4_5)
		end
	end

	return var_4_0
end

function var_0_1.AddTimer(arg_5_0)
	if manager.time:GetServerTime() >= arg_5_0.stopTime_ then
		return
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.skinTrialIDList_) do
		if arg_5_0.skinItemList_[iter_5_0] and arg_5_0.skinItemList_[iter_5_0].RefreshTime ~= nil then
			arg_5_0.skinItemList_[iter_5_0]:RefreshTime()
		end
	end

	arg_5_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_5_0.stopTime_ then
			arg_5_0:StopTimer()

			return
		end

		for iter_6_0, iter_6_1 in ipairs(arg_5_0.skinTrialIDList_) do
			if arg_5_0.skinItemList_[iter_6_0] and arg_5_0.skinItemList_[iter_6_0].RefreshTime ~= nil then
				arg_5_0.skinItemList_[iter_6_0]:RefreshTime()
			end
		end
	end, 1, -1)

	arg_5_0.timer_:Start()
end

function var_0_1.GetItemClass(arg_7_0)
	return FactorySkinTrialActivityItem
end

return var_0_1
