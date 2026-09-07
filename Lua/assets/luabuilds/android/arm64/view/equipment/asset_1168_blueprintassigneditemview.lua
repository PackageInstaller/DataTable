local BlueprintAssignedItemView = class("BlueprintAssignedItemView", import(".AssignedItemView"))

function BlueprintAssignedItemView:getUIName()
	return "BlueprintItemAssignedView"
end

function BlueprintAssignedItemView:OnInit()
	BlueprintAssignedItemView.super.OnInit(self)

	self.countOver = self._tf:Find("operate/calc/value_bg/over_count")

	setText(self.countOver, i18n("blueprint_select_overflow"))
	onButton(self, self.maxBtn, function()
		if not self.itemVO or not self.selectedIndex then
			return
		end

		local var_3_0 = self.displayDrops[self.selectedIndex]
		local var_3_1 = self:GetBlueprintNeed(self.displayDrops[self.selectedIndex].id)

		if self.count * self.displayDrops[self.selectedIndex].count < var_3_1 then
			self.count = math.floor((var_3_1 + var_3_0.count - 1) / var_3_0.count)
			self.count = math.min(self.count, self.itemVO.count)
		else
			self.count = self.itemVO.count
		end

		self:updateValue()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if not self.selectedIndex or not self.itemVO or self.count <= 0 then
			return
		end

		local var_4_0 = self.displayDrops[self.selectedIndex]
		local var_4_1 = self.count * self.displayDrops[self.selectedIndex].count
		local var_4_2 = self:GetBlueprintNeed(self.displayDrops[self.selectedIndex].id)
		local var_4_3 = {}

		if self.isSwitch and not self:checkBlueprintIsFate(var_4_0.id) then
			if self.count * self.displayDrops[self.selectedIndex].count <= var_4_2 then
				table.insert(var_4_3, function(arg_5_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("blueprint_exchange_fate_unlock"),
						onYes = arg_5_0
					})

					return
				end)
			else
				table.insert(var_4_3, function(arg_6_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("blueprint_exchange_fate_unlock_over", var_4_0:getConfig("name"), var_4_1 - var_4_2),
						onYes = arg_6_0
					})

					return
				end)
			end
		elseif not self.isAllNeedZero and var_4_2 < self.count * self.displayDrops[self.selectedIndex].count then
			table.insert(var_4_3, function(arg_7_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("blueprint_select_overflow_tip", var_4_0:getConfig("name"), var_4_1 - var_4_2),
					onYes = arg_7_0
				})

				return
			end)
		end

		seriesAsync(var_4_3, function()
			self:emit(EquipmentMediator.ON_USE_ITEM, self.itemVO.id, self.count, self.itemVO:getConfig("usage_arg")[self.selectedIndex])
			self:Hide()

			return
		end)

		return
	end, SFX_PANEL)

	self.toggleSwitch = self._tf:Find("operate/got/top/switch_btn")

	setText(self.toggleSwitch:Find("Text_off"), i18n("show_fate_demand_count"))
	setText(self.toggleSwitch:Find("Text_on"), i18n("show_design_demand_count"))
	onToggle(self, self.toggleSwitch, function(arg_9_0)
		self.isSwitch = arg_9_0

		self:updateValue()

		return
	end, SFX_PANEL)
	setText(self._tf:Find("operate/got/top/info/Text"), i18n("fate_unlock_icon_desc"))

	return
end

function BlueprintAssignedItemView:GetBlueprintNeed(arg_10_1)
	self.technologyProxy = self.technologyProxy or getProxy(TechnologyProxy)

	local var_10_0 = self.technologyProxy:getBluePrintById(self.technologyProxy:GetBlueprint4Item(arg_10_1))

	self.bagProxy = self.bagProxy or getProxy(BagProxy)

	warning(self.isSwitch)

	return math.max(var_10_0:getUseageMaxItem() + (self.isSwitch and var_10_0:getFateMaxLeftOver() or 0) - self.bagProxy:getItemCountById(var_10_0:getItemId()), 0)
end

function BlueprintAssignedItemView:checkBlueprintIsUnlock(arg_11_1)
	self.technologyProxy = self.technologyProxy or getProxy(TechnologyProxy)

	return self.technologyProxy:getBluePrintById(self.technologyProxy:GetBlueprint4Item(arg_11_1)):isUnlock()
end

function BlueprintAssignedItemView:checkBlueprintIsFate(arg_12_1)
	self.technologyProxy = self.technologyProxy or getProxy(TechnologyProxy)

	return self.technologyProxy:getBluePrintById(self.technologyProxy:GetBlueprint4Item(arg_12_1)):IsFate()
end

function BlueprintAssignedItemView:updateValue()
	self.isAllNeedZero = underscore.all(self.displayDrops, function(arg_14_0)
		return self:GetBlueprintNeed(arg_14_0.id) == 0
	end)

	self:updateCountText()
	self.ulist:each(function(arg_15_0, arg_15_1)
		if not isActive(arg_15_1) then
			return
		end

		arg_15_0 = arg_15_0 + 1

		local var_15_0 = self.count * self.displayDrops[arg_15_0].count
		local var_15_1 = self:GetBlueprintNeed(self.displayDrops[arg_15_0].id)

		setText(arg_15_1:Find("item/icon_bg/count"), setColorStr(self.count * self.displayDrops[arg_15_0].count, not self.isAllNeedZero and var_15_1 < var_15_0 and "#FF5A5A" or "#FFEC6E") .. "/" .. var_15_1)

		return
	end)

	return
end

function BlueprintAssignedItemView:updateCountText()
	local var_16_0 = self.count * self.displayDrops[self.selectedIndex].count
	local var_16_1 = self:GetBlueprintNeed(self.displayDrops[self.selectedIndex].id)

	setText(self.valueText, not self.isAllNeedZero and var_16_1 < var_16_0 and setColorStr(self.count, "#FF5A5A") or self.count)
	setActive(self.countOver, not self.isAllNeedZero and var_16_1 < var_16_0)

	return
end

function BlueprintAssignedItemView:update(arg_17_1)
	self.count = 1
	self.selectedIndex = nil
	self.selectedItem = nil
	self.isSwitch = false
	self.itemVO = arg_17_1
	self.displayDrops = underscore.map(arg_17_1:getConfig("display_icon"), function(arg_18_0)
		return {
			type = arg_18_0[1],
			id = arg_18_0[2],
			count = arg_18_0[3]
		}
	end)

	self.ulist:make(function(arg_19_0, arg_19_1, arg_19_2)
		arg_19_1 = arg_19_1 + 1

		if arg_19_0 == UIItemList.EventUpdate then
			updateDrop(arg_19_2:Find("item"), self.displayDrops[arg_19_1])
			onToggle(self, arg_19_2, function(arg_20_0)
				if arg_20_0 then
					self.selectedIndex = arg_19_1
					self.selectedItem = arg_19_2

					self:updateCountText()
				end

				return
			end, SFX_PANEL)
			triggerToggle(arg_19_2, arg_19_1 == 1)
			setScrollText(arg_19_2:Find("name_bg/Text"), self.displayDrops[arg_19_1]:getConfig("name"))

			self.selectedItem = self.selectedItem or arg_19_2

			setText(arg_19_2:Find("item/tip/Text"), i18n("tech_character_get"))
			setActive(arg_19_2:Find("item/tip"), self:checkBlueprintIsUnlock(self.displayDrops[arg_19_1].id))
			setActive(arg_19_2:Find("fateFlag"), self:checkBlueprintIsFate(self.displayDrops[arg_19_1].id))
		end

		return
	end)
	self.ulist:align(#self.displayDrops)
	triggerToggle(self.selectedItem, true)
	triggerToggle(self.toggleSwitch, false)

	local var_17_0 = Drop.New({
		type = DROP_TYPE_ITEM,
		id = arg_17_1.id,
		count = arg_17_1.count
	})

	updateDrop(self.itemTF:Find("left/IconTpl"), setmetatable({
		count = 0
	}, {
		__index = var_17_0
	}))
	UpdateOwnDisplay(self.itemTF:Find("left/own"), var_17_0)
	setText(self.nameTF, arg_17_1:getConfig("name"))
	setText(self.descTF, arg_17_1:getConfig("display"))

	return
end

return BlueprintAssignedItemView
