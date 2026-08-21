local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("IndiaPuzzleNewTaskView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return PuzzleNewTools.GetTaskUIName(arg_1_0.activityID_)
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.scrollView_, PuzzleNewTools.GetTaskItemClass(arg_3_0.activityID_))
	arg_3_0.taskUpdateHandler_ = handler(arg_3_0, arg_3_0.UpdateData)

	arg_3_0:InitController()

	local var_3_0 = ActivityCfg[arg_3_0.activityID_].sub_activity_list

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if ActivityCfg[iter_3_1].activity_template == ActivityTemplateConst.TASK then
			arg_3_0.taskActivityID_ = iter_3_1

			break
		end
	end

	if arg_3_0.taskActivityID_ == nil then
		arg_3_0.taskActivityID_ = 170045
	end
end

function var_0_1.InitController(arg_4_0)
	arg_4_0.allReceiveController_ = ControllerUtil.GetController(arg_4_0.listPanelTrans_, "clear")
end

function var_0_1.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.playBtn_, nil, function()
		if not arg_5_0:IsActivityTime() then
			return
		end

		PuzzleNewData:SetPlayBtnSelected(arg_5_0.activityID_)
		arg_5_0:Go("/puzzleNewPlay", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.lockBtn_, nil, function()
		local var_7_0, var_7_1 = arg_5_0:CheckAdvanceOpenTime()

		if var_7_0 then
			ShowTips(var_7_1)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.allReceiveBtn_, nil, function()
		if not arg_5_0:IsActivityTime() then
			return
		end

		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_5_0.taskDataList_) do
			if iter_8_1.progress < AssignmentCfg[iter_8_1.id].need or iter_8_1.complete_flag >= 1 then
				break
			end

			var_8_0[#var_8_0 + 1] = iter_8_1.id
		end

		TaskAction:SubmitTaskList(var_8_0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.descBtn_, nil, function()
		local var_9_0 = GetTips("ACTIVITY_XUHENG_PUZZLE_DESCRIBE")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_XUHENG_PUZZLE_DESCRIBE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_9_0
		})
	end)
end

function var_0_1.Dispose(arg_10_0)
	arg_10_0.taskUpdateHandler_ = nil

	arg_10_0.scrollHelper_:Dispose()

	arg_10_0.scrollHelper_ = nil

	arg_10_0:StopTimer()
	var_0_1.super.Dispose(arg_10_0)
end

function var_0_1.Show(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)

	if arg_11_1 == true then
		arg_11_0:RefreshUI()
		manager.redPoint:bindUIandKey(arg_11_0.playBtnTrans_, string.format("%s_%s", RedPointConst.PUZZLE_NEW_PLAY, arg_11_0.activityID_))
		arg_11_0:RegistEventListener(OSIRIS_TASK_UPDATE, arg_11_0.taskUpdateHandler_)
	else
		manager.redPoint:unbindUIandKey(arg_11_0.playBtnTrans_, string.format("%s_%s", RedPointConst.PUZZLE_NEW_PLAY, arg_11_0.activityID_))
		arg_11_0:RemoveAllEventListener()
	end
end

function var_0_1.RefreshUI(arg_12_0)
	arg_12_0.taskDataList_ = TaskData2:GetActivityTaskSortList(arg_12_0.taskActivityID_)

	arg_12_0:RefreshReceiveBtn()
	arg_12_0.scrollHelper_:StartScroll(#arg_12_0.taskDataList_)
end

function var_0_1.RefreshReceiveBtn(arg_13_0)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.taskDataList_) do
		if iter_13_1.progress >= AssignmentCfg[iter_13_1.id].need and iter_13_1.complete_flag < 1 then
			var_13_0 = 1

			break
		end
	end

	arg_13_0.allReceiveController_:SetSelectedState(var_13_0 == 1 and "true" or "false")
end

function var_0_1.IndexItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.taskDataList_[arg_14_1].id

	arg_14_2:SetData(var_14_0, arg_14_0.taskActivityID_)
end

function var_0_1.UpdateData(arg_15_0)
	arg_15_0:RefreshUI()
	PuzzleNewData:RefreshPieceRedPoint(arg_15_0.activityID_)
end

return var_0_1
