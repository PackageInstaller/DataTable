local var_0_0 = class("HeroTrialView_2_0", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = Asset.Load(arg_1_0:UIName(arg_1_2))

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.activityID_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.UIName(arg_2_0, arg_2_1)
	return HeroTrialTools.GetMainUIName(arg_2_1)
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.heroItemList_ = {}
	arg_4_0.rewardItemList_ = {}
	arg_4_0.itemDataList_ = {}
	arg_4_0.onClickTrialHandler_ = handler(arg_4_0, arg_4_0.OnClickTrial)
	arg_4_0.OnActivityUpdateHandler_ = handler(arg_4_0, arg_4_0.OnActivityUpdate)
	arg_4_0.adaptImg_ = arg_4_0:FindCom("AdaptImage", nil, arg_4_0.imageIcon_.transform)
	arg_4_0.imageIcon_.immediate = true
	arg_4_0.goItemParentTrans_ = arg_4_0.goItemParent_.transform
	arg_4_0.controller_ = ControllerUtil.GetController(arg_4_0.transformBtn_, "name")
	arg_4_0.attackTypeController_ = ControllerUtil.GetController(arg_4_0.transform_, "attackType")

	if not arg_4_0.atackTypeIcon_ then
		arg_4_0.atackTypeIcon_ = arg_4_0.transform_:Find("right_adapt/panel/right/property/type/icon"):GetComponent("Image")
	end
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnReceive_, nil, function()
		HeroTrialAction.GetTrialReward(arg_5_0.activityID_, arg_5_0.selectActivityHeroID_, function(arg_7_0)
			if isSuccess(arg_7_0.result) then
				getReward(formatRewardCfgList(ActivityHeroTrialCfg[arg_5_0.selectActivityHeroID_].reward_list))
				arg_5_0:RefreshReward()
			else
				ShowTips(arg_7_0.result)
			end
		end)
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnTrial_, nil, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_5_0.activityHeroIDList_) do
			local var_8_1 = HeroTrialTools.GetHeroStandardID(iter_8_1)

			table.insert(var_8_0, var_8_1)
		end

		arg_5_0:Go("/newHero", {
			isEnter = true,
			hid = HeroTrialTools.GetHeroStandardID(arg_5_0.selectActivityHeroID_),
			type = HeroConst.HERO_DATA_TYPE.TRIAL,
			tempHeroList = var_8_0
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnBattle_, nil, function()
		HeroTrialData:SaveStageID(arg_5_0.selectActivityHeroID_)
		HeroTrialData:SetBattleWay(ActivityHeroTrialConst.BATTLE_WAY.ACTIVITY)
		arg_5_0:Go("/sectionSelectHero", {
			section = ActivityHeroTrialCfg[arg_5_0.selectActivityHeroID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.HERO_TRIAL,
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.descBtn_, nil, function()
		local var_10_0 = GetTips("ACTIVITY_HERO_TRIAL_DESCRIPE")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_HERO_TRIAL_DESCRIPE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_10_0
		})
	end)
end

function var_0_0.UpdateBar(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)

	for iter_12_0, iter_12_1 in pairs(arg_12_0.rewardItemList_) do
		iter_12_1:Dispose()
	end

	arg_12_0.rewardItemList_ = nil
	arg_12_0.itemDataList_ = nil

	for iter_12_2, iter_12_3 in pairs(arg_12_0.heroItemList_) do
		iter_12_3:Dispose()
	end

	arg_12_0.heroItemList_ = nil
end

function var_0_0.Show(arg_13_0, arg_13_1)
	SetActive(arg_13_0.gameObject_, arg_13_1)

	if arg_13_1 == true then
		arg_13_0:OnEnable()
	else
		arg_13_0:OnDisable()
	end
end

function var_0_0.OnEnable(arg_14_0)
	arg_14_0:InitActivityList()
	arg_14_0:ScrollToLastPos()
	arg_14_0:RefreshHeroItem()
	arg_14_0:RefreshUI()
	arg_14_0:UpdateStopTime()
	arg_14_0:AddTimer()
	arg_14_0:RegistEventListener(HERO_TRIAL_CLICK, arg_14_0.onClickTrialHandler_)
	arg_14_0:RegistEventListener(ACTIVITY_UPDATE, arg_14_0.OnActivityUpdateHandler_)
end

function var_0_0.OnDisable(arg_15_0)
	arg_15_0:StopTimer()
	arg_15_0:RemoveAllEventListener()
	arg_15_0:SaveLastScrollPos()
end

function var_0_0.InitActivityList(arg_16_0)
	arg_16_0.activityHeroIDList_ = {}

	for iter_16_0, iter_16_1 in ipairs(ActivityCfg[arg_16_0.activityID_].sub_activity_list) do
		if ActivityData:GetActivityIsOpen(iter_16_1) then
			local var_16_0 = ActivityHeroTrialCfg.get_id_list_by_activity_id[iter_16_1]

			for iter_16_2, iter_16_3 in ipairs(var_16_0) do
				arg_16_0.activityHeroIDList_[#arg_16_0.activityHeroIDList_ + 1] = iter_16_3
			end
		end
	end

	local var_16_1 = HeroTrialData:GetHeroTrialStateList()

	table.sort(arg_16_0.activityHeroIDList_, function(arg_17_0, arg_17_1)
		local var_17_0 = var_16_1[arg_17_0]
		local var_17_1 = var_16_1[arg_17_1]

		if var_17_0 ~= var_17_1 then
			return var_17_0 < var_17_1
		else
			return arg_17_0 < arg_17_1
		end
	end)
	arg_16_0:InitSelectActivityHeroID()
end

function var_0_0.InitSelectActivityHeroID(arg_18_0)
	local var_18_0 = HeroTrialData:GetSelectActivityHeroID(arg_18_0.activityID_)

	if not var_18_0 or not table.indexof(arg_18_0.activityHeroIDList_, var_18_0) then
		var_18_0 = arg_18_0.activityHeroIDList_[1]
	end

	arg_18_0.selectActivityHeroID_ = var_18_0

	HeroTrialData:SetSelectActivityHeroID(arg_18_0.activityID_, arg_18_0.selectActivityHeroID_)
end

function var_0_0.ScrollToLastPos(arg_19_0)
	local var_19_0 = HeroTrialData:GetLastContentPosX(arg_19_0.activityID_)

	if var_19_0 then
		arg_19_0.goItemParentTrans_:SetAnchoredPositionX(var_19_0)
	end
end

function var_0_0.SaveLastScrollPos(arg_20_0)
	local var_20_0 = arg_20_0.goItemParentTrans_:GetAnchoredPositionX(nil)

	HeroTrialData:SetLastContentPosX(arg_20_0.activityID_, var_20_0)
end

function var_0_0.RefreshHeroItem(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.activityHeroIDList_) do
		if arg_21_0.heroItemList_[iter_21_0] then
			arg_21_0.heroItemList_[iter_21_0]:SetActivityHeroID(arg_21_0.activityID_, iter_21_1)
		else
			arg_21_0.heroItemList_[iter_21_0] = arg_21_0:GetHeroTrialSelectItemClass().New(arg_21_0.goItem_, arg_21_0.goItemParent_, iter_21_1, arg_21_0.activityID_)
		end
	end

	for iter_21_2 = #arg_21_0.heroItemList_, #arg_21_0.activityHeroIDList_ + 1, -1 do
		arg_21_0.heroItemList_[iter_21_2]:Dispose()

		arg_21_0.heroItemList_[iter_21_2] = nil
	end

	arg_21_0:RefreshSelectActivityHero()
end

function var_0_0.RefreshSelectActivityHero(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.heroItemList_) do
		iter_22_1:OnSelect(arg_22_0.selectActivityHeroID_)
	end
end

function var_0_0.OnClickTrial(arg_23_0, arg_23_1)
	arg_23_0.selectActivityHeroID_ = arg_23_1

	HeroTrialData:SetSelectActivityHeroID(arg_23_0.activityID_, arg_23_0.selectActivityHeroID_)
	arg_23_0:RefreshUI()
	arg_23_0:RefreshSelectActivityHero()
	arg_23_0:UpdateStopTime()
end

function var_0_0.OnActivityUpdate(arg_24_0, arg_24_1)
	if ActivityCfg[arg_24_1].activity_template == ActivityTemplateConst.SUB_HERO_TRIAL then
		arg_24_0:InitActivityList()
		arg_24_0:RefreshHeroItem()
		arg_24_0:RefreshUI()
	end
end

function var_0_0.GetHeroTrialSelectItemClass(arg_25_0)
	return HeroTrialSelectItem_2_0
end

function var_0_0.RefreshUI(arg_26_0)
	arg_26_0:RefreshHeroUI()
	arg_26_0:RefreshReward()
end

function var_0_0.RefreshHeroUI(arg_27_0)
	arg_27_0:GetHeroCfg()
	arg_27_0:RefreshHeroImage()
	arg_27_0:RefreshHeroName()
	arg_27_0:RefreshRangeType()
	arg_27_0:RefreshChargeType()
	arg_27_0:RefreshAttackType()
	arg_27_0:RefreshRace()
	arg_27_0:RefreshRare()
end

function var_0_0.GetHeroCfg(arg_28_0)
	local var_28_0 = HeroTrialTools.GetHeroStandardID(arg_28_0.selectActivityHeroID_)

	arg_28_0.heroID_ = HeroStandardSystemCfg[var_28_0].hero_id
	arg_28_0.heroCfg_ = HeroCfg[arg_28_0.heroID_]
end

function var_0_0.RefreshHeroImage(arg_29_0)
	local var_29_0 = HeroTrialTools.GetHeroStandardID(arg_29_0.selectActivityHeroID_)

	arg_29_0.imageIcon_.spriteSync = "TextureConfig/Character/Portrait/" .. SkinCfg[HeroStandardSystemCfg[var_29_0].skin_id].picture_id

	arg_29_0.imageIcon_:SetNativeSize()

	if arg_29_0.adaptImg_ then
		arg_29_0.adaptImg_:AdaptImg()
	end
end

function var_0_0.RefreshHeroName(arg_30_0)
	local var_30_0 = string.format("%s·%s", arg_30_0.heroCfg_.name, arg_30_0.heroCfg_.suffix)

	arg_30_0:RefreshTextName(var_30_0)

	local var_30_1 = GetTips("COMPLETE_TRAIL_STAGE")

	arg_30_0.textTips_.text = string.format(var_30_1, GetI18NText(var_30_0))
end

function var_0_0.RefreshTextName(arg_31_0, arg_31_1)
	local var_31_0 = string.split(arg_31_1, "·")

	arg_31_0.textName_.text = GetI18NText(var_31_0[1])
	arg_31_0.textSubName_.text = GetI18NText(var_31_0[2])
end

function var_0_0.RefreshRangeType(arg_32_0)
	arg_32_0.rangeTypeText_.text = CharactorParamCfg[arg_32_0.heroID_].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
end

function var_0_0.RefreshChargeType(arg_33_0)
	arg_33_0.chargeType_.text = HeroTools.GetChargeTextByType(arg_33_0.heroCfg_.mechanism_type[1])
end

function var_0_0.RefreshAttackType(arg_34_0)
	if arg_34_0.atackTypeIcon_ then
		arg_34_0.atackTypeIcon_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_34_0.heroCfg_.id)
	elseif arg_34_0.attackTypeController_ then
		if #arg_34_0.heroCfg_.ATK_attribute > 1 then
			arg_34_0.attackTypeController_:SetSelectedState(-1)
		else
			arg_34_0.attackTypeController_:SetSelectedState(arg_34_0.heroCfg_.ATK_attribute[1])
		end
	end
end

function var_0_0.RefreshRace(arg_35_0)
	arg_35_0.imageRace_.sprite = HeroTools.GetHeroRaceIcon(arg_35_0.heroCfg_.id)
end

function var_0_0.RefreshRare(arg_36_0)
	arg_36_0.imageLv_.sprite = HeroTools.GetHeroRareSprite(arg_36_0.heroCfg_.id)
end

function var_0_0.GetRewardItem(arg_37_0, arg_37_1)
	return HeroTrialRewardItem_2_0.New(arg_37_0.goRewardPanel_, arg_37_0.rewardItemGo_, arg_37_1, true)
end

function var_0_0.RefreshReward(arg_38_0)
	arg_38_0:RefreshRewardState()
	arg_38_0:RefreshRewardItem()
end

function var_0_0.RefreshRewardState(arg_39_0)
	arg_39_0.rewardState_ = HeroTrialData:GetHeroTrialStateList()[arg_39_0.selectActivityHeroID_]

	if arg_39_0.rewardState_ then
		if arg_39_0.rewardState_ == ActivityHeroTrialConst.REWARD_STATE.RECEIVE then
			arg_39_0.controller_:SetSelectedState("receive")
		elseif arg_39_0.rewardState_ == ActivityHeroTrialConst.REWARD_STATE.COMPLETE then
			arg_39_0.controller_:SetSelectedState("complete")
		else
			arg_39_0.controller_:SetSelectedState("not")
		end
	else
		arg_39_0.controller_:SetSelectedState("not")
	end
end

function var_0_0.RefreshRewardItem(arg_40_0)
	local var_40_0 = ActivityHeroTrialCfg[arg_40_0.selectActivityHeroID_].reward_list

	for iter_40_0 = 1, 3 do
		local var_40_1 = var_40_0[iter_40_0]

		if not arg_40_0.itemDataList_[iter_40_0] then
			arg_40_0.itemDataList_[iter_40_0] = clone(ItemTemplateData)
			arg_40_0.itemDataList_[iter_40_0].clickFun = function(arg_41_0)
				ShowPopItem(POP_ITEM, {
					arg_41_0.id,
					arg_41_0.number
				})
			end
		end

		local var_40_2 = true

		if var_40_1 then
			arg_40_0.itemDataList_[iter_40_0].id = var_40_1[1]
			arg_40_0.itemDataList_[iter_40_0].number = var_40_1[2]
			arg_40_0.itemDataList_[iter_40_0].completedFlag = arg_40_0.rewardState_ == 2
			var_40_2 = false
		end

		if arg_40_0.rewardItemList_[iter_40_0] == nil then
			arg_40_0.rewardItemList_[iter_40_0] = CommonItemPool.New(arg_40_0.goRewardPanel_, nil, true)
		end

		if not var_40_2 then
			arg_40_0.rewardItemList_[iter_40_0]:SetData(arg_40_0.itemDataList_[iter_40_0])
		else
			arg_40_0.rewardItemList_[iter_40_0]:SetData(nil)
		end
	end
end

function var_0_0.UpdateStopTime(arg_42_0)
	local var_42_0 = ActivityHeroTrialCfg[arg_42_0.selectActivityHeroID_].activity_id

	arg_42_0.stopTime_ = ActivityData:GetActivityData(var_42_0).stopTime
end

function var_0_0.AddTimer(arg_43_0)
	if manager.time:GetServerTime() >= arg_43_0.stopTime_ then
		arg_43_0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	arg_43_0:StopTimer()

	arg_43_0.textTime_.text = manager.time:GetLostTimeStrWith2Unit(arg_43_0.stopTime_)
	arg_43_0.timer_ = Timer.New(handler(arg_43_0, arg_43_0.UpdateTimer), 1, -1)

	arg_43_0.timer_:Start()
end

function var_0_0.StopTimer(arg_44_0)
	if arg_44_0.timer_ then
		arg_44_0.timer_:Stop()

		arg_44_0.timer_ = nil
	end
end

function var_0_0.UpdateTimer(arg_45_0)
	if manager.time:GetServerTime() >= arg_45_0.stopTime_ then
		arg_45_0:StopTimer()

		arg_45_0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	arg_45_0.textTime_.text = manager.time:GetLostTimeStrWith2Unit(arg_45_0.stopTime_)
end

return var_0_0
