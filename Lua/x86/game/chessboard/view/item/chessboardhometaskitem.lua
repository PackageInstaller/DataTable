local var_0_0 = class("ChessBoardHomeTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.taskID_ = arg_4_1

	arg_4_0:UpdateView()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		local var_6_0 = ChessBoardTaskPoolCfg[arg_5_0.taskID_]

		if type(var_6_0.camera_move) == "table" and var_6_0.camera_move[1] ~= nil then
			manager.ChessBoardManager:MoveToTarget(var_6_0.camera_move[1], var_6_0.camera_move[2])
		end
	end)
end

function var_0_0.UpdateView(arg_7_0)
	local var_7_0 = ChessBoardTaskPoolCfg[arg_7_0.taskID_]
	local var_7_1 = manager.ChessBoardManager.taskManager_:GetTaskInfo(arg_7_0.taskID_)

	arg_7_0.nameText_.text = var_7_0.title
	arg_7_0.descText_.text = var_7_0.description

	if var_7_0.cost > 0 then
		SetActive(arg_7_0.costGo_, true)

		arg_7_0.costText_.text = var_7_0.cost
	else
		SetActive(arg_7_0.costGo_, false)
	end

	if arg_7_0.taskID_ == ChessBoardConst.GET_DUCK_TASKID then
		SetActive(arg_7_0.normalDescGo_, false)
		SetActive(arg_7_0.duckDescGo_, true)
	else
		SetActive(arg_7_0.normalDescGo_, true)
		SetActive(arg_7_0.duckDescGo_, false)
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
