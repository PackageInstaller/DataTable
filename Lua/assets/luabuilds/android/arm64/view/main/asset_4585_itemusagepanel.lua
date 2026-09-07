local ItemUsagePanel = class("ItemUsagePanel")

ItemUsagePanel.SINGLE = 1
ItemUsagePanel.BATCH = 2
ItemUsagePanel.INFO = 3
ItemUsagePanel.SEE = 4

function ItemUsagePanel:Ctor(arg_1_1, arg_1_2)
	pg.DelegateInfo.New(self)

	self._go = arg_1_1

	setActive(self._go, false)

	self._parent = arg_1_2
	self.backBtn = findTF(self._go, "window/top/btnBack")
	self.itemTF = findTF(self._go, "window/item")
	self.itemIntro = findTF(self.itemTF, "display_panel/desc/Text")
	self.itemName = findTF(self.itemTF, "display_panel/name_container/name/Text")
	self.resetBtn = findTF(self.itemTF, "reset_btn")
	self.useBtn = findTF(self._go, "window/actions/use_one_button")

	setActive(self.useBtn, false)

	self.batchUseBtn = findTF(self._go, "window/actions/batch_use_button")

	setActive(self.batchUseBtn, false)

	self.useOneBtn = findTF(self._go, "window/actions/use_button")

	setActive(self.useOneBtn, false)

	self.confirmBtn = findTF(self._go, "window/actions/confirm_button")

	setActive(self.confirmBtn, false)

	self.seeBtn = findTF(self._go, "window/actions/see_button")

	setActive(self.seeBtn, false)

	self.batchText = self.batchUseBtn:Find("text")

	onButton(self, self.backBtn, function()
		self:Close()

		return
	end, SFX_PANEL)
	onButton(self, findTF(self._go, "bg"), function()
		self:Close()

		return
	end, SFX_PANEL)

	return
end

function ItemUsagePanel:Open(arg_4_1)
	self.settings = arg_4_1 or {}

	self:Update(self.settings.item)
	self:UpdateAction(self.settings.item)
	setActive(self.resetBtn, true)
	setActive(self._go, true)
	pg.UIMgr.GetInstance():BlurPanel(self._go)

	return
end

function ItemUsagePanel:Close()
	self.settings = nil

	setActive(self._go, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._go, self._parent)

	return
end

function ItemUsagePanel:Update(arg_6_1)
	local var_6_0 = Drop.New({
		type = DROP_TYPE_WORLD_ITEM,
		id = arg_6_1.id,
		count = arg_6_1.count
	})

	updateDrop(self.itemTF:Find("left/IconTpl"), var_6_0)
	UpdateOwnDisplay(self.itemTF:Find("left/own"), var_6_0)
	RegisterDetailButton(self, self.itemTF:Find("left/detail"), var_6_0)
	setText(self.itemIntro, arg_6_1:getConfig("display"))
	setText(self.itemName, arg_6_1:getConfig("name"))
	onButton(self, self.resetBtn, function()
		assert(self.settings.onResetInfo, "without reset info callback")
		self.settings.onResetInfo(Drop.New({
			count = 1,
			type = DROP_TYPE_WORLD_ITEM,
			id = arg_6_1.id
		}))

		return
	end, SFX_PANEL)

	return
end

function ItemUsagePanel:UpdateAction(arg_8_1)
	local var_8_0 = self.settings
	local var_8_1 = self.settings.mode or ItemUsagePanel.SINGLE

	setActive(self.useBtn, var_8_1 == ItemUsagePanel.SINGLE)
	setActive(self.batchUseBtn, var_8_1 == ItemUsagePanel.BATCH)
	setActive(self.useOneBtn, var_8_1 == ItemUsagePanel.BATCH)
	setActive(self.confirmBtn, var_8_1 == ItemUsagePanel.INFO)
	setActive(self.seeBtn, var_8_1 == ItemUsagePanel.SEE)

	if var_8_1 == ItemUsagePanel.SINGLE then
		onButton(self, self.useBtn, function()
			if arg_8_1.count == 0 then
				return
			end

			if var_8_0.onUse then
				var_8_0.onUse()
			end

			self:Close()

			return
		end, SFX_PANEL)
	elseif var_8_1 == ItemUsagePanel.BATCH then
		local var_8_2 = math.min(arg_8_1.count, 10)

		setText(self.batchText, var_8_2)
		onButton(self, self.batchUseBtn, function()
			if arg_8_1.count == 0 then
				return
			end

			if var_8_0.onUseBatch then
				var_8_0.onUseBatch(var_8_2)
			end

			self:Close()

			return
		end, SFX_PANEL)
		onButton(self, self.useOneBtn, function()
			if arg_8_1.count == 0 then
				return
			end

			if var_8_0.onUseOne then
				var_8_0.onUseOne()
			end

			self:Close()

			return
		end, SFX_PANEL)
		setActive(self.batchUseBtn, var_8_2 > 1)
	elseif var_8_1 == ItemUsagePanel.INFO then
		onButton(self, self.confirmBtn, function()
			self:Close()

			return
		end, SFX_PANEL)
	elseif var_8_1 == ItemUsagePanel.SEE then
		onButton(self, self.seeBtn, function()
			if arg_8_1.count == 0 then
				return
			end

			if var_8_0.onUse then
				var_8_0.onUse()
			end

			self:Close()

			return
		end, SFX_PANEL)
	end

	return
end

function ItemUsagePanel:Dispose()
	pg.DelegateInfo.Dispose(self)
	self:Close()

	return
end

return ItemUsagePanel
