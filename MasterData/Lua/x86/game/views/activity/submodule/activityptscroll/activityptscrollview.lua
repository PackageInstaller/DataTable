local ActivityPtScrollView = class("ActivityPtScrollView", ReduxView)

function ActivityPtScrollView:UIName()
	return ActivityPtScrollTools.GetMainUIName(self.params_.mainActivityID)
end

function ActivityPtScrollView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityPtScrollView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityPtScrollView:InitUI()
	self:BindCfgUI()
	self:RefreshShop()

	self.normalBtn_ = {}
	self.challengeBtn_ = {}
	self.normalCon_ = {}
	self.challengeCon_ = {}
	self.normalLevel_ = {}
	self.challengeLevel_ = {}

	for iter_4_0, iter_4_1 in ipairs(ActivityPtRouletteStageCfg.get_id_list_by_activity_id[self.params_.mainActivityID]) do
		if ActivityPtRouletteStageCfg[iter_4_1].mode == 1 then
			table.insert(self.normalLevel_, ActivityPtRouletteStageCfg[iter_4_1].stage_id)
		else
			table.insert(self.challengeLevel_, ActivityPtRouletteStageCfg[iter_4_1].stage_id)
		end
	end

	for iter_4_2, iter_4_3 in ipairs(self.normalLevel_) do
		table.insert(self.normalBtn_, self["normalBtn_" .. iter_4_2])
		table.insert(self.normalCon_, ControllerUtil.GetController(self["normalBtn_" .. iter_4_2].transform, "status"))
	end

	for iter_4_4, iter_4_5 in ipairs(self.challengeLevel_) do
		table.insert(self.challengeBtn_, self["challengeBtn_" .. iter_4_4])
		table.insert(self.challengeCon_, ControllerUtil.GetController(self["challengeBtn_" .. iter_4_4].transform, "status"))
	end

	self.tgl_ = {
		self.tgl_1,
		self.tgl_2
	}
	self.typeCon_ = ControllerUtil.GetController(self.gameObject_.transform, "type")
	self.indexCon_ = ControllerUtil.GetController(self.gameObject_.transform, "index")
end

function ActivityPtScrollView:AddUIListeners()
	self:AddBtnListener(self.shopBtn_, nil, function()
		if self:IsOpenSectionView() then
			JumpTools.Back()
			self:ResetSelect()
		end

		local var_6_0 = ActivityShopCfg[ActivityPtScrollTools.GetShopActivityID(self.mainActivityID_)]
		local var_6_1 = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[var_6_0.activity_theme]) do
			local var_6_2 = ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[iter_6_1].shop_id].activity_id)

			if var_6_2 and var_6_2:IsActivitying() then
				table.insert(var_6_1, ActivityShopCfg[iter_6_1].shop_id)
			end
		end

		local var_6_3, var_6_4 = ShopTools.IsShopOpen(var_6_0.shop_id)

		if var_6_3 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = var_6_0.shop_id,
				showShops = var_6_1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_6_4 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_6_4 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	self:AddBtnListener(self.buffBtn_, nil, function()
		JumpTools.OpenPageByJump("activityPtScrollPop", {
			isScroll = false,
			mainActivityID = self.mainActivityID_
		})
	end)
	self:AddBtnListener(self.affixBtn_, nil, function()
		JumpTools.OpenPageByJump("activityPtScrollAffixSelect", {
			mainActivityID = self.mainActivityID_
		})
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		if self:IsOpenSectionView() then
			JumpTools.Back()
			self:ResetSelect()
		end
	end)

	for iter_5_0, iter_5_1 in ipairs(self.tgl_) do
		self:AddToggleListener(iter_5_1, function(arg_10_0)
			if arg_10_0 then
				if self:IsOpenSectionView() then
					self.tgl_[self.index_].isOn = true

					return
				end

				if iter_5_0 ~= self.index_ then
					self.index_ = iter_5_0
				end

				if self.index_ == 2 then
					self:CheckScroll()
				end

				self.indexCon_:SetSelectedState(0)
				self.typeCon_:SetSelectedState(iter_5_0)
				ActivityPtScrollData:SetLastStage(self.mainActivityID_, iter_5_0, 1)
			end
		end)
	end

	for iter_5_2, iter_5_3 in ipairs(self.normalBtn_) do
		self:AddBtnListener(iter_5_3, nil, function()
			if manager.time:GetServerTime() >= self.stopTime_ then
				ShowTips("TIME_OVER")

				return
			end

			self:EnterLevel(1, iter_5_2)
		end)
	end

	for iter_5_4, iter_5_5 in ipairs(self.challengeBtn_) do
		self:AddBtnListener(iter_5_5, nil, function()
			if manager.time:GetServerTime() >= self.stopTime_ then
				ShowTips("TIME_OVER")

				return
			end

			self:EnterLevel(2, iter_5_4)
		end)
	end

	if self.eventTrigger_ then
		self.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_13_0, arg_13_1)
			if self:IsOpenSectionView() then
				JumpTools.Back()
			end

			self.drag_ = true
		end))
		self.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_14_0, arg_14_1)
			self.drag_ = false
		end))
	end
end

function ActivityPtScrollView:OnEnter()
	if self.mainActivityID_ and self.mainActivityID_ ~= self.params_.mainActivityID then
		self.mainActivityID_ = self.params_.mainActivityID

		self:ReLoad()
	end

	self:RefreshUI()
end

function ActivityPtScrollView:ReLoad()
	if self.gameObject_ then
		self:Dispose()
		Object.Destroy(self.gameObject_)
	end

	self.gameObject_ = Object.Instantiate(Asset.Load(self:UIName()), self:UIParent())
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityPtScrollView:RefreshUI()
	self:RefreshData()
	self:RefreshTime()
	self:RefreshState()
	self:BindRedPointUI()
end

function ActivityPtScrollView:RefreshData()
	self.mainActivityID_ = self.params_.mainActivityID
	self.activityID_ = ActivityPtScrollTools.GetLevelActivityID(self.mainActivityID_)
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
end

function ActivityPtScrollView:RefreshTime()
	local var_19_0 = ActivityData:GetActivityData(self.mainActivityID_).stopTime
	local var_19_1 = manager.time:GetServerTime()

	self:StopTimer()

	if var_19_1 < self.startTime_ then
		SetActive(self.shopTimeGo_, false)

		self.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			if self.startTime_ <= manager.time:GetServerTime() then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_19_1 < var_19_0 then
		self.timeLable_.text = var_19_1 < self.stopTime_ and manager.time:GetLostTimeStrWith2Unit(self.stopTime_) or GetTips("TIME_OVER")

		if GameSetting.time_remaining_show.value[1] * 86400 > var_19_0 - var_19_1 then
			self.shopTimeLable_.text = manager.time:GetLostTimeStr2(var_19_0, nil, false)

			SetActive(self.shopTimeGo_, true)
		else
			SetActive(self.shopTimeGo_, false)
		end

		self.timer_ = Timer.New(function()
			var_19_1 = manager.time:GetServerTime()

			if var_19_0 <= var_19_1 then
				self:StopTimer()
				self:RefreshTime()

				return
			end

			self.timeLable_.text = var_19_1 < self.stopTime_ and manager.time:GetLostTimeStrWith2Unit(self.stopTime_) or GetTips("TIME_OVER")

			if GameSetting.time_remaining_show.value[1] * 86400 > var_19_0 - var_19_1 then
				self.shopTimeLable_.text = manager.time:GetLostTimeStr2(var_19_0, nil, false)

				SetActive(self.shopTimeGo_, true)
			else
				SetActive(self.shopTimeGo_, false)
			end
		end, 1, -1)

		self.timer_:Start()
	else
		SetActive(self.shopTimeGo_, true)

		self.timeLable_.text = GetTips("TIME_OVER")
		self.shopTimeLable_.text = GetTips("TIME_OVER")
	end
end

function ActivityPtScrollView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityPtScrollView:RefreshState()
	self:RefreshLevel()
	self:RefreshReward()
	self:RefreshBuff()
	self:RefreshServant()
end

function ActivityPtScrollView:RefreshLevel()
	local var_24_0 = ActivityPtScrollData:GetLastStage(self.mainActivityID_)

	if var_24_0 then
		self.index_ = var_24_0.type or 1
	end

	self.typeCon_:SetSelectedState(self.index_)

	self.tgl_[self.index_].isOn = true
	self.selectLevel_ = 0

	if self:IsOpenSectionView() and var_24_0 then
		self.selectLevel_ = var_24_0.index

		ActivityPtScrollData:SetLastStage(self.mainActivityID_, var_24_0.type, var_24_0.index)
		self.indexCon_:SetSelectedState(var_24_0.type .. "_" .. var_24_0.index)
	else
		self.indexCon_:SetSelectedState(0)
	end

	if self.index_ == 2 then
		self:CheckScroll()
	end
end

function ActivityPtScrollView:RefreshReward()
	local var_25_0 = ActivityPtScrollData:GetClearList(self.mainActivityID_)

	for iter_25_0, iter_25_1 in ipairs(self.normalLevel_) do
		if table.indexof(var_25_0, iter_25_1) then
			self.normalCon_[iter_25_0]:SetSelectedState("get")
		else
			self.normalCon_[iter_25_0]:SetSelectedState("nor")
		end
	end

	for iter_25_2, iter_25_3 in ipairs(self.challengeLevel_) do
		if table.indexof(var_25_0, iter_25_3) then
			self.challengeCon_[iter_25_2]:SetSelectedState("get")
		else
			self.challengeCon_[iter_25_2]:SetSelectedState("nor")
		end
	end
end

function ActivityPtScrollView:RefreshBuff()
	local var_26_0 = ActivityPtScrollData:GetAffixInfo(self.mainActivityID_, (ActivityPtScrollData:GetChooseAffixID(self.mainActivityID_)))

	if var_26_0.useless then
		self.buffIcon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.AffixIcon.path .. ActivityPtRouletteTipsCfg[var_26_0.affix].icon)
		self.buffText_.text = ActivityPtRouletteTipsCfg[var_26_0.affix].desc
	else
		self.buffIcon_.sprite = getAffixSprite({
			var_26_0.affix
		})
		self.buffText_.text = getAffixDesc({
			var_26_0.affix,
			var_26_0.level
		})
	end
end

function ActivityPtScrollView:RefreshServant()
	local var_27_0, var_27_1 = ActivityPtScrollData:GetUpSelect(self.mainActivityID_)

	if EquipSuitCfg[var_27_1] then
		self.keyText_.text = EquipSuitCfg[var_27_1].name

		SetSpriteWithoutAtlasAsync(self.keyIcon_, SpritePathCfg.EquipIcon_s.path .. var_27_1)
	end
end

function ActivityPtScrollView:CheckScroll()
	if (getData("activityPtScroll", "last_scroll_time") or 0) < manager.time:GetTodayFreshTime() then
		JumpTools.OpenPageByJump("activityPtScrollPop", {
			isScroll = true,
			mainActivityID = self.mainActivityID_
		})
		saveData("activityPtScroll", "last_scroll_time", (manager.time:GetServerTime()))
	end
end

function ActivityPtScrollView:EnterLevel(arg_29_1, arg_29_2)
	self.selectLevel_ = arg_29_2

	ActivityPtScrollData:SetLastStage(self.mainActivityID_, arg_29_1, arg_29_2)
	self.indexCon_:SetSelectedState(arg_29_1 .. "_" .. arg_29_2)
	JumpTools.OpenPageByJump("activityPtScrollSectionInfo", {
		section = (arg_29_1 == 1 or nil) and (self.normalLevel_[arg_29_2] or self.challengeLevel_[arg_29_2]),
		sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL,
		mainActivityID = self.mainActivityID_,
		activityId = self.mainActivityID_,
		backCall = handler(self, self.ResetSelect)
	})
end

function ActivityPtScrollView:ResetSelect()
	self.indexCon_:SetSelectedState(0)

	self.selectLevel_ = 0
end

function ActivityPtScrollView:IsOpenSectionView()
	return self:IsOpenRoute("activityPtScrollSectionInfo")
end

function ActivityPtScrollView:OnSetSelectSuit()
	self:RefreshServant()
end

function ActivityPtScrollView:RefreshShop()
	self.shopName_.text = ShopListCfg[ActivityShopCfg[ActivityPtScrollTools.GetShopActivityID(self.params_.mainActivityID)].shop_id].remark
end

function ActivityPtScrollView:BindRedPointUI()
	manager.redPoint:bindUIandKey(self.upRect_, RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. self.mainActivityID_)
	manager.redPoint:bindUIandKey(self.tgl_2.transform, RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. self.mainActivityID_)
end

function ActivityPtScrollView:UnbindRedPointUI()
	manager.redPoint:unbindUIandKey(self.upRect_, RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. self.mainActivityID_)
	manager.redPoint:unbindUIandKey(self.tgl_2.transform, RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. self.mainActivityID_)
end

function ActivityPtScrollView:OnTop()
	local var_36_0 = ActivityPtScrollTools.GetHelpKey(self.mainActivityID_)
	local var_36_1 = ActivityPtScrollTools.GetChallengeCurrencyID(self.mainActivityID_)

	if var_36_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR,
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			var_36_1,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
		manager.windowBar:SetGameHelpKey(var_36_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			var_36_1,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
	end

	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanClick(var_36_1, true)
end

function ActivityPtScrollView:OnExit()
	self:StopTimer()
	self:UnbindRedPointUI()
	manager.windowBar:HideBar()
	self.indexCon_:SetSelectedState(-1)
end

function ActivityPtScrollView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivityPtScrollView
