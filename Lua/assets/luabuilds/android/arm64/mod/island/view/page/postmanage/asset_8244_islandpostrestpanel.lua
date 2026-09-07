local IslandPostRestPanel = class("IslandPostRestPanel", import("view.base.BaseSubView"))

IslandPostRestPanel.MAX_ASSISTANT_CNT = 2
IslandPostRestPanel.MAX_SHELF_CNT = 5
IslandPostRestPanel.ScrollValue = 0

function IslandPostRestPanel:getUIName()
	return "IslandPostRestPanel"
end

function IslandPostRestPanel:OnLoaded()
	self.scrollTF = self._tf:Find("view")

	local var_2_0 = self._tf:Find("view/content")
	local var_2_1 = var_2_0:Find("tpl")

	setText(var_2_1:Find("btns/opening/Text"), i18n("island_manage_view"))
	setText(var_2_1:Find("btns/close/Text"), i18n("island_manage_result"))
	setText(var_2_1:Find("btns/lock/Text"), i18n("word_lock"))
	setText(var_2_1:Find("name/event/Text"), i18n("island_post_event_label"))

	self.uiList = UIItemList.New(var_2_0, var_2_1)

	return
end

function IslandPostRestPanel:OnInit()
	self.restIds = pg.island_set.post_manage_operate.key_value_varchar

	self.uiList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventInit then
			self:InitItem(arg_4_1, arg_4_2)
		elseif arg_4_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_4_1, arg_4_2)
		end

		return
	end)
	onScroll(self, self.scrollTF, function(arg_5_0)
		IslandPostRestPanel.ScrollValue = arg_5_0.x

		return
	end)

	return
end

function IslandPostRestPanel:TriggerEvent(arg_6_1)
	local var_6_0 = -1

	for iter_6_0, iter_6_1 in ipairs(self.restIds) do
		if iter_6_1 == arg_6_1 then
			var_6_0 = iter_6_0

			break
		end
	end

	if var_6_0 < 0 then
		return
	end

	self.uiList:eachActive(function(arg_7_0, arg_7_1)
		if arg_7_0 + 1 == var_6_0 then
			triggerButton(arg_7_1:Find("btns/opening"))
		end

		return
	end)

	return
end

function IslandPostRestPanel:InitItem(arg_8_1, arg_8_2)
	onButton(self, arg_8_2:Find("btns/prepare"), function()
		self:OpenRestaurant(self.restIds[arg_8_1 + 1])

		return
	end, SFX_PANEL)
	onButton(self, arg_8_2:Find("btns/opening"), function()
		self:OpenRestaurant(self.restIds[arg_8_1 + 1])

		return
	end, SFX_PANEL)
	onButton(self, arg_8_2:Find("btns/close"), function()
		self:OpenRestaurant(self.restIds[arg_8_1 + 1])

		return
	end, SFX_PANEL)

	return
end

function IslandPostRestPanel:OpenRestaurant(arg_12_1)
	self:emit(IslandMediator.OPEN_PAGE, "IslandRestaurantPage", {
		arg_12_1,
		true
	})

	return
end

function IslandPostRestPanel:UpdateItem(arg_13_1, arg_13_2)
	arg_13_2.name = self.restIds[arg_13_1 + 1]

	setText(arg_13_2:Find("name"), pg.island_manage_restaurant[self.restIds[arg_13_1 + 1]].name)

	local var_13_0 = self.rests[self.restIds[arg_13_1 + 1]]

	setActive(arg_13_2:Find("lock"), not self.rests[self.restIds[arg_13_1 + 1]])
	setActive(arg_13_2:Find("btns/lock"), not var_13_0)
	setActive(arg_13_2:Find("rank"), var_13_0)
	setActive(arg_13_2:Find("opening"), var_13_0 and var_13_0:GetStatus() == IslandRestaurant.STATUS.OPENING)

	if var_13_0 then
		local var_13_1 = var_13_0:GetEventInfo()

		setActive(arg_13_2:Find("name/event"), var_13_0:GetEventInfo() ~= 0)
	else
		setActive(arg_13_2:Find("name/event"), false)
	end

	onButton(self, arg_13_2:Find("name/event"), function()
		self:emit(IslandPostManagePage.EVENT_SHOW_SP_EVENT_TIP, var_13_0, false)

		return
	end, SFX_PANEL)

	local var_13_2 = var_13_0 and var_13_0:GetAssistants() or {}

	UIItemList.StaticAlign(arg_13_2:Find("ships"), arg_13_2:Find("ships/tpl"), IslandPostRestPanel.MAX_ASSISTANT_CNT, function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			setActive(arg_15_2:Find("lock"), not var_13_2[arg_15_1 + 1])

			local var_15_0 = var_13_2[arg_15_1 + 1] and var_13_2[arg_15_1 + 1].shipId

			setActive(arg_15_2:Find("icon"), var_13_2[arg_15_1 + 1] and var_13_2[arg_15_1 + 1].shipId and var_15_0 ~= 0)

			if var_15_0 and var_15_0 ~= 0 then
				LoadImageSpriteAsync("squareicon/" .. IslandShip.StaticGetPrefab(var_15_0), arg_15_2:Find("icon"))
			end
		end

		return
	end)

	local var_13_3 = var_13_0 and var_13_0:GetCommondities() or {}
	local var_13_4 = var_13_0 and var_13_0:GetShelfCnt() or 0

	UIItemList.StaticAlign(arg_13_2:Find("shelfs"), arg_13_2:Find("shelfs/tpl"), IslandPostRestPanel.MAX_SHELF_CNT, function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			local var_16_0 = var_13_3[arg_16_1 + 1]

			setActive(arg_16_2:Find("lock"), var_13_4 < arg_16_1 + 1)
			setActive(arg_16_2:Find("drop"), var_16_0)

			if var_16_0 then
				updateCustomDrop(arg_16_2:Find("drop"), (Drop.New({
					type = DROP_TYPE_ISLAND_ITEM,
					id = var_16_0.id,
					count = var_16_0.num
				})))
			end
		end

		return
	end)

	if var_13_0 then
		local var_13_5 = var_13_0:getConfig("opening_number")
		local var_13_6 = var_13_0:GetRemainCnt()

		setText(arg_13_2:Find("btns/prepare/Text"), string.format("%s(%d/%d)", i18n("island_manage_prepare"), var_13_6, var_13_5))
		setText(arg_13_2:Find("btns/end/Text"), string.format("%s(%d/%d)", i18n("island_manage_daily_cnt_tip"), var_13_6, var_13_5))
		LoadImageSpriteAsync("island/islandrestaurant/" .. var_13_0:GetRankIcon(), arg_13_2:Find("rank"), true)
		self:UpdataStatusInfo(arg_13_2, var_13_0)
	end

	return
end

function IslandPostRestPanel:UpdataStatusInfo(arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2:GetStatus()

	if var_17_0 == IslandRestaurant.STATUS.OPENING then
		local var_17_1 = pg.TimeMgr.GetInstance()

		setText(arg_17_1:Find("opening/Text"), var_17_1:DescCDTime(arg_17_2:GetEndTime() - var_17_1:GetServerTime()))
	end

	eachChild(arg_17_1:Find("btns"), function(arg_18_0)
		setActive(arg_18_0, arg_18_0.name == var_17_0)

		return
	end)

	return
end

function IslandPostRestPanel:Show()
	self.super.Show(self)
	self:Flush()
	self:CheckEventTip()
	scrollTo(self.scrollTF, IslandPostRestPanel.ScrollValue)

	return
end

function IslandPostRestPanel:CheckEventTip()
	if not getProxy(SettingsProxy):ShouldTipIslandRestEvet() then
		return
	end

	local var_20_0

	for iter_20_0, iter_20_1 in pairs(self.rests) do
		local var_20_1 = iter_20_1:GetEventInfo()

		if iter_20_1:GetEventInfo() ~= 0 then
			var_20_0 = iter_20_1

			break
		end
	end

	if var_20_0 then
		self:emit(IslandPostManagePage.EVENT_SHOW_SP_EVENT_TIP, var_20_0, true)
	end

	return
end

function IslandPostRestPanel:Flush()
	self:StopTimer()

	self.rests = getProxy(IslandProxy):GetIsland():GetManageAgency():GetRestaurants()

	table.sort(self.restIds, CompareFuncs({
		function(arg_22_0)
			return self.rests[arg_22_0] and 0 or 1
		end,
		function(arg_23_0)
			return self.rests[arg_23_0] and self:GetStatusSortWeight(self.rests[arg_23_0]:GetStatus()) or 999
		end,
		function(arg_24_0)
			return arg_24_0
		end
	}))
	self.uiList:align(#self.restIds)
	self:StartTimer()
	self:UpdateTime()

	return
end

function IslandPostRestPanel:GetStatusSortWeight(arg_25_1)
	return switch(arg_25_1, {
		[IslandRestaurant.STATUS.CLOSE] = function()
			return 1
		end,
		[IslandRestaurant.STATUS.PREPARE] = function()
			return 2
		end,
		[IslandRestaurant.STATUS.OPENING] = function()
			return 3
		end,
		[IslandRestaurant.STATUS.END] = function()
			return 4
		end
	}, function()
		return 999
	end)
end

function IslandPostRestPanel:UpdateTime()
	self.uiList:eachActive(function(arg_32_0, arg_32_1)
		if self.rests[self.restIds[arg_32_0 + 1]] then
			self:UpdataStatusInfo(arg_32_1, self.rests[self.restIds[arg_32_0 + 1]])
		end

		return
	end)

	return
end

function IslandPostRestPanel:StartTimer()
	self.timer = Timer.New(function()
		self:UpdateTime()

		return
	end, 1, -1)

	self.timer:Start()

	return
end

function IslandPostRestPanel:StopTimer()
	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandPostRestPanel:OnHide()
	self:StopTimer()

	return
end

function IslandPostRestPanel:OnDestroy()
	self:OnHide()

	return
end

return IslandPostRestPanel
