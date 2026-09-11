local ActivityPtView = class("ActivityPtView", ReduxView)

function ActivityPtView:UIName()
	return ActivityPtTools.GetMainUIName(self.params_.activityID)
end

function ActivityPtView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityPtView:OnCtor()
	return
end

function ActivityPtView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityPtView:InitUI()
	self:BindCfgUI()

	self.indexController_ = ControllerUtil.GetController(self.gameObject_.transform, "index")
	self.btns_ = {}
	self.selectedControllers_ = {}

	for iter_5_0, iter_5_1 in ipairs(ActivityPtRepeatCfg.get_id_list_by_activity_id[self.params_.activityID]) do
		table.insert(self.btns_, self["btn" .. iter_5_0 .. "_"])
		table.insert(self.selectedControllers_, ControllerUtil.GetController(self["btn" .. iter_5_0 .. "_"].transform, "status"))
	end
end

function ActivityPtView:AddUIListener()
	self.indexController_:AddSelectChangeListener(function(arg_7_0)
		self:SelectIndex(arg_7_0)
	end)
	self:AddBtnListener(self.exchangeBtn_, nil, function()
		if self:IsOpenSectionView() then
			JumpTools.Back()
			self.indexController_:SetSelectedIndex(0)
		end

		local var_8_0 = ActivityShopCfg[self.params_.activityID]
		local var_8_1 = {}

		for iter_8_0, iter_8_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[ActivityShopCfg[self.params_.activityID].activity_theme]) do
			local var_8_2 = ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[iter_8_1].shop_id].activity_id)

			if var_8_2 and var_8_2:IsActivitying() then
				table.insert(var_8_1, ActivityShopCfg[iter_8_1].shop_id)
			end
		end

		local var_8_3, var_8_4 = ShopTools.IsShopOpen(var_8_0.shop_id)

		if var_8_3 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = var_8_0.shop_id,
				showShops = var_8_1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_8_4 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_8_4 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)

	for iter_6_0, iter_6_1 in ipairs(self.btns_) do
		self:AddBtnListener(iter_6_1, nil, function()
			if not ActivityData:GetActivityData(self.params_.activityID):IsActivitying() then
				ShowTips("SOLO_TIME_OVER")

				return
			end

			self:EnterLevel(iter_6_0)
		end)
	end

	self:AddBtnListener(self.bgBtn_, nil, function()
		if self:IsOpenSectionView() then
			JumpTools.Back()
			self.indexController_:SetSelectedIndex(0)
		end
	end)

	if self.eventTrigger_ then
		self.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_11_0, arg_11_1)
			if self:IsOpenSectionView() then
				JumpTools.Back()
			end

			self.drag_ = true
		end))
		self.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_12_0, arg_12_1)
			self.drag_ = false
		end))
	end
end

function ActivityPtView:SelectIndex(arg_13_1)
	if arg_13_1 == 0 then
		-- block empty
	end
end

function ActivityPtView:EnterLevel(arg_14_1)
	self.indexController_:SetSelectedIndex(arg_14_1)
	JumpTools.OpenPageByJump("activityPtSectionInfo", {
		index = arg_14_1,
		section = ActivityPtRepeatCfg[ActivityPtRepeatCfg.get_id_list_by_activity_id[self.params_.activityID][arg_14_1]].stage_id,
		sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_GAME,
		activityID = self.params_.activityID,
		repeat_id = ActivityPtRepeatCfg.get_id_list_by_activity_id[self.params_.activityID][arg_14_1]
	})
end

function ActivityPtView:AddEventListeners()
	return
end

function ActivityPtView:OnTop()
	self:UpdateBar()
	self.indexController_:SetSelectedIndex(0)
end

function ActivityPtView:OnBehind()
	manager.windowBar:HideBar()
end

function ActivityPtView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:RegistBackCallBack(function()
		if self:IsOpenSectionView() then
			JumpTools.Back()
			self.indexController_:SetSelectedIndex(0)
		else
			JumpTools.Back()
		end
	end)
	manager.windowBar:SetGameHelpKey((ActivityPtTools.GetHelpKey(self.params_.activityID)))
end

function ActivityPtView:OnEnter()
	if not self.activityID_ or self.activityID_ ~= self.params_.activityID then
		self.activityID_ = self.params_.activityID

		self:ReLoad()
	end

	self:AddEventListeners()
	self:PlayEnterVoice()
	saveData("activity_pt_" .. self.params_.activityID, "opened", 1)
	manager.redPoint:setTip(RedPointConst.SUMMER_ACTIVITY_PT_OPEN .. "_" .. self.params_.activityID, 0)

	if self.params_.index then
		self.indexController_:SetSelectedIndex(self.params_.index)
	end

	self:RefreshTime()

	for iter_20_0, iter_20_1 in ipairs(self.selectedControllers_) do
		if SummerActivityPtData:GetLevelChallengeCount(ActivityPtRepeatCfg.get_id_list_by_activity_id[self.params_.activityID][iter_20_0]) > 0 then
			iter_20_1:SetSelectedIndex(1)
		else
			iter_20_1:SetSelectedIndex(0)
		end
	end
end

function ActivityPtView:ReLoad()
	if self.gameObject_ then
		self:Dispose()
		Object.Destroy(self.gameObject_)
	end

	self.gameObject_ = Object.Instantiate(Asset.Load(self:UIName()), self:UIParent())
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityPtView:PlayEnterVoice()
	local var_22_0, var_22_1, var_22_2, var_22_3 = ActivityPtTools.GetEnterVoice(self.params_.activityID)

	if var_22_0 then
		manager.audio:PlayEffect(var_22_1, var_22_2, var_22_3)
	end
end

function ActivityPtView:RefreshTime()
	local var_23_0
	local var_23_1 = manager.time:GetServerTime()
	local var_23_2 = ActivityData:GetActivityData(self.params_.activityID)
	local var_23_3 = var_23_2.startTime
	local var_23_4 = var_23_2.stopTime
	local var_23_5 = ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[self.params_.activityID].shop_id].activity_id).stopTime
	local var_23_6 = var_23_5 - var_23_1

	self:StopTimer()

	if var_23_1 < var_23_2.startTime and var_23_2:IsActivitying() == false then
		self.timeLabel_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			var_23_0 = var_23_3 - manager.time:GetServerTime()

			if var_23_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_23_1 < var_23_2.stopTime or var_23_1 < var_23_5 then
		self.timeLabel_.text = var_23_1 < var_23_2.stopTime and manager.time:GetLostTimeStr2(var_23_2.stopTime) or GetTips("TIME_OVER")

		if self.shopTimeGo_ then
			if var_23_6 <= GameSetting.time_remaining_show.value[1] * 86400 then
				self.shopTimeLabel_.text = manager.time:GetLostTimeStr2(var_23_5)

				SetActive(self.shopTimeGo_, true)
			else
				SetActive(self.shopTimeGo_, false)
			end
		end

		self.timer_ = Timer.New(function()
			var_23_1 = manager.time:GetServerTime()
			var_23_0 = var_23_4 - var_23_1
			var_23_6 = var_23_5 - var_23_1

			if var_23_0 <= 0 and var_23_6 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end

			self.timeLabel_.text = var_23_1 < var_23_4 and manager.time:GetLostTimeStr2(var_23_4) or GetTips("TIME_OVER")

			if self.shopTimeGo_ then
				if var_23_6 <= GameSetting.time_remaining_show.value[1] * 86400 then
					self.shopTimeLabel_.text = manager.time:GetLostTimeStr2(var_23_5)

					SetActive(self.shopTimeGo_, true)
				else
					SetActive(self.shopTimeGo_, false)
				end
			end
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeLabel_.text = GetTips("TIME_OVER")
		self.shopTimeLabel_.text = GetTips("TIME_OVER")
	end
end

function ActivityPtView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityPtView:OnExit()
	self:StopTimer()
	manager.audio:Stop("effect")
	self.indexController_:SetSelectedState(-1)
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function ActivityPtView:OnMainHomeViewTop()
	return
end

function ActivityPtView:IsOpenSectionView()
	return self:IsOpenRoute("activityPtSectionInfo")
end

function ActivityPtView:Dispose()
	ActivityPtView.super.Dispose(self)
end

return ActivityPtView
