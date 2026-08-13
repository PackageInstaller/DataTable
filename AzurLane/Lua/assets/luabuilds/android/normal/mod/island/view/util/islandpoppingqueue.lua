class = var_0_10000

local var_0_0 = var_0_10000("IslandPoppingQueue")

var_0_0.PERFORMANCE = 1
var_0_0.DISPLAY_AWARD = 2
var_0_0.MSGBOX = 3
var_0_0.STORY = 4
var_0_0.TASK_ACCEPT_PAGE = 5

function var_0_0.CreateTask(arg_1_0, arg_1_1)
	var_2.callback = ({
		type = arg_1_0,
		args = arg_1_1 or {}
	}).args.callback

	return var_2
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.islandScene = arg_2_1
	arg_2_0.schedule = {}
	arg_2_0.ignoringStoryList = {}
	arg_2_0.playerList = {}

	return
end

function var_0_0.GetSceneView(arg_3_0)
	return arg_3_0.islandScene
end

function var_0_0.Enqueue(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0_0.CreateTask(arg_4_1, arg_4_2)

	if not arg_4_0:IsValid(var_4_0) then
		return
	end

	table = var_4

	var_4.insert(arg_4_0.schedule, var_4_0)

	if #arg_4_0.schedule == 1 then
		arg_4_0:ProcessNextOne()
	end

	return
end

function var_0_0.IsValid(arg_5_0, arg_5_1)
	if arg_5_1.type == var_0_0.STORY then
		table = var_2

		if var_2.contains(arg_5_0.ignoringStoryList, arg_5_1.args.name) then
			arg_5_0:ExecuteStory(arg_5_1.callback, arg_5_1.args.name, arg_5_1.args.refreshNpc)

			return false
		end
	end

	return true
end

function var_0_0.ProcessNextOne(arg_6_0)
	local var_6_0 = arg_6_0.schedule[1]

	local function var_6_1()
		if var_6_0.callback then
			var_6_0.callback()
		end

		if not arg_6_0.schedule then
			return
		end

		local var_7_0 = arg_6_0

		var_7_0.ignoringStoryList = {}
		table = var_7_0

		var_7_0.remove(arg_6_0.schedule, 1)

		if #arg_6_0.schedule > 0 then
			onNextTick = var_0

			var_0(function()
				local var_8_0 = arg_6_0

				var_0.ProcessNextOne(var_8_0)

				return
			end)
		end

		return
	end

	if var_6_0.type == var_0_0.PERFORMANCE then
		arg_6_0:ExecutePerformer(var_6_1, var_6_0.args.name)
	elseif var_6_0.type == var_0_0.DISPLAY_AWARD then
		arg_6_0:ExecuteAwardDisplay(var_6_1, var_6_0.args.dropData, var_6_0.args.displayType)
	elseif var_6_0.type == var_0_0.MSGBOX then
		arg_6_0:ExecuteMsgbox(var_6_1, var_6_0.args)
	elseif var_6_0.type == var_0_0.STORY then
		arg_6_0:ExecuteStory(var_6_1, var_6_0.args.name, var_6_0.args.refreshNpc)
	elseif var_6_0.type == var_0_0.TASK_ACCEPT_PAGE then
		arg_6_0:ExecuteTaskAcceptWin(var_6_1, var_6_0.args.taskId)
	else
		error = var_3

		local var_6_2 = "Unknown popping type: "

		tostring = var_1_10005

		var_3(var_6_2 .. var_1_10005(var_6_0.type))
	end

	return
end

function var_0_0.ExecuteStory(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0:GetSceneView()

	var_4.TryDisVisible(var_9_0)

	local var_9_1 = arg_9_0:GetSceneView()
	local var_9_2 = var_4.GetSubView

	IslandStoryMgr = var_1_10006

	local var_9_3 = var_9_2(var_9_1, var_1_10006)

	var_4.ExecuteAction(var_9_3, "Play", arg_9_2, arg_9_3, function()
		local var_10_0 = arg_9_0
		local var_10_1 = var_0.GetSceneView(var_10_0)

		var_0.TryVisible(var_10_1)
		arg_9_1()

		return
	end)

	return
end

function var_0_0.ExecuteMsgbox(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:GetSceneView()
	local var_11_1 = var_3.GetSubView

	IslandMsgBox = var_1_10005

	local var_11_2 = var_11_1(var_11_0, var_1_10005)

	var_3.ExecuteAction(var_11_2, "Show", arg_11_2, arg_11_1)

	return
end

function var_0_0.ExecutePerformer(arg_12_0, arg_12_1, arg_12_2)
	pg = var_1_10003

	local var_12_0 = var_1_10003.NewStoryMgr.GetInstance()

	if not var_3.GetScript(var_12_0, arg_12_2) or #var_3 <= 0 then
		arg_12_1()

		return
	end

	ipairs = var_12_0

	for iter_12_0, iter_12_1 in var_12_0(var_3) do
		local var_12_1 = iter_12_1.type

		IslandPerformancePerformer = var_1_10010

		if var_12_1 == var_1_10010.TYPE_STORY then
			table = var_12_1

			var_12_1.insert(arg_12_0.ignoringStoryList, iter_12_1.name)
		end
	end

	IslandPerformancePerformer = var_4

	local var_12_2 = var_4.New(arg_12_0:GetSceneView().event)

	var_4.Play(var_12_2, arg_12_2, var_3, function()
		local var_13_0 = var_0

		var_0.Dispose(var_13_0)

		table = var_0

		var_0.removebyvalue(arg_12_0.playerList, var_0)
		arg_12_1()

		return
	end)

	table = var_5

	var_5.insert(arg_12_0.playerList, var_4)

	return
end

function var_0_0.ExecuteAwardDisplay(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_15_0)
			if not arg_14_2.drops or #arg_14_2.drops <= 0 then
				arg_15_0()

				return
			end

			local var_15_0 = arg_14_0
			local var_15_1 = var_1.GetSceneView(var_15_0)
			local var_15_2 = var_1.emit

			BaseUI = var_2_10003

			var_15_2(var_15_1, var_2_10003.ON_ACHIEVE, arg_14_2.drops, arg_15_0)

			return
		end,
		function(arg_16_0)
			onNextTick = var_2_10001

			var_2_10001(arg_16_0)

			return
		end,
		function(arg_17_0)
			if not arg_14_2.awards or #arg_14_2.awards <= 0 then
				arg_17_0()

				return
			end

			local var_17_0 = arg_14_0
			local var_17_1 = var_1.GetSceneView(var_17_0)
			local var_17_2 = var_1.DisplayAward
			local var_17_3 = {
				type = arg_14_3
			}

			i18n = var_4
			var_17_3.title = var_4("island_get_item_tip")
			var_17_3.awards = arg_14_2.awards
			var_17_3.callback = arg_17_0

			var_17_2(var_17_1, var_17_3)

			return
		end,
		function(arg_18_0)
			onNextTick = var_2_10001

			var_2_10001(arg_18_0)

			return
		end,
		function(arg_19_0)
			if not arg_14_2.exp or arg_14_2.exp <= 0 then
				arg_19_0()

				return
			end

			local var_19_0 = arg_14_0
			local var_19_1 = var_1.GetSceneView(var_19_0)

			var_1.ShowExpAdd(var_19_1, arg_14_2.exp, arg_19_0)

			return
		end,
		function(arg_20_0)
			onNextTick = var_2_10001

			var_2_10001(arg_20_0)

			return
		end,
		function(arg_21_0)
			local var_21_0 = arg_14_0
			local var_21_1 = var_1.GetSceneView(var_21_0)

			var_1.DisplaySystemUnlock(var_21_1, arg_14_2.abilitys, arg_21_0)

			return
		end,
		function(arg_22_0)
			onNextTick = var_2_10001

			var_2_10001(arg_22_0)

			return
		end,
		function(arg_23_0)
			pg = var_2_10001

			local var_23_0 = var_2_10001.m02
			local var_23_1 = var_1.sendNotification

			GAME = var_2_10003

			var_23_1(var_23_0, var_2_10003.ISLAND_UPGRADE, {
				callback = arg_23_0
			})

			return
		end,
		function(arg_24_0)
			onNextTick = var_2_10001

			var_2_10001(arg_24_0)

			return
		end,
		function(arg_25_0)
			if not arg_14_2.overflowAwards or #arg_14_2.overflowAwards == 0 then
				arg_25_0()

				return
			end

			local var_25_0 = arg_14_0
			local var_25_1 = var_1.GetSceneView(var_25_0)
			local var_25_2 = var_1.DisplayAward
			local var_25_3 = {
				titleColor = "#ab4734"
			}

			i18n = var_2_10004
			var_25_3.title = var_2_10004("island_add_temp_bag")
			var_25_3.awards = arg_14_2.overflowAwards
			var_25_3.callback = arg_25_0

			var_25_2(var_25_1, var_25_3)

			return
		end,
		function(arg_26_0)
			if not arg_14_2.overflowAwards or #arg_14_2.overflowAwards == 0 then
				arg_26_0()

				return
			end

			local var_26_0 = arg_14_0
			local var_26_1 = var_1.GetSceneView(var_26_0)
			local var_26_2 = var_1.OpenPage

			IslandInventoryPage = var_2_10003

			var_26_2(var_26_1, var_2_10003)
			arg_26_0()

			return
		end
	}, arg_14_1)

	return
end

function var_0_0.ExecuteTaskAcceptWin(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0:GetSceneView()
	local var_27_1 = var_3.emitCore

	ISLAND_EVT = var_1_10005

	var_27_1(var_27_0, var_1_10005.DISABLE_INPUT)

	local function var_27_2()
		local var_28_0 = arg_27_0
		local var_28_1 = var_0.GetSceneView(var_28_0)
		local var_28_2 = var_0.emitCore

		ISLAND_EVT = var_2_10002

		var_28_2(var_28_1, var_2_10002.ENABLE_INPUT)
		arg_27_1()

		return
	end

	local var_27_3 = arg_27_0:GetSceneView()
	local var_27_4 = var_4.GetSubView

	Island3dTaskAcceptPage = var_1_10006

	local var_27_5 = var_27_4(var_27_3, var_1_10006)

	var_4.ExecuteAction(var_27_5, "Show", arg_27_2, var_27_2)

	return
end

function var_0_0.AnyPlayerIsRunning(arg_29_0)
	return #arg_29_0.playerList > 0
end

function var_0_0.Dispose(arg_30_0)
	arg_30_0.schedule = nil
	ipairs = var_1

	local var_30_0

	if not arg_30_0.playerList then
		var_30_0 = {}
	end

	for iter_30_0, iter_30_1 in var_1(var_30_0) do
		iter_30_1:Dispose()
	end

	arg_30_0.playerList = nil

	return
end

return var_0_0
