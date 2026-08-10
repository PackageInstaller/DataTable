local var_0_0 = class("EatSnakeShowView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_3_10_SnakegameUI/SandPlay_3_10_SnakegameCodexUI"
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

	for iter_4_0 = 1, 7 do
		arg_4_0["controller" .. iter_4_0] = arg_4_0["controller" .. iter_4_0 .. "_"]:GetController("lock")
	end
end

function var_0_0.AddUIListener(arg_5_0)
	for iter_5_0 = 1, 7 do
		arg_5_0:AddBtnListener(arg_5_0["btn" .. iter_5_0 .. "_"], nil, function()
			if arg_5_0.stageList[iter_5_0] == nil then
				return
			end

			JumpTools.OpenPageByJump("eatSnakeShowPop", {
				id = ActivityEatSnakeCfg.all[iter_5_0],
				isLock = arg_5_0.stageList[iter_5_0] ~= nil
			})
		end)
	end
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:UpdateData()
	arg_7_0:UpdateView()
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.UpdateData(arg_9_0)
	arg_9_0.stageList = EatSnakeData:GetDataByPara("stageList")
end

function var_0_0.UpdateView(arg_10_0)
	for iter_10_0 = 1, 7 do
		arg_10_0["controller" .. iter_10_0]:SetSelectedState(arg_10_0.stageList[iter_10_0] == nil and "lock" or "unlock")
	end
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
