local var_0_0 = class("SummerChessBoardEmergencyView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_EmergencyPopUI"
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

	arg_4_0.taskItem = SummerChessBoardActivityTaskItem.New(arg_4_0.questGo_)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.fullscreenBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({})

	local var_7_0 = SummerChessBoardData:GetBreakOutEventAndRedData()

	if var_7_0 == nil or var_7_0 == 0 then
		JumpTools.Back()
	end
end

function var_0_0.OnEnter(arg_8_0)
	saveData("SummerChessBoard", USER_ID .. "EmergencyTime", manager.time:GetServerTime())
	arg_8_0:InitData()
	arg_8_0:RefreshUI()
end

function var_0_0.InitData(arg_9_0)
	arg_9_0.eventID = SummerChessBoardData:GetBreakOutEventAndRedData()
end

function var_0_0.RefreshUI(arg_10_0)
	if not arg_10_0.eventID then
		return
	end

	local var_10_0 = AssignmentCfg[arg_10_0.eventID]
	local var_10_1 = ActivityEmergencyCfg[arg_10_0.eventID]

	arg_10_0.titleText_.text = var_10_1.desc_name
	arg_10_0.textText_.text = var_10_1.desc

	arg_10_0.taskItem:SetData(arg_10_0.eventID)
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.taskItem then
		arg_12_0.taskItem:Dispose()

		arg_12_0.taskItem = nil
	end

	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
