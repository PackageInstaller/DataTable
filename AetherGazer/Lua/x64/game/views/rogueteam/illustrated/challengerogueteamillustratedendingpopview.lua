local var_0_0 = class("ChallengeRogueTeamIllustratedEndingPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/Illustrated/illustratedendingPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListener()

	arg_3_0.lockController_ = arg_3_0.controller_:GetController("lock")
	arg_3_0.btnList_ = {}
	arg_3_0.btnController_ = arg_3_0.taskBtnController_:GetController("rewards")
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_4_0.templateID_ = arg_4_0.params_.templateID or ChallengeRogueTeamData:GetCacheTemplateID()
	arg_4_0.index_ = arg_4_0.params_.index
	arg_4_0.id_ = arg_4_0.params_.id

	arg_4_0:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function()
		arg_4_0:RefreshTask()
	end)
	arg_4_0:RefreshUI()
	arg_4_0:RefreshPlot(1)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.btnList_) do
		iter_4_1:RefreshSelect(1)
	end
end

function var_0_0.AddListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btn_, nil, function()
		if not ChallengeRogueTeamData:IsIllustratedObtained(arg_6_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.END, arg_6_0.id_) then
			ShowTips("ERROR_NO_UNLOCK_PLOT")

			return
		end

		manager.story:StartStoryById(arg_6_0.cfg_.story_id, function()
			return
		end)
	end)
	arg_6_0:AddBtnListener(arg_6_0.taskBtn_, nil, function()
		local var_9_0 = TaskData2:GetTaskComplete(arg_6_0.taskID_)

		if TaskData2:GetTaskProgress(arg_6_0.taskID_) >= arg_6_0.taskCfg_.need and not var_9_0 then
			TaskAction:SubmitTask(arg_6_0.taskID_)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.checkBtn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamPortraitFull", {
			image = arg_6_0.cfg_.full_image
		})
	end)
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0.cfg_ = RogueTeamEndingCfg[arg_11_0.id_]
	arg_11_0.plotList_ = arg_11_0.cfg_.text_id_list

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.btnList_) do
		SetActive(iter_11_1.gameObject_, false)
	end

	for iter_11_2, iter_11_3 in ipairs(arg_11_0.plotList_) do
		if not arg_11_0.btnList_[iter_11_2] then
			local var_11_0 = GameObject.Instantiate(arg_11_0.paragrapGo_, arg_11_0.paragrapContent_)
			local var_11_1 = ChallengeRogueTeamEndingBtnItem.New(var_11_0)

			arg_11_0.btnList_[iter_11_2] = var_11_1
		end

		local var_11_2 = ChallengeRogueTeamData:GetHistoryEndingPassCnt(arg_11_0.templateID_, arg_11_0.id_)

		arg_11_0.btnList_[iter_11_2]:SetData(iter_11_2, arg_11_0.plotList_[iter_11_2])
		arg_11_0.btnList_[iter_11_2].lockController_:SetSelectedState(tostring(iter_11_2 <= var_11_2))
		arg_11_0.btnList_[iter_11_2]:SetClickCallBack(function(arg_12_0)
			for iter_12_0, iter_12_1 in ipairs(arg_11_0.btnList_) do
				iter_12_1:RefreshSelect(arg_12_0)
			end

			arg_11_0:RefreshPlot(arg_12_0)

			local var_12_0 = ChallengeRogueTeamData:GetHistoryEndingPassCnt(arg_11_0.templateID_, arg_11_0.id_)

			arg_11_0.btnList_[arg_12_0].lockController_:SetSelectedState(tostring(var_12_0 >= arg_11_0.selelctPlotIndex_))
		end)
		SetActive(arg_11_0.btnList_[iter_11_2].gameObject_, true)
	end

	arg_11_0.numText_.text = arg_11_0.index_ >= 10 and arg_11_0.index_ or "0" .. arg_11_0.index_
	arg_11_0.image_.sprite = pureGetSpriteWithoutAtlas(arg_11_0.cfg_.image)
	arg_11_0.topTitleText_.text = arg_11_0.cfg_.story_name

	arg_11_0:RefreshTask()
end

function var_0_0.RefreshTask(arg_13_0)
	arg_13_0.taskList_ = ChallengeRogueTeamData:GetAllCollectionTaskByType(arg_13_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.END)

	if arg_13_0.taskList_ then
		arg_13_0.taskID_ = arg_13_0.taskList_[arg_13_0.index_]
	end

	arg_13_0.taskCfg_ = AssignmentCfg[arg_13_0.taskID_]

	local var_13_0 = TaskData2:GetTaskComplete(arg_13_0.taskID_)
	local var_13_1 = TaskData2:GetTaskProgress(arg_13_0.taskID_) >= arg_13_0.taskCfg_.need

	if var_13_0 then
		arg_13_0.btnController_:SetSelectedState("received")
	elseif var_13_1 then
		arg_13_0.btnController_:SetSelectedState("true")
	else
		arg_13_0.btnController_:SetSelectedState("false")
	end

	local var_13_2 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_13_0.taskID_)

	manager.redPoint:bindUIandKey(arg_13_0.taskBtn_.transform, var_13_2)
end

function var_0_0.RefreshPlot(arg_14_0, arg_14_1)
	arg_14_0.selelctPlotIndex_ = arg_14_1
	arg_14_0.plotID_ = arg_14_0.plotList_[arg_14_0.selelctPlotIndex_]
	arg_14_0.plotCfg_ = RogueTeamEndingPlotCfg[arg_14_0.plotID_]
	arg_14_0.titleText_.text = arg_14_0.plotCfg_.name
	arg_14_0.descText_.text = arg_14_0.plotCfg_.desc
	arg_14_0.lockText_.text = arg_14_0.plotCfg_.lock_desc
	arg_14_0.lineImg_.fillAmount = (#arg_14_0.plotList_ - 1) / 5

	local var_14_0 = ChallengeRogueTeamData:GetHistoryEndingPassCnt(arg_14_0.templateID_, arg_14_0.id_)

	arg_14_0.lockController_:SetSelectedState(tostring(var_14_0 >= arg_14_0.selelctPlotIndex_))
end

function var_0_0.OnExit(arg_15_0)
	local var_15_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_15_0.taskID_)

	manager.redPoint:unbindUIandKey(arg_15_0.taskBtn_.transform, var_15_0)
	arg_15_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)
end

function var_0_0.OnTop(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_17_0:RefreshUI()
end

return var_0_0
