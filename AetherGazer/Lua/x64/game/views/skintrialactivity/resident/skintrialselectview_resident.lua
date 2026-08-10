local var_0_0 = class("SkinTrialSelectView_Resident", ReduxView)

function var_0_0.UIName(arg_1_0)
	return SkinTrialTools.GetSelectViewUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitStaticText()
	arg_4_0:InitController()
	arg_4_0:InitRewardItem()

	arg_4_0.skinImage_.immediate = true
end

function var_0_0.InitStaticText(arg_5_0)
	if arg_5_0.battleBtnText_ then
		arg_5_0.battleBtnText_.text = GetTips("ACTIVITY_HERO_TRIAL_START")
	end

	if arg_5_0.sourceBtnText_ then
		arg_5_0.sourceBtnText_.text = GetTips("ACTIVITY_SKIN_TRIAL_GOTOGET")
	end
end

function var_0_0.InitController(arg_6_0)
	arg_6_0.rewardController_ = arg_6_0.rewardControllerEx_:GetController("reward")
end

function var_0_0.InitRewardItem(arg_7_0)
	arg_7_0.rewardItemList_ = {}
	arg_7_0.itemDataList_ = {}

	local var_7_0 = arg_7_0.rewardPanelTrans_.childCount

	for iter_7_0 = 1, var_7_0 do
		arg_7_0.rewardItemList_[iter_7_0] = CommonItemView.New(arg_7_0.rewardPanelTrans_:GetChild(iter_7_0 - 1).gameObject, true)
		arg_7_0.itemDataList_[iter_7_0] = clone(ItemTemplateData)
		arg_7_0.itemDataList_[iter_7_0].clickFun = function(arg_8_0)
			ShowPopItem(POP_ITEM, {
				arg_8_0.id,
				arg_8_0.number
			})
		end
	end
end

function var_0_0.OnEnter(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_9_0:OnBackBtnClick()
	end)
	arg_9_0:RegistEventListener(SKIN_TRIAL_UPDATE, handler(arg_9_0, arg_9_0.OnSkinTrialUpdate))

	arg_9_0.activityID_ = arg_9_0.params_.activityID
	arg_9_0.skinTrialID_ = arg_9_0.params_.skinTrialID
	arg_9_0.startTime_ = ActivityData:GetActivityData(arg_9_0.activityID_).startTime
	arg_9_0.stopTime_ = ActivityData:GetActivityData(arg_9_0.activityID_).stopTime

	arg_9_0:RefreshUI()
	arg_9_0:AddTimer()
end

function var_0_0.AddListeners(arg_11_0)
	arg_11_0:AddBtnListener(arg_11_0.battleBtn_, nil, function()
		SkinTrialData:SaveStageID(arg_11_0.skinTrialID_)

		if not ActivityData:GetActivityData(arg_11_0.activityID_):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

		arg_11_0:SaveRoute()
		arg_11_0:Go("/sectionSelectHero", {
			section = ActivitySkinTrialCfg[arg_11_0.skinTrialID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL,
			activityID = arg_11_0.activityID_
		})
	end)
	arg_11_0:AddBtnListener(arg_11_0.sourceBtn_, nil, function()
		if not ActivityData:GetActivityData(arg_11_0.activityID_):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

		local var_13_0 = ActivitySkinTrialCfg[arg_11_0.skinTrialID_].source

		JumpTools.JumpToPage2(var_13_0)
	end)
	arg_11_0:AddBtnListener(arg_11_0.rewardBtn_, nil, function()
		SkinTrialAction.RequestSkinTrialReward(arg_11_0.skinTrialID_)
	end)
end

function var_0_0.OnBackBtnClick(arg_15_0)
	local var_15_0 = SkinTrialData:GetSkinTrialMainScrollPos("Global")

	SkinTrialData:SaveSkinTrialMainScrollPos(var_15_0, "Back")
	arg_15_0:Back()
end

function var_0_0.OnExit(arg_16_0)
	manager.windowBar:HideBar()
	arg_16_0:StopTimer()
	arg_16_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.rewardItemList_) do
		iter_17_1:Dispose()
	end

	arg_17_0.rewardItemList_ = nil
	arg_17_0.itemDataList_ = nil

	var_0_0.super.Dispose(arg_17_0)
end

function var_0_0.RefreshUI(arg_18_0)
	arg_18_0:RefreshSkinInfo()
	arg_18_0:RefreshRoleImage()
	arg_18_0:RefreshReward()
end

function var_0_0.RefreshSkinInfo(arg_19_0)
	local var_19_0 = SkinTrialTools.GetHeroStandardID(arg_19_0.skinTrialID_)
	local var_19_1 = HeroStandardSystemCfg[var_19_0].skin_id
	local var_19_2 = HeroStandardSystemCfg[var_19_0].hero_id

	arg_19_0.heroNameText_.text = string.format("%s·%s", GetI18NText(HeroCfg[var_19_2].name), GetI18NText(HeroCfg[var_19_2].suffix))
	arg_19_0.skinDescText_.text = GetI18NText(SkinCfg[var_19_1].desc)
	arg_19_0.skinNameText_.text = GetI18NText(SkinCfg[var_19_1].name)
end

function var_0_0.RefreshRoleImage(arg_20_0)
	local var_20_0 = SkinTrialTools.GetHeroStandardID(arg_20_0.skinTrialID_)

	arg_20_0.skinImage_.spriteSync = "TextureConfig/Character/Portrait/" .. SkinCfg[HeroStandardSystemCfg[var_20_0].skin_id].picture_id
end

function var_0_0.RefreshReward(arg_21_0)
	arg_21_0:RefreshRewardState()
	arg_21_0:RefreshRewardItem()
end

function var_0_0.RefreshRewardState(arg_22_0)
	local var_22_0 = SkinTrialData:GetSkinTrialStatus(arg_22_0.skinTrialID_)

	if var_22_0 == 0 then
		arg_22_0.rewardController_:SetSelectedState("normal")
	elseif var_22_0 == 1 then
		arg_22_0.rewardController_:SetSelectedState("clear")
	elseif var_22_0 == 2 then
		arg_22_0.rewardController_:SetSelectedState("receive")
	end
end

function var_0_0.RefreshRewardItem(arg_23_0)
	local var_23_0 = ActivitySkinTrialCfg[arg_23_0.skinTrialID_].reward

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		arg_23_0.itemDataList_[iter_23_0].id = iter_23_1[1]
		arg_23_0.itemDataList_[iter_23_0].number = iter_23_1[2]

		arg_23_0.rewardItemList_[iter_23_0]:SetData(arg_23_0.itemDataList_[iter_23_0])
	end

	for iter_23_2 = #var_23_0 + 1, #arg_23_0.rewardItemList_ do
		arg_23_0.rewardItemList_[iter_23_2]:SetData(nil)
	end
end

function var_0_0.AddTimer(arg_24_0)
	if manager.time:GetServerTime() >= arg_24_0.stopTime_ then
		arg_24_0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	arg_24_0.textTime_.text = manager.time:GetLostTimeStr(arg_24_0.stopTime_)
	arg_24_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_24_0.stopTime_ then
			arg_24_0:StopTimer()

			arg_24_0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		arg_24_0.textTime_.text = manager.time:GetLostTimeStr(arg_24_0.stopTime_)
	end, 1, -1)

	arg_24_0.timer_:Start()
end

function var_0_0.StopTimer(arg_26_0)
	if arg_26_0.timer_ then
		arg_26_0.timer_:Stop()

		arg_26_0.timer_ = nil
	end
end

function var_0_0.SaveRoute(arg_27_0)
	local var_27_0 = {
		name = "skinTrialSelectView_Resident",
		activityID = arg_27_0.activityID_,
		skinTrialID = arg_27_0.skinTrialID_
	}

	SkinTrialData:SaveRoute(var_27_0)
end

function var_0_0.OnSkinTrialUpdate(arg_28_0, arg_28_1)
	arg_28_0:RefreshRewardState()
end

return var_0_0
