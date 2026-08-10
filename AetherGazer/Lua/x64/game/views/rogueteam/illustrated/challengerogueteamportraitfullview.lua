local var_0_0 = class("ChallengeRogueTeamPortraitFullView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ObtainUI/HeroMovie/PortraitFullUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.closeBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.image_ = arg_9_0.params_.image
	arg_9_0.portriatImg_.sprite = pureGetSpriteWithoutAtlas(arg_9_0.image_)

	arg_9_0.portriatImg_:SetNativeSize()
end

return var_0_0
