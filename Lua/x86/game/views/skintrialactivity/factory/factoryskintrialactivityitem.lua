SkinTrialActivityItem = import("game.views.skinTrialActivity.SkinTrialActivityItem")

local var_0_0 = class("FactorySkinTrialActivityItem", SkinTrialActivityItem)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateController_ = ControllerUtil.GetController(arg_1_0.transform_, "state")

	arg_1_0:SetSkinTrialID(arg_1_2)
	SetActive(arg_1_0.gameObject_, true)
end

function var_0_0.RefreshUI(arg_2_0)
	if SDKTools.GetIsOverSea() then
		local var_2_0 = ActivitySkinTrialCfg[arg_2_0.skinTrialID_]
		local var_2_1 = var_2_0.trial_id
		local var_2_2 = HeroStandardSystemCfg[var_2_1].skin_id
		local var_2_3 = getSpriteViaConfig("SkinTrialTextrues", string.format("%s_oversea", var_2_2))

		if var_2_3 ~= nil then
			arg_2_0.skinImage_.sprite = var_2_3
		end

		arg_2_0.skinNameText_.text = GetI18NText(var_2_0.name)
		arg_2_0.heroNameText_.text = HeroTools.GetHeroFullName(HeroStandardSystemCfg[var_2_1].hero_id)
	end

	if SkinTrialData:IsCompleted(arg_2_0.skinTrialID_) then
		arg_2_0.stateController_:SetSelectedState("true")
	end
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

		if arg_3_0.path_ == nil then
			arg_3_0.path_ = string.format("/skinTrialSelect%d", arg_3_0.skinTrialID_)
		end

		arg_3_0:Go(arg_3_0.path_, {
			canPlayAnim = true,
			activityID = arg_3_0.activityID_,
			skinTrialID = arg_3_0.skinTrialID_
		})
	end)
end

return var_0_0
