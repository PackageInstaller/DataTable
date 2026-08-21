local var_0_0 = class("SkinTrialSelect1001", SkinTrialActivitySelectView)

function var_0_0.UIName(arg_1_0)
	return "UI/OsirisUI/OsirisSkinTrialUI_101"
end

function var_0_0.OnEnter(arg_2_0)
	var_0_0.super.OnEnter(arg_2_0)

	arg_2_0.startTime_ = ActivityData:GetActivityData(arg_2_0.activityID_).startTime
	arg_2_0.stopTime_ = ActivityData:GetActivityData(arg_2_0.activityID_).stopTime
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btnBattle_, nil, function()
		SkinTrialData:SaveStageID(arg_3_0.skinTrialID_)

		if not ActivityData:GetActivityData(arg_3_0.activityID_):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

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

	arg_6_0.heroTitleText_.text = GetI18NText(SkinCfg[var_6_2].name)
	arg_6_0.skinImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. SkinCfg[var_6_2].picture_id)
	arg_6_0.heroNameText_.text = string.format("%s·%s", GetI18NText(HeroCfg[var_6_3].name), GetI18NText(HeroCfg[var_6_3].suffix))

	local var_6_4 = SettingData:GetCurrentLanguage()

	if var_6_4 == "fr" or var_6_4 == "de" then
		arg_6_0.heroNameText_.text = string.format("%s-%s", GetI18NText(HeroCfg[var_6_3].name), GetI18NText(HeroCfg[var_6_3].suffix))
	end

	arg_6_0.skinDescText_.text = GetI18NText(SkinCfg[var_6_2].desc)

	arg_6_0:RefreshReward()
end

function var_0_0.GetRewardItem(arg_7_0)
	return CommonItem
end

function var_0_0.GetCommonItem(arg_8_0, arg_8_1)
	return arg_8_1
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.rewardCfg_[arg_9_1]
	local var_9_1 = arg_9_0:GetCommonItem(arg_9_2)

	var_9_1:RefreshData(formatReward(var_9_0))
	var_9_1:RegistCallBack(function()
		if arg_9_0.clickCallback_ then
			if arg_9_0.clickCallback_() then
				ShowPopItem(arg_9_0.popType_, var_9_0)
			end
		else
			ShowPopItem(arg_9_0.popType_, var_9_0)
		end
	end)

	if arg_9_0.receivedControllerList_[arg_9_1] == nil then
		arg_9_0.receivedControllerList_[arg_9_1] = ControllerUtil.GetController(var_9_1.transform_, "received")
	end

	if SkinTrialData:IsCompleted(arg_9_0.skinTrialID_) then
		arg_9_0.receivedControllerList_[arg_9_1]:SetSelectedState("true")
	end
end

function var_0_0.AddTimer(arg_11_0)
	if manager.time:GetServerTime() >= arg_11_0.stopTime_ then
		arg_11_0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	arg_11_0.textTime_.text = manager.time:GetLostTimeStr(arg_11_0.stopTime_)
	arg_11_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_11_0.stopTime_ then
			arg_11_0:StopTimer()

			arg_11_0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		arg_11_0.textTime_.text = manager.time:GetLostTimeStr(arg_11_0.stopTime_)
	end, 1, -1)

	arg_11_0.timer_:Start()
end

function var_0_0.StopTimer(arg_13_0)
	if arg_13_0.timer_ then
		arg_13_0.timer_:Stop()

		arg_13_0.timer_ = nil
	end
end

return var_0_0
