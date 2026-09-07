local Dorm3dSettingScene = class("Dorm3dSettingScene", import("view.Setting.NewSettingsScene"))

function Dorm3dSettingScene:getUIName()
	return "Dorm3dSettingUI"
end

function Dorm3dSettingScene:init()
	self.backBtn = self._tf:Find("blur_panel/adapt/top/back_btn")
	self.pages = {
		Settings3DPage.New(self._tf:Find("pages"), self.event, self.contextData)
	}
	self.toggles = {
		self._tf:Find("blur_panel/adapt/left_length/threeD")
	}
	self.otherTip = self.toggles[1]:Find("tip")
	self.descWindow = SettingsMsgBosPage.New(self._tf, self.event)

	return
end

function Dorm3dSettingScene:didEnter()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	self:SwitchPage(1)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function Dorm3dSettingScene:onBackPressed()
	self:closeView()

	return
end

function Dorm3dSettingScene:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	Dorm3dSettingScene.super.willExit(self)

	return
end

return Dorm3dSettingScene
