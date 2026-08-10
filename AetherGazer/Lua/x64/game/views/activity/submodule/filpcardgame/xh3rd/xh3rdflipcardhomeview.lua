ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("XH3rdFlipCardHomeView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return XH3rdFlipCardTool:GetHomeUI()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
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
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.playBtn_, nil, function()
		if not arg_4_0:IsActivityTime() then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("/xH3rdFlipCardGame", {
			activityId = arg_4_0.activityID_
		})

		XH3rdFlipCardAction.hasEnterGame = true

		XH3rdFlipCardAction.UpdateTokenRedPoint()
	end)
	arg_4_0:AddBtnListener(arg_4_0.allReceiveBtn_, nil, function()
		if not arg_4_0:IsActivityTime() then
			ShowTips("TIME_OVER")

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
		local var_7_0 = XH3rdFlipCardTool:GetHelpTips()

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_FLIP_CARD_EXPLAIN",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_7_0
		})
	end)
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.taskUpdateHandler_ = nil

	arg_8_0.scrollHelper_:Dispose()

	arg_8_0.scrollHelper_ = nil

	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.UpdateBar(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		FlipCardCfg[arg_9_0.activityID_].cost_id
	})
	manager.windowBar:SetBarCanAdd(FlipCardCfg[arg_9_0.activityID_].cost_id, true)
end

function var_0_0.Show(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)

	if arg_10_1 == true then
		arg_10_0:RefreshUI()
		manager.redPoint:bindUIandKey(arg_10_0.playBtnTrans_, string.format("%s_%s_challenge", RedPointConst.ACTIVITY_2_2_FLIP_CARD, arg_10_0.activityID_))
		arg_10_0:RegistEventListener(OSIRIS_TASK_UPDATE, arg_10_0.taskUpdateHandler_)
	else
		manager.redPoint:unbindUIandKey(arg_10_0.playBtnTrans_, string.format("%s_%s_challenge", RedPointConst.ACTIVITY_2_2_FLIP_CARD, arg_10_0.activityID_))
		arg_10_0:RemoveAllEventListener()
	end
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0.taskDataList_ = TaskData2:GetActivityTaskSortList(arg_11_0.taskActivityID_)

	arg_11_0.scrollHelper_:StartScroll(#arg_11_0.taskDataList_)
	arg_11_0:RefreshReceiveBtn()
end

function var_0_0.RefreshReceiveBtn(arg_12_0)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.taskDataList_) do
		if iter_12_1.progress >= AssignmentCfg[iter_12_1.id].need and iter_12_1.complete_flag < 1 then
			var_12_0 = 1

			break
		end
	end

	arg_12_0.allReceiveController_:SetSelectedIndex(var_12_0)
end

function var_0_0.IndexItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.taskDataList_[arg_13_1].id

	arg_13_2:SetData(var_13_0, arg_13_0.taskActivityID_)
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:StopTimer()
end

function var_0_0.UpdateData(arg_15_0)
	arg_15_0:RefreshUI()
end

return var_0_0
