local var_0_0 = class("SPHeroChallengeHeroChipTaskView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeTaskPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.taskListModule = CommonTaskListModule.New(arg_5_0.comTaskList_)
	arg_5_0.gatherList = LuaList.New(handler(arg_5_0, arg_5_0.indexAwardItem), arg_5_0.awardList_, SPHeroChallengeCommonItem)
	arg_5_0.chipAwardController = arg_5_0.chipController:GetController("awardState")
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.taskListModule:OnEnter()

	arg_6_0.activityID = arg_6_0.params_.activityID

	if arg_6_0.activityID then
		arg_6_0.taskListModule:RenderActivityTaskList(arg_6_0.activityID)
	end

	arg_6_0:RefreshView()
	arg_6_0:RegisterEvents()
	arg_6_0:StartTimer()
end

function var_0_0.OnTop(arg_7_0)
	return
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0.taskListModule:OnExit()
	arg_8_0:RemoveAllEventListener()
	arg_8_0:CloseTimer()
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.bgmaskBtn_, nil, function()
		arg_9_0:Back()
	end)
	arg_9_0:AddBtnListener(arg_9_0.awardBtn, nil, function()
		local var_11_0 = SPHeroChallengeData:GetActivityID()
		local var_11_1 = SPHeroChallengeData.activityCfg[var_11_0].HeroChipTask

		if arg_9_0.chipAwardController:GetSelectedState() == "canReceive" then
			TaskAction:SubmitTask(var_11_1)
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.drawBtn_, nil, function()
		JumpTools.GoToSystem("/draw", {
			isFirst = true,
			poolId = DrawTools:GetRoleUpPoolID(arg_9_0.roleID)
		}, ViewConst.SYSTEM_ID.DRAW)
	end)
end

function var_0_0.RegisterEvents(arg_13_0)
	arg_13_0:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function()
		arg_13_0:RefreshGatherProgress()

		local var_14_0 = SPHeroChallengeData:GetActivityID()

		SPHeroChallengeRedPointTools:UpdataCanGetEntrustRewardRedPoint(var_14_0)
	end)
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.taskListModule then
		arg_15_0.taskListModule:Dispose()
	end

	if arg_15_0.gatherList then
		arg_15_0.gatherList:Dispose()
	end

	arg_15_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_15_0)
	arg_15_0:CloseTimer()
end

function var_0_0.RefreshView(arg_16_0)
	arg_16_0:RefreshGatherProgress()
	arg_16_0:RefreshHeroExtractState()
end

function var_0_0.RefreshHeroExtractState(arg_17_0)
	SetActive(arg_17_0.drawBtn_.gameObject, false)
end

function var_0_0.RefreshGatherProgress(arg_18_0)
	local var_18_0 = SPHeroChallengeData:GetActivityID()
	local var_18_1 = SPHeroChallengeData.activityCfg[var_18_0].HeroChipTask
	local var_18_2 = TaskData2:GetTask(var_18_1)

	if var_18_2 then
		local var_18_3 = AssignmentCfg[var_18_1].need

		if var_18_2.complete_flag > 0 then
			arg_18_0.chipAwardController:SetSelectedState("received")
		elseif var_18_3 <= var_18_2.progress then
			arg_18_0.chipAwardController:SetSelectedState("canReceive")
		else
			arg_18_0.chipAwardController:SetSelectedState("notMeet")
		end

		local var_18_4 = CurrencyConst.CURRENCY_HERO_CHALLENGE_COIN_2
		local var_18_5 = var_18_2.progress

		arg_18_0.awardList = {}

		for iter_18_0 = 1, var_18_3 do
			local var_18_6 = {}

			if iter_18_0 <= var_18_5 then
				var_18_6 = {
					state = "full",
					id = var_18_4
				}
			else
				var_18_6 = {
					id = -1,
					state = "empty"
				}
			end

			table.insert(arg_18_0.awardList, var_18_6)
		end

		arg_18_0.awardProText.text = string.format("%s/%s", tostring(var_18_2.progress), tostring(var_18_3))

		arg_18_0.gatherList:StartScroll(#arg_18_0.awardList)
	end
end

function var_0_0.indexAwardItem(arg_19_0, arg_19_1, arg_19_2)
	arg_19_2:RefreshUI(arg_19_0.awardList[arg_19_1])
end

function var_0_0.StartTimer(arg_20_0)
	arg_20_0:CloseTimer()

	arg_20_0.timer = Timer.New(function()
		arg_20_0:RefreshHeroExtractState()
	end, 1, -1)

	arg_20_0.timer:Start()
end

function var_0_0.CloseTimer(arg_22_0)
	if arg_22_0.timer then
		arg_22_0.timer:Stop()

		arg_22_0.timer = nil
	end
end

return var_0_0
