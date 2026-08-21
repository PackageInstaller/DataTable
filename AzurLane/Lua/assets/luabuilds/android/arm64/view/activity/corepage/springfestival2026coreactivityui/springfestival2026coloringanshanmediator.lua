local var_0_0 = class("SpringFestival2026ColoringAnshanMediator", import("view.base.ContextMediator"))

var_0_0.EVENT_GO_SCENE = "event go scene"
var_0_0.EVENT_COLORING_CELL = "event coloring cell"
var_0_0.EVENT_COLORING_CLEAR = "event coloring clear"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.EVENT_GO_SCENE, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_2_1, arg_2_2)

		return
	end)
	arg_1_0:bind(var_0_0.EVENT_COLORING_CELL, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.COLORING_CELL, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_0.EVENT_COLORING_CLEAR, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.COLORING_CLEAR, arg_4_1)

		return
	end)
	arg_1_0.viewComponent:setActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_COLORING_ALPHA)))

	local var_1_0 = getProxy(ColoringProxy)

	arg_1_0.viewComponent:setColorItems(var_1_0:getColorItems())
	arg_1_0.viewComponent:setColorGroups(var_1_0:getColorGroups())
	arg_1_0.viewComponent:DidMediatorRegisterDone()
	arg_1_0:tryColoringAchieve()

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		GAME.COLORING_CELL_DONE,
		GAME.COLORING_CLEAR_DONE,
		GAME.COLORING_ACHIEVE_DONE
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == GAME.COLORING_CELL_DONE then
		_.each(var_6_1.cells, function(arg_7_0)
			arg_6_0.viewComponent:updateCell(arg_7_0.row, arg_7_0.column)

			return
		end)
		arg_6_0.viewComponent:updateSelectedColoring()

		if var_6_1.stateChange then
			arg_6_0.viewComponent:updatePage()
			arg_6_0:tryColoringAchieve()
		end
	elseif var_6_0 == GAME.COLORING_CLEAR_DONE then
		arg_6_0.viewComponent:updateSelectedColoring()
	elseif var_6_0 == GAME.COLORING_ACHIEVE_DONE then
		arg_6_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1.drops, function()
			arg_6_0.viewComponent:updatePage()

			return
		end)
	end

	return
end

function var_0_0.tryColoringAchieve(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs((getProxy(ColoringProxy):getColorGroups())) do
		if iter_9_1:getState() == ColorGroup.StateFinish and iter_9_1:getHasAward() then
			arg_9_0:sendNotification(GAME.COLORING_ACHIEVE, {
				activityId = arg_9_0.viewComponent.activity.id,
				id = iter_9_1.id
			})

			break
		end
	end

	return
end

return var_0_0
