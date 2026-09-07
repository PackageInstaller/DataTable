local WorldAssignedItemView = class("WorldAssignedItemView", import("..base.BaseSubView"))

function WorldAssignedItemView:getUIName()
	return "StoreHouseItemAssignedView"
end

function WorldAssignedItemView:OnInit()
	local var_2_0 = self._tf:Find("operate")

	self.ulist = UIItemList.New(var_2_0:Find("got/bottom/list"), var_2_0:Find("got/bottom/list/tpl"))
	self.confirmBtn = var_2_0:Find("actions/confirm")

	setText(self.confirmBtn:Find("Image"), i18n("text_confirm"))

	self.cancelBtn = var_2_0:Find("actions/cancel")

	setText(self.cancelBtn:Find("Image"), i18n("text_cancel"))

	self.rightArr = var_2_0:Find("calc/value_bg/add")
	self.leftArr = var_2_0:Find("calc/value_bg/mius")
	self.maxBtn = var_2_0:Find("calc/max")
	self.valueText = var_2_0:Find("calc/value_bg/Text")
	self.itemTF = var_2_0:Find("item")
	self.nameTF = var_2_0:Find("item/display_panel/name_container/name/Text")
	self.descTF = var_2_0:Find("item/display_panel/desc/Text")

	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	pressPersistTrigger(self.rightArr, 0.5, function(arg_5_0)
		if not self.itemVO then
			arg_5_0()

			return
		end

		self.count = math.min(self.count + 1, self.itemVO.count)

		self:updateValue()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(self.leftArr, 0.5, function(arg_6_0)
		if not self.itemVO then
			arg_6_0()

			return
		end

		self.count = math.max(self.count - 1, 1)

		self:updateValue()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(self, self.maxBtn, function()
		if not self.itemVO then
			return
		end

		self.count = self.itemVO.count

		self:updateValue()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if not self.selectedIndex or not self.itemVO or self.count <= 0 then
			return
		end

		self:emit(WorldInventoryMediator.OnUseItem, self.itemVO.id, self.count, self.itemVO:getConfig("usage_arg")[self.selectedIndex])
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function WorldAssignedItemView:Show()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setActive(self._tf, true)

	return
end

function WorldAssignedItemView:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	setActive(self._tf, false)

	return
end

function WorldAssignedItemView:updateValue()
	setText(self.valueText, self.count)
	self.ulist:each(function(arg_12_0, arg_12_1)
		if not isActive(arg_12_1) then
			return
		end

		setText(arg_12_1:Find("item/icon_bg/count"), self.count)

		return
	end)

	return
end

function WorldAssignedItemView:update(arg_13_1)
	self.count = 1
	self.selectedIndex = nil
	self.selectedItem = nil
	self.itemVO = arg_13_1
	self.displayDrops = underscore.map(arg_13_1:getConfig("usage_arg"), function(arg_14_0)
		return {
			type = arg_14_0[1],
			id = arg_14_0[2],
			count = arg_14_0[3]
		}
	end)

	self.ulist:make(function(arg_15_0, arg_15_1, arg_15_2)
		arg_15_1 = arg_15_1 + 1

		if arg_15_0 == UIItemList.EventUpdate then
			updateDrop(arg_15_2:Find("item"), self.displayDrops[arg_15_1])

			local var_15_0 = arg_15_2:Find("item/icon_bg/count")

			onToggle(self, arg_15_2, function(arg_16_0)
				if arg_16_0 then
					self.selectedIndex = arg_15_1
					self.selectedItem = arg_15_2
				elseif self.selectedIndex == arg_15_1 then
					self.selectedIndex = nil
					self.selectedItem = nil
				end

				return
			end, SFX_PANEL)
			setScrollText(arg_15_2:Find("name_bg/Text"), self.displayDrops[arg_15_1]:getConfig("name"))

			self.selectedItem = self.selectedItem or arg_15_2
		end

		return
	end)
	self.ulist:align(#self.displayDrops)
	triggerToggle(self.selectedItem, true)
	self:updateValue()

	local var_13_0 = Drop.New({
		type = arg_13_1.type,
		id = arg_13_1.id,
		count = arg_13_1.count
	})

	updateDrop(self.itemTF:Find("left/IconTpl"), setmetatable({
		count = 0
	}, {
		__index = var_13_0
	}))
	UpdateOwnDisplay(self.itemTF:Find("left/own"), var_13_0)
	setText(self.nameTF, arg_13_1:getConfig("name"))
	setText(self.descTF, arg_13_1:getConfig("display"))

	return
end

return WorldAssignedItemView
