local var_0_0 = class("HeroTrialActivityView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/OsirisUI/OsirisUIontrial"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.heroItemList_ = {}
	arg_3_0.rewardItemList_ = {}
	arg_3_0.onClickTrialHandler_ = handler(arg_3_0, arg_3_0.OnClickTrial)
	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.transformBtn_, "name")
	arg_3_0.adaptImg_ = arg_3_0:FindCom("AdaptImage", nil, arg_3_0.imageIcon_.transform)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_HERO_TRIAL_DESCRIPE")
	manager.notify:RegistListener(HERO_TRIAL_CLICK, arg_4_0.onClickTrialHandler_)

	arg_4_0.activityID_ = arg_4_0.params_.activityID
	arg_4_0.stopTime_ = ActivityData:GetActivityData(arg_4_0.activityID_).stopTime

	arg_4_0:AddTimer()
	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(HERO_TRIAL_CLICK, arg_5_0.onClickTrialHandler_)
	arg_5_0:StopTimer()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.onClickTrialHandler_ = nil

	for iter_6_0, iter_6_1 in pairs(arg_6_0.rewardItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.rewardItemList_ = nil

	for iter_6_2, iter_6_3 in pairs(arg_6_0.heroItemList_) do
		iter_6_3:Dispose()
	end

	arg_6_0.heroItemList_ = nil
end

function var_0_0.OnTop(arg_7_0)
	if arg_7_0.selectActivityHeroID_ == nil then
		ShowTips("TIME_OVER")
		arg_7_0:Back()

		return
	end
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.btnReceive_, nil, function()
		HeroTrialAction.GetTrialReward(arg_8_0.selectActivityHeroID_, function(arg_10_0)
			if isSuccess(arg_10_0.result) then
				getReward(formatRewardCfgList(ActivityHeroTrialCfg[arg_8_0.selectActivityHeroID_].reward_list))
				arg_8_0.controller_:SetSelectedState("complete")
			else
				ShowTips(arg_10_0.result)
			end
		end)
	end)
	arg_8_0:AddBtnListener(arg_8_0.btnTrial_, nil, function()
		local var_11_0 = {}

		for iter_11_0, iter_11_1 in ipairs(arg_8_0.activityHeroIDList_) do
			local var_11_1 = HeroTrialTools.GetHeroStandardID(iter_11_1)

			table.insert(var_11_0, var_11_1)
		end

		arg_8_0:Go("/newHero", {
			isEnter = true,
			isTemp = true,
			hid = HeroTrialTools.GetHeroStandardID(arg_8_0.selectActivityHeroID_),
			tempHeroList = var_11_0
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.btnBattle_, nil, function()
		HeroTrialData:SaveStageID(arg_8_0.selectActivityHeroID_)
		arg_8_0:Go("/sectionSelectHero", {
			section = ActivityHeroTrialCfg[arg_8_0.selectActivityHeroID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.HERO_TRIAL,
			activityID = arg_8_0.activityID_
		})
	end)
end

function var_0_0.RefreshUI(arg_13_0)
	local var_13_0 = arg_13_0:GetActivityHeroIDList()

	arg_13_0.activityHeroIDList_ = var_13_0

	local var_13_1 = HeroTrialData:GetSelectActivityHeroID(arg_13_0.activityID_) or var_13_0[1]

	arg_13_0.selectActivityHeroID_ = var_13_1

	if var_13_1 == nil then
		return
	end

	HeroTrialData:SetSelectActivityHeroID(arg_13_0.activityID_, var_13_1)
	arg_13_0:RefreshHeroItem()

	local var_13_2 = HeroTrialTools.GetHeroStandardID(var_13_1)

	arg_13_0.heroID_ = HeroStandardSystemCfg[var_13_2].hero_id
	arg_13_0.heroCfg_ = HeroCfg[arg_13_0.heroID_]

	local var_13_3 = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. SkinCfg[HeroStandardSystemCfg[var_13_2].skin_id].picture_id)

	if var_13_3 ~= nil then
		arg_13_0.imageIcon_.sprite = var_13_3
	end

	arg_13_0.imageIcon_:SetNativeSize()

	if arg_13_0.adaptImg_ then
		arg_13_0.adaptImg_:AdaptImg()
	end

	local var_13_4 = string.format("%s·%s", arg_13_0.heroCfg_.name, arg_13_0.heroCfg_.suffix)

	arg_13_0:RefreshTextName(var_13_4)

	local var_13_5 = GetTips("COMPLETE_TRAIL_STAGE")

	arg_13_0.textTips_.text = string.format(var_13_5, GetI18NText(var_13_4))
	arg_13_0.imageRace_.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[arg_13_0.heroCfg_.race].icon)

	arg_13_0:RefreshReward(var_13_1)

	arg_13_0.imageLv_.sprite = getSprite("Atlas/Common", "star_" .. arg_13_0.heroCfg_.rare)
end

function var_0_0.RefreshTextName(arg_14_0, arg_14_1)
	arg_14_0.textName_.text = GetI18NText(arg_14_1)
end

function var_0_0.RefreshHeroItem(arg_15_0)
	local var_15_0 = arg_15_0.selectActivityHeroID_
	local var_15_1 = arg_15_0.activityHeroIDList_

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		if arg_15_0.heroItemList_[iter_15_0] then
			arg_15_0.heroItemList_[iter_15_0]:SetActivityHeroID(arg_15_0.activityID_, iter_15_1)
		else
			arg_15_0.heroItemList_[iter_15_0] = HeroTrialActivityItem.New(arg_15_0.goItem_, arg_15_0.goItemParent_, iter_15_1, arg_15_0.activityID_)
		end
	end

	for iter_15_2 = #arg_15_0.heroItemList_, #var_15_1 + 1, -1 do
		arg_15_0.heroItemList_[iter_15_2]:Dispose()

		arg_15_0.heroItemList_[iter_15_2] = nil
	end

	for iter_15_3, iter_15_4 in pairs(var_15_1) do
		if iter_15_4 == var_15_0 then
			arg_15_0:RefreshSelectActivityHero(var_15_0)

			return
		end
	end

	arg_15_0:RefreshSelectActivityHero(var_15_1[1])
end

function var_0_0.RefreshReward(arg_16_0, arg_16_1)
	local var_16_0 = ActivityHeroTrialCfg[arg_16_1].reward_list

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if arg_16_0.rewardItemList_[iter_16_0] then
			arg_16_0.rewardItemList_[iter_16_0]:SetData(iter_16_1, false)
		else
			arg_16_0.rewardItemList_[iter_16_0] = arg_16_0:GetRewardItem(iter_16_1)
		end
	end

	for iter_16_2 = #var_16_0 + 1, #arg_16_0.rewardItemList_ do
		arg_16_0.rewardItemList_[iter_16_2]:Show(false)
	end

	local var_16_1 = HeroTrialData:GetHeroTrialStateList()[arg_16_1]

	if var_16_1 then
		if var_16_1 == 1 then
			arg_16_0.controller_:SetSelectedState("receive")
		elseif var_16_1 == 2 then
			arg_16_0.controller_:SetSelectedState("complete")
		else
			arg_16_0.controller_:SetSelectedState("not")
		end
	else
		arg_16_0.controller_:SetSelectedState("not")
	end
end

function var_0_0.GetRewardItem(arg_17_0, arg_17_1)
	return RewardPoolItem.New(arg_17_0.goRewardPanel_, arg_17_1, false)
end

function var_0_0.OnClickTrial(arg_18_0)
	arg_18_0:RefreshUI()
end

function var_0_0.GetActivityHeroIDList(arg_19_0)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(ActivityHeroTrialCfg.get_id_list_by_activity_id[arg_19_0.activityID_]) do
		local var_19_1 = true

		if var_19_1 then
			table.insert(var_19_0, iter_19_1)
		end
	end

	return var_19_0
end

function var_0_0.RefreshSelectActivityHero(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.heroItemList_) do
		iter_20_1:OnSelect(arg_20_1)
	end
end

function var_0_0.AddTimer(arg_21_0)
	if manager.time:GetServerTime() >= arg_21_0.stopTime_ then
		arg_21_0.textTime_.text = GetTips("TIME_OVER")

		arg_21_0:Back()

		return
	end

	arg_21_0.textTime_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStr(arg_21_0.stopTime_))
	arg_21_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_21_0.stopTime_ then
			arg_21_0:StopTimer()

			arg_21_0.textTime_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStr(arg_21_0.stopTime_))

			return
		end

		arg_21_0.textTime_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStr(arg_21_0.stopTime_))
	end, 1, -1)

	arg_21_0.timer_:Start()
end

function var_0_0.StopTimer(arg_23_0)
	if arg_23_0.timer_ then
		arg_23_0.timer_:Stop()

		arg_23_0.timer_ = nil
	end
end

return var_0_0
