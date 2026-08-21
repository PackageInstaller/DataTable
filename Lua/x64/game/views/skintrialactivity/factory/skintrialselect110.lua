local var_0_0 = class("SkinTrialSelect110", SkinTrialActivitySelectView)

function var_0_0.UIName(arg_1_0)
	return "UI/MardukUI/skinTrial/MardukSkinTrialUI_" .. arg_1_0.params_.skinTrialID
end

function var_0_0.OnEnter(arg_2_0)
	var_0_0.super.OnEnter(arg_2_0)

	arg_2_0.startTime_ = ActivityData:GetActivityData(arg_2_0.activityID_).startTime
	arg_2_0.stopTime_ = ActivityData:GetActivityData(arg_2_0.activityID_).stopTime
	arg_2_0.textTime_.text = manager.time:GetLostTimeStr(arg_2_0.stopTime_)

	arg_2_0:AddTimer()
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btnBattle_, nil, function()
		SkinTrialData:SaveStageID(arg_3_0.skinTrialID_)

		if not ActivityData:GetActivityData(arg_3_0.activityID_):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

		arg_3_0:SaveRoute()
		arg_3_0:Go("/sectionSelectHero", {
			section = ActivitySkinTrialCfg[arg_3_0.skinTrialID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL,
			activityID = arg_3_0.activityID_
		})
	end)
end

function var_0_0.OnExit(arg_5_0)
	var_0_0.super.OnExit(arg_5_0)
	arg_5_0:StopTimer()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = arg_6_0.skinTrialID_
	local var_6_1 = SkinTrialTools.GetHeroStandardID(var_6_0)
	local var_6_2 = HeroStandardSystemCfg[var_6_1].skin_id
	local var_6_3 = HeroStandardSystemCfg[var_6_1].hero_id

	arg_6_0.heroNameText_.text = HeroTools.GetHeroFullName(var_6_3)
	arg_6_0.skinDescText_.text = GetI18NText(SkinCfg[var_6_2].desc)

	arg_6_0:RefreshReward()
end

function var_0_0.GetRewardItem(arg_7_0)
	return FactorySkinTrialRewardItem
end

function var_0_0.GetCommonItem(arg_8_0, arg_8_1)
	return arg_8_1:GetCommonItem()
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.rewardCfg_[arg_9_1]

	arg_9_2:SetData(var_9_0, arg_9_0.popType_, arg_9_0.skinTrialID_)
end

function var_0_0.AddTimer(arg_10_0)
	if manager.time:GetServerTime() >= arg_10_0.stopTime_ then
		arg_10_0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	arg_10_0.textTime_.text = manager.time:GetLostTimeStr(arg_10_0.stopTime_)
	arg_10_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_10_0.stopTime_ then
			arg_10_0:StopTimer()

			arg_10_0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		arg_10_0.textTime_.text = manager.time:GetLostTimeStr(arg_10_0.stopTime_)
	end, 1, -1)

	arg_10_0.timer_:Start()
end

function var_0_0.StopTimer(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end
end

return var_0_0
