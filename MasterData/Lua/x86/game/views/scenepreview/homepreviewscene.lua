local HomePreviewScene = class("HomePreviewScene", ReduxView)

function HomePreviewScene:UIName()
	return "Widget/System/Main/SceneChange3"
end

function HomePreviewScene:UIParent()
	return manager.ui.uiMain.transform
end

function HomePreviewScene:Init()
	self:InitUI()
	self:AddUIListeners()
end

function HomePreviewScene:InitUI()
	self:BindCfgUI()

	self.selectCon_ = ControllerUtil.GetController(self.transform_, "select")
end

function HomePreviewScene:AddUIListeners()
	self:AddBtnListener(self.showBtn_, nil, function()
		self.isOff_ = 1 - self.isOff_

		self.selectCon_:SetSelectedState(self.isOff_ == 1 and "off" or "on")
	end)
end

function HomePreviewScene:OnEnter()
	manager.ui:SetMainCamera("homePreview")

	local var_7_0 = HomeSceneSettingData:GetPreviewScene()

	if HomeSceneSettingCfg[var_7_0].limit_display == 0 then
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.preview, CustomCenterTools.GetMatchSkinByScene(var_7_0))
	end

	manager.loadScene:SetPreviewHomeSceneSoundEffect()
	self:RefreshUI()
	self:PlayBgm()
end

function HomePreviewScene:RefreshUI()
	self.isOff_ = 1

	self.selectCon_:SetSelectedState("off")
end

function HomePreviewScene:PlayBgm()
	local var_9_0 = HomeSceneSettingCfg[HomeSceneSettingData:GetPreviewScene()]

	if var_9_0.default_music ~= 0 and SettingData:GetHomeSceneSettingData().home_scene_scene_bgm == 1 and table.indexof(var_9_0.scene_setting, HomeSceneSettingConst.SETTING.SCENE_BGM) then
		if MusicRecordCfg[var_9_0.default_music] then
			manager.audio:PlayBGM(MusicRecordCfg[var_9_0.default_music].cuesheet, MusicRecordCfg[var_9_0.default_music].cueName, MusicRecordCfg[var_9_0.default_music].awbName)
		end
	end
end

function HomePreviewScene:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function HomePreviewScene:OnExit()
	if HomeSceneSettingCfg[HomeSceneSettingData:GetPreviewScene()].limit_display == 0 then
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)
	end

	manager.loadScene:StopSceneSoundEffect()
	manager.windowBar:HideBar()
end

function HomePreviewScene:Dispose()
	self:RemoveAllListeners()
	HomePreviewScene.super.Dispose(self)
end

return HomePreviewScene
