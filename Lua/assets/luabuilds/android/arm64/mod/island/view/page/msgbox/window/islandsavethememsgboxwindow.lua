local var_0_0 = class("IslandSaveThemeMsgboxWindow", import(".IslandCommonMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandCommonMsgBoxForSaveTheme"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.icon = arg_2_0._tf:Find("icon")
	arg_2_0.iconRaw = arg_2_0._tf:Find("icon_raw"):GetComponent(typeof(RawImage))
	arg_2_0.inputTr = arg_2_0._tf:Find("input")

	return
end

function var_0_0.OnInit(arg_3_0)
	var_0_0.super.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		local var_4_0 = getInputText(arg_3_0.inputTr)

		if not var_4_0 or var_4_0 == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_input_theme_name"))

			return
		end

		if arg_3_0.onYes then
			arg_3_0.onYes(var_4_0)
		end

		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShow(arg_5_0)
	setInputText(arg_5_0.inputTr, i18n("island_custom_theme_name", arg_5_0.settings.id))

	arg_5_0.settings.content = i18n("island_custom_theme_name_tip")

	var_0_0.super.OnShow(arg_5_0)
	arg_5_0:FlushIcon()

	return
end

function var_0_0.FlushIcon(arg_6_0)
	arg_6_0:LoadRawTex(arg_6_0.settings.id)

	return
end

function var_0_0.LoadRawTex(arg_7_0, arg_7_1)
	local var_7_0 = AgoraCalc.BuildScreenShootSavePath(arg_7_1)
	local var_7_1

	if not PathMgr.FileExists(var_7_0) then
		do return end

		var_7_1 = UnityEngine.Texture2D.New(426, 320)
	end

	Tex2DExtension.LoadImage(var_7_1, (System.IO.File.ReadAllBytes(var_7_0)))

	arg_7_0.iconRaw.texture = var_7_1

	setActive(arg_7_0.iconRaw, true)
	setActive(arg_7_0.icon, false)

	return
end

function var_0_0.OnHide(arg_8_0)
	var_0_0.super.OnHide(arg_8_0)

	if not IsNil(arg_8_0.iconRaw.texture) then
		Object.Destroy(arg_8_0.iconRaw.texture)

		arg_8_0.iconRaw.texture = nil
	end

	return
end

return var_0_0
