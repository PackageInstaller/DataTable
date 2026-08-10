local var_0_0 = class("EatSnakeAnimationView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_3_10_SnakegameUI/SandPlay_3_10_SnakegameUnlockpopUI"
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

	arg_4_0.animController_ = arg_4_0.animCon_:GetController("animEffect")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0.Back()
		JumpTools.GoToSystem("eatSnakeResult", {
			type = 1,
			time = arg_5_0.params_.time,
			id = arg_5_0.params_.id,
			parent = arg_5_0.params_.parent
		})
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.animController_:SetSelectedState(table.indexof(ActivityEatSnakeCfg.all, arg_7_0.params_.id))
	arg_7_0:UpdateData()
	arg_7_0:UpdateView()
end

function var_0_0.UpdateData(arg_8_0)
	arg_8_0.cfg = ActivityEatSnakeCfg[arg_8_0.params_.id]
end

function var_0_0.UpdateView(arg_9_0)
	arg_9_0.image_.sprite = pureGetSpriteWithoutAtlas(arg_9_0.cfg.image)
	arg_9_0.nameTxt_.text = arg_9_0.cfg.name
	arg_9_0.time = TimeTools.StartAfterSeconds(5, function()
		arg_9_0.Back()
		JumpTools.GoToSystem("eatSnakeResult", {
			type = 1,
			time = arg_9_0.params_.time,
			id = arg_9_0.params_.id,
			parent = arg_9_0.params_.parent
		})
	end, {})
end

function var_0_0.OnExit(arg_11_0)
	if arg_11_0.time then
		arg_11_0.time:Stop()

		arg_11_0.time = nil
	end
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
