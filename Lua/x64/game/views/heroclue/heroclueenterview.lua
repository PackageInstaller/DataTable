local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("HeroClueEnterView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return HeroClueTools.GetEnterViewUIName(arg_1_0.activityID_)
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.taskUpdateHandler_ = handler(arg_3_0, arg_3_0.UpdateData)
	arg_3_0.taskActivityID_ = HeroClueTools.GetTaskActivityID(arg_3_0.activityID_)

	arg_3_0:InitController()
	arg_3_0:InitTaskList()
	arg_3_0:InitStaticText()
end

function var_0_1.InitController(arg_4_0)
	arg_4_0.allReceiveController_ = ControllerUtil.GetController(arg_4_0.taskPanelTrans_, "clear")
end

function var_0_1.InitTaskList(arg_5_0)
	arg_5_0.scrollHelper_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexItem), arg_5_0.scrollView_, HeroClueTools.GetTaskItemClass(arg_5_0.activityID_))
end

function var_0_1.InitStaticText(arg_6_0)
	if arg_6_0.titleText_ then
		arg_6_0.titleText_.text = HeroClueTools.GetActivityTitle(arg_6_0.activityID_)
	end

	if arg_6_0.activityDescText_ then
		arg_6_0.activityDescText_.text = HeroClueTools.GetActivityDesc(arg_6_0.activityID_)
	end
end

function var_0_1.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.playBtn_, nil, function()
		if not arg_7_0:IsActivityTime() then
			return
		end

		HeroClueTools.GoToClueMainView(arg_7_0.activityID_)
	end)
	arg_7_0:AddBtnListener(arg_7_0.allReceiveBtn_, nil, function()
		if not arg_7_0:IsActivityTime() then
			return
		end

		local var_9_0 = {}

		for iter_9_0, iter_9_1 in ipairs(arg_7_0.taskDataList_) do
			if iter_9_1.progress < AssignmentCfg[iter_9_1.id].need or iter_9_1.complete_flag >= 1 then
				break
			end

			var_9_0[#var_9_0 + 1] = iter_9_1.id
		end

		TaskAction:SubmitTaskList(var_9_0)
	end)
	arg_7_0:AddBtnListener(arg_7_0.descBtn_, nil, function()
		local var_10_0 = HeroClueTools.GetGamePlayDesc(arg_7_0.activityID_)

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_HERO_CLUE_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_10_0
		})
	end)
end

function var_0_1.Dispose(arg_11_0)
	arg_11_0.taskUpdateHandler_ = nil

	arg_11_0.scrollHelper_:Dispose()

	arg_11_0.scrollHelper_ = nil

	arg_11_0:StopTimer()
	var_0_1.super.Dispose(arg_11_0)
end

function var_0_1.Show(arg_12_0, arg_12_1)
	SetActive(arg_12_0.gameObject_, arg_12_1)

	if arg_12_1 == true then
		arg_12_0:RefreshUI()
		manager.redPoint:bindUIandKey(arg_12_0.playBtn_.transform, string.format("%s_%d", RedPointConst.HERO_CLUE_PLAY, arg_12_0.activityID_))
		arg_12_0:RegistEventListener(OSIRIS_TASK_UPDATE, arg_12_0.taskUpdateHandler_)
	else
		manager.redPoint:unbindUIandKey(arg_12_0.playBtn_.transform, string.format("%s_%s", RedPointConst.HERO_CLUE_PLAY, arg_12_0.activityID_))
		arg_12_0:RemoveAllEventListener()
	end
end

function var_0_1.RefreshUI(arg_13_0)
	arg_13_0.taskDataList_ = TaskData2:GetActivityTaskSortList(arg_13_0.taskActivityID_)

	arg_13_0.scrollHelper_:StartScroll(#arg_13_0.taskDataList_)
	arg_13_0:RefreshReceiveBtn()
end

function var_0_1.RefreshReceiveBtn(arg_14_0)
	local var_14_0 = false

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.taskDataList_) do
		if iter_14_1.progress >= AssignmentCfg[iter_14_1.id].need and iter_14_1.complete_flag < 1 then
			var_14_0 = true

			break
		end
	end

	arg_14_0.allReceiveController_:SetSelectedState(tostring(var_14_0))
	arg_14_0.scrollHelper_:StartScroll(#arg_14_0.taskDataList_)
end

function var_0_1.IndexItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.taskDataList_[arg_15_1].id

	arg_15_2:SetData(var_15_0, arg_15_0.taskActivityID_)
end

function var_0_1.UpdateData(arg_16_0)
	arg_16_0:RefreshUI()
	HeroClueAction.UpdateDrawRedPoint(arg_16_0.activityID_)
end

function var_0_1.RefreshTimeText(arg_17_0)
	if arg_17_0.timeText_ then
		arg_17_0.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(arg_17_0.stopTime_, true)
	end
end

return var_0_1
