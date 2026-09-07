local AssignedItemPanel = class("AssignedItemPanel")

function AssignedItemPanel:Ctor(arg_1_1, arg_1_2)
	pg.DelegateInfo.New(self)

	self._go = arg_1_1
	self._tf = tf(arg_1_1)
	self.isInited = false
	self.selectedVO = nil
	self.count = 1
	self.view = arg_1_2

	return
end

function AssignedItemPanel:show()
	setActive(self._tf, true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function AssignedItemPanel:hide()
	setActive(self._tf, false)

	self.selectedVO = nil
	self.itemVO = nil
	self.count = 1

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self.view._tf)

	if self.selectedItem then
		triggerToggle(self.selectedItem, false)
	end

	self.selectedItem = nil

	return
end

function AssignedItemPanel:init()
	self.isInited = true
	self.ulist = UIItemList.New(self._tf:Find("got/bottom/scroll/list"), self._tf:Find("got/bottom/scroll/list/tpl"))
	self.confirmBtn = self._tf:Find("calc/confirm")
	self.rightArr = self._tf:Find("calc/value_bg/add")
	self.leftArr = self._tf:Find("calc/value_bg/mius")
	self.maxBtn = self._tf:Find("calc/max")
	self.valueText = self._tf:Find("calc/value_bg/Text")
	self.itemTF = self._tf:Find("item/bottom/item")
	self.nameTF = self._tf:Find("item/bottom/name_bg/name")
	self.descTF = self._tf:Find("item/bottom/desc")

	onButton(self, self._tf, function()
		self:hide()

		return
	end, SFX_PANEL)
	onButton(self, self.rightArr, function()
		if not self.itemVO then
			return
		end

		self.count = math.min(self.count + 1, self.itemVO.count)

		self:updateValue()

		return
	end, SFX_PANEL)
	onButton(self, self.leftArr, function()
		if not self.itemVO then
			return
		end

		self.count = math.max(self.count - 1, 1)

		self:updateValue()

		return
	end, SFX_PANEL)
	onButton(self, self.maxBtn, function()
		if not self.itemVO then
			return
		end

		self.count = self.itemVO.count

		self:updateValue()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if not self.selectedVO or not self.itemVO or self.count <= 0 then
			return
		end

		self.view:emit(EquipmentMediator.ON_USE_ITEM, self.itemVO.id, self.count, self.selectedVO)
		self:hide()

		return
	end, SFX_PANEL)

	return
end

function AssignedItemPanel:updateValue()
	setText(self.valueText, self.count)
	self.ulist:each(function(arg_11_0, arg_11_1)
		setText(arg_11_1:Find("item/bg/icon_bg/count"), self.count)

		return
	end)

	return
end

function AssignedItemPanel:update(arg_12_1)
	self.itemVO = arg_12_1

	if not self.isInited then
		self:init()
	end

	local var_12_0 = arg_12_1:getConfig("display_icon")

	self.selectedItem = nil

	self.ulist:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			local var_13_0 = var_12_0[arg_13_1 + 1]
			local var_13_1 = {
				type = var_12_0[arg_13_1 + 1][1],
				id = var_12_0[arg_13_1 + 1][2],
				count = var_12_0[arg_13_1 + 1][3]
			}

			updateDrop(arg_13_2:Find("item/bg"), var_13_1)

			local var_13_2 = arg_13_2:Find("item/bg/icon_bg/count")

			onToggle(self, arg_13_2, function(arg_14_0)
				if arg_14_0 then
					self.selectedVO = arg_12_1:getConfig("usage_arg")[arg_13_1 + 1]

					setText(var_13_2, self.count * var_13_0[3])

					self.selectedItem = arg_13_2
				end

				return
			end, SFX_PANEL)
			setScrollText(arg_13_2:Find("name_bg/Text"), var_13_1:getConfig("name"))
		end

		return
	end)
	self.ulist:align(#var_12_0)
	self:updateValue()
	updateDrop(self.itemTF:Find("bg"), {
		type = DROP_TYPE_ITEM,
		id = arg_12_1.id,
		count = arg_12_1.count
	})
	setText(self.nameTF, arg_12_1:getConfig("name"))
	setText(self.descTF, arg_12_1:getConfig("display"))

	return
end

function AssignedItemPanel:dispose()
	pg.DelegateInfo.Dispose(self)

	return
end

return AssignedItemPanel
