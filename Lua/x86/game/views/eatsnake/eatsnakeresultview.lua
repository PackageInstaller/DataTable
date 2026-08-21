local var_0_0 = class("EatSnakeResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_3_10_SnakegameUI/SandPlay_Com_SnakegameResultPopUI"
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

	arg_4_0.controller = arg_4_0.controller_:GetController("state")
	arg_4_0.conditionList = {}

	for iter_4_0 = 1, 3 do
		arg_4_0.conditionList[iter_4_0] = arg_4_0["condition" .. iter_4_0 .. "Controller_"]:GetController("status")
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		arg_5_0.params_.parent.tools:ClearAllBlockStatus()
		EatSnakesLuaBridge.OverGame()
	end)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		arg_5_0.Back()
		arg_5_0.params_.parent:OnEnter()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:UpdateData()
	arg_8_0:UpdateView()
	manager.windowBar:HideBar()
end

function var_0_0.UpdateData(arg_9_0)
	arg_9_0.stageList = EatSnakeData:GetDataByPara("stageList")
end

function var_0_0.UpdateView(arg_10_0)
	if arg_10_0.params_.type == 1 then
		arg_10_0.controller:SetSelectedState("win")
		manager.audio:PlayEffect("minigame_activity_3_10", "minigame_activity_3_10_snake_win", "")
	else
		arg_10_0.controller:SetSelectedState("lose")
		manager.audio:PlayEffect("minigame_activity_3_10", "minigame_activity_3_10_snake_lose", "")
	end

	arg_10_0.cfg = ActivityEatSnakeCfg[arg_10_0.params_.id]
	arg_10_0.time = arg_10_0.params_.time

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.cfg.target_list) do
		arg_10_0["condition" .. iter_10_0 .. "Txt_"].text = ConditionCfg[iter_10_1].desc
	end

	for iter_10_2 = 1, 3 do
		if arg_10_0.params_.type == 2 then
			arg_10_0.conditionList[iter_10_2]:SetSelectedState("notpass")
		elseif iter_10_2 == 1 then
			arg_10_0.conditionList[iter_10_2]:SetSelectedState("pass")
		else
			arg_10_0.conditionList[iter_10_2]:SetSelectedState(arg_10_0.time < ConditionCfg[arg_10_0.cfg.target_list[iter_10_2]].params[2] and "pass" or "notpass")
		end
	end
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
