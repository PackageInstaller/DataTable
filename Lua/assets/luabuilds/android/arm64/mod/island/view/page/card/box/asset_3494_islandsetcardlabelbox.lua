local IslandSetCardLabelBox = class("IslandSetCardLabelBox", import("view.base.BaseSubView"))

function IslandSetCardLabelBox:getUIName()
	return "IslandSetCardLabelBox"
end

function IslandSetCardLabelBox:OnLoaded()
	setText(self._tf:Find("frame/title"), i18n("island_card_choose_label", 1, 1))
	setActive(self._tf:Find("empty"), false)

	self.closeBtn = self._tf:Find("frame/close")
	self.cancelBtn = self._tf:Find("cancel")

	setText(self.cancelBtn:Find("Text"), i18n("word_cancel"))

	self.confirmBtn = self._tf:Find("confirm")

	setText(self.confirmBtn:Find("Text"), i18n("word_ok"))

	self.scrollRect = self._tf:Find("scrollrect"):GetComponent("LScrollRect")

	function self.scrollRect.onInitItem(arg_3_0)
		self:OnInitItem(arg_3_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	return
end

function IslandSetCardLabelBox:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		self:emit(IslandOtherCardMediator.GIVE_CARD_LABEL, self.userId, self.selectedId)

		return
	end, SFX_PANEL)

	self.cards = {}

	return
end

function IslandSetCardLabelBox:OnInitItem(arg_9_1)
	self.cards[arg_9_1] = IslandCardSetLabelCard.New(arg_9_1)

	return
end

function IslandSetCardLabelBox:OnUpdateItem(arg_10_1, arg_10_2)
	local var_10_0 = self.cards[arg_10_2]

	if not self.cards[arg_10_2] then
		self:OnInitItem(arg_10_2)

		var_10_0 = self.cards[arg_10_2]
	end

	local var_10_1 = self.ids[arg_10_1 + 1]

	if self.ids[arg_10_1 + 1] then
		var_10_0:Update(var_10_1, (self.labelData[var_10_1] or nil) and (self.labelData[var_10_1].num or 0), self.selectedId)
	end

	onButton(self, var_10_0._go, function()
		for iter_11_0, iter_11_1 in pairs(self.cards) do
			iter_11_1:UpdateSelected(nil)
		end

		self.selectedId = var_10_1

		var_10_0:UpdateSelected(self.selectedId)

		return
	end, SFX_PANEL)

	if self.triggerFirstCard and arg_10_1 == 0 then
		self.triggerFirstCard = nil

		triggerButton(var_10_0._go)
	end

	return
end

function IslandSetCardLabelBox:Show(arg_12_1, arg_12_2)
	IslandSetCardLabelBox.super.Show(self)

	self.userId = arg_12_1
	self.ids = pg.island_card_label.all
	self.labelData = arg_12_2
	self.triggerFirstCard = true

	self.scrollRect:SetTotalCount(#self.ids, -1)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function IslandSetCardLabelBox:Hide()
	IslandSetCardLabelBox.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function IslandSetCardLabelBox:OnDestroy()
	ClearLScrollrect(self.scrollRect)

	for iter_14_0, iter_14_1 in pairs(self.cards) do
		iter_14_1:Dispose()
	end

	self.cards = {}

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

return IslandSetCardLabelBox
