local var_0_0 = class("CowboyAttributeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Cowboy/CowboyAttributeUI"
end

function var_0_0.GetCustomScene(arg_2_0)
	return HeroRaiseTrackConst.CustomScene.Cowboy
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListeners()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_6_0)
	return
end

function var_0_0.OnEnter(arg_7_0)
	manager.windowBar:ShowDefaultBar()

	local var_7_0 = arg_7_0:GetCustomSceneController()

	var_7_0:SwitchToShow()
	var_7_0:PlayHeroAnim("1083ui_dynamic", "Skill_Details_2", 0.2)
end

function var_0_0.OnTop(arg_8_0)
	return
end

function var_0_0.OnBehind(arg_9_0)
	return
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
