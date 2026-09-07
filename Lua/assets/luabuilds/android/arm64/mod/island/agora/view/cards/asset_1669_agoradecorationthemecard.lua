local AgoraDecorationThemeCard = class("AgoraDecorationThemeCard")

function AgoraDecorationThemeCard:Ctor(arg_1_1)
	self.tr = arg_1_1.transform
	self.mainTr = self.tr:Find("main")
	self.addTr = self.tr:Find("empty")
	self.icon = self.tr:Find("main/mask/icon"):GetComponent(typeof(Image))
	self.iconRaw = self.tr:Find("main/mask/icon_raw"):GetComponent(typeof(RawImage))
	self.idTr = findTF(self.tr, "main/id")
	self.idTxt = findTF(self.tr, "main/id/Text"):GetComponent(typeof(Text))
	self.nameTxt = findTF(self.tr, "main/name"):GetComponent(typeof(Text))
	self.mark = findTF(self.tr, "main/mark")

	setText(self.addTr:Find("Text"), i18n("island_agora_save_theme"))

	return
end

function AgoraDecorationThemeCard:Update(arg_2_1, arg_2_2)
	self.theme = arg_2_1

	local var_2_0 = arg_2_1.id == -1

	if arg_2_1.id ~= -1 then
		self:UpdateMain(arg_2_1, arg_2_2)
	end

	setActive(self.mainTr, not var_2_0)
	setActive(self.addTr, var_2_0)
	setActive(self.idTr, not var_2_0 and isa(arg_2_1, AgoraTheme))

	return
end

function AgoraDecorationThemeCard:LoadRawTex(arg_3_1)
	local var_3_0 = AgoraCalc.BuildScreenShootSavePath(arg_3_1)
	local var_3_1

	if not PathMgr.FileExists(var_3_0) then
		self:LoadImage(0)

		do return end

		var_3_1 = UnityEngine.Texture2D.New(426, 320)
	end

	Tex2DExtension.LoadImage(var_3_1, (System.IO.File.ReadAllBytes(var_3_0)))

	self.iconRaw.texture = var_3_1

	setActive(self.iconRaw, true)
	setActive(self.icon, false)

	return
end

function AgoraDecorationThemeCard:LoadImage(arg_4_1)
	LoadSpriteAsync("island/IslandThemeIcon/" .. arg_4_1, function(arg_5_0)
		self.icon.sprite = arg_5_0

		self.icon:SetNativeSize()

		return
	end)
	setActive(self.iconRaw, false)
	setActive(self.icon, true)

	return
end

function AgoraDecorationThemeCard:UpdateMain(arg_6_1, arg_6_2)
	self.idTxt.text = arg_6_1.id
	self.nameTxt.text = shortenString(arg_6_1.name, 5)

	setActive(self.mark, arg_6_1.id == arg_6_2)

	if isa(arg_6_1, AgoraTheme) then
		self:LoadRawTex(arg_6_1.id)
	else
		self:LoadImage(arg_6_1.id)
	end

	return
end

function AgoraDecorationThemeCard:Dispose()
	if not IsNil(self.iconRaw.texture) then
		Object.Destroy(self.iconRaw.texture)

		self.iconRaw.texture = nil
	end

	return
end

return AgoraDecorationThemeCard
