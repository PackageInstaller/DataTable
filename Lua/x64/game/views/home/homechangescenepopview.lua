local var_0_0 = class("HomeChangeScenePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Main/HomeSceneChangePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stateCon_ = arg_4_0.collecter_:GetController("state")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.leftBtn_, nil, function()
		arg_5_0.curIndex_ = 1

		arg_5_0:RefreshState()
	end)
	arg_5_0:AddBtnListener(arg_5_0.rightBtn_, nil, function()
		arg_5_0.curIndex_ = 2

		arg_5_0:RefreshState()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		saveData("scenePop", "sceneID_" .. arg_5_0.leftID_, true)

		if arg_5_0.curIndex_ == 2 then
			HomeSceneSettingAction.SetHomeScene(arg_5_0.rightID_)
		else
			HomeSceneSettingData:SetDefaultScene(arg_5_0.leftID_)
		end

		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.curIndex_ = 1
	arg_9_0.leftID_ = arg_9_0.params_.left
	arg_9_0.rightID_ = arg_9_0.params_.right
	arg_9_0.leftText_.text = HomeSceneSettingCfg[arg_9_0.leftID_].title
	arg_9_0.rightText_.text = HomeSceneSettingCfg[arg_9_0.rightID_].title
	arg_9_0.leftIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SceneChangeUI/item/" .. arg_9_0.leftID_)
	arg_9_0.rightIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SceneChangeUI/item/" .. arg_9_0.rightID_)
	arg_9_0.desc_.text = GetTips("HOME_SCENE_FORCE_CHANGE")

	arg_9_0:RefreshState()
end

function var_0_0.RefreshState(arg_10_0)
	arg_10_0.stateCon_:SetSelectedState(arg_10_0.curIndex_ == 1 and "left" or "right")
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
