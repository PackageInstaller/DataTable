local var_0_0 = class("ActivityHeroLetterTaskView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityHeroLetterTools.GetTaskUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.onSubmitTaskResponseHandle_ = handler(arg_4_0, arg_4_0.OnTaskRefresh)
	arg_4_0.stateCon_ = arg_4_0.conCollecter_:GetController("state")
	arg_4_0.lockCon_ = arg_4_0.rewardCollecter_:GetController("lock")
	arg_4_0.rewardCon_ = arg_4_0.rewardCollecter_:GetController("reward")
	arg_4_0.rewardGo_ = {}
	arg_4_0.rewardItem_ = {}

	for iter_4_0 = 1, 3 do
		arg_4_0.rewardGo_[iter_4_0] = arg_4_0["rewardGo_" .. iter_4_0]
		arg_4_0.rewardItem_[iter_4_0] = CommonItemView.New(arg_4_0.rewardGo_[iter_4_0])
	end
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		TaskAction:SubmitTask(arg_5_0.taskID_)
	end)
end

function var_0_0.OnEnter(arg_7_0)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_7_0.onSubmitTaskResponseHandle_)
	arg_7_0.lockCon_:SetSelectedState("on")
	arg_7_0:RefreshUI()
	arg_7_0:RefreshTask()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.id_ = arg_8_0.params_.id
	arg_8_0.cfg_ = ActivityHeroTaskCfg[arg_8_0.id_]

	local var_8_0 = arg_8_0.cfg_.hero_id

	arg_8_0.name2_.text = HeroCfg[var_8_0].suffix
	arg_8_0.name1_.text = string.format(GetTips("ACTIVITY_HERO_TASK_REWARD"), HeroCfg[var_8_0].suffix)
	arg_8_0.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. var_8_0)
	arg_8_0.desc_.text = arg_8_0.cfg_.desc

	local var_8_1 = ActivityHeroLetterTools.IsReward(arg_8_0.id_)

	arg_8_0.rewardCon_:SetSelectedState(var_8_1 and "on" or "off")
end

function var_0_0.RefreshTask(arg_9_0)
	arg_9_0.taskID_ = arg_9_0.cfg_.task_id

	local var_9_0 = AssignmentCfg[arg_9_0.taskID_]

	arg_9_0.taskDesc_.text = var_9_0.desc

	local var_9_1 = TaskData2:GetTask(arg_9_0.taskID_)
	local var_9_2 = var_9_0.need
	local var_9_3 = var_9_2 < var_9_1.progress and var_9_2 or var_9_1.progress

	arg_9_0.progress_.text = var_9_3 .. "/" .. var_9_2
	arg_9_0.slider_.value = var_9_3 / var_9_2

	local var_9_4 = var_9_0.reward or {}

	for iter_9_0, iter_9_1 in ipairs(var_9_4) do
		local var_9_5 = clone(ItemTemplateData)

		var_9_5.id = iter_9_1[1]
		var_9_5.number = iter_9_1[2]

		function var_9_5.clickFun()
			ShowPopItem(POP_ITEM, {
				var_9_5.id
			})
		end

		arg_9_0.rewardItem_[iter_9_0]:SetData(var_9_5)
	end

	for iter_9_2 = #var_9_4 + 1, #arg_9_0.rewardItem_ do
		arg_9_0.rewardItem_[iter_9_2]:SetData()
	end

	if var_9_1.complete_flag == 1 then
		arg_9_0.stateCon_:SetSelectedState("complete")
	elseif var_9_2 <= var_9_3 then
		arg_9_0.stateCon_:SetSelectedState("get")
	else
		arg_9_0.stateCon_:SetSelectedState("unfinished")
	end
end

function var_0_0.OnTaskRefresh(arg_11_0)
	arg_11_0:RefreshUI()
	arg_11_0:RefreshTask()
end

function var_0_0.OnTop(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:RemoveAllEventListener()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_13_0.onSubmitTaskResponseHandle_)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllListeners()

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.rewardItem_) do
		iter_14_1:Dispose()
	end

	arg_14_0.super.Dispose(arg_14_0)
end

return var_0_0
