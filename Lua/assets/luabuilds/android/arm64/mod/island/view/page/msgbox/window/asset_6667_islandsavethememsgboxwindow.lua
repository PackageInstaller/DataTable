local IslandSaveThemeMsgboxWindow = class("IslandSaveThemeMsgboxWindow", import(".IslandCommonMsgboxWindow"))

function IslandSaveThemeMsgboxWindow:getUIName()
	return "IslandCommonMsgBoxForSaveTheme"
end

function IslandSaveThemeMsgboxWindow:OnLoaded()
	IslandSaveThemeMsgboxWindow.super.OnLoaded(self)

	self.icon = self._tf:Find("icon")
	self.iconRaw = self._tf:Find("icon_raw"):GetComponent(typeof(RawImage))
	self.inputTr = self._tf:Find("input")

	return
end

function IslandSaveThemeMsgboxWindow:OnInit()
	IslandSaveThemeMsgboxWindow.super.OnInit(self)
	onButton(self, self.confirmBtn, function()
		local var_4_0 = getInputText(self.inputTr)

		if not var_4_0 or var_4_0 == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_input_theme_name"))

			return
		end

		if self.onYes then
			self.onYes(var_4_0)
		end

		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function IslandSaveThemeMsgboxWindow:OnShow()
	setInputText(self.inputTr, i18n("island_custom_theme_name", self.settings.id))

	self.settings.content = i18n("island_custom_theme_name_tip")

	IslandSaveThemeMsgboxWindow.super.OnShow(self)
	self:FlushIcon()

	return
end

function IslandSaveThemeMsgboxWindow:FlushIcon()
	self:LoadRawTex(self.settings.id)

	return
end

function IslandSaveThemeMsgboxWindow:LoadRawTex(arg_7_1)
	local var_7_0 = AgoraCalc.BuildScreenShootSavePath(arg_7_1)
	local var_7_1

	if not PathMgr.FileExists(var_7_0) then
		do return end

		var_7_1 = UnityEngine.Texture2D.New(426, 320)
	end

	Tex2DExtension.LoadImage(var_7_1, (System.IO.File.ReadAllBytes(var_7_0)))

	self.iconRaw.texture = var_7_1

	setActive(self.iconRaw, true)
	setActive(self.icon, false)

	return
end

function IslandSaveThemeMsgboxWindow:OnHide()
	IslandSaveThemeMsgboxWindow.super.OnHide(self)

	if not IsNil(self.iconRaw.texture) then
		Object.Destroy(self.iconRaw.texture)

		self.iconRaw.texture = nil
	end

	return
end

return IslandSaveThemeMsgboxWindow
