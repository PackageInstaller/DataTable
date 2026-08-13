class = var_0_10000

local var_0_0 = "ClueMapMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_TASK_SUBMIT_ONESTEP = "ClueMapMediator.ON_TASK_SUBMIT_ONESTEP"
var_0_1.OPEN_SINGLE_CLUE_GROUP = "ClueMapMediator.OPEN_SINGLE_CLUE_GROUP"
var_0_1.OPEN_CLUE_BOOK = "ClueMapMediator.OPEN_CLUE_BOOK"
var_0_1.OPEN_CLUE_TASk = "ClueMapMediator.OPEN_CLUE_TASk"
var_0_1.OPEN_STAGE = "ClueMapMediator.OPEN_STAGE"
var_0_1.ON_FLEET_SELECT = "ClueMapMediator.ON_FLEET_SELECT"
var_0_1.OPEN_CLUE_JUMP = "ClueMapMediator.OPEN_CLUE_JUMP"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT_ONESTEP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_2_1,
			task_ids = arg_2_2,
			callback = arg_2_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_SINGLE_CLUE_GROUP, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = arg_1_0
		local var_3_1 = var_4.addSubLayers

		Context = var_2_10006

		local var_3_2 = var_2_10006.New
		local var_3_3 = {}

		ClueGroupSingleView = var_2_10008
		var_3_3.viewComponent = var_2_10008
		ClueGroupSingleMediator = var_2_10008
		var_3_3.mediator = var_2_10008
		var_3_3.data = {
			clueGroupId = arg_3_1,
			submitClueIds = arg_3_2
		}
		var_3_3.onRemoved = arg_3_3

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CLUE_BOOK, function(arg_4_0, arg_4_1)
		arg_1_0.contextData.bookOpen = true

		local var_4_0 = arg_1_0.contextData
		local var_4_1

		if not arg_1_0.contextData.indexInfo then
			var_4_1 = {}
		end

		var_4_0.indexInfo = var_4_1

		local var_4_2 = arg_1_0
		local var_4_3 = var_2.addSubLayers

		Context = var_2_10004

		local var_4_4 = var_2_10004.New
		local var_4_5 = {}

		ClueBookLayer = var_2_10006
		var_4_5.viewComponent = var_2_10006
		ClueBookMediator = var_2_10006
		var_4_5.mediator = var_2_10006
		var_4_5.data = {
			indexInfo = arg_1_0.contextData.indexInfo
		}

		function var_4_5.onRemoved()
			local var_5_0 = arg_1_0.contextData

			var_5_0.bookOpen = false
			existCall = var_5_0

			var_5_0(arg_4_1)

			return
		end

		var_4_3(var_4_2, var_4_4(var_4_5))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CLUE_TASk, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_6_2 = var_2_10004.New
		local var_6_3 = {}

		ClueTasksLayer = var_2_10006
		var_6_3.viewComponent = var_2_10006
		ClueTasksMediator = var_2_10006
		var_6_3.mediator = var_2_10006
		var_6_3.onRemoved = arg_6_1

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_STAGE, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_7_2 = var_2_10004.New
		local var_7_3 = {}

		ClueBuffSelectLayer = var_2_10006
		var_7_3.viewComponent = var_2_10006
		ClueBuffSelectMediator = var_2_10006
		var_7_3.mediator = var_2_10006
		var_7_3.data = {
			clueSingleEnemyID = arg_7_1
		}

		var_7_1(var_7_0, var_7_2(var_7_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {
		var_0_1.ON_FLEET_SELECT,
		var_0_1.OPEN_CLUE_JUMP
	}

	PlayerProxy = var_2
	var_8_0[3] = var_2.UPDATED
	GAME = var_2
	var_8_0[4] = var_2.SUBMIT_ACTIVITY_TASK_DONE

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == var_0_1.ON_FLEET_SELECT then
		var_1_10005 = arg_9_0.viewComponent

		var_4.ShowNormalFleet(var_1_10005, var_9_1.singleID)
	else
		local var_9_2

		if var_9_0 == var_0_1.OPEN_CLUE_JUMP then
			var_9_2 = var_9_1.jumpID
			pg = var_1_10005

			local var_9_3 = var_1_10005.activity_clue_group[var_9_2]
			local var_9_4 = arg_9_0
			local var_9_5 = arg_9_0.addSubLayers

			Context = var_1_10008

			local var_9_6 = var_1_10008.New
			local var_9_7 = {}

			ClueBuffSelectLayer = var_1_10010
			var_9_7.viewComponent = var_1_10010
			ClueBuffSelectMediator = var_1_10010
			var_9_7.mediator = var_1_10010

			local var_9_8 = {
				clueSingleEnemyID = var_9_3.unlock_jump[1][1]
			}

			Clone = var_11
			var_9_8.preSelectedBuffList = var_11(var_9_3.unlock_jump[2])
			var_9_7.data = var_9_8

			var_9_5(var_9_4, var_9_6(var_9_7))

			pg = var_9_5

			if var_9_5.activity_single_enemy[var_9_3.unlock_jump[1][1]].type == 1 or var_6 == 2 or var_6 == 3 then
				triggerToggle = var_7

				var_7(arg_9_0.viewComponent.mapsSwitch[var_6], true)
			end
		else
			PlayerProxy = var_9_2

			if var_9_0 == var_9_2.UPDATED then
				local var_9_9 = arg_9_0.viewComponent

				var_4.ShowResUI(var_9_9)
			else
				GAME = var_4

				if var_9_0 == var_4.SUBMIT_ACTIVITY_TASK_DONE then
					local var_9_10 = arg_9_0.viewComponent

					var_4.RefreshPtAndTicket(var_9_10)
				end
			end
		end
	end

	return
end

return var_0_1
