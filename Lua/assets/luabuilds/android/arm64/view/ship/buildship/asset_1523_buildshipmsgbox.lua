local BuildShipMsgBox = class("BuildShipMsgBox", import("...base.BaseSubView"))

function BuildShipMsgBox:getUIName()
	return "BuildShipMsgBoxUI"
end

function BuildShipMsgBox:OnLoaded()
	self.cancenlBtn = findTF(self._go, "window/btns/cancel_btn")
	self.confirmBtn = findTF(self._go, "window/btns/confirm_btn")
	self.closeBtn = findTF(self._go, "window/close_btn")
	self.count = 1
	self.minusBtn = findTF(self._go, "window/content/calc_panel/minus")
	self.addBtn = findTF(self._go, "window/content/calc_panel/add")
	self.maxBtn = findTF(self._go, "window/content/max")
	self.valueTxt = findTF(self._go, "window/content/calc_panel/Text"):GetComponent(typeof(Text))
	self.text = findTF(self._go, "window/content/Text"):GetComponent(typeof(Text))

	setText(self._tf:Find("window/btns/cancel_btn/Image/Image (1)"), i18n("text_cancel"))
	setText(self._tf:Find("window/btns/confirm_btn/Image/Image (1)"), i18n("text_confirm"))

	return
end

function BuildShipMsgBox:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancenlBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if self.onConfirm then
			self.onConfirm(self.count)
		end

		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.minusBtn, function()
		self.count = math.max(self.count - 1, 1)

		self:updateTxt(self.count)

		return
	end, SFX_PANEL)
	onButton(self, self.addBtn, function()
		if self.buildType == "ticket" and self.count >= self.itemVO.count then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tip_build_ticket_not_enough", self.itemVO:getConfig("name")))

			return
		end

		self.count = math.clamp(self.count + 1, 1, MAX_BUILD_WORK_COUNT)

		self:updateTxt(self.count)

		return
	end, SFX_PANEL)
	onButton(self, self.maxBtn, function()
		self.count = MAX_BUILD_WORK_COUNT

		if self.buildType == "ticket" then
			self.count = math.clamp(self.itemVO.count, 1, MAX_BUILD_WORK_COUNT)
		end

		self:updateTxt(self.count)

		return
	end, SFX_PANEL)

	return
end

function BuildShipMsgBox:updateTxt(arg_11_1)
	self.valueTxt.text = arg_11_1
	self.text.text = self:GetDesc(arg_11_1)

	return
end

function BuildShipMsgBox:GetDesc(arg_12_1)
	local var_12_0 = ""

	switch(self.buildType, {
		base = function()
			var_12_0 = arg_12_1 <= self.max and self.player.gold >= arg_12_1 * self.buildPool.use_gold and self.itemVO.count >= arg_12_1 * self.buildPool.number_1 and i18n("build_ship_tip", arg_12_1, self.buildPool.name, arg_12_1 * self.buildPool.use_gold, arg_12_1 * self.buildPool.number_1, COLOR_GREEN) or i18n("build_ship_tip", arg_12_1, self.buildPool.name, arg_12_1 * self.buildPool.use_gold, arg_12_1 * self.buildPool.number_1, COLOR_RED)

			return
		end,
		ticket = function()
			var_12_0 = arg_12_1 <= self.max and self.itemVO.count >= arg_12_1 and i18n("build_ship_tip_use_ticket", arg_12_1, self.buildPool.name, arg_12_1, self.itemVO:getConfig("name"), COLOR_GREEN) or i18n("build_ship_tip_use_ticket", arg_12_1, self.buildPool.name, arg_12_1, self.itemVO:getConfig("name"), COLOR_RED)

			return
		end,
		medal = function()
			var_12_0 = arg_12_1 <= self.max and self.itemVO.count >= arg_12_1 * self.cost and i18n("honor_medal_support_tips_confirm", arg_12_1, arg_12_1 * self.cost, COLOR_GREEN) or i18n("honor_medal_support_tips_confirm", arg_12_1, arg_12_1 * self.cost, COLOR_RED)

			return
		end
	})

	return ""
end

function BuildShipMsgBox:Show(arg_16_1)
	self.showing = true

	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		self[iter_16_0] = iter_16_1
	end

	self.count = 1

	self:updateTxt(self.count)
	setText(self._tf:Find("window/content/title"), i18n(self.buildType == "medal" and "support_times_tip" or "build_times_tip"))
	setActiveViaLayer(self._go, true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function BuildShipMsgBox:Hide()
	self.showing = false

	if self._go then
		self.onConfirm = nil
		self.count = 1
		self.max = 1

		setActiveViaLayer(self._go, false)
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function BuildShipMsgBox:isShowing()
	return self.showing
end

function BuildShipMsgBox:OnDestroy()
	self:Hide()

	return
end

return BuildShipMsgBox
