local RandomDockYardMsgBoxPgae = class("RandomDockYardMsgBoxPgae", import("view.base.BaseSubView"))

function RandomDockYardMsgBoxPgae:getUIName()
	return "RandomDockYardMsgBoxUI"
end

function RandomDockYardMsgBoxPgae:OnLoaded()
	self.closeBtn = self._tf:Find("frame/top/btnBack")
	self.cancelBtn = self._tf:Find("frame/cancel_button")
	self.confirmBtn = self._tf:Find("frame/confirm_button")
	self.scrollrect = self._tf:Find("frame/sliders"):GetComponent("LScrollRect")
	self.titleTxt = self._tf:Find("frame/top/title_list/infomation/title"):GetComponent(typeof(Text))
	self.titleEnTxt = self._tf:Find("frame/top/title_list/infomation/title_en"):GetComponent(typeof(Text))
	self.subTitleTxt = self._tf:Find("frame/label/Text"):GetComponent(typeof(Text))

	setText(self._tf:Find("frame/confirm_button/pic"), i18n("text_confirm"))
	setText(self._tf:Find("frame/cancel_button/pic"), i18n("text_cancel"))

	return
end

function RandomDockYardMsgBoxPgae:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if self.callback then
			self.callback()
		end

		self:Hide()

		return
	end, SFX_PANEL)

	self.cards = {}

	function self.scrollrect.onUpdateItem(arg_8_0, arg_8_1)
		self:OnUpdateItem(arg_8_0, arg_8_1)

		return
	end

	function self.scrollrect.onInitItem(arg_9_0)
		self:OnInitItem(arg_9_0)

		return
	end

	return
end

function RandomDockYardMsgBoxPgae:OnInitItem(arg_10_1)
	self.cards[arg_10_1] = RandomDockYardCard.New(arg_10_1)

	return
end

function RandomDockYardMsgBoxPgae:OnUpdateItem(arg_11_1, arg_11_2)
	local var_11_0 = self.cards[arg_11_2]

	if not self.cards[arg_11_2] then
		self:OnInitItem(arg_11_2)

		var_11_0 = self.cards[arg_11_2]
	end

	var_11_0:Update(getProxy(BayProxy):RawGetShipById(self.shipIds[arg_11_1 + 1]), false)

	return
end

function RandomDockYardMsgBoxPgae:Flush(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	self:Show()
	self:UpdateTitle(arg_12_1)
	self:UpdateSubTitle(arg_12_2)
	self:UpdateList(arg_12_3)

	self.callback = arg_12_4

	return
end

function RandomDockYardMsgBoxPgae:UpdateTitle(arg_13_1)
	self.titleTxt.text = arg_13_1.cn
	self.titleEnTxt.text = arg_13_1.en

	return
end

function RandomDockYardMsgBoxPgae:UpdateSubTitle(arg_14_1)
	self.subTitleTxt.text = arg_14_1

	return
end

function RandomDockYardMsgBoxPgae:UpdateList(arg_15_1)
	self.shipIds = arg_15_1

	self.scrollrect:SetTotalCount(#self.shipIds)

	return
end

function RandomDockYardMsgBoxPgae:Show()
	RandomDockYardMsgBoxPgae.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function RandomDockYardMsgBoxPgae:Hide()
	self.callback = nil
	self.shipIds = nil

	for iter_17_0, iter_17_1 in pairs(self.cards) do
		iter_17_1:Dispose()
	end

	self.cards = {}

	RandomDockYardMsgBoxPgae.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function RandomDockYardMsgBoxPgae:OnDestroy()
	self:Hide()

	return
end

return RandomDockYardMsgBoxPgae
