local var_0_0 = class("HomePreviewScene", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Main/SceneChange3"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.selectCon_ = ControllerUtil.GetController(arg_4_0.transform_, "select")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.showBtn_, nil, function()
		arg_5_0.isOff_ = 1 - arg_5_0.isOff_

		arg_5_0.selectCon_:SetSelectedState(arg_5_0.isOff_ == 1 and "off" or "on")
	end)
end

function var_0_0.OnEnter(arg_7_0)
	manager.ui:SetMainCamera("homePreview")

	local var_7_0 = HomeSceneSettingData:GetPreviewScene()

	if HomeSceneSettingCfg[var_7_0].limit_display == 0 then
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.preview, CustomCenterTools.GetMatchSkinByScene(var_7_0))
	end

	manager.loadScene:SetPreviewHomeSceneSoundEffect()
	arg_7_0:RefreshUI()
	arg_7_0:PlayBgm()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.isOff_ = 1

	arg_8_0.selectCon_:SetSelectedState("off")
end

function var_0_0.PlayBgm(arg_9_0)
	local var_9_0 = HomeSceneSettingData:GetPreviewScene()
	local var_9_1 = HomeSceneSettingCfg[var_9_0]
	local var_9_2 = var_9_1.scene_setting
	local var_9_3 = var_9_1.default_music
	local var_9_4 = SettingData:GetHomeSceneSettingData()

	if var_9_3 ~= 0 and var_9_4.home_scene_scene_bgm == 1 and table.indexof(var_9_2, HomeSceneSettingConst.SETTING.SCENE_BGM) then
		local var_9_5 = MusicRecordCfg[var_9_3]

		if var_9_5 then
			manager.audio:PlayBGM(var_9_5.cuesheet, var_9_5.cueName, var_9_5.awbName)
		end
	end
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.OnExit(arg_11_0)
	local var_11_0 = HomeSceneSettingData:GetPreviewScene()

	if HomeSceneSettingCfg[var_11_0].limit_display == 0 then
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)
	end

	manager.loadScene:StopSceneSoundEffect()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
