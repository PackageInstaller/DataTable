local var_0_0 = class("AgoraDecorationThemeCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.tr = arg_1_1.transform
	arg_1_0.mainTr = arg_1_0.tr:Find("main")
	arg_1_0.addTr = arg_1_0.tr:Find("empty")
	arg_1_0.icon = arg_1_0.tr:Find("main/mask/icon"):GetComponent(typeof(Image))
	arg_1_0.iconRaw = arg_1_0.tr:Find("main/mask/icon_raw"):GetComponent(typeof(RawImage))
	arg_1_0.idTr = findTF(arg_1_0.tr, "main/id")
	arg_1_0.idTxt = findTF(arg_1_0.tr, "main/id/Text"):GetComponent(typeof(Text))
	arg_1_0.nameTxt = findTF(arg_1_0.tr, "main/name"):GetComponent(typeof(Text))
	arg_1_0.mark = findTF(arg_1_0.tr, "main/mark")

	setText(arg_1_0.addTr:Find("Text"), i18n("island_agora_save_theme"))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.theme = arg_2_1

	local var_2_0 = arg_2_1.id == -1

	if arg_2_1.id ~= -1 then
		arg_2_0:UpdateMain(arg_2_1, arg_2_2)
	end

	setActive(arg_2_0.mainTr, not var_2_0)
	setActive(arg_2_0.addTr, var_2_0)
	setActive(arg_2_0.idTr, not var_2_0 and isa(arg_2_1, AgoraTheme))

	return
end

function var_0_0.LoadRawTex(arg_3_0, arg_3_1)
	local var_3_0 = AgoraCalc.BuildScreenShootSavePath(arg_3_1)
	local var_3_1

	if not PathMgr.FileExists(var_3_0) then
		arg_3_0:LoadImage(0)

		do return end

		var_3_1 = UnityEngine.Texture2D.New(426, 320)
	end

	Tex2DExtension.LoadImage(var_3_1, (System.IO.File.ReadAllBytes(var_3_0)))

	arg_3_0.iconRaw.texture = var_3_1

	setActive(arg_3_0.iconRaw, true)
	setActive(arg_3_0.icon, false)

	return
end

function var_0_0.LoadImage(arg_4_0, arg_4_1)
	LoadSpriteAsync("island/IslandThemeIcon/" .. arg_4_1, function(arg_5_0)
		arg_4_0.icon.sprite = arg_5_0

		arg_4_0.icon:SetNativeSize()

		return
	end)
	setActive(arg_4_0.iconRaw, false)
	setActive(arg_4_0.icon, true)

	return
end

function var_0_0.UpdateMain(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.idTxt.text = arg_6_1.id
	arg_6_0.nameTxt.text = shortenString(arg_6_1.name, 5)

	setActive(arg_6_0.mark, arg_6_1.id == arg_6_2)

	if isa(arg_6_1, AgoraTheme) then
		arg_6_0:LoadRawTex(arg_6_1.id)
	else
		arg_6_0:LoadImage(arg_6_1.id)
	end

	return
end

function var_0_0.Dispose(arg_7_0)
	if not IsNil(arg_7_0.iconRaw.texture) then
		Object.Destroy(arg_7_0.iconRaw.texture)

		arg_7_0.iconRaw.texture = nil
	end

	return
end

return var_0_0
