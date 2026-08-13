class = var_0_10000

local var_0_0 = "SpringFestival2026ColoringAnshanMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.EVENT_GO_SCENE = "event go scene"
var_0_1.EVENT_COLORING_CELL = "event coloring cell"
var_0_1.EVENT_COLORING_CLEAR = "event coloring clear"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.EVENT_GO_SCENE, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.GO_SCENE, arg_2_1, arg_2_2)

		return
	end)
	arg_1_0:bind(var_0_1.EVENT_COLORING_CELL, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.COLORING_CELL, arg_3_1)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.EVENT_COLORING_CLEAR, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.COLORING_CLEAR, arg_4_1)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_5

	local var_1_3 = var_1_2(var_1_1, var_5.ACTIVITY_TYPE_COLORING_ALPHA)
	local var_1_4 = arg_1_0.viewComponent

	var_3.setActivity(var_1_4, var_1_3)

	getProxy = var_3
	ColoringProxy = var_1_4

	local var_1_5 = var_3(var_1_4)
	local var_1_6 = arg_1_0.viewComponent

	var_4.setColorItems(var_1_6, var_1_5:getColorItems())

	local var_1_7 = arg_1_0.viewComponent

	var_4.setColorGroups(var_1_7, var_1_5:getColorGroups())

	local var_1_8 = arg_1_0.viewComponent

	var_4.DidMediatorRegisterDone(var_1_8)
	arg_1_0:tryColoringAchieve()

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.COLORING_CELL_DONE
	GAME = var_2
	var_5_0[2] = var_2.COLORING_CLEAR_DONE
	GAME = var_2
	var_5_0[3] = var_2.COLORING_ACHIEVE_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1:getBody()

	GAME = var_6_0

	if var_6_1 == var_6_0.COLORING_CELL_DONE then
		_ = var_4

		var_4.each(var_6_2.cells, function(arg_7_0)
			local var_7_0 = arg_6_0.viewComponent

			var_1.updateCell(var_7_0, arg_7_0.row, arg_7_0.column)

			return
		end)

		local var_6_3 = arg_6_0.viewComponent

		var_4.updateSelectedColoring(var_6_3)

		if var_6_2.stateChange then
			local var_6_4 = arg_6_0.viewComponent

			var_4.updatePage(var_6_4)
			arg_6_0:tryColoringAchieve()
		end
	else
		GAME = var_4

		if var_6_1 == var_4.COLORING_CLEAR_DONE then
			local var_6_5 = arg_6_0.viewComponent

			var_4.updateSelectedColoring(var_6_5)
		else
			GAME = var_4

			if var_6_1 == var_4.COLORING_ACHIEVE_DONE then
				local var_6_6 = arg_6_0.viewComponent
				local var_6_7 = var_4.emit

				BaseUI = var_1_10007

				var_6_7(var_6_6, var_1_10007.ON_ACHIEVE, var_6_2.drops, function()
					local var_8_0 = arg_6_0.viewComponent

					var_0.updatePage(var_8_0)

					return
				end)
			end
		end
	end

	return
end

function var_0_1.tryColoringAchieve(arg_9_0)
	getProxy = var_1_10001
	ColoringProxy = var_1_10003

	local var_9_0 = var_1_10001(var_1_10003)
	local var_9_1 = var_1.getColorGroups(var_9_0)

	ipairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(var_9_1) do
		local var_9_2 = iter_9_1:getState()

		ColorGroup = var_1_10009

		if var_9_2 == var_1_10009.StateFinish and iter_9_1:getHasAward() then
			local var_9_3 = arg_9_0
			local var_9_4 = arg_9_0.sendNotification

			GAME = var_1_10011

			var_9_4(var_9_3, var_1_10011.COLORING_ACHIEVE, {
				activityId = arg_9_0.viewComponent.activity.id,
				id = iter_9_1.id
			})

			break
		end
	end

	return
end

return var_0_1
