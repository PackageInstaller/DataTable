local ActivityMainToggleBaseView = class("ActivityMainToggleBaseView", ReduxView)

ActivityMainToggleBaseView.IsCommonMainActivityPage = true
ActivityMainToggleBaseView.MAX_CACHE_PANEL_CNT = 4

function ActivityMainToggleBaseView:UIName()
	return ActivityEntraceCfg[self:GetActivityID()].prefab_path
end

function ActivityMainToggleBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityMainToggleBaseView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.toggleClickHandler_ = handler(self, self.ToggleOnClick)
	self.toggleOverHandler_ = handler(self, self.ToggleOver)
	self.toggleItemList_ = {}
	self.panelItemList_ = {}
	self.activeItemList_ = {}
	self.activePanelList_ = {}
	self.cachePanelList_ = {}
end

function ActivityMainToggleBaseView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INVITE_BAR
	})
	manager.notify:RegistListener(ACTIVITY_MAIN_TOGGLE_CLICK, self.toggleClickHandler_)
	manager.notify:RegistListener(ACTIVITY_MAIN_TOGGLE_OVER, self.toggleOverHandler_)

	for iter_4_0, iter_4_1 in pairs(self.toggleItemList_) do
		iter_4_1:Show(false)
	end

	self.activeItemList_ = {}

	for iter_4_2, iter_4_3 in ipairs((self:GetSortToggle(ActivityToggleCfg.get_id_list_by_activity_theme[self:GetActivityTheme()] or {}))) do
		local var_4_0 = ActivityData:GetActivityData(iter_4_3.activity_id)

		self.toggleItemList_[iter_4_3.activity_id] = self.toggleItemList_[iter_4_3.activity_id] or ActivityMainToggleItem.New(self.itemGo_, self.itemParentGo_, iter_4_3.id, iter_4_3.activity_id, var_4_0.template == ActivityTemplateConst.ACTIVITY_ADVANCE_OPEN and var_4_0.subActivityIdList[1] or iter_4_3.activity_id)

		self.toggleItemList_[iter_4_3.activity_id]:Show(true)

		self.activeItemList_[iter_4_3.activity_id] = true
	end

	for iter_4_4, iter_4_5 in pairs(self.activeItemList_) do
		self.toggleItemList_[iter_4_4]:OnEnter()
	end

	self.activePanelList_ = {}

	local var_4_3 = self.params_.isBack and ActivityVersionData:GetSelectActivityID(self:GetActivityID()) or self.params_.subActivityID and self.params_.subActivityID or self:GetOpenActivityID()

	if var_4_3 == nil then
		self:Go("/home")

		return
	end

	self:ScrollToggle(var_4_3)
	self:ToggleOnClick(var_4_3, true)
	self:UpdateUIArrow()
end

function ActivityMainToggleBaseView:OnTop()
	local var_5_0 = ActivityVersionData:GetSelectActivityID(self:GetActivityID())

	if var_5_0 == nil then
		return
	end

	if self.panelItemList_[var_5_0] then
		self.panelItemList_[var_5_0]:OnTop()

		if self.panelItemList_[var_5_0].UpdateBar then
			self.panelItemList_[var_5_0]:UpdateBar()
		end
	end
end

function ActivityMainToggleBaseView:OnUpdate()
	if not self.params_.subActivityID or ActivityVersionData:GetSelectActivityID(self:GetActivityID()) == self.params_.subActivityID then
		return
	end

	self:ScrollToggle(self.params_.subActivityID)
	self:ToggleOnClick(self.params_.subActivityID, true)
end

function ActivityMainToggleBaseView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(ACTIVITY_MAIN_TOGGLE_CLICK, self.toggleClickHandler_)
	manager.notify:RemoveListener(ACTIVITY_MAIN_TOGGLE_OVER, self.toggleOverHandler_)

	for iter_7_0, iter_7_1 in pairs(self.activeItemList_) do
		self.toggleItemList_[iter_7_0]:OnExit()
	end

	for iter_7_2, iter_7_3 in pairs(self.activePanelList_) do
		self.panelItemList_[iter_7_2]:Show(false)
		self.panelItemList_[iter_7_2]:OnExit()
	end
end

function ActivityMainToggleBaseView:Dispose()
	ActivityMainToggleBaseView.super.Dispose(self)

	self.toggleClickHandler_ = nil
	self.toggleOverHandler_ = nil

	for iter_8_0, iter_8_1 in pairs(self.panelItemList_) do
		iter_8_1:Dispose()
	end

	self.panelItemList_ = nil

	for iter_8_2, iter_8_3 in pairs(self.toggleItemList_) do
		iter_8_3:Dispose()
	end

	self.toggleItemList_ = nil
	self.cachePanelList_ = nil
end

function ActivityMainToggleBaseView:AddListeners()
	self:AddToggleListener(self.scrollView_, function(arg_10_0)
		self:UpdateUIArrow()
	end)
end

function ActivityMainToggleBaseView:GetToggleCfg()
	return {}
end

function ActivityMainToggleBaseView:GetActivityID()
	if ActivityEntraceCfg[self.params_.activityID] == nil then
		self.params_.activityID = ActivityEntraceCfg.get_id_list_by_theme[ActivityCfg[self.params_.activityID].activity_theme][1]
	end

	return self.params_.activityID
end

function ActivityMainToggleBaseView:GetActivityTheme()
	return ActivityTools.GetActivityTheme(self:GetActivityID())
end

function ActivityMainToggleBaseView:ToggleOnClick(arg_14_1, arg_14_2)
	if ActivityVersionData:GetSelectActivityID(self:GetActivityID()) == arg_14_1 and arg_14_2 ~= true then
		return
	end

	self.params_.subActivityID = arg_14_1

	ActivityVersionData:SetSelectActivityID(self:GetActivityID(), arg_14_1)

	for iter_14_0, iter_14_1 in pairs(self.panelItemList_) do
		if iter_14_0 ~= arg_14_1 then
			iter_14_1:Show(false)
		end
	end

	local var_14_0 = table.keyof(self.cachePanelList_, arg_14_1)

	if var_14_0 then
		table.remove(self.cachePanelList_, var_14_0)
	end

	table.insert(self.cachePanelList_, 1, arg_14_1)

	self.panelItemList_[arg_14_1] = self.panelItemList_[arg_14_1] or ActivityTools.GetTogglePanelView(arg_14_1).New(self.panelParentGo_, arg_14_1)

	if not self.activePanelList_[arg_14_1] then
		self.panelItemList_[arg_14_1]:OnEnter()

		self.activePanelList_[arg_14_1] = true
	end

	self.panelItemList_[arg_14_1]:UpdateBar()
	self.panelItemList_[arg_14_1]:Show(true)
	self:DestroyCachePanel()

	for iter_14_2, iter_14_3 in pairs(self.toggleItemList_) do
		iter_14_3:OnSelect(iter_14_2 == arg_14_1)
	end

	if self.viewTf_ and self.contentTf_ and self.toggleItemList_[arg_14_1] then
		local var_14_1

		if -self.contentTf_.anchoredPosition.y - self.viewTf_.rect.height > self.toggleItemList_[arg_14_1].transform_.anchoredPosition.y - (self.toggleItemList_[arg_14_1].transform_.sizeDelta.y / 2 + 10) then
			var_14_1 = self.contentTf_.anchoredPosition.y + (-self.contentTf_.anchoredPosition.y - self.viewTf_.rect.height) - (self.toggleItemList_[arg_14_1].transform_.anchoredPosition.y - (self.toggleItemList_[arg_14_1].transform_.sizeDelta.y / 2 + 10))
		elseif -self.contentTf_.anchoredPosition.y < self.toggleItemList_[arg_14_1].transform_.anchoredPosition.y + (self.toggleItemList_[arg_14_1].transform_.sizeDelta.y / 2 + 10) then
			var_14_1 = self.contentTf_.anchoredPosition.y + -self.contentTf_.anchoredPosition.y - (self.toggleItemList_[arg_14_1].transform_.anchoredPosition.y + (self.toggleItemList_[arg_14_1].transform_.sizeDelta.y / 2 + 10))
		end

		if var_14_1 then
			self.contentTf_:SetAnchoredPositionY(var_14_1)
		end
	end
end

function ActivityMainToggleBaseView:ScrollToggle(arg_15_1)
	self.scrollTimer_ = FrameTimer.New(function()
		if self.scrollView_ then
			local var_16_0, var_16_1 = self:GetActivityIndex(arg_15_1)

			if var_16_0 == nil then
				self.scrollView_.verticalNormalizedPosition = 1
			else
				local var_16_2 = (var_16_0 - 1) / ((self.contentTf_.rect.height - self.viewTf_.rect.height) / (self.itemTf_.rect.height + self.contentLayout_.spacing))

				if (var_16_0 - 1) / ((self.contentTf_.rect.height - self.viewTf_.rect.height) / (self.itemTf_.rect.height + self.contentLayout_.spacing)) > 1 then
					var_16_2 = 1
				elseif var_16_2 < 0 then
					var_16_2 = 0
				end

				self.scrollView_.verticalNormalizedPosition = 1 - var_16_2
			end
		end
	end, 1, 1)

	self.scrollTimer_:Start()
end

function ActivityMainToggleBaseView:UpdateUIArrow()
	if self.contentTf_.rect.height > self.viewTf_.rect.height and self.scrollView_.verticalNormalizedPosition > 0 then
		SetActive(self.arrowGo_, true)
	else
		SetActive(self.arrowGo_, false)
	end
end

function ActivityMainToggleBaseView:ToggleOver(arg_18_1)
	if ActivityVersionData:GetSelectActivityID(self:GetActivityID()) == arg_18_1 then
		local var_18_0 = self:GetOpenActivityID()

		if var_18_0 == nil then
			self:Go("/home")

			return
		end

		self:ToggleOnClick(var_18_0, true)
	end
end

function ActivityMainToggleBaseView:GetOpenActivityID()
	local var_19_0 = manager.time:GetServerTime()

	for iter_19_0, iter_19_1 in ipairs((self:GetSortToggle(ActivityToggleCfg.get_id_list_by_activity_theme[self:GetActivityTheme()] or {}))) do
		local var_19_1 = ActivityToggleCfg[iter_19_1.id].activity_id
		local var_19_2 = ActivityData:GetActivityData(ActivityToggleCfg[iter_19_1.id].activity_id)
		local var_19_3, var_19_4 = ChapterResidentTools.GetResidentMainActTime(ActivityToggleCfg[iter_19_1.id].activity_id)

		if not var_19_3 or not var_19_4 then
			var_19_3 = var_19_2.startTime
			var_19_4 = var_19_2.stopTime
		end

		if ActivityShopCfg[var_19_1] then
			var_19_4 = ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[var_19_1].shop_id].activity_id).stopTime
		end

		if var_19_3 <= var_19_0 and var_19_0 < var_19_4 then
			return var_19_1
		end
	end
end

function ActivityMainToggleBaseView:GetActivityIndex(arg_20_1)
	local var_20_0 = manager.time:GetServerTime()
	local var_20_1 = {}

	for iter_20_0, iter_20_1 in ipairs((self:GetSortToggle(ActivityToggleCfg.get_id_list_by_activity_theme[self:GetActivityTheme()] or {}))) do
		local var_20_2 = ActivityData:GetActivityData(iter_20_1.activity_id)

		if ActivityShopCfg[iter_20_1.activity_id] then
			if ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[iter_20_1.activity_id].shop_id].activity_id):IsActivitying() then
				table.insert(var_20_1, iter_20_1.activity_id)
			end
		elseif var_20_0 >= var_20_2.startTime and var_20_0 < var_20_2.stopTime then
			table.insert(var_20_1, iter_20_1.activity_id)
		end
	end

	return table.keyof(var_20_1, arg_20_1), #var_20_1
end

function ActivityMainToggleBaseView:DestroyCachePanel()
	if #self.cachePanelList_ > ActivityMainToggleBaseView.MAX_CACHE_PANEL_CNT then
		for iter_21_0 = #self.cachePanelList_, 2, -1 do
			if #self.cachePanelList_ <= ActivityMainToggleBaseView.MAX_CACHE_PANEL_CNT then
				break
			end

			local var_21_0 = self.cachePanelList_[iter_21_0]

			if not self.panelItemList_[self.cachePanelList_[iter_21_0]].DonotPreDestroy or not self.panelItemList_[self.cachePanelList_[iter_21_0]]:DonotPreDestroy() then
				table.remove(self.cachePanelList_, iter_21_0)
				self.panelItemList_[self.cachePanelList_[iter_21_0]]:OnExit()
				self.panelItemList_[self.cachePanelList_[iter_21_0]]:Dispose()

				self.panelItemList_[var_21_0] = nil
				self.activePanelList_[var_21_0] = nil
			end
		end
	end
end

function ActivityMainToggleBaseView:GetSortToggle(arg_22_1)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		table.insert(var_22_0, ActivityToggleCfg[iter_22_1])
	end

	table.sort(var_22_0, function(arg_23_0, arg_23_1)
		if arg_23_0.order == arg_23_1.order then
			return arg_23_0.id < arg_23_1.id
		else
			return arg_23_0.order > arg_23_1.order
		end
	end)

	return var_22_0
end

return ActivityMainToggleBaseView
