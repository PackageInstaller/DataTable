local var_0_0 = class("ActivityRaceSwitchView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIDownUI/ActivityRace/ActivityRaceSwitchUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.selectStageItemHandler_ = handler(arg_3_0, arg_3_0.OnSelectStageItem)
	arg_3_0.selectAffixItemHandler_ = handler(arg_3_0, arg_3_0.OnSelectAffixItem)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.raceController_ = ControllerUtil.GetController(arg_4_0.transform_, "race")
	arg_4_0.indexController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "index")
	arg_4_0.stageItemList_ = {}

	local var_4_0 = arg_4_0.stagePanelTrans_.childCount
	local var_4_1

	for iter_4_0 = 1, var_4_0 do
		local var_4_2 = arg_4_0.stagePanelTrans_:GetChild(iter_4_0 - 1).gameObject

		arg_4_0.stageItemList_[iter_4_0] = ActivityRaceStageItem.New(var_4_2)
	end

	arg_4_0.affixItemList_ = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.shopBtn_, nil, function()
		if arg_5_0:IsOpenSectionView() then
			JumpTools.Back()
			arg_5_0.indexController_:SetSelectedIndex(0)
			arg_5_0:RefreshSelectStageItem(0)
		end

		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_6_0 = ActivityRaceCfg[arg_5_0.activityID_].main_activity_id
		local var_6_1 = ActivityShopCfg[var_6_0]
		local var_6_2 = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[var_6_1.activity_theme]) do
			table.insert(var_6_2, ActivityShopCfg[iter_6_1].shop_id)
		end

		local var_6_3, var_6_4 = ShopTools.IsShopOpen(var_6_1.shop_id)

		if var_6_3 then
			JumpTools.GoToSystem("/shop", {
				shopId = var_6_1.shop_id,
				showShops = var_6_2
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_6_4 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_6_4 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		if arg_5_0:IsOpenSectionView() then
			JumpTools.Back()
			arg_5_0.indexController_:SetSelectedIndex(0)
			arg_5_0:RefreshSelectStageItem(0)
		end

		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("activityRaceRewardPanel", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		if arg_5_0:IsOpenSectionView() then
			JumpTools.Back()
			arg_5_0.indexController_:SetSelectedIndex(0)
			arg_5_0:RefreshSelectStageItem(0)
		end
	end)
	arg_5_0.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		if arg_5_0:IsOpenSectionView() then
			JumpTools.Back()
		end
	end))
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.indexController_:SetSelectedIndex(0)
	arg_10_0:RefreshSelectStageItem(0)

	arg_10_0.activityID_ = arg_10_0.params_.activityID
	arg_10_0.stageIDList_ = ActivityRaceCfg[arg_10_0.activityID_].stage_list
	arg_10_0.unlockStageList_ = ActivityRaceData:GetStateList()[arg_10_0.activityID_].unlockStageList

	arg_10_0:RegisterRedPoint()
	arg_10_0:RefreshUI()
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_RACE_DESCRIPE")
	manager.windowBar:RegistBackCallBack(function()
		if arg_11_0:IsOpenSectionView() then
			JumpTools.Back()
			arg_11_0.indexController_:SetSelectedIndex(0)
			arg_11_0:RefreshSelectStageItem(0)
		else
			JumpTools.Back()
		end
	end)
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.stageItemList_) do
		iter_13_1:OnExit()
	end

	arg_13_0:UnRegisterRedPoint()
	SetActive(arg_13_0.affixinfoTrs_.gameObject, false)

	if arg_13_0.countdownTimer_ then
		arg_13_0.countdownTimer_:Stop()

		arg_13_0.countdownTimer_ = nil
	end

	arg_13_0.selectStageID_ = nil
end

function var_0_0.Dispose(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.stageItemList_) do
		iter_14_1:Dispose()
	end

	for iter_14_2, iter_14_3 in ipairs(arg_14_0.affixItemList_) do
		iter_14_3:Dispose()
	end

	arg_14_0.affixItemList_ = nil
	arg_14_0.selectStageItemHandler_ = nil
	arg_14_0.selectAffixItemHandler_ = nil

	arg_14_0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.RefreshUI(arg_15_0)
	arg_15_0:RefreshStageItem()
	arg_15_0:RefreshAffixItem()
	arg_15_0:RefreshRaceBuff()
	arg_15_0:RefreshTitle()
end

function var_0_0.RefreshTitle(arg_16_0)
	local var_16_0 = ActivityRaceCfg[arg_16_0.activityID_].map_title_icon

	if SDKTools.GetIsOverSea() then
		var_16_0 = var_16_0 .. "@" .. SettingData:GetCurrentLanguage()
	end

	arg_16_0.titleIcon_.sprite = getSprite("Atlas/VolumeIIIDownUI", var_16_0)

	arg_16_0.titleIcon_:SetNativeSize()

	local var_16_1 = ActivityRaceCfg[arg_16_0.activityID_].race_id

	arg_16_0.raceController_:SetSelectedState(tostring(var_16_1))
end

function var_0_0.RefreshStageItem(arg_17_0)
	local var_17_0

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.stageItemList_) do
		local var_17_1 = arg_17_0.unlockStageList_[arg_17_0.stageIDList_[iter_17_0]] == nil

		iter_17_1:SetData(arg_17_0.activityID_, arg_17_0.stageIDList_[iter_17_0], iter_17_0, var_17_1)
		iter_17_1:SetSelectCallBack(arg_17_0.selectStageItemHandler_)
	end
end

function var_0_0.OnSelectStageItem(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.indexController_:SetSelectedIndex(arg_18_1)
	arg_18_0:RefreshSelectStageItem(arg_18_2)

	if arg_18_0:IsOpenSectionView() then
		JumpTools.Back()
	end
end

function var_0_0.RefreshSelectStageItem(arg_19_0, arg_19_1)
	arg_19_0.selectStageID_ = arg_19_1

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.stageItemList_) do
		iter_19_1:RefreshSelect(arg_19_0.selectStageID_)
	end
end

function var_0_0.RefreshAffixItem(arg_20_0)
	arg_20_0.affixIDList_ = ActivityRaceCfg[arg_20_0.activityID_].buff_pool
	arg_20_0.unlockAffixList_ = ActivityRaceData:GetUnlockAffixList(arg_20_0.activityID_)

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.affixIDList_) do
		if arg_20_0.affixItemList_[iter_20_0] == nil then
			arg_20_0.affixItemList_[iter_20_0] = ActivityRaceAffixItem.New(arg_20_0.affixItemTemplate_, arg_20_0.affixpanelTrans_)
		end

		local var_20_0 = arg_20_0.unlockAffixList_[iter_20_1] ~= nil
		local var_20_1

		if var_20_0 == true then
			var_20_1 = ActivityAffixPoolCfg[arg_20_0.unlockAffixList_[iter_20_1]].affix[2]
		end

		arg_20_0.affixItemList_[iter_20_0]:SetData(iter_20_0, iter_20_1, var_20_1, var_20_0)
		arg_20_0.affixItemList_[iter_20_0]:RegistSelectCallBack(arg_20_0.selectAffixItemHandler_)
	end

	for iter_20_2 = #arg_20_0.affixItemList_, #arg_20_0.affixIDList_ + 1, -1 do
		arg_20_0.affixItemList_[iter_20_2]:SetActive(false)
	end
end

function var_0_0.IndexItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.affixIDList_[arg_21_1]
	local var_21_1 = arg_21_0.unlockAffixList_[var_21_0] ~= nil
	local var_21_2

	if var_21_1 == true then
		var_21_2 = arg_21_0.unlockAffixList_[var_21_0][2]
	end

	arg_21_2:SetData(arg_21_1, var_21_0, var_21_2, var_21_1)
	arg_21_2:RegistSelectCallBack(arg_21_0.selectAffixItemHandler_)
end

function var_0_0.RefreshRaceBuff(arg_22_0)
	local var_22_0 = ActivityRaceCfg[arg_22_0.activityID_].race_buff

	arg_22_0.raceBuffDesc.text = GetI18NText(getAffixDesc(ActivityAffixPoolCfg[var_22_0].affix))
end

function var_0_0.OnSelectAffixItem(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_3 = arg_23_3 and arg_23_3 or 1

	if arg_23_0:IsOpenSectionView() then
		JumpTools.Back()
	end

	arg_23_0.affixinfoTrs_:SetParent(arg_23_0.affixItemList_[arg_23_1].transform_)

	arg_23_0.affixinfoTrs_.localPosition = Vector3(0, 0, 0)

	arg_23_0.affixinfoTrs_:SetParent(arg_23_0.transform_)

	local var_23_0 = AffixTypeCfg[arg_23_2]

	if var_23_0 == nil then
		-- block empty
	end

	arg_23_0.affixcontentText_.text = GetI18NText(GetCfgDescription(var_23_0.description[1], arg_23_3))
	arg_23_0.affixnameText_.text = GetI18NText(var_23_0.name)

	if arg_23_0.countdownTimer_ then
		arg_23_0.countdownTimer_:Stop()

		arg_23_0.countdownTimer_ = nil
	end

	arg_23_0.countdownTimer_ = Timer.New(function()
		SetActive(arg_23_0.affixinfoTrs_.gameObject, false)
	end, 2, 1)

	arg_23_0.countdownTimer_:Start()
	SetActive(arg_23_0.affixinfoTrs_.gameObject, true)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_0.affixInfoDescTrans_)
end

function var_0_0.IsOpenSectionView(arg_25_0)
	return arg_25_0:IsOpenRoute("activityRaceSectionInfo")
end

function var_0_0.RegisterRedPoint(arg_26_0)
	local var_26_0 = ActivityRaceCfg[arg_26_0.activityID_].main_activity_id

	manager.redPoint:bindUIandKey(arg_26_0.rewardBtnTrans_, string.format("%s_%s_%s_reward", RedPointConst.ACTIVITY_RACE, var_26_0, arg_26_0.activityID_))
end

function var_0_0.UnRegisterRedPoint(arg_27_0)
	local var_27_0 = ActivityRaceCfg[arg_27_0.activityID_].main_activity_id

	manager.redPoint:unbindUIandKey(arg_27_0.rewardBtnTrans_, string.format("%s_%s_%s_reward", RedPointConst.ACTIVITY_RACE, var_27_0, arg_27_0.activityID_))
end

return var_0_0
