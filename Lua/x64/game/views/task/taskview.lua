local var_0_0 = class("TaskView", ReduxView)
local var_0_1 = import("game.const.TaskConst")
local var_0_2 = import("game.tools.TaskTools")

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Quest/UIQuest"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.taskSwitchView_ = {}
	arg_3_0.taskContentView_ = {}
	arg_3_0.taskSwitchView_[var_0_1.TASK_TYPE.DAILY] = TaskSwitchView.New(arg_3_0.dailyTask_, var_0_1.TASK_TYPE.DAILY)
	arg_3_0.taskSwitchView_[var_0_1.TASK_TYPE.PLOT] = TaskSwitchView.New(arg_3_0.plotTask_, var_0_1.TASK_TYPE.PLOT)
	arg_3_0.taskSwitchView_[var_0_1.TASK_TYPE.WEEK] = TaskSwitchView.New(arg_3_0.weekTask_, var_0_1.TASK_TYPE.WEEK)

	arg_3_0.taskSwitchView_[var_0_1.TASK_TYPE.DAILY]:SetBtnFunc(handler(arg_3_0, arg_3_0.RefreshSelect))
	arg_3_0.taskSwitchView_[var_0_1.TASK_TYPE.PLOT]:SetBtnFunc(handler(arg_3_0, arg_3_0.RefreshSelect))
	arg_3_0.taskSwitchView_[var_0_1.TASK_TYPE.WEEK]:SetBtnFunc(handler(arg_3_0, arg_3_0.RefreshSelect))

	arg_3_0.taskViewObj = {
		[var_0_1.TASK_TYPE.DAILY] = "Widget/System/Quest/TaskDailyContentView",
		[var_0_1.TASK_TYPE.WEEK] = "Widget/System/Quest/TaskWeekContentView",
		[var_0_1.TASK_TYPE.PLOT] = "Widget/System/Quest/TaskPlotContentView"
	}
	arg_3_0.refreshBtnStateHandle = handler(arg_3_0, arg_3_0.RefreshOnceBtnState)
	arg_3_0.oneKeyCon_ = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("onekey")

	arg_3_0:AddBtnListener(arg_3_0.exploreBtn_, nil, function()
		JumpTools.OpenPageByJump("/adminCatExploreView", nil, ViewConst.SYSTEM_ID.ADMIN_CAT_EXPLORE)
	end)
	arg_3_0:AddBtnListener(arg_3_0.onceBtn_, nil, function()
		arg_3_0:OnClickOnceBtn()
	end)
end

function var_0_0.OnTop(arg_6_0)
	arg_6_0:ShowDefaultBar()
	arg_6_0:RefreshSelect(arg_6_0.params_.taskIndex)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:AddEventListeners()
	arg_7_0:RefreshSelect(arg_7_0.params_.taskIndex)

	for iter_7_0, iter_7_1 in pairs(arg_7_0.taskSwitchView_) do
		iter_7_1:OnEnter()
	end

	arg_7_0:BindRedPoint()
end

function var_0_0.BindRedPoint(arg_8_0)
	manager.redPoint:bindUIandKey(arg_8_0.noticeContainer_, RedPointConst.EXPLORE_MAIN)
end

function var_0_0.UnbindRedPoint(arg_9_0)
	manager.redPoint:unbindUIandKey(arg_9_0.noticeContainer_, RedPointConst.EXPLORE_MAIN)
end

function var_0_0.OnMainHomeViewTop(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.taskContentView_) do
		iter_10_1:ClearCache()
	end
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0.selectIndex_ = nil

	arg_11_0:RemoveAllEventListener()
	arg_11_0:UnbindRedPoint()

	for iter_11_0, iter_11_1 in pairs(arg_11_0.taskContentView_) do
		iter_11_1:OnExit()
	end

	for iter_11_2, iter_11_3 in pairs(arg_11_0.taskSwitchView_) do
		iter_11_3:OnExit()
	end

	manager.windowBar:HideBar()
	arg_11_0:RecordStay(arg_11_0.params_.taskIndex)
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.taskSwitchView_) do
		iter_12_1:Dispose()
	end

	arg_12_0.taskSwitchView_ = nil

	for iter_12_2, iter_12_3 in pairs(arg_12_0.taskContentView_) do
		iter_12_3:Dispose()
	end

	arg_12_0.taskContentView_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.OnTaskListChange(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.taskContentView_) do
		if iter_13_1.OnTaskListChange then
			iter_13_1:OnTaskListChange()
		end
	end
end

function var_0_0.OnActivityPtUpdate(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.taskContentView_) do
		if iter_14_1.OnSubActivityPtUpdate then
			iter_14_1:OnSubActivityPtUpdate()
		end
	end
end

function var_0_0.RefreshSelect(arg_15_0, arg_15_1, arg_15_2)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TASK_DAILY) then
		arg_15_1 = var_0_1.TASK_TYPE.PLOT
	end

	for iter_15_0, iter_15_1 in pairs(arg_15_0.taskSwitchView_) do
		iter_15_1:SwitchButton(arg_15_1)
	end

	if arg_15_0.taskContentView_[arg_15_1] == nil and arg_15_0.taskViewObj[arg_15_1] then
		local var_15_0 = arg_15_0:InstView(arg_15_1)

		if arg_15_1 == var_0_1.TASK_TYPE.DAILY then
			arg_15_0.taskContentView_[arg_15_1] = TaskDailyContentView.New(var_15_0, var_0_1.TASK_TYPE.DAILY, ActivityPtConst.TASK_DAILY_ACTIVITY_PT)
		elseif arg_15_1 == var_0_1.TASK_TYPE.PLOT then
			arg_15_0.taskContentView_[arg_15_1] = TaskPlotContentView.New(var_15_0)
		elseif arg_15_1 == var_0_1.TASK_TYPE.WEEK then
			arg_15_0.taskContentView_[arg_15_1] = TaskWeekContentView.New(var_15_0, var_0_1.TASK_TYPE.WEEK, ActivityPtConst.TASK_WEEK_ACTIVITY_PT)
		end

		arg_15_0.taskContentView_[arg_15_1]:RegisterRefreshOnceStateCallback(arg_15_0.refreshBtnStateHandle)
	end

	if arg_15_0.selectIndex_ == arg_15_1 then
		return
	end

	arg_15_0.selectIndex_ = arg_15_1

	for iter_15_2, iter_15_3 in pairs(arg_15_0.taskContentView_) do
		if iter_15_2 == arg_15_1 then
			arg_15_0.params_.taskIndex = arg_15_1
		else
			arg_15_0:RecordStay(iter_15_2)
		end

		if iter_15_3 then
			iter_15_3:Show(iter_15_2 == arg_15_1, arg_15_2)
		end
	end
end

function var_0_0.AddEventListeners(arg_16_0)
	arg_16_0:RegistEventListener(PLAYER_LEVEL_UP, handler(arg_16_0, arg_16_0.OnLevelUp))
end

function var_0_0.OnLevelUp(arg_17_0)
	local var_17_0 = PlayerData:GetlevelUpInfos()

	if var_17_0 and #var_17_0 > 0 then
		if not arg_17_0.levelUpTimer_ then
			arg_17_0.levelUpTimer_ = Timer.New(function()
				PlayerAction.LevelUpFinish()
				JumpTools.OpenPageByJump("levelUp", {
					levelUpInfoList = var_17_0
				})

				arg_17_0.levelUpTimer_ = nil
			end, 0.2, 0)
		end

		arg_17_0.levelUpTimer_:Start()
	end
end

function var_0_0.RecordStay(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:GetStayTime()

	if var_19_0 == 0 then
		return
	end

	local var_19_1 = 0

	if arg_19_1 == var_0_1.TASK_TYPE.DAILY then
		var_19_1 = 10801
	elseif arg_19_1 == var_0_1.TASK_TYPE.PLOT then
		var_19_1 = 10802
	end

	OperationRecorder.RecordStayView("STAY_VIEW_TASK", var_19_0, var_19_1)
	arg_19_0:UpdateLastOpenTime()
end

function var_0_0.InstView(arg_20_0, arg_20_1)
	local var_20_0 = Asset.Load(arg_20_0.taskViewObj[arg_20_1])

	return Object.Instantiate(var_20_0, arg_20_0.pageContainer_)
end

function var_0_0.OnClickOnceBtn(arg_21_0)
	local var_21_0 = arg_21_0.taskContentView_[arg_21_0.selectIndex_]

	if var_21_0 then
		var_21_0:OnOnceClick()
	end
end

function var_0_0.RefreshOnceBtnState(arg_22_0, arg_22_1)
	arg_22_0.oneKeyCon_:SetSelectedState(arg_22_1 and "true" or "false")
end

return var_0_0
