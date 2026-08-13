class = var_0_10000

local var_0_0 = "BackYardDecorationMsgBox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "BackYardDecorationMsgBox"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.frame = var_1.Find(var_2_0, "frame")

	local var_2_1 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_1, "frame/control/cancel_btn")

	local var_2_2 = arg_2_0._tf

	arg_2_0.deleteBtn = var_1.Find(var_2_2, "frame/control/delete_btn")

	local var_2_3 = arg_2_0._tf

	arg_2_0.saveBtn = var_1.Find(var_2_3, "frame/control/save_btn")

	local var_2_4 = arg_2_0._tf

	arg_2_0.applyBtn = var_1.Find(var_2_4, "frame/control/set_btn")

	local var_2_5 = arg_2_0._tf

	arg_2_0.input = var_1.Find(var_2_5, "frame/bound/input")

	local var_2_6 = arg_2_0._tf

	arg_2_0.inputField = var_1.Find(var_2_6, "frame/bound/input/InputField")

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "frame/bound/desc")
	local var_2_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.desc = var_2_9(var_2_8, var_3(var_1_10004))

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.Find(var_2_10, "frame/bound/mask/Icon")
	local var_2_12 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.icon = var_2_12(var_2_11, var_3(var_1_10004))

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "frame/bound/mask/Icon_raw")
	local var_2_15 = var_1.GetComponent

	typeof = var_3
	RawImage = var_1_10004
	arg_2_0.iconRaw = var_2_15(var_2_14, var_3(var_1_10004))

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_1.Find(var_2_16, "frame/title")
	local var_2_18 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.title = var_2_18(var_2_17, var_3(var_1_10004))

	local var_2_19 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_19, "frame/close")

	local var_2_20 = arg_2_0._tf

	arg_2_0.innerMsgbox = var_1.Find(var_2_20, "msg")

	local var_2_21 = arg_2_0.innerMsgbox
	local var_2_22 = var_1.Find(var_2_21, "bound/Text")
	local var_2_23 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.innerMsgboxContent = var_2_23(var_2_22, var_3(var_1_10004))

	local var_2_24 = arg_2_0.innerMsgbox

	arg_2_0.innerMsgboxComfirmBtn = var_1.Find(var_2_24, "btns/btn1")

	local var_2_25 = arg_2_0.innerMsgbox

	arg_2_0.innerMsgboxCancelBtn = var_1.Find(var_2_25, "btns/btn2")

	local var_2_26 = arg_2_0._tf

	arg_2_0.innerCloseBtn = var_1.Find(var_2_26, "msg/close")

	local var_2_27 = arg_2_0.innerMsgbox
	local var_2_28 = var_1.Find(var_2_27, "bound/title")
	local var_2_29 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.scrollTitleText = var_2_29(var_2_28, var_3(var_1_10004))

	local var_2_30 = arg_2_0.innerMsgbox
	local var_2_31 = var_1.Find(var_2_30, "bound/scrollrect/Text")
	local var_2_32 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.scrollText = var_2_32(var_2_31, var_3(var_1_10004))
	setText = var_1

	local var_2_33 = arg_2_0.cancelBtn
	local var_2_34 = var_2.Find(var_2_33, "Text")

	i18n = var_2_33

	var_1(var_2_34, var_2_33("word_cancel"))

	setText = var_1

	local var_2_35 = arg_2_0.deleteBtn
	local var_2_36 = var_2.Find(var_2_35, "Text")

	i18n = var_2_35

	var_1(var_2_36, var_2_35("word_delete"))

	setText = var_1

	local var_2_37 = arg_2_0.saveBtn
	local var_2_38 = var_2.Find(var_2_37, "Text")

	i18n = var_2_37

	var_1(var_2_38, var_2_37("word_save"))

	setText = var_1

	local var_2_39 = arg_2_0.applyBtn
	local var_2_40 = var_2.Find(var_2_39, "Text")

	i18n = var_2_39

	var_1(var_2_40, var_2_39("backyard_theme_word_apply"))

	setText = var_1

	local var_2_41 = arg_2_0.innerMsgboxComfirmBtn
	local var_2_42 = var_2.Find(var_2_41, "Text")

	i18n = var_2_41

	var_1(var_2_42, var_2_41("word_ok"))

	setText = var_1

	local var_2_43 = arg_2_0.innerMsgboxCancelBtn
	local var_2_44 = var_2.Find(var_2_43, "Text")

	i18n = var_2_43

	var_1(var_2_44, var_2_43("word_cancel"))

	setText = var_1

	local var_2_45 = arg_2_0.inputField
	local var_2_46 = var_2.Find(var_2_45, "Placeholder")

	i18n = var_2_45

	var_1(var_2_46, var_2_45("enter_theme_name"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		if arg_3_0.showInnerMsg then
			local var_4_0 = arg_3_0

			var_0.HideInnerMsgBox(var_4_0)
		else
			local var_4_1 = arg_3_0

			var_0.Hide(var_4_1)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.innerCloseBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.HideInnerMsgBox(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.cancelBtn

	local function var_3_11()
		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.deleteBtn

	local function var_3_14()
		local var_8_0 = arg_3_0.theme

		if var_0.IsPushed(var_8_0) then
			local var_8_1 = arg_3_0
			local var_8_2 = var_0.ShowInnerMsgBox

			i18n = var_2_10002

			var_8_2(var_8_1, var_2_10002("backyard_decoration_theme_template_delete_tip"), function()
				local var_9_0 = arg_3_0
				local var_9_1 = var_0.emit

				BackYardDecorationMediator = var_3_10002

				var_9_1(var_9_0, var_3_10002.DELETE_THEME, arg_3_0.theme.id)

				local var_9_2 = arg_3_0

				var_0.Hide(var_9_2)

				return
			end, true)
		else
			local var_8_3 = arg_3_0
			local var_8_4 = var_0.emit

			BackYardDecorationMediator = var_2_10002

			var_8_4(var_8_3, var_2_10002.DELETE_THEME, arg_3_0.theme.id)

			local var_8_5 = arg_3_0

			var_0.Hide(var_8_5)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_12, var_3_13, var_3_14, var_1_10005)

	onButton = var_1_10001

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.saveBtn

	local function var_3_17()
		getInputText = var_2_10000

		local var_10_0 = var_2_10000(arg_3_0.inputField)

		wordVer = var_1

		if var_1(var_10_0) > 0 then
			pg = var_1

			local var_10_1 = var_1.TipsMgr.GetInstance()
			local var_10_2 = var_1.ShowTips

			i18n = var_2_10003

			var_10_2(var_10_1, var_2_10003("backyard_theme_name_forbid"))

			return
		end

		local var_10_3 = arg_3_0
		local var_10_4 = var_1.emit

		BackYardDecorationMediator = var_2_10003

		var_10_4(var_10_3, var_2_10003.SAVE_THEME, arg_3_0.theme.id, var_10_0)

		local var_10_5 = arg_3_0

		var_1.Hide(var_10_5)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_15, var_3_16, var_3_17, var_1_10005)

	onButton = var_1_10001

	local var_3_18 = arg_3_0
	local var_3_19 = arg_3_0.applyBtn

	local function var_3_20()
		local function var_11_0(arg_12_0)
			return
		end

		local var_11_1 = arg_3_0
		local var_11_2 = var_1.emit

		BackYardDecorationMediator = var_2_10003

		var_11_2(var_11_1, var_2_10003.APPLY_THEME, arg_3_0.theme, function(arg_13_0, arg_13_1)
			gcAll = var_3_10002

			var_3_10002(false)

			if arg_13_0 then
				local var_13_0 = arg_3_0
				local var_13_1 = var_2.emit

				BackYardDecorationMediator = var_3_10004

				var_13_1(var_13_0, var_3_10004.ADD_FURNITURES, arg_3_0.theme.id, arg_13_1, var_11_0)

				local var_13_2 = arg_3_0

				var_2.Hide(var_13_2)
			else
				local var_13_3 = arg_3_0
				local var_13_4 = var_2.ShowInnerMsgBox

				i18n = var_3_10004

				local var_13_5 = "backyarad_theme_replace"
				local var_13_6 = arg_3_0.theme

				var_13_4(var_13_3, var_3_10004(var_13_5, var_6.getName(var_13_6)), function()
					local var_14_0 = arg_3_0
					local var_14_1 = var_0.emit

					BackYardDecorationMediator = var_4_10002

					var_14_1(var_14_0, var_4_10002.ADD_FURNITURES, arg_3_0.theme.id, arg_13_1, var_11_0)

					local var_14_2 = arg_3_0

					var_0.HideInnerMsgBox(var_14_2)

					local var_14_3 = arg_3_0

					var_0.Hide(var_14_3)

					return
				end)
			end

			return
		end)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_18, var_3_19, var_3_20, var_1_10005)

	onInputChanged = var_1_10001

	var_1_10001(arg_3_0, arg_3_0.inputField, function()
		if not arg_3_0.unEmpty then
			setText = var_0

			local var_15_0 = arg_3_0.desc

			i18n = var_2_10002

			var_0(var_15_0, var_2_10002("backyard_theme_save_tip"))
		end

		return
	end)

	return
end

function var_0_1.Show(arg_16_0, arg_16_1, arg_16_2)
	var_0_1.super.Show(arg_16_0)

	arg_16_0.theme = arg_16_1
	arg_16_0.unEmpty = arg_16_2

	local var_16_0

	if arg_16_2 then
		var_16_0 = arg_16_0

		arg_16_0.ApplyTheme(var_16_0)
	else
		var_16_0 = arg_16_0

		arg_16_0.NewTheme(var_16_0)
	end

	local var_16_1 = arg_16_0.title

	if arg_16_2 and arg_16_1:IsSystem() then
		i18n = var_16_0

		if not var_16_0("courtyard_label_system_theme") then
			i18n = var_16_0
			var_16_0 = var_16_0("courtyard_label_custom_theme")
		end

		var_16_1.text = var_16_0
		setActive = var_16_1

		var_16_1(arg_16_0.frame, true)

		setActive = var_16_1

		var_16_1(arg_16_0._tf, true)

		setActive = var_16_1

		var_16_1(arg_16_0.innerMsgbox, false)

		setActive = var_16_1

		var_16_1(arg_16_0.input, not arg_16_2)

		setActive = var_16_1

		var_16_1(arg_16_0.cancelBtn, not arg_16_2)

		setActive = var_16_1

		var_16_1(arg_16_0.deleteBtn, arg_16_2 and not arg_16_1:IsSystem())

		setActive = var_16_1

		var_16_1(arg_16_0.applyBtn, arg_16_2)

		setActive = var_16_1

		var_16_1(arg_16_0.saveBtn, not arg_16_2)

		local var_16_2 = arg_16_0._tf

		var_3.SetAsLastSibling(var_16_2)

		return
	end
end

function var_0_1.RemoveSizeTag(arg_17_0, arg_17_1)
	string = var_1_10002

	local var_17_0 = var_1_10002.gsub(arg_17_1, "</size>", "")

	string = var_3

	return var_3.gsub(var_17_0, "<size=%d+>", "")
end

function var_0_1.ApplyTheme(arg_18_0)
	local var_18_0 = arg_18_0.theme
	local var_18_1 = var_1.getName(var_18_0)
	local var_18_2 = arg_18_0.desc

	i18n = var_1_10004
	var_18_2.text = var_1_10004("backyard_theme_set_tip", var_18_1)

	local var_18_3 = var_1

	if not var_1.IsSystem(var_18_3) then
		BackYardThemeTempalteUtil = var_18_3

		if var_18_3.FileExists(var_1:GetTextureIconName()) or var_1:IsPushed() then
			setActive = var_18_3

			var_18_3(arg_18_0.iconRaw.gameObject, false)

			setActive = var_18_3

			var_18_3(arg_18_0.icon.gameObject, false)

			local var_18_4 = var_1

			var_18_3 = var_1.GetIconMd5(var_18_4)
			BackYardThemeTempalteUtil = var_18_4

			var_18_4.GetTexture(var_1:GetTextureIconName(), var_18_3, function(arg_19_0)
				IsNil = var_2_10001

				if not var_2_10001(arg_18_0.iconRaw) and arg_19_0 then
					setActive = var_1

					var_1(arg_18_0.iconRaw.gameObject, true)

					arg_18_0.iconRaw.texture = arg_19_0
				end

				return
			end)

			goto label_18_0
		end
	end

	setActive = var_18_3

	var_18_3(arg_18_0.iconRaw.gameObject, false)

	setActive = var_18_3

	var_18_3(arg_18_0.icon.gameObject, true)

	do
		local var_18_5 = arg_18_0.icon

		LoadSprite = var_5
		var_18_5.sprite = var_5("furnitureicon/" .. var_1:getIcon())
	end

	::label_18_0::

	return
end

function var_0_1.NewTheme(arg_20_0)
	local var_20_0 = arg_20_0.theme.id

	setInputText = var_1_10003

	local var_20_1 = arg_20_0.inputField

	i18n = var_1_10005

	var_1_10003(var_20_1, var_1_10005("backyard_theme_defaultname") .. var_20_0)

	local var_20_2 = arg_20_0.desc

	i18n = var_20_1

	local var_20_3 = "backyard_theme_save_tip"

	i18n = var_6
	var_20_2.text = var_20_1(var_20_3, var_6("backyard_theme_defaultname") .. var_20_0)

	local var_20_4 = arg_20_0.icon

	LoadSprite = var_4
	var_20_4.sprite = var_4("furnitureicon/default_theme")
	setActive = var_20_4

	var_20_4(arg_20_0.iconRaw.gameObject, false)

	setActive = var_20_4

	var_20_4(arg_20_0.icon.gameObject, true)

	return
end

function var_0_1.ShowInnerMsgBox(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	setActive = var_1_10005

	var_1_10005(arg_21_0.frame, false)

	setActive = var_1_10005

	var_1_10005(arg_21_0.innerMsgbox, true)

	setActive = var_1_10005

	var_1_10005(arg_21_0.innerMsgboxCancelBtn, arg_21_3)

	if arg_21_4 then
		var_1_10005 = arg_21_0.innerMsgboxContent
		var_1_10005.text = ""
		var_1_10005 = arg_21_0.scrollTitleText
		var_1_10005.text = arg_21_4
		var_1_10005 = arg_21_0.scrollText
		var_1_10005.text = arg_21_1
	else
		var_1_10005 = arg_21_0.scrollTitleText
		var_1_10005.text = ""
		var_1_10005 = arg_21_0.scrollText
		var_1_10005.text = ""
		var_1_10005 = arg_21_0.innerMsgboxContent
		var_1_10005.text = arg_21_1
	end

	onButton = var_1_10005

	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.innerMsgboxComfirmBtn

	local function var_21_2()
		if arg_21_2 then
			arg_21_2()
		end

		return
	end

	SFX_PANEL = var_1_10009

	var_1_10005(var_21_0, var_21_1, var_21_2, var_1_10009)

	if arg_21_3 then
		onButton = var_1_10005

		local var_21_3 = arg_21_0
		local var_21_4 = arg_21_0.innerMsgboxCancelBtn

		local function var_21_5()
			setActive = var_2_10000

			var_2_10000(arg_21_0.innerMsgbox, false)

			setActive = var_2_10000

			var_2_10000(arg_21_0.frame, true)

			return
		end

		SFX_PANEL = var_1_10009

		var_1_10005(var_21_3, var_21_4, var_21_5, var_1_10009)
	end

	arg_21_0.showInnerMsg = true

	return
end

function var_0_1.HideInnerMsgBox(arg_24_0)
	setActive = var_1_10001

	var_1_10001(arg_24_0.frame, true)

	setActive = var_1_10001

	var_1_10001(arg_24_0.innerMsgbox, false)

	arg_24_0.showInnerMsg = false

	return
end

function var_0_1.OnDestroy(arg_25_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_25_0.iconRaw.texture) then
		Object = var_1

		var_1.Destroy(arg_25_0.iconRaw.texture)

		arg_25_0.iconRaw.texture = nil
	end

	return
end

return var_0_1
