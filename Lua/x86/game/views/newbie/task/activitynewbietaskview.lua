local var_0_0 = class("ActivityNewbieTaskView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/Activitynewbie/NewbieTaskUI")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.scrollHelper_ = LuaList.New(handler(arg_1_0, arg_1_0.RefreshItem), arg_1_0.taskItemScroll_, ActivityNewbieTaskItem)
	arg_1_0.phaseView_ = ActivityNewbieTaskPhase.New(arg_1_0.generalTaskGo_)

	SetActive(arg_1_0.gameObject_, true)

	arg_1_0.newbieTaskUpdateHandler_ = handler(arg_1_0, arg_1_0.NewbieTaskUpdate)
end

function var_0_0.SetData(arg_2_0)
	arg_2_0.phaseView_:OnEnter()
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.scrollHelper_:Dispose()
	arg_3_0.phaseView_:Dispose()

	arg_3_0.phaseView_ = nil
	arg_3_0.newbieTaskUpdateHandler_ = nil

	Object.Destroy(arg_3_0.gameObject_)
	var_0_0.super.Dispose(arg_3_0)

	arg_3_0.transform_ = nil
	arg_3_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.buttonPrevious_, nil, function()
		if arg_4_0.selectPhase_ == nil then
			arg_4_0.selectPhase_ = 1

			print("not self.selectPhase_")
			Debug.LogError(debug.traceback("ActivityNewbieTaskView.buttonPrevious_"))
		end

		arg_4_0:SwitchPhase(arg_4_0.selectPhase_ - 1)
	end)
	arg_4_0:AddBtnListener(arg_4_0.buttonNext_, nil, function()
		if arg_4_0.selectPhase_ == nil then
			arg_4_0.selectPhase_ = 1

			print("not self.selectPhase_")
			Debug.LogError(debug.traceback("ActivityNewbieTaskView.buttonNext_"))
		end

		arg_4_0:SwitchPhase(arg_4_0.selectPhase_ + 1)
	end)
end

function var_0_0.SetActive(arg_7_0, arg_7_1)
	if arg_7_1 == true then
		arg_7_0:SwitchPhase(TaskData2:GetAssignmentPhase())
		manager.notify:RegistListener(NEWBIE_TASK_UPDATE, arg_7_0.newbieTaskUpdateHandler_)
	else
		manager.notify:RemoveListener(NEWBIE_TASK_UPDATE, arg_7_0.newbieTaskUpdateHandler_)
	end

	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.RefreshItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:SetData(TaskTools:GetNewbieTaskSortList(arg_8_0.selectPhase_)[arg_8_1].id)
end

function var_0_0.ClearCache(arg_9_0)
	arg_9_0.lastPosition_ = nil
end

function var_0_0.SwitchPhase(arg_10_0, arg_10_1)
	local var_10_0 = TaskTools:GetNewbiePhaseTask()
	local var_10_1 = #var_10_0

	if var_10_1 < arg_10_1 then
		arg_10_1 = var_10_1
	end

	if arg_10_1 < 1 then
		arg_10_1 = 1
	end

	arg_10_0.selectPhase_ = arg_10_1

	local var_10_2 = var_10_0[arg_10_1].id

	if var_10_2 then
		arg_10_0.titleText_.text = GetI18NText(AssignmentCfg[var_10_2].desc)

		arg_10_0.phaseView_:SetData(var_10_2)

		if arg_10_0.lastPosition_ then
			arg_10_0.scrollHelper_:StartScrollWithoutAnimator(#TaskTools:GetNewbieTaskSortList(arg_10_1), arg_10_0.lastPosition_)
		else
			arg_10_0.scrollHelper_:StartScroll(#TaskTools:GetNewbieTaskSortList(arg_10_1))
		end

		if arg_10_1 > TaskData2:GetAssignmentPhase() then
			ShowTips(string.format(GetTips("NOTE_TASK_UNLOCK"), GetI18NText(AssignmentCfg[var_10_0[arg_10_1 - 1].id].desc)))
		end
	end

	if arg_10_1 <= 1 then
		SetActive(arg_10_0.leftBtn_, false)
		SetActive(arg_10_0.rightBtn_, true)
	elseif var_10_1 <= arg_10_1 then
		SetActive(arg_10_0.leftBtn_, true)
		SetActive(arg_10_0.rightBtn_, false)
	else
		SetActive(arg_10_0.leftBtn_, true)
		SetActive(arg_10_0.rightBtn_, true)
	end
end

function var_0_0.RefreshIcon(arg_11_0)
	local var_11_0 = AssignmentCfg[taskID].reward[1][1]

	if ItemCfg[var_11_0].type == ItemConst.ITEM_TYPE.HERO then
		arg_11_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. var_11_0)
	else
		arg_11_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Item_l" .. var_11_0)
	end
end

function var_0_0.NewbieTaskUpdate(arg_12_0)
	arg_12_0:SwitchPhase(TaskData2:GetAssignmentPhase())
end

return var_0_0
