local MainBuffDesMsgbox = class("MainBuffDesMsgbox", import("view.base.BaseSubView"))

function MainBuffDesMsgbox:getUIName()
	return "MainBuffDescMsgboxUI"
end

function MainBuffDesMsgbox:OnLoaded()
	self.singleBuffMask = self._tf:Find("bg")
	self.singleSureBtn = self._tf:Find("window/top/btnBack")
	self.singleCloseBtn = self._tf:Find("window/sure_btn")
	self.singleDescContent = self._tf:Find("window/panel/intro_view/Viewport/Content")
	self.singleDescTpl = self._tf:Find("window/panel/intro_view/buff_desc_tpl")
	self.f2aPanel = self._tf:Find("window/panel/icon/f_to_a")
	self.sPanel = self._tf:Find("window/panel/icon/s_ss")
	self.sssPanel = self._tf:Find("window/panel/icon/sss")
	self.lvBarImages = self._tf:Find("bg/lv_bars")
	self.lvTagImages = self._tf:Find("bg/lv_tags")

	setText(self._tf:Find("window/top/bg/infomation/title"), i18n("words_information"))
	setText(self._tf:Find("window/sure_btn/pic"), i18n("text_confirm"))

	return
end

function MainBuffDesMsgbox:OnInit()
	onButton(self, self.singleBuffMask, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.singleCloseBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.singleSureBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function MainBuffDesMsgbox:Show(arg_7_1)
	MainBuffDesMsgbox.super.Show(self)
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	local var_7_0 = getProxy(ActivityProxy):RawGetActivityById(arg_7_1)

	assert(var_7_0, "activity should exist" .. arg_7_1)

	self.ptData = ActivityPtData.New(var_7_0)

	self:UpdateLevelPanel()
	self:UpdateContent()

	return
end

function MainBuffDesMsgbox:UpdateContent()
	for iter_8_0, iter_8_1 in ipairs(self.ptData:GetCurBuffInfos() or {}) do
		setText(iter_8_0 <= self.singleDescContent.childCount and self.singleDescContent:GetChild(iter_8_0 - 1) or cloneTplTo(self.singleDescTpl, self.singleDescContent), pg.benefit_buff_template[iter_8_1.id].name .. pg.benefit_buff_template[iter_8_1.id].desc)
	end

	return
end

function MainBuffDesMsgbox:UpdateLevelPanel()
	local var_9_0, var_9_1 = self.ptData:GetBuffLevelProgress()

	self.curPanel = nil
	self.curPanel = var_9_0 == 9 and self.sssPanel or var_9_0 > 6 and self.sPanel or self.f2aPanel

	setActive(self.f2aPanel, self.curPanel == self.f2aPanel)
	setActive(self.sPanel, self.curPanel == self.sPanel)
	setActive(self.sssPanel, self.curPanel == self.sssPanel)
	setImageSprite(self.curPanel:Find("bar"), self.lvBarImages:Find(var_9_0):GetComponent(typeof(Image)).sprite)
	setImageSprite(self.curPanel:Find("lv_tag"), self.lvTagImages:Find(var_9_0):GetComponent(typeof(Image)).sprite, true)
	setSlider(self.curPanel, 0, 1, var_9_1)

	return
end

function MainBuffDesMsgbox:Hide()
	MainBuffDesMsgbox.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

return MainBuffDesMsgbox
