class = var_0_10000

local var_0_0 = var_0_10000("AgoraDecorationThemeCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.tr = arg_1_1.transform

	local var_1_0 = arg_1_0.tr

	arg_1_0.mainTr = var_2.Find(var_1_0, "main")

	local var_1_1 = arg_1_0.tr

	arg_1_0.addTr = var_2.Find(var_1_1, "empty")

	local var_1_2 = arg_1_0.tr
	local var_1_3 = var_2.Find(var_1_2, "main/mask/icon")
	local var_1_4 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.icon = var_1_4(var_1_3, var_5(var_1_10007))

	local var_1_5 = arg_1_0.tr
	local var_1_6 = var_2.Find(var_1_5, "main/mask/icon_raw")
	local var_1_7 = var_2.GetComponent

	typeof = var_5
	RawImage = var_1_10007
	arg_1_0.iconRaw = var_1_7(var_1_6, var_5(var_1_10007))
	findTF = var_2
	arg_1_0.idTr = var_2(arg_1_0.tr, "main/id")
	findTF = var_2

	local var_1_8 = var_2(arg_1_0.tr, "main/id/Text")
	local var_1_9 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.idTxt = var_1_9(var_1_8, var_5(var_1_10007))
	findTF = var_2

	local var_1_10 = var_2(arg_1_0.tr, "main/name")
	local var_1_11 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.nameTxt = var_1_11(var_1_10, var_5(var_1_10007))
	findTF = var_2
	arg_1_0.mark = var_2(arg_1_0.tr, "main/mark")
	setText = var_2

	local var_1_12 = arg_1_0.addTr
	local var_1_13 = var_4.Find(var_1_12, "Text")

	i18n = var_5

	var_2(var_1_13, var_5("island_agora_save_theme"))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.theme = arg_2_1

	if not (arg_2_1.id == -1) then
		arg_2_0:UpdateMain(arg_2_1, arg_2_2)
	end

	setActive = var_1_10004

	var_1_10004(arg_2_0.mainTr, not var_3)

	setActive = var_1_10004

	var_1_10004(arg_2_0.addTr, var_3)

	setActive = var_1_10004

	local var_2_0 = arg_2_0.idTr
	local var_2_2

	if not var_3 then
		isa = var_7

		local var_2_1 = arg_2_1

		AgoraTheme = var_1_10010
		var_2_2 = var_7(var_2_1, var_1_10010)
	else
		var_2_2 = false
	end

	if false then
		var_2_2 = true
	end

	var_1_10004(var_2_0, var_2_2)

	return
end

function var_0_0.LoadRawTex(arg_3_0, arg_3_1)
	AgoraCalc = var_1_10002

	local var_3_0 = var_1_10002.BuildScreenShootSavePath(arg_3_1)

	PathMgr = var_1_10003

	if not var_1_10003.FileExists(var_3_0) then
		arg_3_0:LoadImage(0)

		return
	end

	System = var_3

	local var_3_1 = var_3.IO.File.ReadAllBytes(var_3_0)

	UnityEngine = var_4

	local var_3_2 = var_4.Texture2D.New(426, 320)

	Tex2DExtension = var_5

	var_5.LoadImage(var_3_2, var_3_1)

	local var_3_3 = arg_3_0.iconRaw

	var_3_3.texture = var_3_2
	setActive = var_3_3

	var_3_3(arg_3_0.iconRaw, true)

	setActive = var_3_3

	var_3_3(arg_3_0.icon, false)

	return
end

function var_0_0.LoadImage(arg_4_0, arg_4_1)
	LoadSpriteAsync = var_1_10002

	var_1_10002("island/IslandThemeIcon/" .. arg_4_1, function(arg_5_0)
		arg_4_0.icon.sprite = arg_5_0

		local var_5_0 = arg_4_0.icon

		var_1.SetNativeSize(var_5_0)

		return
	end)

	setActive = var_1_10002

	var_1_10002(arg_4_0.iconRaw, false)

	setActive = var_1_10002

	var_1_10002(arg_4_0.icon, true)

	return
end

function var_0_0.UpdateMain(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.idTxt.text = arg_6_1.id

	local var_6_0 = arg_6_0.nameTxt

	shortenString = var_4
	var_6_0.text = var_4(arg_6_1.name, 5)
	setActive = var_6_0

	var_6_0(arg_6_0.mark, arg_6_1.id == arg_6_2)

	isa = var_6_0

	local var_6_1 = arg_6_1

	AgoraTheme = var_6

	if var_6_0(var_6_1, var_6) then
		arg_6_0:LoadRawTex(arg_6_1.id)
	else
		arg_6_0:LoadImage(arg_6_1.id)
	end

	return
end

function var_0_0.Dispose(arg_7_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_7_0.iconRaw.texture) then
		Object = var_1

		var_1.Destroy(arg_7_0.iconRaw.texture)

		arg_7_0.iconRaw.texture = nil
	end

	return
end

return var_0_0
