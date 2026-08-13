class = var_0_10000

local var_0_0 = "IslandThemeMsgboxWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandCommonMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCommonMsgBoxForTheme"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "icon_raw")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	RawImage = var_1_10004
	arg_2_0.iconRaw = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "icon")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.icon = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf

	arg_2_0.delBtn = var_1.Find(var_2_6, "delete")
	setText = var_1

	local var_2_7 = arg_2_0.delBtn
	local var_2_8 = var_2.Find(var_2_7, "Text")

	i18n = var_2_7

	var_1(var_2_8, var_2_7("island_btn_label_del"))

	setText = var_1

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_2.Find(var_2_9, "confirm/Text")

	i18n = var_2_9

	var_1(var_2_10, var_2_9("island_word_place"))

	return
end

function var_0_1.OnInit(arg_3_0)
	var_0_1.super.OnInit(arg_3_0)

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.delBtn

	local function var_3_2()
		if arg_3_0.settings.onDel then
			arg_3_0.settings.onDel()
		end

		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.OnShow(arg_5_0)
	arg_5_0.settings.content = arg_5_0.settings.theme.name

	var_0_1.super.OnShow(arg_5_0)
	arg_5_0:FlushIcon()

	return
end

function var_0_1.OnHide(arg_6_0)
	var_0_1.super.OnHide(arg_6_0)

	IsNil = var_1

	if not var_1(arg_6_0.iconRaw.texture) then
		Object = var_1

		var_1.Destroy(arg_6_0.iconRaw.texture)

		arg_6_0.iconRaw.texture = nil
	end

	return
end

function var_0_1.FlushBtn(arg_7_0, arg_7_1)
	return
end

function var_0_1.FlushIcon(arg_8_0)
	local var_8_0 = arg_8_0.settings.theme

	isa = var_1_10002

	local var_8_1 = var_8_0

	AgoraTheme = var_1_10004

	if var_1_10002(var_8_1, var_1_10004) then
		arg_8_0:LoadRawTex(var_8_0.id)
	else
		arg_8_0:LoadImage(var_8_0.id)
	end

	return
end

function var_0_1.LoadRawTex(arg_9_0, arg_9_1)
	AgoraCalc = var_1_10002

	local var_9_0 = var_1_10002.BuildScreenShootSavePath(arg_9_1)

	PathMgr = var_3

	if not var_3.FileExists(var_9_0) then
		arg_9_0:LoadImage(0)

		return
	end

	System = var_3

	local var_9_1 = var_3.IO.File.ReadAllBytes(var_9_0)

	UnityEngine = var_4

	local var_9_2 = var_4.Texture2D.New(426, 320)

	Tex2DExtension = var_5

	var_5.LoadImage(var_9_2, var_9_1)

	local var_9_3 = arg_9_0.iconRaw

	var_9_3.texture = var_9_2
	setActive = var_9_3

	var_9_3(arg_9_0.iconRaw, true)

	setActive = var_9_3

	var_9_3(arg_9_0.icon, false)

	return
end

function var_0_1.LoadImage(arg_10_0, arg_10_1)
	LoadSpriteAsync = var_1_10002

	var_1_10002("island/IslandThemeIcon/" .. arg_10_1, function(arg_11_0)
		arg_10_0.icon.sprite = arg_11_0

		local var_11_0 = arg_10_0.icon

		var_1.SetNativeSize(var_11_0)

		return
	end)

	setActive = var_1_10002

	var_1_10002(arg_10_0.iconRaw, false)

	setActive = var_1_10002

	var_1_10002(arg_10_0.icon, true)

	return
end

return var_0_1
