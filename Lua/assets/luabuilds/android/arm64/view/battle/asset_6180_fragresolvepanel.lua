local FragResolvePanel = class("FragResolvePanel", BaseSubPanel)

function FragResolvePanel:getUIName()
	return "FragResolveUI"
end

local var_0_1 = {
	"control",
	"resolve"
}

function FragResolvePanel:OnInit()
	self.bagProxy = getProxy(BagProxy)
	self.technologyProxy = getProxy(TechnologyProxy)
	self.toggles = {}

	for iter_2_0, iter_2_1 in ipairs(var_0_1) do
		self[iter_2_1 .. "Panel"] = self._tf:Find(iter_2_1)

		local var_2_0 = self._tf:Find("toggle_controll/" .. iter_2_1)

		self.toggles[iter_2_1] = var_2_0

		onToggle(self, var_2_0, function(arg_3_0)
			self["Reset" .. iter_2_1](self)

			return
		end, SFX_PANEL)
	end

	onButton(self, self._tf:Find("bg"), function()
		self:Back()

		return
	end, SFX_PANEL)

	local var_2_1 = self.controlPanel:Find("got/empty/Text")

	setText(self.controlPanel:Find("allMax/txt"), i18n("onebutton_max_tip"))

	local var_2_2 = self._tf:Find("control/condition/text")
	local var_2_3 = self.resolvePanel:Find("cancel_button/label")

	if PLATFORM_CODE == PLATFORM_US then
		setTextEN(var_2_2, i18n("fenjie_lantu_tip"))
		setTextEN(var_2_1, i18n("fragresolve_empty_tip"))
	else
		setText(var_2_2, i18n("fenjie_lantu_tip"))
		setText(var_2_1, i18n("fragresolve_empty_tip"))
	end

	setText(var_2_3, i18n("msgbox_text_cancel"))

	FragResolvePanel.keepFateTog = self._tf:Find("control/condition/keep_tog")

	setText(self.keepFateTog:Find("label"), i18n("keep_fate_tip"))

	FragResolvePanel.keepFateState = not getProxy(PlayerProxy):getData():GetCommonFlag(SHOW_DONT_KEEP_FATE_ITEM)
	GetComponent(self.keepFateTog, typeof(Toggle)).isOn = FragResolvePanel.keepFateState

	onToggle(self, self.keepFateTog, function(arg_5_0)
		FragResolvePanel.keepFateState = arg_5_0

		self:emit(NewShopMainMediator.SET_PLAYER_FLAG, SHOW_DONT_KEEP_FATE_ITEM, not arg_5_0)
		self:Trigger("control")

		return
	end)
	self:Trigger("control")

	return
end

function FragResolvePanel:OnShow()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function FragResolvePanel:OnHide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function FragResolvePanel:Reset()
	if self.resolveItems then
		table.clear(self.resolveItems)
	end

	return
end

function FragResolvePanel:Resetcontrol()
	self.blueprintItems = self.GetAllBluePrintStrengthenItems()

	local var_9_0 = self.blueprintItems
	local var_9_1 = self.controlPanel
	local var_9_2 = self.controlPanel:Find("got/list")

	setActive(self.controlPanel:Find("got/empty"), #self.blueprintItems <= 0)
	setActive(var_9_2, #var_9_0 > 0)

	if #var_9_0 <= 0 then
		self:Updatecontrol()

		return
	end

	local var_9_3 = {}

	for iter_9_0, iter_9_1 in ipairs(self.resolveItems or {}) do
		var_9_3[iter_9_1.id] = iter_9_1
	end

	UIItemList.StaticAlign(var_9_2, var_9_2:Find("item"), #var_9_0, function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = var_9_0[arg_10_1 + 1]

			updateDrop(arg_10_2:Find("icon"), var_9_0[arg_10_1 + 1])

			var_10_0.curCount = math.clamp((var_9_3[var_10_0.id] or nil) and (var_9_3[var_10_0.id].curCount or 0), 0, var_10_0.maxCount)

			onButton(self, arg_10_2:Find("icon/icon_bg"), function()
				self:emit(BaseUI.ON_DROP, var_10_0)

				return
			end, SFX_PANEL)

			local var_10_1 = arg_10_2:Find("count")

			onButton(self, var_10_1:Find("max"), function()
				if var_10_0.curCount ~= var_10_0.maxCount then
					var_10_0.curCount = var_10_0.maxCount

					self:Updatecontrol()
				end

				return
			end)
			pressPersistTrigger(var_10_1:Find("number_panel/left"), 0.5, function(arg_13_0)
				if var_10_0.curCount <= 0 then
					arg_13_0()

					return
				end

				var_10_0.curCount = var_10_0.curCount - 1

				self:Updatecontrol()

				return
			end, nil, true, true, 0.1, SFX_PANEL)
			pressPersistTrigger(var_10_1:Find("number_panel/right"), 0.5, function(arg_14_0)
				if var_10_0.curCount >= var_10_0.maxCount then
					arg_14_0()

					return
				end

				var_10_0.curCount = var_10_0.curCount + 1

				self:Updatecontrol()

				return
			end, nil, true, true, 0.1, SFX_PANEL)
		end

		return
	end)
	onButton(self, var_9_1:Find("button_1"), function()
		local var_15_0 = {}

		for iter_15_0, iter_15_1 in ipairs(self.blueprintItems) do
			if iter_15_1.curCount > 0 then
				local var_15_1 = Clone(iter_15_1)

				var_15_1.count = iter_15_1.curCount

				table.insert(var_15_0, var_15_1)
			end
		end

		if #var_15_0 > 0 then
			self.resolveItems = var_15_0

			triggerToggle(self.toggles.resolve, true)
		end

		return
	end, SFX_PANEL)
	onButton(self, var_9_1:Find("allMax"), function()
		for iter_16_0 = 1, #var_9_0 do
			if var_9_0[iter_16_0].curCount ~= var_9_0[iter_16_0].maxCount then
				var_9_0[iter_16_0].curCount = var_9_0[iter_16_0].maxCount
			end

			self:Updatecontrol()
		end

		return
	end, SFX_PANEL)
	self:Updatecontrol()

	return
end

function FragResolvePanel:Updatecontrol()
	local var_17_0 = self.controlPanel:Find("got/list")
	local var_17_1 = self.blueprintItems
	local var_17_2 = 0

	UIItemList.StaticAlign(var_17_0, var_17_0:Find("item"), #self.blueprintItems, function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			setText(arg_18_2:Find("count"):Find("number_panel/value"), var_17_1[arg_18_1 + 1].curCount)

			var_17_2 = var_17_2 + var_17_1[arg_18_1 + 1].curCount
		end

		return
	end)

	local var_17_3 = self.controlPanel:Find("button_1")

	setButtonEnabled(var_17_3, var_17_2 > 0)
	setGray(var_17_3, var_17_2 <= 0)

	local var_17_4 = self.controlPanel:Find("allMax")

	setGray(var_17_4, not var_17_1 or #var_17_1 == 0)
	setButtonEnabled(var_17_4, var_17_1 and #var_17_1 > 0)

	return
end

function FragResolvePanel:Resetresolve()
	local var_19_0 = self.resolvePanel:Find("preview/got/list")
	local var_19_1 = self.resolvePanel:Find("result/got/list")
	local var_19_2 = self.resolveItems

	UIItemList.StaticAlign(var_19_0, var_19_0:Find("item"), #self.resolveItems, function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventUpdate then
			local var_20_0 = var_19_2[arg_20_1 + 1]

			updateDrop(arg_20_2:Find("icon"), var_19_2[arg_20_1 + 1])
			onButton(self, arg_20_2:Find("icon/icon_bg"), function()
				self:emit(BaseUI.ON_DROP, var_20_0)

				return
			end, SFX_PANEL)
			setText(arg_20_2:Find("name_panel/name"), var_19_2[arg_20_1 + 1]:getConfig("name"))
			setText(arg_20_2:Find("name_panel/number"), "x " .. var_19_2[arg_20_1 + 1].curCount)
		end

		return
	end)

	local var_19_3 = {}
	local var_19_4 = {}

	for iter_19_0, iter_19_1 in pairs(self.resolveItems) do
		local var_19_6 = Item.getConfigData(iter_19_1.id)

		assert(var_19_6, "Can't find the price " .. iter_19_1.id)

		var_19_3[var_19_6.price[1]] = (var_19_3[var_19_6.price[1]] or 0) + var_19_6.price[2] * iter_19_1.count
	end

	for iter_19_2, iter_19_3 in pairs(var_19_3) do
		table.insert(var_19_4, {
			type = DROP_TYPE_RESOURCE,
			id = iter_19_2,
			count = iter_19_3
		})
	end

	UIItemList.StaticAlign(var_19_1, var_19_1:Find("item"), #var_19_4, function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			local var_22_0 = var_19_4[arg_22_1 + 1]

			updateDrop(arg_22_2:Find("icon"), var_19_4[arg_22_1 + 1])
			onButton(self, arg_22_2:Find("icon/icon_bg"), function()
				self:emit(BaseUI.ON_DROP, var_22_0)

				return
			end, SFX_PANEL)
			setText(arg_22_2:Find("name_panel/name"), var_19_4[arg_22_1 + 1]:getConfig("name"))
			setText(arg_22_2:Find("name_panel/number"), "x " .. var_19_4[arg_22_1 + 1].count)
		end

		return
	end)
	onButton(self, self.resolvePanel:Find("cancel_button"), function()
		self:Back()

		return
	end)
	onButton(self, self.resolvePanel:Find("destroy_button"), function()
		self:emit(NewShopMainMediator.SELL_BLUEPRINT, self.resolveItems)

		return
	end)

	return
end

function FragResolvePanel.GetAllBluePrintStrengthenItems()
	local var_26_0 = {}
	local var_26_1 = getProxy(TechnologyProxy)
	local var_26_2 = getProxy(BagProxy)

	for iter_26_0, iter_26_1 in ipairs(pg.ship_data_blueprint.all) do
		if var_26_1:getBluePrintById(iter_26_1):isMaxLevel() then
			local var_26_3 = var_26_2:getItemById(pg.ship_data_blueprint[iter_26_1].strengthen_item)

			if var_26_3 then
				local var_26_4 = var_26_3.count

				if var_26_3 and var_26_3.count > 0 and FragResolvePanel.keepFateState then
					var_26_4 = var_26_3.count - var_26_1:getBluePrintById(var_26_1:GetBlueprint4Item(pg.ship_data_blueprint[iter_26_1].strengthen_item)):getFateMaxLeftOver()
					var_26_4 = var_26_4 < 0 and 0 or var_26_4
				end

				table.insert(var_26_0, Drop.New({
					id = var_26_3.id,
					type = DROP_TYPE_ITEM,
					count = var_26_3.count,
					maxCount = var_26_4
				}))
			end
		end
	end

	return var_26_0
end

function FragResolvePanel:Trigger(arg_27_1)
	if self.toggles[arg_27_1] then
		self.buffer:Show()
		triggerToggle(self.toggles[arg_27_1], true)
	end

	return
end

function FragResolvePanel:Back()
	if getToggleState(self.toggles.resolve) then
		triggerToggle(self.toggles.control, true)
	elseif getToggleState(self.toggles.control) then
		self:Hide()
	end

	return
end

return FragResolvePanel
