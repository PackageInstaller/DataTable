class = var_0_10000

local var_0_0 = "TaskScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.PAGE_TYPE_SCENARIO = "scenario"
var_0_1.PAGE_TYPE_BRANCH = "branch"
var_0_1.PAGE_TYPE_ROUTINE = "routine"
var_0_1.PAGE_TYPE_WEEKLY = "weekly"
var_0_1.PAGE_TYPE_ALL = "all"
var_0_1.PAGE_TYPE_ACT = "activity"

local var_0_2 = {
	[var_0_1.PAGE_TYPE_SCENARIO] = {
		[1] = true
	},
	[var_0_1.PAGE_TYPE_BRANCH] = {
		nil,
		true,
		nil,
		nil,
		true,
		true
	},
	[var_0_1.PAGE_TYPE_ROUTINE] = {
		[3] = true,
		[36] = true
	},
	[var_0_1.PAGE_TYPE_WEEKLY] = {
		[4] = true,
		[13] = true
	},
	[var_0_1.PAGE_TYPE_ALL] = {
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
	[var_0_1.PAGE_TYPE_ACT] = {
		[36] = true,
		[6] = true,
		[26] = true,
		[16] = true
	}
}

function var_0_1.getUIName(arg_1_0)
	return "TaskScene"
end

function var_0_1.setTaskVOs(arg_2_0, arg_2_1)
	arg_2_0.contextData.taskVOsById = arg_2_1

	return
end

function var_0_1.SetWeekTaskProgressInfo(arg_3_0, arg_3_1)
	arg_3_0.contextData.weekTaskProgressInfo = arg_3_1

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0._topPanel = var_1.Find(var_4_0, "blur_panel/adapt/top")

	local var_4_1 = arg_4_0._topPanel

	arg_4_0._backBtn = var_1.Find(var_4_1, "back_btn")

	local var_4_2 = arg_4_0._tf

	arg_4_0._leftLength = var_1.Find(var_4_2, "blur_panel/adapt/left_length")

	local var_4_3 = arg_4_0._tf

	arg_4_0._tagRoot = var_1.Find(var_4_3, "blur_panel/adapt/left_length/frame/tagRoot")

	local var_4_4 = arg_4_0._tf

	arg_4_0.taskIconTpl = var_1.Find(var_4_4, "taskTagOb/task_icon_default")

	local var_4_5 = arg_4_0._tagRoot

	arg_4_0.weekTip = var_1.Find(var_4_5, "weekly/tip")

	local var_4_6 = arg_4_0._tf

	arg_4_0.oneStepBtn = var_1.Find(var_4_6, "blur_panel/adapt/top/GetAllButton")
	arg_4_0.contextData.viewComponent = arg_4_0

	local var_4_7 = arg_4_0._tf

	arg_4_0.pageTF = var_1.Find(var_4_7, "pages")

	return
end

function var_0_1.IsNewStyleTime()
	pg = var_1_10000

	local var_5_0 = var_1_10000.TimeMgr.GetInstance()
	local var_5_1 = var_0.parseTimeFromConfig(var_5_0, {
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
	})

	pg = var_1_10001

	local var_5_2 = var_1_10001.TimeMgr.GetInstance()

	return var_5_1 <= var_1.GetServerTime(var_5_2)
end

function var_0_1.IsPassScenario()
	pg = var_1_10000

	local var_6_0 = var_1_10000.gameset.task_first_daily_pre_id.key_value

	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_6_1 = var_1_10001(var_1_10003)
	local var_6_2 = var_1.getData(var_6_1)

	_ = var_1_10002

	local var_6_3 = var_1_10002.select

	_ = var_1_10004

	if #var_6_3(var_1_10004.values(var_6_2), function(arg_7_0)
		return arg_7_0:getConfig("type") == 1
	end) > 0 then
		table = var_3

		var_3.sort(var_2, function(arg_8_0, arg_8_1)
			return arg_8_0.id < arg_8_1.id
		end)

		return var_6_0 < var_2[1].id
	else
		return true
	end

	return
end

function var_0_1.didEnter(arg_9_0)
	TaskCommonPage = var_1_10001

	local var_9_0 = var_1_10001.New(arg_9_0.pageTF, arg_9_0.event, arg_9_0.contextData)

	if var_0_1.IsNewStyleTime() then
		local var_9_1 = arg_9_0.contextData.weekTaskProgressInfo

		if not var_2.IsMaximum(var_9_1) then
			TaskWeekPage = var_2

			local var_9_2

			if not var_2.New(arg_9_0.pageTF, arg_9_0.event, arg_9_0.contextData) then
				var_9_2 = var_9_0
			end

			TaskEmptyListPage = var_3
			arg_9_0.emptyPage = var_3.New(arg_9_0._tf, arg_9_0.event)
			arg_9_0.pages = {
				[var_0_1.PAGE_TYPE_SCENARIO] = var_9_0,
				[var_0_1.PAGE_TYPE_BRANCH] = var_9_0,
				[var_0_1.PAGE_TYPE_ROUTINE] = var_9_0,
				[var_0_1.PAGE_TYPE_WEEKLY] = var_9_2,
				[var_0_1.PAGE_TYPE_ALL] = var_9_0,
				[var_0_1.PAGE_TYPE_ACT] = var_9_0
			}

			local var_9_3 = arg_9_0.contextData

			TaskPtAwardPage = var_4
			var_9_3.ptAwardWindow = var_4.New(arg_9_0._tf, arg_9_0.event, arg_9_0.contextData)
			onButton = var_9_3

			local var_9_4 = arg_9_0
			local var_9_5 = arg_9_0._backBtn

			local function var_9_6()
				local var_10_0 = arg_9_0

				var_0.emit(var_10_0, var_0_1.ON_BACK)

				return
			end

			SFX_CANCEL = var_8

			var_9_3(var_9_4, var_9_5, var_9_6, var_8)

			setActive = var_9_3

			local var_9_7 = arg_9_0._tf
			local var_9_8 = var_5.Find(var_9_7, "stamp")

			getProxy = var_9_5
			TaskProxy = var_8

			local var_9_9 = var_9_5(var_8)

			var_9_3(var_9_8, var_6.mingshiTouchFlagEnabled(var_9_9))

			LOCK_CLICK_MINGSHI = var_9_3

			if var_9_3 then
				setActive = var_9_3

				local var_9_10 = arg_9_0._tf

				var_9_3(var_5.Find(var_9_10, "stamp"), false)
			end

			onButton = var_9_3

			local var_9_11 = arg_9_0
			local var_9_12 = arg_9_0._tf
			local var_9_13 = var_6.Find(var_9_12, "stamp")

			local function var_9_14()
				getProxy = var_2_10000
				TaskProxy = var_2_10002

				local var_11_0 = var_2_10000(var_2_10002)

				var_0.dealMingshiTouchFlag(var_11_0, 5)

				return
			end

			SFX_CONFIRM = var_9_12

			var_9_3(var_9_11, var_9_13, var_9_14, var_9_12)

			arg_9_0.toggles = {}
			pairs = var_3

			for iter_9_0, iter_9_1 in var_3(var_0_2) do
				local var_9_15 = arg_9_0._tagRoot
				local var_9_16 = var_8.Find(var_9_15, iter_9_0)

				onToggle = var_9_20

				local var_9_17 = arg_9_0
				local var_9_18 = var_9_16

				local function var_9_19(arg_12_0)
					if arg_12_0 then
						local var_12_0 = arg_9_0

						var_1.UpdatePage(var_12_0, iter_9_0)
					end

					return
				end

				SFX_PANEL = var_1_10014

				var_9_20(var_9_17, var_9_18, var_9_19, var_1_10014)

				local var_9_20 = arg_9_0.toggles

				var_9_20[iter_9_0] = var_9_16
			end

			local var_9_21 = arg_9_0.toggles
			local var_9_22

			if not arg_9_0.contextData.page then
				var_9_22 = var_0_1.PAGE_TYPE_ALL
			end

			local var_9_23 = var_9_21[var_9_22]

			if arg_9_0.toggles and var_9_23 then
				triggerToggle = var_4

				var_4(var_9_23, true)
			end

			arg_9_0:UpdateWeekTip()

			return
		end
	end
end

function var_0_1.refreshPage(arg_13_0)
	arg_13_0:UpdatePage(arg_13_0._currentToggleType)

	return
end

function var_0_1.UpdatePage(arg_14_0, arg_14_1)
	local var_14_0 = var_0_2[arg_14_1]

	local function var_14_1(arg_15_0, arg_15_1)
		if #arg_15_1 <= 0 then
			local var_15_0 = arg_14_0.emptyPage

			var_2.ExecuteAction(var_15_0, "ShowOrHide", true)
		elseif #arg_15_1 > 0 then
			local var_15_1 = arg_14_0.emptyPage

			if var_2.GetLoaded(var_15_1) then
				local var_15_2 = arg_14_0.emptyPage

				var_2.ExecuteAction(var_15_2, "ShowOrHide", false)
			end
		end

		local var_15_3 = arg_14_0

		var_2.updateOneStepBtn(var_15_3, arg_15_0)

		return
	end

	if arg_14_0._currentToggleType and arg_14_0._currentToggleType ~= arg_14_1 then
		local var_14_2 = arg_14_0.pages[arg_14_0._currentToggleType]

		var_4.ExecuteAction(var_14_2, "Hide")
	end

	local var_14_3 = arg_14_0.pages[arg_14_1]

	var_4.ExecuteAction(var_14_3, "Update", arg_14_1, var_14_0, function(arg_16_0)
		var_14_1(var_0, arg_16_0)

		return
	end)

	arg_14_0._currentToggleType = arg_14_1
	arg_14_0.contextData.page = arg_14_1

	return
end

function var_0_1.addTask(arg_17_0, arg_17_1)
	arg_17_0.contextData.taskVOsById[arg_17_1.id] = arg_17_1

	arg_17_0:UpdatePage(arg_17_0._currentToggleType)

	return
end

function var_0_1.removeTask(arg_18_0, arg_18_1)
	arg_18_0.contextData.taskVOsById[arg_18_1.id] = nil

	arg_18_0:UpdatePage(arg_18_0._currentToggleType)

	return
end

function var_0_1.updateTask(arg_19_0, arg_19_1)
	arg_19_0:addTask(arg_19_1)

	return
end

function var_0_1.ResetWeekTaskPage(arg_20_0)
	local var_20_0 = arg_20_0.pages[var_0_1.PAGE_TYPE_WEEKLY]

	if var_0_1.IsNewStyleTime() then
		isa = var_2

		local var_20_1 = var_20_0

		TaskCommonPage = var_1_10005

		if var_2(var_20_1, var_1_10005) then
			if var_20_0:GetLoaded() and var_20_0:isShowing() then
				var_20_0:Hide()
			end

			TaskWeekPage = var_2

			local var_20_2 = var_2.New(arg_20_0.pageTF, arg_20_0.event, arg_20_0.contextData)

			arg_20_0.pages[var_0_1.PAGE_TYPE_WEEKLY] = var_20_2
		end
	end

	arg_20_0:RefreshWeekTaskPage()

	if arg_20_0._currentToggleType ~= var_0_1.PAGE_TYPE_WEEKLY then
		arg_20_0:UpdatePage(arg_20_0._currentToggleType)
	end

	return
end

function var_0_1.RefreshWeekTaskPage(arg_21_0)
	if arg_21_0._currentToggleType == var_0_1.PAGE_TYPE_WEEKLY then
		arg_21_0:UpdatePage(arg_21_0._currentToggleType)
		arg_21_0:UpdateWeekTip()
	end

	return
end

function var_0_1.RefreshWeekTaskPageBefore(arg_22_0, arg_22_1)
	if arg_22_0._currentToggleType == var_0_1.PAGE_TYPE_WEEKLY then
		local var_22_0 = arg_22_0.pages[arg_22_0._currentToggleType]

		var_2.RefreshWeekTaskPageBefore(var_22_0, arg_22_1)
	end

	return
end

function var_0_1.RefreshWeekTaskProgress(arg_23_0)
	local var_23_0 = arg_23_0.pages[arg_23_0._currentToggleType]

	isa = var_2

	local var_23_1 = var_23_0

	TaskWeekPage = var_1_10005

	if var_2(var_23_1, var_1_10005) then
		local var_23_2 = arg_23_0.contextData.weekTaskProgressInfo

		if var_2.IsMaximum(var_23_2) then
			var_23_0:Destroy()

			arg_23_0.pages[var_0_1.PAGE_TYPE_WEEKLY] = arg_23_0.pages[var_0_1.PAGE_TYPE_SCENARIO]

			arg_23_0:UpdatePage(var_0_1.PAGE_TYPE_WEEKLY)

			goto label_23_0
		end
	end

	if arg_23_0._currentToggleType == var_0_1.PAGE_TYPE_WEEKLY then
		isa = var_2

		local var_23_3 = var_23_0

		TaskWeekPage = var_1_10005

		if var_2(var_23_3, var_1_10005) then
			var_23_0:ExecuteAction("RefreshWeekProgress")
			arg_23_0:UpdateWeekTip()
		end
	end

	::label_23_0::

	return
end

function var_0_1.UpdateWeekTip(arg_24_0)
	local var_24_0 = false

	if var_0_1.IsPassScenario() and var_0_1.IsNewStyleTime() then
		pairs = var_2

		for iter_24_0, iter_24_1 in var_2(arg_24_0.contextData.taskVOsById) do
			if (iter_24_1:getConfig("type") == 4 or iter_24_1:getConfig("type") == 13) and iter_24_1:isFinish() and not iter_24_1:isReceive() and iter_24_1:ShowOnTaskScene() then
				var_24_0 = true

				break
			end
		end

		if not var_24_0 then
			local var_24_1 = arg_24_0.contextData.weekTaskProgressInfo

			if var_2.CanUpgrade(var_24_1) or var_2:AnySubTaskCanSubmit() then
				var_24_0 = true
			end
		end
	end

	setActive = var_2

	var_2(arg_24_0.weekTip, var_24_0)

	return
end

function var_0_1.GoToFilter(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0._tagRoot
	local var_25_1 = var_2.Find(var_25_0, arg_25_1)

	triggerToggle = var_1_10003

	var_1_10003(var_25_1, true)

	return
end

function var_0_1.onSubmit(arg_26_0, arg_26_1)
	if arg_26_0.onShowAwards then
		return
	end

	local var_26_0 = arg_26_0
	local var_26_1 = arg_26_0.emit

	TaskMediator = var_1_10005

	var_26_1(var_26_0, var_1_10005.ON_TASK_SUBMIT, arg_26_1)

	return
end

function var_0_1.onSubmitForWeek(arg_27_0, arg_27_1)
	if arg_27_0.onShowAwards then
		return
	end

	local var_27_0 = arg_27_0
	local var_27_1 = arg_27_0.emit

	TaskMediator = var_1_10005

	var_27_1(var_27_0, var_1_10005.ON_SUBMIT_WEEK_TASK, arg_27_1)

	return
end

function var_0_1.onSubmitForAvatar(arg_28_0, arg_28_1)
	if arg_28_0.onShowAwards then
		return
	end

	local var_28_0 = arg_28_0
	local var_28_1 = arg_28_0.emit

	TaskMediator = var_1_10005

	var_28_1(var_28_0, var_1_10005.ON_SUBMIT_AVATAR_TASK, arg_28_1)

	return
end

function var_0_1.onGo(arg_29_0, arg_29_1)
	if arg_29_0.onShowAwards then
		return
	end

	isa = var_2

	local var_29_0 = arg_29_1

	AvatarFrameTask = var_1_10005

	if var_2(var_29_0, var_1_10005) and arg_29_1:IsActEnd() then
		pg = var_2

		local var_29_1 = var_2.TipsMgr.GetInstance()
		local var_29_2 = var_2.ShowTips

		i18n = var_1_10005

		var_29_2(var_29_1, var_1_10005("common_activity_end"))

		return
	end

	local var_29_3 = arg_29_0
	local var_29_4 = arg_29_0.emit

	TaskMediator = var_1_10005

	var_29_4(var_29_3, var_1_10005.ON_TASK_GO, arg_29_1)

	return
end

function var_0_1.willExit(arg_30_0)
	pairs = var_1_10001

	for iter_30_0, iter_30_1 in var_1_10001(arg_30_0.pages) do
		iter_30_1:Destroy()
	end

	if arg_30_0.emptyPage then
		local var_30_0 = arg_30_0.emptyPage

		var_1.Destroy(var_30_0)

		arg_30_0.emptyPage = nil
	end

	arg_30_0.pages = nil

	local var_30_1 = arg_30_0.contextData.ptAwardWindow

	var_1.Destroy(var_30_1)

	arg_30_0.contextData.ptAwardWindow = nil
	arg_30_0.contextData.taskVOsById = nil
	arg_30_0.contextData.weekTaskProgressInfo = nil
	arg_30_0.contextData.viewComponent = nil

	return
end

function var_0_1.updateOneStepBtn(arg_31_0, arg_31_1)
	arg_31_1 = arg_31_1 or arg_31_0.pages[arg_31_0._currentToggleType]

	local var_31_0 = #arg_31_1:GetWaitToCheckList()

	if 2 <= var_31_0 then
		onButton = var_4

		local var_31_1 = arg_31_0
		local var_31_2 = arg_31_0.oneStepBtn

		local function var_31_3()
			local var_32_0 = arg_31_1

			var_0.ExecuteOneStepSubmit(var_32_0)

			return
		end

		SFX_PANEL = var_1_10009

		var_4(var_31_1, var_31_2, var_31_3, var_1_10009)
	else
		removeOnButton = var_4

		var_4(arg_31_0.oneStepBtn)
	end

	setActive = var_4

	var_4(arg_31_0.oneStepBtn, var_3)

	return
end

return var_0_1
