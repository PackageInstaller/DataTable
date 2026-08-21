local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("PuzzleNewTaskView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return PuzzleNewTools.GetTaskUIName(arg_1_0.activityID_)
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.scrollView_, PuzzleNewTaskItem)
	arg_3_0.taskUpdateHandler_ = handler(arg_3_0, arg_3_0.UpdateData)
	arg_3_0.allReceiveController_ = ControllerUtil.GetController(arg_3_0.transform_, "allReceive")

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

function var_0_1.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.playBtn_, nil, function()
		if not arg_4_0:IsActivityTime() then
			return
		end

		PuzzleNewData:SetPlayBtnSelected(arg_4_0.activityID_)
		arg_4_0:Go("/puzzleNewPlay", {
			activityID = arg_4_0.activityID_
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.allReceiveBtn_, nil, function()
		if not arg_4_0:IsActivityTime() then
			return
		end

		local var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(arg_4_0.taskDataList_) do
			if iter_6_1.progress < AssignmentCfg[iter_6_1.id].need or iter_6_1.complete_flag >= 1 then
				break
			end

			var_6_0[#var_6_0 + 1] = iter_6_1.id
		end

		TaskAction:SubmitTaskList(var_6_0)
	end)
	arg_4_0:AddBtnListener(arg_4_0.descBtn_, nil, function()
		local var_7_0 = GetTips("ACTIVITY_XUHENG_PUZZLE_DESCRIBE")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_XUHENG_PUZZLE_DESCRIBE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_7_0
		})
	end)
end

function var_0_1.Dispose(arg_8_0)
	arg_8_0.taskUpdateHandler_ = nil

	arg_8_0.scrollHelper_:Dispose()

	arg_8_0.scrollHelper_ = nil

	arg_8_0:StopTimer()
	var_0_1.super.Dispose(arg_8_0)
end

function var_0_1.Show(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)

	if arg_9_1 == true then
		arg_9_0:RefreshUI()
		manager.redPoint:bindUIandKey(arg_9_0.playBtnTrans_, string.format("%s_%s", RedPointConst.PUZZLE_NEW_PLAY, arg_9_0.activityID_))
		arg_9_0:RegistEventListener(OSIRIS_TASK_UPDATE, arg_9_0.taskUpdateHandler_)
	else
		manager.redPoint:unbindUIandKey(arg_9_0.playBtnTrans_, string.format("%s_%s", RedPointConst.PUZZLE_NEW_PLAY, arg_9_0.activityID_))
		arg_9_0:RemoveAllEventListener()
	end
end

function var_0_1.RefreshUI(arg_10_0)
	arg_10_0.taskDataList_ = TaskData2:GetActivityTaskSortList(arg_10_0.taskActivityID_)

	arg_10_0.scrollHelper_:StartScroll(#arg_10_0.taskDataList_)
	arg_10_0:RefreshReceiveBtn()
end

function var_0_1.RefreshReceiveBtn(arg_11_0)
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.taskDataList_) do
		if iter_11_1.progress >= AssignmentCfg[iter_11_1.id].need and iter_11_1.complete_flag < 1 then
			var_11_0 = 1

			break
		end
	end

	arg_11_0.allReceiveController_:SetSelectedIndex(var_11_0)
end

function var_0_1.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.taskDataList_[arg_12_1].id

	arg_12_2:SetData(var_12_0, arg_12_0.taskActivityID_)
end

function var_0_1.UpdateData(arg_13_0)
	arg_13_0:RefreshUI()
	PuzzleNewData:RefreshPieceRedPoint(arg_13_0.activityID_)
end

function var_0_1.RefreshTimeText(arg_14_0)
	if arg_14_0.timeText_ then
		arg_14_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_14_0.stopTime_, true)
	end
end

return var_0_1
