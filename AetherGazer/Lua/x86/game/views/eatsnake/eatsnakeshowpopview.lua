local var_0_0 = class("EatSnakeShowPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_3_10_SnakegameUI/SandPlay_3_10_SnakegameCodexpopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.controller = arg_4_0.controller_:GetController("select")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:UpdateData()
	arg_7_0:UpdateView()
end

function var_0_0.UpdateData(arg_8_0)
	return
end

function var_0_0.UpdateView(arg_9_0)
	arg_9_0.cfg = ActivityEatSnakeCfg[arg_9_0.params_.id]
	arg_9_0.image_.sprite = pureGetSpriteWithoutAtlas(arg_9_0.cfg.image)
	arg_9_0.nameText_.text = arg_9_0.cfg.name
	arg_9_0.descText_.text = arg_9_0.cfg.desc

	arg_9_0.controller:SetSelectedState(arg_9_0.params_.isLock and "false" or "true")
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
	Object.Destroy(arg_12_0.gameObject_)
end

return var_0_0
