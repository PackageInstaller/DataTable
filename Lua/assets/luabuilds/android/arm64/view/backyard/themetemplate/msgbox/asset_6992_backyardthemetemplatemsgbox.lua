local BackYardThemeTemplateMsgBox = class("BackYardThemeTemplateMsgBox", import("....base.BaseSubView"))

BackYardThemeTemplateMsgBox.TYPE_TEXT = 1
BackYardThemeTemplateMsgBox.TYPE_IMAGE = 2

function BackYardThemeTemplateMsgBox:getUIName()
	return "BackYardThemeTemplateMsgBox"
end

function BackYardThemeTemplateMsgBox:OnLoaded()
	self.frame = self._tf:Find("window1")
	self.content = self._tf:Find("window1/content"):GetComponent(typeof(Text))
	self.frame1 = self._tf:Find("window2")
	self.content1 = self._tf:Find("window2/content"):GetComponent(typeof(Text))
	self.icon = self._tf:Find("window2/mask/Icon"):GetComponent(typeof(RawImage))
	self.cancelBtn = self._tf:Find("btns/cancel")
	self.cancelBtnTxt = self._tf:Find("btns/cancel/Text"):GetComponent(typeof(Text))
	self.confirmBtn = self._tf:Find("btns/confirm")
	self.confirmBtnTxt = self._tf:Find("btns/confirm/Text"):GetComponent(typeof(Text))
	self._parentTF = self._tf.parent

	setText(self._tf:Find("title"), i18n("words_information"))

	return
end

function BackYardThemeTemplateMsgBox:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		if self.onCancel then
			self.onCancel()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		self:Hide()

		if self.onYes then
			self.onYes()
		end

		return
	end, SFX_PANEL)

	return
end

function BackYardThemeTemplateMsgBox:SetUp(arg_7_1)
	self.onYes = arg_7_1.onYes
	self.onCancel = arg_7_1.onCancel
	self.cancelBtnTxt.text = arg_7_1.cancelTxt or i18n("word_cancel")
	self.confirmBtnTxt.text = arg_7_1.confirmTxt or i18n("word_ok")

	local var_7_0 = arg_7_1.type or BackYardThemeTemplateMsgBox.TYPE_TEXT

	if var_7_0 == BackYardThemeTemplateMsgBox.TYPE_TEXT then
		self.content.text = arg_7_1.content
	elseif var_7_0 == BackYardThemeTemplateMsgBox.TYPE_IMAGE then
		self.content1.text = arg_7_1.content

		BackYardThemeTempalteUtil.GetNonCacheTexture(arg_7_1.srpiteName, arg_7_1.md5, function(arg_8_0)
			if not IsNil(self.icon) and arg_8_0 then
				self.icon.texture = arg_8_0
			end

			return
		end)
	end

	setActive(self.frame, var_7_0 == BackYardThemeTemplateMsgBox.TYPE_TEXT)
	setActive(self.frame1, var_7_0 == BackYardThemeTemplateMsgBox.TYPE_IMAGE)
	setActive(self.cancelBtn, not arg_7_1.hideNo)
	self:Show()

	return
end

function BackYardThemeTemplateMsgBox:Show()
	BackYardThemeTemplateMsgBox.super.Show(self)
	SetParent(self._tf, pg.UIMgr.GetInstance().OverlayMain)

	return
end

function BackYardThemeTemplateMsgBox:Hide()
	if not IsNil(self.icon.texture) then
		Object.Destroy(self.icon.texture)

		self.icon.texture = nil
	end

	BackYardThemeTemplateMsgBox.super.Hide(self)
	SetParent(self._tf, self._parentTF)

	return
end

function BackYardThemeTemplateMsgBox:OnDestroy()
	self:Hide()

	return
end

return BackYardThemeTemplateMsgBox
