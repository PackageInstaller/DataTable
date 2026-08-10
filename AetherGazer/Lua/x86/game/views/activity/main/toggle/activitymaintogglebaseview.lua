local var_0_0 = class("ActivityMainToggleBaseView", ReduxView)

var_0_0.IsCommonMainActivityPage = true
var_0_0.MAX_CACHE_PANEL_CNT = 4

function var_0_0.UIName(arg_1_0)
	local var_1_0 = arg_1_0:GetActivityID()

	return ActivityEntraceCfg[var_1_0].prefab_path
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.toggleClickHandler_ = handler(arg_3_0, arg_3_0.ToggleOnClick)
	arg_3_0.toggleOverHandler_ = handler(arg_3_0, arg_3_0.ToggleOver)
	arg_3_0.toggleItemList_ = {}
	arg_3_0.panelItemList_ = {}
	arg_3_0.activeItemList_ = {}
	arg_3_0.activePanelList_ = {}
	arg_3_0.cachePanelList_ = {}
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INVITE_BAR
	})
	manager.notify:RegistListener(ACTIVITY_MAIN_TOGGLE_CLICK, arg_4_0.toggleClickHandler_)
	manager.notify:RegistListener(ACTIVITY_MAIN_TOGGLE_OVER, arg_4_0.toggleOverHandler_)

	for iter_4_0, iter_4_1 in pairs(arg_4_0.toggleItemList_) do
		iter_4_1:Show(false)
	end

	arg_4_0.activeItemList_ = {}

	local var_4_0 = ActivityToggleCfg.get_id_list_by_activity_theme[arg_4_0:GetActivityTheme()] or {}
	local var_4_1 = arg_4_0:GetSortToggle(var_4_0)

	for iter_4_2, iter_4_3 in ipairs(var_4_1) do
		local var_4_2 = ActivityData:GetActivityData(iter_4_3.activity_id)
		local var_4_3

		if var_4_2.template == ActivityTemplateConst.ACTIVITY_ADVANCE_OPEN then
			var_4_3 = var_4_2.subActivityIdList[1]
		else
			var_4_3 = iter_4_3.activity_id
		end

		arg_4_0.toggleItemList_[iter_4_3.activity_id] = arg_4_0.toggleItemList_[iter_4_3.activity_id] or ActivityMainToggleItem.New(arg_4_0.itemGo_, arg_4_0.itemParentGo_, iter_4_3.id, iter_4_3.activity_id, var_4_3)

		arg_4_0.toggleItemList_[iter_4_3.activity_id]:Show(true)

		arg_4_0.activeItemList_[iter_4_3.activity_id] = true
	end

	for iter_4_4, iter_4_5 in pairs(arg_4_0.activeItemList_) do
		arg_4_0.toggleItemList_[iter_4_4]:OnEnter()
	end

	arg_4_0.activePanelList_ = {}

	local var_4_4

	if arg_4_0.params_.isBack then
		var_4_4 = ActivityVersionData:GetSelectActivityID(arg_4_0:GetActivityID())
	elseif arg_4_0.params_.subActivityID then
		var_4_4 = arg_4_0.params_.subActivityID
	else
		var_4_4 = arg_4_0:GetOpenActivityID()
	end

	if var_4_4 == nil then
		arg_4_0:Go("/home")

		return
	end

	arg_4_0:ScrollToggle(var_4_4)
	arg_4_0:ToggleOnClick(var_4_4, true)
	arg_4_0:UpdateUIArrow()
end

function var_0_0.OnTop(arg_5_0)
	local var_5_0 = ActivityVersionData:GetSelectActivityID(arg_5_0:GetActivityID())

	if var_5_0 == nil then
		return
	end

	if arg_5_0.panelItemList_[var_5_0] then
		arg_5_0.panelItemList_[var_5_0]:OnTop()

		if arg_5_0.panelItemList_[var_5_0].UpdateBar then
			arg_5_0.panelItemList_[var_5_0]:UpdateBar()
		end
	end
end

function var_0_0.OnUpdate(arg_6_0)
	local var_6_0 = arg_6_0.params_.subActivityID
	local var_6_1 = ActivityVersionData:GetSelectActivityID(arg_6_0:GetActivityID())

	if not var_6_0 or var_6_1 == var_6_0 then
		return
	end

	arg_6_0:ScrollToggle(var_6_0)
	arg_6_0:ToggleOnClick(var_6_0, true)
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(ACTIVITY_MAIN_TOGGLE_CLICK, arg_7_0.toggleClickHandler_)
	manager.notify:RemoveListener(ACTIVITY_MAIN_TOGGLE_OVER, arg_7_0.toggleOverHandler_)

	for iter_7_0, iter_7_1 in pairs(arg_7_0.activeItemList_) do
		arg_7_0.toggleItemList_[iter_7_0]:OnExit()
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_0.activePanelList_) do
		local var_7_0 = arg_7_0.panelItemList_[iter_7_2]

		var_7_0:Show(false)
		var_7_0:OnExit()
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)

	arg_8_0.toggleClickHandler_ = nil
	arg_8_0.toggleOverHandler_ = nil

	for iter_8_0, iter_8_1 in pairs(arg_8_0.panelItemList_) do
		iter_8_1:Dispose()
	end

	arg_8_0.panelItemList_ = nil

	for iter_8_2, iter_8_3 in pairs(arg_8_0.toggleItemList_) do
		iter_8_3:Dispose()
	end

	arg_8_0.toggleItemList_ = nil
	arg_8_0.cachePanelList_ = nil
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddToggleListener(arg_9_0.scrollView_, function(arg_10_0)
		arg_9_0:UpdateUIArrow()
	end)
end

function var_0_0.GetToggleCfg(arg_11_0)
	return {}
end

function var_0_0.GetActivityID(arg_12_0)
	local var_12_0 = arg_12_0.params_.activityID

	if ActivityEntraceCfg[var_12_0] == nil then
		arg_12_0.params_.activityID = ActivityEntraceCfg.get_id_list_by_theme[ActivityCfg[var_12_0].activity_theme][1]
	end

	return arg_12_0.params_.activityID
end

function var_0_0.GetActivityTheme(arg_13_0)
	return ActivityTools.GetActivityTheme(arg_13_0:GetActivityID())
end

function var_0_0.ToggleOnClick(arg_14_0, arg_14_1, arg_14_2)
	if ActivityVersionData:GetSelectActivityID(arg_14_0:GetActivityID()) == arg_14_1 and arg_14_2 ~= true then
		return
	end

	arg_14_0.params_.subActivityID = arg_14_1

	ActivityVersionData:SetSelectActivityID(arg_14_0:GetActivityID(), arg_14_1)

	for iter_14_0, iter_14_1 in pairs(arg_14_0.panelItemList_) do
		if iter_14_0 ~= arg_14_1 then
			iter_14_1:Show(false)
		end
	end

	local var_14_0 = table.keyof(arg_14_0.cachePanelList_, arg_14_1)

	if var_14_0 then
		table.remove(arg_14_0.cachePanelList_, var_14_0)
	end

	table.insert(arg_14_0.cachePanelList_, 1, arg_14_1)

	if not arg_14_0.panelItemList_[arg_14_1] then
		arg_14_0.panelItemList_[arg_14_1] = ActivityTools.GetTogglePanelView(arg_14_1).New(arg_14_0.panelParentGo_, arg_14_1)
	end

	if not arg_14_0.activePanelList_[arg_14_1] then
		arg_14_0.panelItemList_[arg_14_1]:OnEnter()

		arg_14_0.activePanelList_[arg_14_1] = true
	end

	arg_14_0.panelItemList_[arg_14_1]:UpdateBar()
	arg_14_0.panelItemList_[arg_14_1]:Show(true)
	arg_14_0:DestroyCachePanel()

	for iter_14_2, iter_14_3 in pairs(arg_14_0.toggleItemList_) do
		iter_14_3:OnSelect(iter_14_2 == arg_14_1)
	end

	local var_14_1 = arg_14_0.toggleItemList_[arg_14_1]

	if arg_14_0.viewTf_ and arg_14_0.contentTf_ and var_14_1 then
		local var_14_2 = arg_14_0.contentTf_.anchoredPosition.y
		local var_14_3 = var_14_1.transform_.anchoredPosition.y
		local var_14_4 = var_14_1.transform_.sizeDelta.y / 2 + 10
		local var_14_5 = arg_14_0.viewTf_.rect.height
		local var_14_6 = -var_14_2
		local var_14_7 = -var_14_2 - var_14_5
		local var_14_8

		if var_14_7 > var_14_3 - var_14_4 then
			var_14_8 = var_14_2 + var_14_7 - (var_14_3 - var_14_4)
		elseif var_14_6 < var_14_3 + var_14_4 then
			var_14_8 = var_14_2 + var_14_6 - (var_14_3 + var_14_4)
		end

		if var_14_8 then
			arg_14_0.contentTf_:SetAnchoredPositionY(var_14_8)
		end
	end
end

function var_0_0.ScrollToggle(arg_15_0, arg_15_1)
	arg_15_0.scrollTimer_ = FrameTimer.New(function()
		if arg_15_0.scrollView_ then
			local var_16_0, var_16_1 = arg_15_0:GetActivityIndex(arg_15_1)

			if var_16_0 == nil then
				arg_15_0.scrollView_.verticalNormalizedPosition = 1
			else
				local var_16_2 = (var_16_0 - 1) / ((arg_15_0.contentTf_.rect.height - arg_15_0.viewTf_.rect.height) / (arg_15_0.itemTf_.rect.height + arg_15_0.contentLayout_.spacing))

				if var_16_2 > 1 then
					var_16_2 = 1
				elseif var_16_2 < 0 then
					var_16_2 = 0
				end

				arg_15_0.scrollView_.verticalNormalizedPosition = 1 - var_16_2
			end
		end
	end, 1, 1)

	arg_15_0.scrollTimer_:Start()
end

function var_0_0.UpdateUIArrow(arg_17_0)
	if arg_17_0.contentTf_.rect.height > arg_17_0.viewTf_.rect.height and arg_17_0.scrollView_.verticalNormalizedPosition > 0 then
		SetActive(arg_17_0.arrowGo_, true)
	else
		SetActive(arg_17_0.arrowGo_, false)
	end
end

function var_0_0.ToggleOver(arg_18_0, arg_18_1)
	if ActivityVersionData:GetSelectActivityID(arg_18_0:GetActivityID()) == arg_18_1 then
		local var_18_0 = arg_18_0:GetOpenActivityID()

		if var_18_0 == nil then
			arg_18_0:Go("/home")

			return
		end

		arg_18_0:ToggleOnClick(var_18_0, true)
	end
end

function var_0_0.GetOpenActivityID(arg_19_0)
	local var_19_0 = manager.time:GetServerTime()
	local var_19_1 = ActivityToggleCfg.get_id_list_by_activity_theme[arg_19_0:GetActivityTheme()] or {}
	local var_19_2 = arg_19_0:GetSortToggle(var_19_1)

	for iter_19_0, iter_19_1 in ipairs(var_19_2) do
		local var_19_3 = iter_19_1.id
		local var_19_4 = ActivityToggleCfg[var_19_3].activity_id
		local var_19_5 = ActivityData:GetActivityData(var_19_4)
		local var_19_6, var_19_7 = ChapterResidentTools.GetResidentMainActTime(var_19_4)

		if not var_19_6 or not var_19_7 then
			var_19_6 = var_19_5.startTime
			var_19_7 = var_19_5.stopTime
		end

		if ActivityShopCfg[var_19_4] then
			local var_19_8 = ActivityShopCfg[var_19_4].shop_id
			local var_19_9 = ShopListCfg[var_19_8].activity_id

			var_19_7 = ActivityData:GetActivityData(var_19_9).stopTime
		end

		if var_19_6 <= var_19_0 and var_19_0 < var_19_7 then
			return var_19_4
		end
	end
end

function var_0_0.GetActivityIndex(arg_20_0, arg_20_1)
	local var_20_0 = manager.time:GetServerTime()
	local var_20_1 = ActivityToggleCfg.get_id_list_by_activity_theme[arg_20_0:GetActivityTheme()] or {}
	local var_20_2 = arg_20_0:GetSortToggle(var_20_1)
	local var_20_3 = {}

	for iter_20_0, iter_20_1 in ipairs(var_20_2) do
		local var_20_4 = iter_20_1.activity_id
		local var_20_5 = ActivityData:GetActivityData(var_20_4)

		if ActivityShopCfg[var_20_4] then
			local var_20_6 = ActivityShopCfg[var_20_4].shop_id
			local var_20_7 = ShopListCfg[var_20_6].activity_id

			if ActivityData:GetActivityData(var_20_7):IsActivitying() then
				table.insert(var_20_3, var_20_4)
			end
		elseif var_20_0 >= var_20_5.startTime and var_20_0 < var_20_5.stopTime then
			table.insert(var_20_3, var_20_4)
		end
	end

	return table.keyof(var_20_3, arg_20_1), #var_20_3
end

function var_0_0.DestroyCachePanel(arg_21_0)
	if #arg_21_0.cachePanelList_ > var_0_0.MAX_CACHE_PANEL_CNT then
		for iter_21_0 = #arg_21_0.cachePanelList_, 2, -1 do
			if #arg_21_0.cachePanelList_ <= var_0_0.MAX_CACHE_PANEL_CNT then
				break
			end

			local var_21_0 = arg_21_0.cachePanelList_[iter_21_0]
			local var_21_1 = arg_21_0.panelItemList_[var_21_0]

			if not var_21_1.DonotPreDestroy or not var_21_1:DonotPreDestroy() then
				table.remove(arg_21_0.cachePanelList_, iter_21_0)
				var_21_1:OnExit()
				var_21_1:Dispose()

				arg_21_0.panelItemList_[var_21_0] = nil
				arg_21_0.activePanelList_[var_21_0] = nil
			end
		end
	end
end

function var_0_0.GetSortToggle(arg_22_0, arg_22_1)
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

return var_0_0
