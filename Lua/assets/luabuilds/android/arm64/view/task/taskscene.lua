local var_0_0 = class("TaskScene", import("..base.BaseUI"))

var_0_0.PAGE_TYPE_SCENARIO = "scenario"
var_0_0.PAGE_TYPE_BRANCH = "branch"
var_0_0.PAGE_TYPE_ROUTINE = "routine"
var_0_0.PAGE_TYPE_WEEKLY = "weekly"
var_0_0.PAGE_TYPE_ALL = "all"
var_0_0.PAGE_TYPE_ACT = "activity"

local var_0_1 = {
	[var_0_0.PAGE_TYPE_SCENARIO] = {
		[1] = true
	},
	[var_0_0.PAGE_TYPE_BRANCH] = {
		nil,
		true,
		nil,
		nil,
		true,
		true
	},
	[var_0_0.PAGE_TYPE_ROUTINE] = {
		[3] = true,
		[36] = true
	},
	[var_0_0.PAGE_TYPE_WEEKLY] = {
		[4] = true,
		[13] = true
	},
	[var_0_0.PAGE_TYPE_ALL] = {
		[0] = true,
		true,
		true,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		true,
		36,
		true,
		26,
		true,
		[nil] = true,
		[true] = true
	},
	[var_0_0.PAGE_TYPE_ACT] = {
		[36] = true,
		[6] = true,
		[26] = true,
		[16] = true
	}
}

function var_0_0.getUIName(arg_1_0)
	return "TaskScene"
end

function var_0_0.setTaskVOs(arg_2_0, arg_2_1)
	arg_2_0.contextData.taskVOsById = arg_2_1

	return
end

function var_0_0.SetWeekTaskProgressInfo(arg_3_0, arg_3_1)
	arg_3_0.contextData.weekTaskProgressInfo = arg_3_1

	return
end

function var_0_0.init(arg_4_0)
	arg_4_0._topPanel = arg_4_0._tf:Find("blur_panel/adapt/top")
	arg_4_0._backBtn = arg_4_0._topPanel:Find("back_btn")
	arg_4_0._leftLength = arg_4_0._tf:Find("blur_panel/adapt/left_length")
	arg_4_0._tagRoot = arg_4_0._tf:Find("blur_panel/adapt/left_length/frame/tagRoot")
	arg_4_0.taskIconTpl = arg_4_0._tf:Find("taskTagOb/task_icon_default")
	arg_4_0.weekTip = arg_4_0._tagRoot:Find("weekly/tip")
	arg_4_0.oneStepBtn = arg_4_0._tf:Find("blur_panel/adapt/top/GetAllButton")
	arg_4_0.contextData.viewComponent = arg_4_0
	arg_4_0.pageTF = arg_4_0._tf:Find("pages")

	return
end

function var_0_0.IsNewStyleTime()
	local var_5_0 = pg.TimeMgr.GetInstance()
	local var_5_1 = pg.TimeMgr.GetInstance()

	return var_5_0:parseTimeFromConfig({
		{
			2021,
			6,
			14
		},
		{
			0,
			0,
			0
		}
	}) <= var_5_1:GetServerTime()
end

function var_0_0.IsPassScenario()
	local var_6_0 = pg.gameset.task_first_daily_pre_id.key_value
	local var_6_1 = _.select(_.values((getProxy(TaskProxy):getData())), function(arg_7_0)
		return arg_7_0:getConfig("type") == 1
	end)

	if #var_6_1 > 0 then
		table.sort(var_6_1, function(arg_8_0, arg_8_1)
			return arg_8_0.id < arg_8_1.id
		end)

		return var_6_0 < var_6_1[1].id
	else
		return true
	end

	return
end

function var_0_0.didEnter(arg_9_0)
	local var_9_0 = TaskCommonPage.New(arg_9_0.pageTF, arg_9_0.event, arg_9_0.contextData)
	local var_9_1 = var_0_0.IsNewStyleTime() and not arg_9_0.contextData.weekTaskProgressInfo:IsMaximum() and TaskWeekPage.New(arg_9_0.pageTF, arg_9_0.event, arg_9_0.contextData) or var_9_0

	arg_9_0.emptyPage = TaskEmptyListPage.New(arg_9_0._tf, arg_9_0.event)
	arg_9_0.pages = {
		[var_0_0.PAGE_TYPE_SCENARIO] = var_9_0,
		[var_0_0.PAGE_TYPE_BRANCH] = var_9_0,
		[var_0_0.PAGE_TYPE_ROUTINE] = var_9_0,
		[var_0_0.PAGE_TYPE_WEEKLY] = var_9_1,
		[var_0_0.PAGE_TYPE_ALL] = var_9_0,
		[var_0_0.PAGE_TYPE_ACT] = var_9_0
	}
	arg_9_0.contextData.ptAwardWindow = TaskPtAwardPage.New(arg_9_0._tf, arg_9_0.event, arg_9_0.contextData)

	onButton(arg_9_0, arg_9_0._backBtn, function()
		arg_9_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)
	setActive(arg_9_0._tf:Find("stamp"), getProxy(TaskProxy):mingshiTouchFlagEnabled())

	if LOCK_CLICK_MINGSHI then
		setActive(arg_9_0._tf:Find("stamp"), false)
	end

	onButton(arg_9_0, arg_9_0._tf:Find("stamp"), function()
		getProxy(TaskProxy):dealMingshiTouchFlag(5)

		return
	end, SFX_CONFIRM)

	arg_9_0.toggles = {}

	for iter_9_0, iter_9_1 in pairs(var_0_1) do
		local var_9_2 = arg_9_0._tagRoot:Find(iter_9_0)

		onToggle(arg_9_0, var_9_2, function(arg_12_0)
			if arg_12_0 then
				arg_9_0:UpdatePage(iter_9_0)
			end

			return
		end, SFX_PANEL)

		arg_9_0.toggles[iter_9_0] = var_9_2
	end

	local var_9_3 = arg_9_0.contextData.page or var_0_0.PAGE_TYPE_ALL
	local var_9_4 = arg_9_0.toggles[var_9_3]

	if arg_9_0.toggles and var_9_4 then
		triggerToggle(var_9_4, true)
	end

	arg_9_0:UpdateWeekTip()

	return
end

function var_0_0.refreshPage(arg_13_0)
	arg_13_0:UpdatePage(arg_13_0._currentToggleType)

	return
end

function var_0_0.UpdatePage(arg_14_0, arg_14_1)
	local function var_14_0(arg_15_0, arg_15_1)
		if #arg_15_1 <= 0 then
			arg_14_0.emptyPage:ExecuteAction("ShowOrHide", true)
		elseif #arg_15_1 > 0 and arg_14_0.emptyPage:GetLoaded() then
			arg_14_0.emptyPage:ExecuteAction("ShowOrHide", false)
		end

		arg_14_0:updateOneStepBtn(arg_15_0)

		return
	end

	if arg_14_0._currentToggleType and arg_14_0._currentToggleType ~= arg_14_1 then
		arg_14_0.pages[arg_14_0._currentToggleType]:ExecuteAction("Hide")
	end

	arg_14_0.pages[arg_14_1]:ExecuteAction("Update", arg_14_1, var_0_1[arg_14_1], function(arg_16_0)
		var_14_0(var_0, arg_16_0)

		return
	end)

	arg_14_0._currentToggleType = arg_14_1
	arg_14_0.contextData.page = arg_14_1

	return
end

function var_0_0.addTask(arg_17_0, arg_17_1)
	arg_17_0.contextData.taskVOsById[arg_17_1.id] = arg_17_1

	arg_17_0:UpdatePage(arg_17_0._currentToggleType)

	return
end

function var_0_0.removeTask(arg_18_0, arg_18_1)
	arg_18_0.contextData.taskVOsById[arg_18_1.id] = nil

	arg_18_0:UpdatePage(arg_18_0._currentToggleType)

	return
end

function var_0_0.updateTask(arg_19_0, arg_19_1)
	arg_19_0:addTask(arg_19_1)

	return
end

function var_0_0.ResetWeekTaskPage(arg_20_0)
	if var_0_0.IsNewStyleTime() and isa(arg_20_0.pages[var_0_0.PAGE_TYPE_WEEKLY], TaskCommonPage) then
		if arg_20_0.pages[var_0_0.PAGE_TYPE_WEEKLY]:GetLoaded() and arg_20_0.pages[var_0_0.PAGE_TYPE_WEEKLY]:isShowing() then
			arg_20_0.pages[var_0_0.PAGE_TYPE_WEEKLY]:Hide()
		end

		arg_20_0.pages[var_0_0.PAGE_TYPE_WEEKLY] = TaskWeekPage.New(arg_20_0.pageTF, arg_20_0.event, arg_20_0.contextData)
	end

	arg_20_0:RefreshWeekTaskPage()

	if arg_20_0._currentToggleType ~= var_0_0.PAGE_TYPE_WEEKLY then
		arg_20_0:UpdatePage(arg_20_0._currentToggleType)
	end

	return
end

function var_0_0.RefreshWeekTaskPage(arg_21_0)
	if arg_21_0._currentToggleType == var_0_0.PAGE_TYPE_WEEKLY then
		arg_21_0:UpdatePage(arg_21_0._currentToggleType)
		arg_21_0:UpdateWeekTip()
	end

	return
end

function var_0_0.RefreshWeekTaskPageBefore(arg_22_0, arg_22_1)
	if arg_22_0._currentToggleType == var_0_0.PAGE_TYPE_WEEKLY then
		arg_22_0.pages[arg_22_0._currentToggleType]:RefreshWeekTaskPageBefore(arg_22_1)
	end

	return
end

function var_0_0.RefreshWeekTaskProgress(arg_23_0)
	if isa(arg_23_0.pages[arg_23_0._currentToggleType], TaskWeekPage) and arg_23_0.contextData.weekTaskProgressInfo:IsMaximum() then
		arg_23_0.pages[arg_23_0._currentToggleType]:Destroy()

		arg_23_0.pages[var_0_0.PAGE_TYPE_WEEKLY] = arg_23_0.pages[var_0_0.PAGE_TYPE_SCENARIO]

		arg_23_0:UpdatePage(var_0_0.PAGE_TYPE_WEEKLY)
	elseif arg_23_0._currentToggleType == var_0_0.PAGE_TYPE_WEEKLY and isa(arg_23_0.pages[arg_23_0._currentToggleType], TaskWeekPage) then
		arg_23_0.pages[arg_23_0._currentToggleType]:ExecuteAction("RefreshWeekProgress")
		arg_23_0:UpdateWeekTip()
	end

	return
end

function var_0_0.UpdateWeekTip(arg_24_0)
	local var_24_0 = false

	if var_0_0.IsPassScenario() and var_0_0.IsNewStyleTime() then
		for iter_24_0, iter_24_1 in pairs(arg_24_0.contextData.taskVOsById) do
			if (iter_24_1:getConfig("type") == 4 or iter_24_1:getConfig("type") == 13) and iter_24_1:isFinish() and not iter_24_1:isReceive() and iter_24_1:ShowOnTaskScene() then
				var_24_0 = true

				break
			end
		end

		if not var_24_0 then
			if arg_24_0.contextData.weekTaskProgressInfo:CanUpgrade() or arg_24_0.contextData.weekTaskProgressInfo:AnySubTaskCanSubmit() then
				var_24_0 = true
			end
		end
	end

	setActive(arg_24_0.weekTip, var_24_0)

	return
end

function var_0_0.GoToFilter(arg_25_0, arg_25_1)
	triggerToggle(arg_25_0._tagRoot:Find(arg_25_1), true)

	return
end

function var_0_0.onSubmit(arg_26_0, arg_26_1)
	if arg_26_0.onShowAwards then
		return
	end

	arg_26_0:emit(TaskMediator.ON_TASK_SUBMIT, arg_26_1)

	return
end

function var_0_0.onSubmitForWeek(arg_27_0, arg_27_1)
	if arg_27_0.onShowAwards then
		return
	end

	arg_27_0:emit(TaskMediator.ON_SUBMIT_WEEK_TASK, arg_27_1)

	return
end

function var_0_0.onSubmitForAvatar(arg_28_0, arg_28_1)
	if arg_28_0.onShowAwards then
		return
	end

	arg_28_0:emit(TaskMediator.ON_SUBMIT_AVATAR_TASK, arg_28_1)

	return
end

function var_0_0.onGo(arg_29_0, arg_29_1)
	if arg_29_0.onShowAwards then
		return
	end

	if isa(arg_29_1, AvatarFrameTask) and arg_29_1:IsActEnd() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end

	arg_29_0:emit(TaskMediator.ON_TASK_GO, arg_29_1)

	return
end

function var_0_0.willExit(arg_30_0)
	for iter_30_0, iter_30_1 in pairs(arg_30_0.pages) do
		iter_30_1:Destroy()
	end

	if arg_30_0.emptyPage then
		arg_30_0.emptyPage:Destroy()

		arg_30_0.emptyPage = nil
	end

	arg_30_0.pages = nil

	arg_30_0.contextData.ptAwardWindow:Destroy()

	arg_30_0.contextData.ptAwardWindow = nil
	arg_30_0.contextData.taskVOsById = nil
	arg_30_0.contextData.weekTaskProgressInfo = nil
	arg_30_0.contextData.viewComponent = nil

	return
end

function var_0_0.updateOneStepBtn(arg_31_0, arg_31_1)
	arg_31_1 = arg_31_1 or arg_31_0.pages[arg_31_0._currentToggleType]

	local var_31_0 = #arg_31_1:GetWaitToCheckList() >= 2

	if var_31_0 then
		onButton(arg_31_0, arg_31_0.oneStepBtn, function()
			arg_31_1:ExecuteOneStepSubmit()

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_31_0.oneStepBtn)
	end

	setActive(arg_31_0.oneStepBtn, var_31_0)

	return
end

return var_0_0
