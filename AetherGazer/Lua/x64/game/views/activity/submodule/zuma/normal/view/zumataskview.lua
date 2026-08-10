local var_0_0 = class("ZumaTalentView", ReduxView)
local var_0_1 = {
	showState = {
		showOneClick = "showOneClick",
		name = "clear",
		normal = "normal"
	}
}

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaQuestPopup"
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

	arg_4_0.showStateController = arg_4_0.controllerexcollection_:GetController(var_0_1.showState.name)
	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiList_, ZumaTaskItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.taskDataList[arg_5_1])
end

function var_0_0.OnTaskListChange(arg_6_0)
	arg_6_0.taskDataList = ZumaData:GetZumaTaskData()

	arg_6_0.list_:StartScroll(#arg_6_0.taskDataList)
	arg_6_0:UpdateTaskData()
end

function var_0_0.UpdateTaskData(arg_7_0)
	arg_7_0.taskDataList = ZumaData:GetZumaTaskData()

	arg_7_0.list_:StartScroll(#arg_7_0.taskDataList)

	local var_7_0 = false

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.taskDataList) do
		local var_7_1 = AssignmentCfg[iter_7_1.id]

		if iter_7_1.progress >= var_7_1.need and iter_7_1.complete_flag < 1 then
			var_7_0 = true

			return
		end
	end

	arg_7_0.showStateController:SetSelectedState(var_7_0 and var_0_1.showState.showOneClick or var_0_1.showState.normal)
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.receiveBtn_, nil, function()
		arg_8_0:OnReceive()
	end)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnReceive(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.taskDataList) do
		local var_11_1 = AssignmentCfg[iter_11_1.id]

		if iter_11_1.progress >= var_11_1.need and iter_11_1.complete_flag < 1 then
			table.insert(var_11_0, iter_11_1.id)
		end
	end

	TaskAction:SubmitTaskList(var_11_0)
end

function var_0_0.OnTop(arg_12_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:UpdateTaskData()
end

function var_0_0.OnExit(arg_14_0)
	return
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.list_ then
		arg_15_0.list_:Dispose()

		arg_15_0.list_ = nil
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
