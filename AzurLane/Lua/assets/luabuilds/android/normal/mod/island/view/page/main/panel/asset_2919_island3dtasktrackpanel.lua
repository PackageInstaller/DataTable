class = var_0_10000

local var_0_0 = "Island3dTaskTrackPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "Island3dTaskTrackPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.GetComponent

	typeof = var_1_10003
	Animation = var_1_10004
	arg_2_0.uiAnim = var_2_1(var_2_0, var_1_10003(var_1_10004))

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_2_0.uiAnimEvent = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0.uiAnimEvent

	var_1.SetEndEvent(var_2_4, function()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end)

	IslandTaskTrackCard = var_1

	local var_2_5 = var_1.New
	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_2.Find(var_2_6, "content")
	local var_2_8 = arg_2_0.event

	IslandTaskTrackCard = var_4
	arg_2_0.mainTrackCard = var_2_5(var_2_7, var_2_8, var_4.TYPES.MAIN)
	IslandTaskTrackCard = var_1

	local var_2_9 = var_1.New
	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_2.Find(var_2_10, "other_content")
	local var_2_12 = arg_2_0.event

	IslandTaskTrackCard = var_4
	arg_2_0.otherTrackCard = var_2_9(var_2_11, var_2_12, var_4.TYPES.OTHER)

	return
end

function var_0_1.OnInit(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.mainTrackCard._tf

	local function var_4_2()
		getProxy = var_2_10000
		IslandProxy = var_2_10001

		local var_5_0 = var_2_10000(var_2_10001)
		local var_5_1 = var_0.GetIsland(var_5_0)
		local var_5_2 = var_0.GetTaskAgency(var_5_1)
		local var_5_3 = var_0.IsFinishTask

		IslandGuideChecker = var_2_10002

		if not var_5_3(var_5_2, var_2_10002.MOVE_TASK_ID) then
			return
		end

		local var_5_4 = arg_4_0
		local var_5_5 = var_0.emit

		IslandMediator = var_2

		var_5_5(var_5_4, var_2.OPEN_PAGE, "Island3dTaskPage", {
			0,
			arg_4_0.mainTask.id
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10005)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.otherTrackCard._tf

	local function var_4_5()
		getProxy = var_2_10000
		IslandProxy = var_2_10001

		local var_6_0 = var_2_10000(var_2_10001)
		local var_6_1 = var_0.GetIsland(var_6_0)
		local var_6_2 = var_0.GetTaskAgency(var_6_1)
		local var_6_3 = var_0.IsFinishTask

		IslandGuideChecker = var_2_10002

		if not var_6_3(var_6_2, var_2_10002.MOVE_TASK_ID) then
			return
		end

		local var_6_4 = arg_4_0
		local var_6_5 = var_0.emit

		IslandMediator = var_2

		var_6_5(var_6_4, var_2.OPEN_PAGE, "Island3dTaskPage", {
			0,
			arg_4_0.otherTask.id
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_3, var_4_4, var_4_5, var_1_10005)

	pg = var_1_10001

	local var_4_6 = var_1_10001.island_set.main_page_function_unlock.key_value_varchar[2]

	getProxy = var_4_3
	IslandProxy = var_4_4

	local var_4_7 = var_4_3(var_4_4)
	local var_4_8 = var_2.GetIsland(var_4_7)
	local var_4_9 = var_2.GetAblityAgency(var_4_8)

	arg_4_0.unlock = var_2.HasAbility(var_4_9, var_4_6)

	return
end

function var_0_1.Show(arg_7_0)
	setActive = var_1_10001

	var_1_10001(arg_7_0._tf, arg_7_0.unlock)
	arg_7_0:ShowOrHideResUI(true)
	arg_7_0:PlayBGM()
	arg_7_0:UpdataAllTask()

	return
end

function var_0_1.UpdataAllTask(arg_8_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_8_0 = var_1_10001(var_1_10002)
	local var_8_1 = var_1.GetIsland(var_8_0)
	local var_8_2 = var_1.GetTaskAgency(var_8_1)

	arg_8_0.mainTask = var_1.GetMainTraceTask(var_8_2)

	if not arg_8_0.mainTask then
		var_8_2 = arg_8_0.mainTrackCard

		var_1.UnTrackUI(var_8_2)
	end

	getProxy = var_1
	IslandProxy = var_8_2

	local var_8_3 = var_1(var_8_2)
	local var_8_4 = var_1.GetIsland(var_8_3)
	local var_8_5 = var_1.GetTaskAgency(var_8_4)

	arg_8_0.otherTask = var_1.GetTraceTask(var_8_5)

	if not arg_8_0.otherTask then
		local var_8_6 = arg_8_0.otherTrackCard

		var_1.UnTrackUI(var_8_6)
	end

	if not arg_8_0.mainTask and not arg_8_0.otherTask then
		return
	end

	if arg_8_0.unlock then
		local var_8_7 = arg_8_0.uiAnim

		var_1.Play(var_8_7, "Island3dTaskTrackPanel_in")
	end

	local var_8_8 = arg_8_0
	local var_8_9 = arg_8_0.UpdateTask

	IslandTaskTrackCard = var_1_10003

	var_8_9(var_8_8, var_1_10003.TYPES.MAIN)

	local var_8_10 = arg_8_0
	local var_8_11 = arg_8_0.UpdateTask

	IslandTaskTrackCard = var_3

	var_8_11(var_8_10, var_3.TYPES.OTHER)

	return
end

function var_0_1.UpdateTask(arg_9_0, arg_9_1)
	IslandTaskTrackCard = var_1_10002

	if arg_9_1 == var_1_10002.TYPES.MAIN then
		getProxy = var_2
		IslandProxy = var_1_10003
		var_1_10003 = var_2(var_1_10003)
		var_1_10003 = var_2.GetIsland(var_1_10003)
		var_1_10003 = var_2.GetTaskAgency(var_1_10003)
		arg_9_0.mainTask = var_2.GetMainTraceTask(var_1_10003)
		var_1_10003 = arg_9_0.mainTrackCard

		var_2.Update(var_1_10003, arg_9_0.mainTask, arg_9_0.unlock)
	else
		IslandTaskTrackCard = var_2

		if arg_9_1 == var_2.TYPES.OTHER then
			getProxy = var_2
			IslandProxy = var_1_10003

			local var_9_0 = var_2(var_1_10003)
			local var_9_1 = var_2.GetIsland(var_9_0)
			local var_9_2 = var_2.GetTaskAgency(var_9_1)

			arg_9_0.otherTask = var_2.GetTraceTask(var_9_2)

			local var_9_3 = arg_9_0.otherTrackCard

			var_2.Update(var_9_3, arg_9_0.otherTask, arg_9_0.unlock)
		end
	end

	return
end

function var_0_1.UpdateProgress(arg_10_0, arg_10_1)
	IslandTaskTrackCard = var_1_10002

	if arg_10_1 == var_1_10002.TYPES.MAIN then
		getProxy = var_2
		IslandProxy = var_1_10003
		var_1_10003 = var_2(var_1_10003)
		var_1_10003 = var_2.GetIsland(var_1_10003)
		var_1_10003 = var_2.GetTaskAgency(var_1_10003)
		arg_10_0.mainTask = var_2.GetMainTraceTask(var_1_10003)

		if arg_10_0.mainTask then
			var_1_10003 = arg_10_0.mainTrackCard

			var_2.UpdateProgress(var_1_10003, arg_10_0.mainTask)
		end
	else
		IslandTaskTrackCard = var_2

		if arg_10_1 == var_2.TYPES.OTHER then
			getProxy = var_2
			IslandProxy = var_1_10003

			local var_10_0 = var_2(var_1_10003)
			local var_10_1 = var_2.GetIsland(var_10_0)
			local var_10_2 = var_2.GetTaskAgency(var_10_1)

			arg_10_0.otherTask = var_2.GetTraceTask(var_10_2)

			if arg_10_0.otherTask then
				local var_10_3 = arg_10_0.otherTrackCard

				var_2.UpdateProgress(var_10_3, arg_10_0.otherTask)
			end
		end
	end

	return
end

function var_0_1.RemoveTask(arg_11_0, arg_11_1)
	IslandTaskTrackCard = var_1_10002

	if arg_11_1 == var_1_10002.TYPES.MAIN then
		local var_11_0 = arg_11_0.mainTrackCard

		var_2.RemoveTask(var_11_0)
	else
		IslandTaskTrackCard = var_2

		if arg_11_1 == var_2.TYPES.OTHER then
			local var_11_1 = arg_11_0.otherTrackCard

			var_2.RemoveTask(var_11_1)
		end
	end

	local var_11_2 = arg_11_0
	local var_11_3 = arg_11_0.emit

	IslandMediator = var_1_10004

	var_11_3(var_11_2, var_1_10004.ON_SET_TRACE_ID, 0, arg_11_1)

	getProxy = var_11_3
	IslandProxy = var_11_2

	local var_11_4 = var_11_3(var_11_2)
	local var_11_5 = var_2.GetIsland(var_11_4)
	local var_11_6 = var_2.GetTaskAgency(var_11_5)

	arg_11_0.mainTask = var_2.GetMainTraceTask(var_11_6)
	getProxy = var_2
	IslandProxy = var_11_6

	local var_11_7 = var_2(var_11_6)
	local var_11_8 = var_2.GetIsland(var_11_7)
	local var_11_9 = var_2.GetTaskAgency(var_11_8)

	arg_11_0.otherTask = var_2.GetTraceTask(var_11_9)

	if not arg_11_0.mainTask and not arg_11_0.otherTask then
		arg_11_0:Hide()
	end

	return
end

function var_0_1.SetUnlock(arg_12_0)
	arg_12_0.unlock = true

	if arg_12_0.mainTask then
		local var_12_0 = arg_12_0.mainTrackCard

		var_1.Update(var_12_0, arg_12_0.mainTask, arg_12_0.unlock)
	end

	if arg_12_0.otherTask then
		local var_12_1 = arg_12_0.otherTrackCard

		var_1.Update(var_12_1, arg_12_0.otherTask, arg_12_0.unlock)
	end

	return
end

function var_0_1.Hide(arg_13_0)
	var_0_1.super.Hide(arg_13_0)

	local var_13_0 = arg_13_0.mainTrackCard

	var_1.UnTrackUI(var_13_0)

	local var_13_1 = arg_13_0.otherTrackCard

	var_1.UnTrackUI(var_13_1)

	return
end

function var_0_1.OnDestroy(arg_14_0)
	local var_14_0 = arg_14_0.uiAnimEvent

	var_1.SetEndEvent(var_14_0, nil)

	local var_14_1 = arg_14_0.mainTrackCard

	var_1.Dispose(var_14_1)

	arg_14_0.mainTrackCard = nil

	local var_14_2 = arg_14_0.otherTrackCard

	var_1.Dispose(var_14_2)

	arg_14_0.otherTrackCard = nil

	return
end

return var_0_1
