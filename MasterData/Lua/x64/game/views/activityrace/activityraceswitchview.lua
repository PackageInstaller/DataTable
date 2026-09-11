local ActivityRaceSwitchView = class("ActivityRaceSwitchView", ReduxView)

function ActivityRaceSwitchView:UIName()
	return "UI/VolumeIIIDownUI/ActivityRace/ActivityRaceSwitchUI"
end

function ActivityRaceSwitchView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityRaceSwitchView:Init()
	self:InitUI()
	self:AddUIListener()

	self.selectStageItemHandler_ = handler(self, self.OnSelectStageItem)
	self.selectAffixItemHandler_ = handler(self, self.OnSelectAffixItem)
end

function ActivityRaceSwitchView:InitUI()
	self:BindCfgUI()

	self.raceController_ = ControllerUtil.GetController(self.transform_, "race")
	self.indexController_ = ControllerUtil.GetController(self.gameObject_.transform, "index")
	self.stageItemList_ = {}

	for iter_4_0 = 1, self.stagePanelTrans_.childCount do
		self.stageItemList_[iter_4_0] = ActivityRaceStageItem.New(self.stagePanelTrans_:GetChild(iter_4_0 - 1).gameObject)
	end

	self.affixItemList_ = {}
end

function ActivityRaceSwitchView:AddUIListener()
	self:AddBtnListener(self.shopBtn_, nil, function()
		if self:IsOpenSectionView() then
			JumpTools.Back()
			self.indexController_:SetSelectedIndex(0)
			self:RefreshSelectStageItem(0)
		end

		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_6_0 = ActivityShopCfg[ActivityRaceCfg[self.activityID_].main_activity_id]
		local var_6_1 = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[ActivityShopCfg[ActivityRaceCfg[self.activityID_].main_activity_id].activity_theme]) do
			table.insert(var_6_1, ActivityShopCfg[iter_6_1].shop_id)
		end

		local var_6_2, var_6_3 = ShopTools.IsShopOpen(var_6_0.shop_id)

		if var_6_2 then
			JumpTools.GoToSystem("/shop", {
				shopId = var_6_0.shop_id,
				showShops = var_6_1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_6_3 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_6_3 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if self:IsOpenSectionView() then
			JumpTools.Back()
			self.indexController_:SetSelectedIndex(0)
			self:RefreshSelectStageItem(0)
		end

		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("activityRaceRewardPanel", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		if self:IsOpenSectionView() then
			JumpTools.Back()
			self.indexController_:SetSelectedIndex(0)
			self:RefreshSelectStageItem(0)
		end
	end)
	self.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		if self:IsOpenSectionView() then
			JumpTools.Back()
		end
	end))
end

function ActivityRaceSwitchView:OnEnter()
	self.indexController_:SetSelectedIndex(0)
	self:RefreshSelectStageItem(0)

	self.activityID_ = self.params_.activityID
	self.stageIDList_ = ActivityRaceCfg[self.activityID_].stage_list
	self.unlockStageList_ = ActivityRaceData:GetStateList()[self.activityID_].unlockStageList

	self:RegisterRedPoint()
	self:RefreshUI()
end

function ActivityRaceSwitchView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_RACE_DESCRIPE")
	manager.windowBar:RegistBackCallBack(function()
		if self:IsOpenSectionView() then
			JumpTools.Back()
			self.indexController_:SetSelectedIndex(0)
			self:RefreshSelectStageItem(0)
		else
			JumpTools.Back()
		end
	end)
end

function ActivityRaceSwitchView:OnExit()
	manager.windowBar:HideBar()

	for iter_13_0, iter_13_1 in ipairs(self.stageItemList_) do
		iter_13_1:OnExit()
	end

	self:UnRegisterRedPoint()
	SetActive(self.affixinfoTrs_.gameObject, false)

	if self.countdownTimer_ then
		self.countdownTimer_:Stop()

		self.countdownTimer_ = nil
	end

	self.selectStageID_ = nil
end

function ActivityRaceSwitchView:Dispose()
	for iter_14_0, iter_14_1 in ipairs(self.stageItemList_) do
		iter_14_1:Dispose()
	end

	for iter_14_2, iter_14_3 in ipairs(self.affixItemList_) do
		iter_14_3:Dispose()
	end

	self.affixItemList_ = nil
	self.selectStageItemHandler_ = nil
	self.selectAffixItemHandler_ = nil

	self.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	ActivityRaceSwitchView.super.Dispose(self)
end

function ActivityRaceSwitchView:RefreshUI()
	self:RefreshStageItem()
	self:RefreshAffixItem()
	self:RefreshRaceBuff()
	self:RefreshTitle()
end

function ActivityRaceSwitchView:RefreshTitle()
	local var_16_0 = ActivityRaceCfg[self.activityID_].map_title_icon

	if SDKTools.GetIsOverSea() then
		var_16_0 = var_16_0 .. "@" .. SettingData:GetCurrentLanguage()
	end

	self.titleIcon_.sprite = getSprite("Atlas/VolumeIIIDownUI", var_16_0)

	self.titleIcon_:SetNativeSize()
	self.raceController_:SetSelectedState(tostring(ActivityRaceCfg[self.activityID_].race_id))
end

function ActivityRaceSwitchView:RefreshStageItem()
	for iter_17_0, iter_17_1 in ipairs(self.stageItemList_) do
		iter_17_1:SetData(self.activityID_, self.stageIDList_[iter_17_0], iter_17_0, self.unlockStageList_[self.stageIDList_[iter_17_0]] == nil)
		iter_17_1:SetSelectCallBack(self.selectStageItemHandler_)
	end
end

function ActivityRaceSwitchView:OnSelectStageItem(arg_18_1, arg_18_2)
	self.indexController_:SetSelectedIndex(arg_18_1)
	self:RefreshSelectStageItem(arg_18_2)

	if self:IsOpenSectionView() then
		JumpTools.Back()
	end
end

function ActivityRaceSwitchView:RefreshSelectStageItem(arg_19_1)
	self.selectStageID_ = arg_19_1

	for iter_19_0, iter_19_1 in ipairs(self.stageItemList_) do
		iter_19_1:RefreshSelect(self.selectStageID_)
	end
end

function ActivityRaceSwitchView:RefreshAffixItem()
	self.affixIDList_ = ActivityRaceCfg[self.activityID_].buff_pool
	self.unlockAffixList_ = ActivityRaceData:GetUnlockAffixList(self.activityID_)

	for iter_20_0, iter_20_1 in ipairs(self.affixIDList_) do
		if self.affixItemList_[iter_20_0] == nil then
			self.affixItemList_[iter_20_0] = ActivityRaceAffixItem.New(self.affixItemTemplate_, self.affixpanelTrans_)
		end

		self.affixItemList_[iter_20_0]:SetData(iter_20_0, iter_20_1, (self.unlockAffixList_[iter_20_1] ~= nil == true or nil) and ActivityAffixPoolCfg[self.unlockAffixList_[iter_20_1]].affix[2], self.unlockAffixList_[iter_20_1] ~= nil)
		self.affixItemList_[iter_20_0]:RegistSelectCallBack(self.selectAffixItemHandler_)
	end

	for iter_20_2 = #self.affixItemList_, #self.affixIDList_ + 1, -1 do
		self.affixItemList_[iter_20_2]:SetActive(false)
	end
end

function ActivityRaceSwitchView:IndexItem(arg_21_1, arg_21_2)
	local var_21_0 = self.affixIDList_[arg_21_1]

	arg_21_2:SetData(arg_21_1, var_21_0, (self.unlockAffixList_[self.affixIDList_[arg_21_1]] ~= nil == true or nil) and self.unlockAffixList_[var_21_0][2], self.unlockAffixList_[self.affixIDList_[arg_21_1]] ~= nil)
	arg_21_2:RegistSelectCallBack(self.selectAffixItemHandler_)
end

function ActivityRaceSwitchView:RefreshRaceBuff()
	self.raceBuffDesc.text = GetI18NText(getAffixDesc(ActivityAffixPoolCfg[ActivityRaceCfg[self.activityID_].race_buff].affix))
end

function ActivityRaceSwitchView:OnSelectAffixItem(arg_23_1, arg_23_2, arg_23_3)
	arg_23_3 = arg_23_3 and arg_23_3 or 1

	if self:IsOpenSectionView() then
		JumpTools.Back()
	end

	self.affixinfoTrs_:SetParent(self.affixItemList_[arg_23_1].transform_)

	self.affixinfoTrs_.localPosition = Vector3(0, 0, 0)

	self.affixinfoTrs_:SetParent(self.transform_)

	if AffixTypeCfg[arg_23_2] == nil then
		-- block empty
	end

	self.affixcontentText_.text = GetI18NText(GetCfgDescription(AffixTypeCfg[arg_23_2].description[1], arg_23_3))
	self.affixnameText_.text = GetI18NText(AffixTypeCfg[arg_23_2].name)

	if self.countdownTimer_ then
		self.countdownTimer_:Stop()

		self.countdownTimer_ = nil
	end

	self.countdownTimer_ = Timer.New(function()
		SetActive(self.affixinfoTrs_.gameObject, false)
	end, 2, 1)

	self.countdownTimer_:Start()
	SetActive(self.affixinfoTrs_.gameObject, true)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.affixInfoDescTrans_)
end

function ActivityRaceSwitchView:IsOpenSectionView()
	return self:IsOpenRoute("activityRaceSectionInfo")
end

function ActivityRaceSwitchView:RegisterRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtnTrans_, string.format("%s_%s_%s_reward", RedPointConst.ACTIVITY_RACE, ActivityRaceCfg[self.activityID_].main_activity_id, self.activityID_))
end

function ActivityRaceSwitchView:UnRegisterRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardBtnTrans_, string.format("%s_%s_%s_reward", RedPointConst.ACTIVITY_RACE, ActivityRaceCfg[self.activityID_].main_activity_id, self.activityID_))
end

return ActivityRaceSwitchView
