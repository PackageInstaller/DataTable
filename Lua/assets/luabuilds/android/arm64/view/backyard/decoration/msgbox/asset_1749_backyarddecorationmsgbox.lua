local BackYardDecorationMsgBox = class("BackYardDecorationMsgBox", import("....base.BaseSubView"))

function BackYardDecorationMsgBox:getUIName()
	return "BackYardDecorationMsgBox"
end

function BackYardDecorationMsgBox:OnLoaded()
	self.frame = self._tf:Find("frame")
	self.cancelBtn = self._tf:Find("frame/control/cancel_btn")
	self.deleteBtn = self._tf:Find("frame/control/delete_btn")
	self.saveBtn = self._tf:Find("frame/control/save_btn")
	self.applyBtn = self._tf:Find("frame/control/set_btn")
	self.input = self._tf:Find("frame/bound/input")
	self.inputField = self._tf:Find("frame/bound/input/InputField")
	self.desc = self._tf:Find("frame/bound/desc"):GetComponent(typeof(Text))
	self.icon = self._tf:Find("frame/bound/mask/Icon"):GetComponent(typeof(Image))
	self.iconRaw = self._tf:Find("frame/bound/mask/Icon_raw"):GetComponent(typeof(RawImage))
	self.title = self._tf:Find("frame/title"):GetComponent(typeof(Text))
	self.closeBtn = self._tf:Find("frame/close")
	self.innerMsgbox = self._tf:Find("msg")
	self.innerMsgboxContent = self.innerMsgbox:Find("bound/Text"):GetComponent(typeof(Text))
	self.innerMsgboxComfirmBtn = self.innerMsgbox:Find("btns/btn1")
	self.innerMsgboxCancelBtn = self.innerMsgbox:Find("btns/btn2")
	self.innerCloseBtn = self._tf:Find("msg/close")
	self.scrollTitleText = self.innerMsgbox:Find("bound/title"):GetComponent(typeof(Text))
	self.scrollText = self.innerMsgbox:Find("bound/scrollrect/Text"):GetComponent(typeof(Text))

	setText(self.cancelBtn:Find("Text"), i18n("word_cancel"))
	setText(self.deleteBtn:Find("Text"), i18n("word_delete"))
	setText(self.saveBtn:Find("Text"), i18n("word_save"))
	setText(self.applyBtn:Find("Text"), i18n("backyard_theme_word_apply"))
	setText(self.innerMsgboxComfirmBtn:Find("Text"), i18n("word_ok"))
	setText(self.innerMsgboxCancelBtn:Find("Text"), i18n("word_cancel"))
	setText(self.inputField:Find("Placeholder"), i18n("enter_theme_name"))

	return
end

function BackYardDecorationMsgBox:OnInit()
	onButton(self, self._tf, function()
		if self.showInnerMsg then
			self:HideInnerMsgBox()
		else
			self:Hide()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.innerCloseBtn, function()
		self:HideInnerMsgBox()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.deleteBtn, function()
		if self.theme:IsPushed() then
			self:ShowInnerMsgBox(i18n("backyard_decoration_theme_template_delete_tip"), function()
				self:emit(BackYardDecorationMediator.DELETE_THEME, self.theme.id)
				self:Hide()

				return
			end, true)
		else
			self:emit(BackYardDecorationMediator.DELETE_THEME, self.theme.id)
			self:Hide()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.saveBtn, function()
		local var_10_0 = getInputText(self.inputField)

		if wordVer(var_10_0) > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_theme_name_forbid"))

			return
		end

		self:emit(BackYardDecorationMediator.SAVE_THEME, self.theme.id, var_10_0)
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.applyBtn, function()
		local function var_11_0(arg_12_0)
			return
		end

		self:emit(BackYardDecorationMediator.APPLY_THEME, self.theme, function(arg_13_0, arg_13_1)
			gcAll(false)

			if arg_13_0 then
				self:emit(BackYardDecorationMediator.ADD_FURNITURES, self.theme.id, arg_13_1, var_11_0)
				self:Hide()
			else
				self:ShowInnerMsgBox(i18n("backyarad_theme_replace", self.theme:getName()), function()
					self:emit(BackYardDecorationMediator.ADD_FURNITURES, self.theme.id, arg_13_1, var_11_0)
					self:HideInnerMsgBox()
					self:Hide()

					return
				end)
			end

			return
		end)

		return
	end, SFX_PANEL)
	onInputChanged(self, self.inputField, function()
		if not self.unEmpty then
			setText(self.desc, i18n("backyard_theme_save_tip"))
		end

		return
	end)

	return
end

function BackYardDecorationMsgBox:Show(arg_16_1, arg_16_2)
	BackYardDecorationMsgBox.super.Show(self)

	self.theme = arg_16_1
	self.unEmpty = arg_16_2

	if arg_16_2 then
		self:ApplyTheme()
	else
		self:NewTheme()
	end

	self.title.text = arg_16_2 and arg_16_1:IsSystem() and i18n("courtyard_label_system_theme") or i18n("courtyard_label_custom_theme")

	setActive(self.frame, true)
	setActive(self._tf, true)
	setActive(self.innerMsgbox, false)
	setActive(self.input, not arg_16_2)
	setActive(self.cancelBtn, not arg_16_2)
	setActive(self.deleteBtn, arg_16_2 and not arg_16_1:IsSystem())
	setActive(self.applyBtn, arg_16_2)
	setActive(self.saveBtn, not arg_16_2)
	self._tf:SetAsLastSibling()

	return
end

function BackYardDecorationMsgBox:RemoveSizeTag(arg_17_1)
	return string.gsub(string.gsub(arg_17_1, "</size>", ""), "<size=%d+>", "")
end

function BackYardDecorationMsgBox:ApplyTheme()
	self.desc.text = i18n("backyard_theme_set_tip", (self.theme:getName()))

	if not self.theme:IsSystem() and (BackYardThemeTempalteUtil.FileExists(self.theme:GetTextureIconName()) or self.theme:IsPushed()) then
		setActive(self.iconRaw.gameObject, false)
		setActive(self.icon.gameObject, false)
		BackYardThemeTempalteUtil.GetTexture(self.theme:GetTextureIconName(), self.theme:GetIconMd5(), function(arg_19_0)
			if not IsNil(self.iconRaw) and arg_19_0 then
				setActive(self.iconRaw.gameObject, true)

				self.iconRaw.texture = arg_19_0
			end

			return
		end)
	else
		setActive(self.iconRaw.gameObject, false)
		setActive(self.icon.gameObject, true)

		self.icon.sprite = LoadSprite("furnitureicon/" .. self.theme:getIcon())
	end

	return
end

function BackYardDecorationMsgBox:NewTheme()
	setInputText(self.inputField, i18n("backyard_theme_defaultname") .. self.theme.id)

	self.desc.text = i18n("backyard_theme_save_tip", i18n("backyard_theme_defaultname") .. self.theme.id)
	self.icon.sprite = LoadSprite("furnitureicon/default_theme")

	setActive(self.iconRaw.gameObject, false)
	setActive(self.icon.gameObject, true)

	return
end

function BackYardDecorationMsgBox:ShowInnerMsgBox(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	setActive(self.frame, false)
	setActive(self.innerMsgbox, true)
	setActive(self.innerMsgboxCancelBtn, arg_21_3)

	if arg_21_4 then
		self.innerMsgboxContent.text = ""
		self.scrollTitleText.text = arg_21_4
		self.scrollText.text = arg_21_1
	else
		self.scrollTitleText.text = ""
		self.scrollText.text = ""
		self.innerMsgboxContent.text = arg_21_1
	end

	onButton(self, self.innerMsgboxComfirmBtn, function()
		if arg_21_2 then
			arg_21_2()
		end

		return
	end, SFX_PANEL)

	if arg_21_3 then
		onButton(self, self.innerMsgboxCancelBtn, function()
			setActive(self.innerMsgbox, false)
			setActive(self.frame, true)

			return
		end, SFX_PANEL)
	end

	self.showInnerMsg = true

	return
end

function BackYardDecorationMsgBox:HideInnerMsgBox()
	setActive(self.frame, true)
	setActive(self.innerMsgbox, false)

	self.showInnerMsg = false

	return
end

function BackYardDecorationMsgBox:OnDestroy()
	if not IsNil(self.iconRaw.texture) then
		Object.Destroy(self.iconRaw.texture)

		self.iconRaw.texture = nil
	end

	return
end

return BackYardDecorationMsgBox
