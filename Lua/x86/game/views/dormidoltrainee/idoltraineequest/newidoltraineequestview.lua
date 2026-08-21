local var_0_0 = class("NewIdolTraineeQuestView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolTrainee/IdolTraineeQuestPopup_new"
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

	arg_4_0.questData_ = {}
	arg_4_0.questUIList_ = LuaList.New(handler(arg_4_0, arg_4_0.RefreshItem), arg_4_0.questList_, IdolTraineeQuestItem)
	arg_4_0.rankItemList_ = {}
	arg_4_0.clearController_ = arg_4_0.mainControllerEx_:GetController("clear")
	arg_4_0.infoController_ = arg_4_0.mainControllerEx_:GetController("info")
	arg_4_0.rankStateController_ = arg_4_0.mainControllerEx_:GetController("rankState")
	arg_4_0.rankSelectController_ = arg_4_0.mainControllerEx_:GetController("rankSelect")
end

function var_0_0.RefreshItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.questData_[arg_5_1]

	arg_5_2:SetData(var_5_0)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.receiveBtn_, nil, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(arg_6_0.questData_) do
			local var_8_1 = TaskData2:GetTaskComplete(iter_8_1)

			if TaskData2:GetTaskProgress(iter_8_1) >= AssignmentCfg[iter_8_1].need and not var_8_1 then
				table.insert(var_8_0, iter_8_1)
			end
		end

		local var_8_2 = true
		local var_8_3 = getData("dorm_weekly_task", "tip_deadline")

		if var_8_3 and tonumber(var_8_3) > manager.time:GetServerTime() then
			var_8_2 = false
		end

		local var_8_4 = 100

		if GameSetting.house_task_points then
			var_8_4 = GameSetting.house_task_points.value[2]
		end

		if var_8_2 and var_8_4 < TaskTools.GetTargetTaskReward(var_8_0, 61) + IdolTraineeData:GetQuestWeeklyData() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("DORM_TASK_WEEKLY_LIMIT_TIP"),
				toggleText = GetTips("WEEKLY_MUTE_TIP"),
				OkCallback = function()
					TaskAction:SubmitTaskList(var_8_0)
				end,
				ToggleCallback = function(arg_10_0)
					if arg_10_0 then
						saveData("dorm_weekly_task", "tip_deadline", tostring(_G.gameTimer:GetNextWeekFreshTime()))
					end
				end
			})
		else
			TaskAction:SubmitTaskList(var_8_0)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.infoBtn_, nil, function()
		arg_6_0.infoController_:SetSelectedState("on")
	end)
	arg_6_0:AddBtnListener(arg_6_0.infoBgBtn_, nil, function()
		arg_6_0.infoController_:SetSelectedState("off")
	end)
end

function var_0_0.OnEnter(arg_13_0)
	manager.windowBar:HideBar()
	arg_13_0:UpdateView()
end

function var_0_0.OnExit(arg_14_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_15_0)
	arg_15_0:CheckRankState()
end

function var_0_0.UpdateView(arg_16_0)
	arg_16_0.infoText_.text = GetTips("DORM_WEEKLY_TASK_INFO")
	arg_16_0.rank, arg_16_0.curNum, arg_16_0.curMax, arg_16_0.weekly = IdolTraineeTools:GetCurQuestRankInfo()

	for iter_16_0 = 1, 4 do
		local var_16_0 = arg_16_0.rankItemList_[iter_16_0]

		if not var_16_0 then
			var_16_0 = DormTaskRankItem.New(arg_16_0["rankItemGo_" .. iter_16_0])
			arg_16_0.rankItemList_[iter_16_0] = var_16_0
		end

		local var_16_1 = IdolTraineeRewardRankCfg[iter_16_0]

		var_16_0:SetData(iter_16_0, arg_16_0.rank, arg_16_0.curNum, arg_16_0.curMax, var_16_1)
	end

	arg_16_0.questData_ = TaskTools:GetIdolTraineeTaskSortList()

	arg_16_0.questUIList_:StartScroll(#arg_16_0.questData_)
	arg_16_0.clearController_:SetSelectedState("false")

	for iter_16_1, iter_16_2 in pairs(arg_16_0.questData_) do
		local var_16_2 = TaskData2:GetTaskComplete(iter_16_2)

		if TaskData2:GetTaskProgress(iter_16_2) >= AssignmentCfg[iter_16_2].need and not var_16_2 then
			arg_16_0.clearController_:SetSelectedState("true")
		end
	end
end

function var_0_0.CheckRankState(arg_17_0)
	arg_17_0.rank, arg_17_0.curNum, arg_17_0.curMax, arg_17_0.weekly = IdolTraineeTools:GetCurQuestRankInfo()

	local var_17_0 = IdolTraineeRewardRankCfg[arg_17_0.rank]

	arg_17_0.curNumText_.text = arg_17_0.curNum
	arg_17_0.progressSlr_.fillAmount = arg_17_0.weekly / 100
	arg_17_0.progressText_.text = arg_17_0.weekly .. "/" .. "100"

	if arg_17_0.curNum >= arg_17_0.curMax then
		if var_17_0.type == 1 then
			IdolTraineeAction.GetQuestRankReward(arg_17_0.rank, {})
		elseif var_17_0.type == 2 then
			local var_17_1 = false
			local var_17_2 = var_17_0.reward

			for iter_17_0 = 1, #var_17_2 do
				local var_17_3 = var_17_2[iter_17_0]
				local var_17_4 = var_17_3 - 10000
				local var_17_5 = HeroCfg[var_17_4]

				if HeroTools.GetIsHide(var_17_3) or HeroTools.GetIsSkinHide(var_17_3) then
					-- block empty
				elseif var_17_5 and HeroTools.GetHeroIsUnlock(var_17_4) then
					var_17_1 = true

					break
				end
			end

			if var_17_1 then
				JumpTools.OpenPageByJump("/idolTaskItemSelectView", {
					rank = arg_17_0.rank
				})
			else
				ShowTips("DORM_WEEKLY_TASK_POP_ERROR")
			end
		end
	end
end

function var_0_0.OnTaskListChange(arg_18_0)
	arg_18_0:UpdateView()
end

function var_0_0.OnExitInput(arg_19_0)
	arg_19_0:Back()

	return true
end

function var_0_0.Dispose(arg_20_0)
	var_0_0.super.Dispose(arg_20_0)

	if arg_20_0.questUIList_ then
		arg_20_0.questUIList_:Dispose()

		arg_20_0.questUIList_ = nil
	end

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.rankItemList_) do
		if iter_20_1 then
			iter_20_1:Dispose()
		end
	end
end

return var_0_0
