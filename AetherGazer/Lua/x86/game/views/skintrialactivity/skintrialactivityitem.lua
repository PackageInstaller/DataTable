local var_0_0 = class("SkinTrialAcitivteItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateController_ = ControllerUtil.GetController(arg_1_0.transform_, "state")
	arg_1_0.adaptImg_ = arg_1_0:FindCom("AdaptImage", nil, arg_1_0.transform_)

	arg_1_0:SetSkinTrialID(arg_1_3)
	SetActive(arg_1_0.gameObject_, true)
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)

	local var_2_0 = ActivitySkinTrialCfg[arg_2_0.skinTrialID_]
	local var_2_1 = string.format("%s_%s", RedPointConst.SKIN_TRIAL, arg_2_0.skinTrialID_)

	manager.redPoint:unbindUIandKey(arg_2_0.transform_, var_2_1)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		if not ActivityData:GetActivityData(arg_3_0.activityID_):IsActivitying() then
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

function var_0_0.SetSkinTrialID(arg_5_0, arg_5_1)
	local var_5_0 = ActivitySkinTrialCfg[arg_5_1]
	local var_5_1 = string.format("%s_%s", RedPointConst.SKIN_TRIAL, arg_5_1)

	manager.redPoint:bindUIandKey(arg_5_0.transform_, var_5_1)

	arg_5_0.skinTrialID_ = arg_5_1
	arg_5_0.activityID_ = ActivitySkinTrialCfg[arg_5_0.skinTrialID_].activity_id
	arg_5_0.startTime_ = ActivityData:GetActivityData(arg_5_0.activityID_).startTime
	arg_5_0.stopTime_ = ActivityData:GetActivityData(arg_5_0.activityID_).stopTime

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = SkinTrialTools.GetHeroStandardID(arg_6_0.skinTrialID_)
	local var_6_1 = HeroStandardSystemCfg[var_6_0].skin_id
	local var_6_2 = SkinCfg[var_6_1].picture_id

	arg_6_0.nameText_.text = GetI18NText(SkinCfg[var_6_1].name)

	local var_6_3 = getSpriteViaConfig("SkinTrialTextrues", var_6_2)

	if var_6_3 ~= nil then
		arg_6_0.skinImage_.sprite = var_6_3

		arg_6_0.adaptImg_:AdaptImg()
	end

	if SkinTrialData:IsCompleted(arg_6_0.skinTrialID_) then
		arg_6_0.stateController_:SetSelectedState("true")
	end
end

function var_0_0.RefreshTime(arg_7_0)
	if manager.time:GetServerTime() < ActivityData:GetActivityData(arg_7_0.activityID_).startTime then
		SetActive(arg_7_0.gameObject_, false)

		return
	end

	if manager.time:GetServerTime() >= ActivityData:GetActivityData(arg_7_0.activityID_).stopTime then
		SetActive(arg_7_0.gameObject_, false)

		return
	end

	SetActive(arg_7_0.gameObject_, true)
end

return var_0_0
