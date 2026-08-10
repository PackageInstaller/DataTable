local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("TangramPuzzleTaskView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return TangramPuzzleTools.GetTaskUIName(arg_1_0.activityID_)
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:InitTaskActivityID()

	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.scrollView_, PuzzleNewTaskItem_Resident)
	arg_3_0.taskUpdateHandler_ = handler(arg_3_0, arg_3_0.UpdateData)
	arg_3_0.allReceiveController_ = arg_3_0.allReceiveControllerEx:GetController("clear")
	arg_3_0.playBtnText_.text = GetTips("TANGRAM_PUZZLE_PLAY_BTN")
end

function var_0_1.InitTaskActivityID(arg_4_0)
	local var_4_0 = ActivityCfg[arg_4_0.activityID_].sub_activity_list

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if ActivityCfg[iter_4_1].activity_template == ActivityTemplateConst.TASK then
			arg_4_0.taskActivityID_ = iter_4_1

			break
		end
	end
end

function var_0_1.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.playBtn_, nil, function()
		if not arg_5_0:IsActivityTime() then
			return
		end

		arg_5_0:Go("/tangramPuzzlePlay", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.allReceiveBtn_, nil, function()
		if not arg_5_0:IsActivityTime() then
			return
		end

		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(arg_5_0.taskDataList_) do
			if iter_7_1.progress < AssignmentCfg[iter_7_1.id].need or iter_7_1.complete_flag >= 1 then
				break
			end

			var_7_0[#var_7_0 + 1] = iter_7_1.id
		end

		TaskAction:SubmitTaskList(var_7_0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.descBtn_, nil, function()
		local var_8_0 = GetTips("ACTIVITY_PUZZLE_III_EXPLAIN")
		local var_8_1 = TangramPuzzleCfg[arg_5_0.activityID_]

		if var_8_1 and var_8_1.coin_id[1] and var_8_1.coin_id[1][1] then
			var_8_0 = string.format(GetTips("ACTIVITY_PUZZLE_III_EXPLAIN"), ItemTools.getItemName(var_8_1.coin_id[1][1]))
		end

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_PUZZLE_III_EXPLAIN",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_8_0
		})
	end)

	if arg_5_0.webBtn_ then
		arg_5_0:AddBtnListener(arg_5_0.webBtn_, nil, function()
			OperationRecorder.RecordButtonTouch(string.format("activity_%s_web_jump", arg_5_0.webActivityID_))
			ActivityWebTools.OpenUrl(arg_5_0.webID_)
		end)
	end

	if arg_5_0.webRewardBtn_ then
		arg_5_0:AddBtnListener(arg_5_0.webRewardBtn_, nil, function()
			OperationRecorder.RecordButtonTouch(string.format("activity_%s_web_jump", arg_5_0.webActivityID_))
			ActivityWebTools.OpenUrl(arg_5_0.webID_)
		end)
	end
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
		arg_12_0:RegistEventListener(OSIRIS_TASK_UPDATE, arg_12_0.taskUpdateHandler_)
	else
		arg_12_0:RemoveAllEventListener()
	end
end

function var_0_1.RefreshUI(arg_13_0)
	arg_13_0.taskDataList_ = TaskData2:GetActivityTaskSortList(arg_13_0.taskActivityID_)

	arg_13_0:RefreshReceiveBtn()
	arg_13_0.scrollHelper_:StartScroll(#arg_13_0.taskDataList_)
	arg_13_0:RefreshBg()
	arg_13_0:RefreshTitle()
	arg_13_0:RefreshWebActivity()
end

function var_0_1.RefreshReceiveBtn(arg_14_0)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.taskDataList_) do
		if iter_14_1.progress >= AssignmentCfg[iter_14_1.id].need and iter_14_1.complete_flag < 1 then
			var_14_0 = 1

			break
		end
	end

	arg_14_0.allReceiveController_:SetSelectedState(var_14_0 == 1 and "true" or "false")
end

function var_0_1.RefreshBg(arg_15_0)
	local var_15_0 = TangramPuzzleCfg[arg_15_0.activityID_].task_bg_path

	if var_15_0 and var_15_0 ~= "" then
		arg_15_0.bgImg_.sprite = pureGetSpriteWithoutAtlas(var_15_0)
	end
end

function var_0_1.RefreshTitle(arg_16_0)
	local var_16_0 = ActivityToggleCfg.get_id_list_by_activity_id[arg_16_0.activityID_][1]

	arg_16_0.titleText_.text = ActivityToggleCfg[var_16_0].name
	arg_16_0.descText_.text = ActivityToggleCfg[var_16_0].desc
end

function var_0_1.RefreshWebActivity(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(ActivityCfg[arg_17_0.activityID_].sub_activity_list) do
		if ActivityCfg[iter_17_1].activity_template == ActivityTemplateConst.ACTIVITY_WEB then
			arg_17_0.webActivityID_ = iter_17_1
			arg_17_0.webID_ = ActivityWebCfg.get_id_list_by_activity_id[arg_17_0.webActivityID_][1]
		end
	end

	if not arg_17_0.webActivityID_ then
		return
	end

	local var_17_0 = ActivityWebCfg[arg_17_0.webID_].reward_list

	arg_17_0.rewardIcon_1.sprite = ItemTools.getItemSprite(var_17_0[1][1])
	arg_17_0.rewardIcon_2.sprite = ItemTools.getItemSprite(var_17_0[2][1])
	arg_17_0.rewardName_1.text = ItemTools.getItemName(var_17_0[1][1])
	arg_17_0.rewardName_2.text = ItemTools.getItemName(var_17_0[2][1])
end

function var_0_1.IndexItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.taskDataList_[arg_18_1].id

	arg_18_2:SetData(var_18_0, arg_18_0.taskActivityID_)
end

function var_0_1.UpdateData(arg_19_0)
	arg_19_0:RefreshUI()
end

function var_0_1.OnEnter(arg_20_0)
	var_0_1.super.OnEnter(arg_20_0)

	local var_20_0 = string.format("%s_%d", RedPointConst.TANGRAM_PUZZLE_CLUE, arg_20_0.activityID_)

	manager.redPoint:bindUIandKey(arg_20_0.playBtnTrans_, var_20_0)
end

function var_0_1.OnExit(arg_21_0)
	var_0_1.super.OnExit(arg_21_0)

	local var_21_0 = string.format("%s_%s", RedPointConst.TANGRAM_PUZZLE_CLUE, arg_21_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_21_0.playBtnTrans_, var_21_0)
end

return var_0_1
