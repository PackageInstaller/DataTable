class = var_0_10000

local var_0_0 = "IslandSaveThemeMsgboxWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandCommonMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCommonMsgBoxForSaveTheme"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.icon = var_1.Find(var_2_0, "icon")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "icon_raw")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	RawImage = var_1_10006
	arg_2_0.iconRaw = var_2_3(var_2_2, var_4(var_1_10006))

	local var_2_4 = arg_2_0._tf

	arg_2_0.inputTr = var_1.Find(var_2_4, "input")

	return
end

function var_0_1.OnInit(arg_3_0)
	var_0_1.super.OnInit(arg_3_0)

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		getInputText = var_2_10000

		if not var_2_10000(arg_3_0.inputTr) or var_0 == "" then
			pg = var_2_10001

			local var_4_0 = var_2_10001.TipsMgr.GetInstance()
			local var_4_1 = var_1.ShowTips

			i18n = var_2_10004

			var_4_1(var_4_0, var_2_10004("island_input_theme_name"))

			return
		end

		if arg_3_0.onYes then
			arg_3_0.onYes(var_0)
		end

		local var_4_2 = arg_3_0

		var_1.Hide(var_4_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.OnShow(arg_5_0)
	setInputText = var_1_10001

	local var_5_0 = arg_5_0.inputTr

	i18n = var_1_10004

	var_1_10001(var_5_0, var_1_10004("island_custom_theme_name", arg_5_0.settings.id))

	local var_5_1 = arg_5_0.settings

	i18n = var_1_10002
	var_5_1.content = var_1_10002("island_custom_theme_name_tip")

	var_0_1.super.OnShow(arg_5_0)
	arg_5_0:FlushIcon()

	return
end

function var_0_1.FlushIcon(arg_6_0)
	arg_6_0:LoadRawTex(arg_6_0.settings.id)

	return
end

function var_0_1.LoadRawTex(arg_7_0, arg_7_1)
	AgoraCalc = var_1_10002

	local var_7_0 = var_1_10002.BuildScreenShootSavePath(arg_7_1)

	PathMgr = var_1_10003

	if not var_1_10003.FileExists(var_7_0) then
		return
	end

	System = var_3

	local var_7_1 = var_3.IO.File.ReadAllBytes(var_7_0)

	UnityEngine = var_4

	local var_7_2 = var_4.Texture2D.New(426, 320)

	Tex2DExtension = var_5

	var_5.LoadImage(var_7_2, var_7_1)

	local var_7_3 = arg_7_0.iconRaw

	var_7_3.texture = var_7_2
	setActive = var_7_3

	var_7_3(arg_7_0.iconRaw, true)

	setActive = var_7_3

	var_7_3(arg_7_0.icon, false)

	return
end

function var_0_1.OnHide(arg_8_0)
	var_0_1.super.OnHide(arg_8_0)

	IsNil = var_1

	if not var_1(arg_8_0.iconRaw.texture) then
		Object = var_1

		var_1.Destroy(arg_8_0.iconRaw.texture)

		arg_8_0.iconRaw.texture = nil
	end

	return
end

return var_0_1
