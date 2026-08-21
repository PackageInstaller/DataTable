local var_0_0 = class("SkinTrialSelectItem_2_0", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.skinImage_.immediate = true

	arg_1_0:AddListeners()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)

	local var_2_0 = string.format("%s_%s", RedPointConst.SKIN_TRIAL, arg_2_0.skinTrialID_)

	manager.redPoint:unbindUIandKey(arg_2_0.transform_, var_2_0)

	arg_2_0.outOfDataHandler_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		if manager.time:GetServerTime() < arg_3_0.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_3_0.startTime_)))

			return
		end

		if manager.time:GetServerTime() >= arg_3_0.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		SkinTrialData:SetSelectSkinTrialID(arg_3_0.skinTrialID_)
		SkinTrialTools.GoToSelectView(arg_3_0.activityID_, arg_3_0.skinTrialID_)
	end)
end

function var_0_0.SetSkinTrialID(arg_5_0, arg_5_1)
	local var_5_0 = string.format("%s_%s", RedPointConst.SKIN_TRIAL, arg_5_1)

	manager.redPoint:bindUIandKey(arg_5_0.transform_, var_5_0)

	arg_5_0.skinTrialID_ = arg_5_1
	arg_5_0.activityID_ = ActivitySkinTrialCfg[arg_5_0.skinTrialID_].activity_id
	arg_5_0.startTime_ = ActivityData:GetActivityData(arg_5_0.activityID_).startTime
	arg_5_0.stopTime_ = ActivityData:GetActivityData(arg_5_0.activityID_).stopTime

	arg_5_0:RefreshUI()
	arg_5_0:RefreshTime()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = SkinTrialTools.GetHeroStandardID(arg_6_0.skinTrialID_)
	local var_6_1 = HeroStandardSystemCfg[var_6_0].skin_id
	local var_6_2 = HeroStandardSystemCfg[var_6_0].hero_id

	arg_6_0.heroNameText_.text = HeroTools.GetHeroFullName(var_6_2)
	arg_6_0.nameText_.text = SkinCfg[var_6_1].name
	arg_6_0.skinImage_.spriteSync = getSpritePathViaConfig("HeroIcon", SkinCfg[var_6_1].picture_id)
end

function var_0_0.RefreshTime(arg_7_0)
	if manager.time:GetServerTime() < arg_7_0.startTime_ or manager.time:GetServerTime() >= arg_7_0.stopTime_ then
		SetActive(arg_7_0.gameObject_, false)
		arg_7_0.outOfDataHandler_()

		return
	end

	SetActive(arg_7_0.gameObject_, true)

	arg_7_0.textTime_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(arg_7_0.stopTime_)
end

function var_0_0.SetOutOfDataHandler(arg_8_0, arg_8_1)
	arg_8_0.outOfDataHandler_ = arg_8_1
end

return var_0_0
