local var_0_0 = class("BackYardDecorationMsgBox", import("....base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "BackYardDecorationMsgBox"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.frame = arg_2_0._tf:Find("frame")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("frame/control/cancel_btn")
	arg_2_0.deleteBtn = arg_2_0._tf:Find("frame/control/delete_btn")
	arg_2_0.saveBtn = arg_2_0._tf:Find("frame/control/save_btn")
	arg_2_0.applyBtn = arg_2_0._tf:Find("frame/control/set_btn")
	arg_2_0.input = arg_2_0._tf:Find("frame/bound/input")
	arg_2_0.inputField = arg_2_0._tf:Find("frame/bound/input/InputField")
	arg_2_0.desc = arg_2_0._tf:Find("frame/bound/desc"):GetComponent(typeof(Text))
	arg_2_0.icon = arg_2_0._tf:Find("frame/bound/mask/Icon"):GetComponent(typeof(Image))
	arg_2_0.iconRaw = arg_2_0._tf:Find("frame/bound/mask/Icon_raw"):GetComponent(typeof(RawImage))
	arg_2_0.title = arg_2_0._tf:Find("frame/title"):GetComponent(typeof(Text))
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close")
	arg_2_0.innerMsgbox = arg_2_0._tf:Find("msg")
	arg_2_0.innerMsgboxContent = arg_2_0.innerMsgbox:Find("bound/Text"):GetComponent(typeof(Text))
	arg_2_0.innerMsgboxComfirmBtn = arg_2_0.innerMsgbox:Find("btns/btn1")
	arg_2_0.innerMsgboxCancelBtn = arg_2_0.innerMsgbox:Find("btns/btn2")
	arg_2_0.innerCloseBtn = arg_2_0._tf:Find("msg/close")
	arg_2_0.scrollTitleText = arg_2_0.innerMsgbox:Find("bound/title"):GetComponent(typeof(Text))
	arg_2_0.scrollText = arg_2_0.innerMsgbox:Find("bound/scrollrect/Text"):GetComponent(typeof(Text))

	setText(arg_2_0.cancelBtn:Find("Text"), i18n("word_cancel"))
	setText(arg_2_0.deleteBtn:Find("Text"), i18n("word_delete"))
	setText(arg_2_0.saveBtn:Find("Text"), i18n("word_save"))
	setText(arg_2_0.applyBtn:Find("Text"), i18n("backyard_theme_word_apply"))
	setText(arg_2_0.innerMsgboxComfirmBtn:Find("Text"), i18n("word_ok"))
	setText(arg_2_0.innerMsgboxCancelBtn:Find("Text"), i18n("word_cancel"))
	setText(arg_2_0.inputField:Find("Placeholder"), i18n("enter_theme_name"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		if arg_3_0.showInnerMsg then
			arg_3_0:HideInnerMsgBox()
		else
			arg_3_0:Hide()
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.innerCloseBtn, function()
		arg_3_0:HideInnerMsgBox()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.deleteBtn, function()
		if arg_3_0.theme:IsPushed() then
			arg_3_0:ShowInnerMsgBox(i18n("backyard_decoration_theme_template_delete_tip"), function()
				arg_3_0:emit(BackYardDecorationMediator.DELETE_THEME, arg_3_0.theme.id)
				arg_3_0:Hide()

				return
			end, true)
		else
			arg_3_0:emit(BackYardDecorationMediator.DELETE_THEME, arg_3_0.theme.id)
			arg_3_0:Hide()
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.saveBtn, function()
		local var_10_0 = getInputText(arg_3_0.inputField)

		if wordVer(var_10_0) > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_theme_name_forbid"))

			return
		end

		arg_3_0:emit(BackYardDecorationMediator.SAVE_THEME, arg_3_0.theme.id, var_10_0)
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.applyBtn, function()
		local function var_11_0(arg_12_0)
			return
		end

		arg_3_0:emit(BackYardDecorationMediator.APPLY_THEME, arg_3_0.theme, function(arg_13_0, arg_13_1)
			gcAll(false)

			if arg_13_0 then
				arg_3_0:emit(BackYardDecorationMediator.ADD_FURNITURES, arg_3_0.theme.id, arg_13_1, var_11_0)
				arg_3_0:Hide()
			else
				arg_3_0:ShowInnerMsgBox(i18n("backyarad_theme_replace", arg_3_0.theme:getName()), function()
					arg_3_0:emit(BackYardDecorationMediator.ADD_FURNITURES, arg_3_0.theme.id, arg_13_1, var_11_0)
					arg_3_0:HideInnerMsgBox()
					arg_3_0:Hide()

					return
				end)
			end

			return
		end)

		return
	end, SFX_PANEL)
	onInputChanged(arg_3_0, arg_3_0.inputField, function()
		if not arg_3_0.unEmpty then
			setText(arg_3_0.desc, i18n("backyard_theme_save_tip"))
		end

		return
	end)

	return
end

function var_0_0.Show(arg_16_0, arg_16_1, arg_16_2)
	var_0_0.super.Show(arg_16_0)

	arg_16_0.theme = arg_16_1
	arg_16_0.unEmpty = arg_16_2

	if arg_16_2 then
		arg_16_0:ApplyTheme()
	else
		arg_16_0:NewTheme()
	end

	local var_16_0 = arg_16_0.title

	var_16_0.text = arg_16_2 and arg_16_1:IsSystem() and i18n("courtyard_label_system_theme") or i18n("courtyard_label_custom_theme")

	setActive(arg_16_0.frame, true)
	setActive(arg_16_0._tf, true)
	setActive(arg_16_0.innerMsgbox, false)
	setActive(arg_16_0.input, not arg_16_2)
	setActive(arg_16_0.cancelBtn, not arg_16_2)
	setActive(arg_16_0.deleteBtn, arg_16_2 and not arg_16_1:IsSystem())
	setActive(arg_16_0.applyBtn, arg_16_2)
	setActive(arg_16_0.saveBtn, not arg_16_2)
	arg_16_0._tf:SetAsLastSibling()

	return
end

function var_0_0.RemoveSizeTag(arg_17_0, arg_17_1)
	return string.gsub(string.gsub(arg_17_1, "</size>", ""), "<size=%d+>", "")
end

function var_0_0.ApplyTheme(arg_18_0)
	arg_18_0.desc.text = i18n("backyard_theme_set_tip", (arg_18_0.theme:getName()))

	if not arg_18_0.theme:IsSystem() and (BackYardThemeTempalteUtil.FileExists(arg_18_0.theme:GetTextureIconName()) or arg_18_0.theme:IsPushed()) then
		setActive(arg_18_0.iconRaw.gameObject, false)
		setActive(arg_18_0.icon.gameObject, false)
		BackYardThemeTempalteUtil.GetTexture(arg_18_0.theme:GetTextureIconName(), arg_18_0.theme:GetIconMd5(), function(arg_19_0)
			if not IsNil(arg_18_0.iconRaw) and arg_19_0 then
				setActive(arg_18_0.iconRaw.gameObject, true)

				arg_18_0.iconRaw.texture = arg_19_0
			end

			return
		end)
	else
		setActive(arg_18_0.iconRaw.gameObject, false)
		setActive(arg_18_0.icon.gameObject, true)

		arg_18_0.icon.sprite = LoadSprite("furnitureicon/" .. arg_18_0.theme:getIcon())
	end

	return
end

function var_0_0.NewTheme(arg_20_0)
	setInputText(arg_20_0.inputField, i18n("backyard_theme_defaultname") .. arg_20_0.theme.id)

	arg_20_0.desc.text = i18n("backyard_theme_save_tip", i18n("backyard_theme_defaultname") .. arg_20_0.theme.id)
	arg_20_0.icon.sprite = LoadSprite("furnitureicon/default_theme")

	setActive(arg_20_0.iconRaw.gameObject, false)
	setActive(arg_20_0.icon.gameObject, true)

	return
end

function var_0_0.ShowInnerMsgBox(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	setActive(arg_21_0.frame, false)
	setActive(arg_21_0.innerMsgbox, true)
	setActive(arg_21_0.innerMsgboxCancelBtn, arg_21_3)

	if arg_21_4 then
		arg_21_0.innerMsgboxContent.text = ""
		arg_21_0.scrollTitleText.text = arg_21_4
		arg_21_0.scrollText.text = arg_21_1
	else
		arg_21_0.scrollTitleText.text = ""
		arg_21_0.scrollText.text = ""
		arg_21_0.innerMsgboxContent.text = arg_21_1
	end

	onButton(arg_21_0, arg_21_0.innerMsgboxComfirmBtn, function()
		if arg_21_2 then
			arg_21_2()
		end

		return
	end, SFX_PANEL)

	if arg_21_3 then
		onButton(arg_21_0, arg_21_0.innerMsgboxCancelBtn, function()
			setActive(arg_21_0.innerMsgbox, false)
			setActive(arg_21_0.frame, true)

			return
		end, SFX_PANEL)
	end

	arg_21_0.showInnerMsg = true

	return
end

function var_0_0.HideInnerMsgBox(arg_24_0)
	setActive(arg_24_0.frame, true)
	setActive(arg_24_0.innerMsgbox, false)

	arg_24_0.showInnerMsg = false

	return
end

function var_0_0.OnDestroy(arg_25_0)
	if not IsNil(arg_25_0.iconRaw.texture) then
		Object.Destroy(arg_25_0.iconRaw.texture)

		arg_25_0.iconRaw.texture = nil
	end

	return
end

return var_0_0
