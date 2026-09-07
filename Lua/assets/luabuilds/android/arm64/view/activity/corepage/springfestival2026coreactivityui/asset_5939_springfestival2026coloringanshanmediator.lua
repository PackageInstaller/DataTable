local SpringFestival2026ColoringAnshanMediator = class("SpringFestival2026ColoringAnshanMediator", import("view.base.ContextMediator"))

SpringFestival2026ColoringAnshanMediator.EVENT_GO_SCENE = "event go scene"
SpringFestival2026ColoringAnshanMediator.EVENT_COLORING_CELL = "event coloring cell"
SpringFestival2026ColoringAnshanMediator.EVENT_COLORING_CLEAR = "event coloring clear"

function SpringFestival2026ColoringAnshanMediator:register()
	self:bind(SpringFestival2026ColoringAnshanMediator.EVENT_GO_SCENE, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.GO_SCENE, arg_2_1, arg_2_2)

		return
	end)
	self:bind(SpringFestival2026ColoringAnshanMediator.EVENT_COLORING_CELL, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.COLORING_CELL, arg_3_1)

		return
	end)
	self:bind(SpringFestival2026ColoringAnshanMediator.EVENT_COLORING_CLEAR, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.COLORING_CLEAR, arg_4_1)

		return
	end)
	self.viewComponent:setActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_COLORING_ALPHA)))

	local var_1_0 = getProxy(ColoringProxy)

	self.viewComponent:setColorItems(var_1_0:getColorItems())
	self.viewComponent:setColorGroups(var_1_0:getColorGroups())
	self.viewComponent:DidMediatorRegisterDone()
	self:tryColoringAchieve()

	return
end

function SpringFestival2026ColoringAnshanMediator:listNotificationInterests()
	return {
		GAME.COLORING_CELL_DONE,
		GAME.COLORING_CLEAR_DONE,
		GAME.COLORING_ACHIEVE_DONE
	}
end

function SpringFestival2026ColoringAnshanMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == GAME.COLORING_CELL_DONE then
		_.each(var_6_1.cells, function(arg_7_0)
			self.viewComponent:updateCell(arg_7_0.row, arg_7_0.column)

			return
		end)
		self.viewComponent:updateSelectedColoring()

		if var_6_1.stateChange then
			self.viewComponent:updatePage()
			self:tryColoringAchieve()
		end
	elseif var_6_0 == GAME.COLORING_CLEAR_DONE then
		self.viewComponent:updateSelectedColoring()
	elseif var_6_0 == GAME.COLORING_ACHIEVE_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1.drops, function()
			self.viewComponent:updatePage()

			return
		end)
	end

	return
end

function SpringFestival2026ColoringAnshanMediator:tryColoringAchieve()
	for iter_9_0, iter_9_1 in ipairs((getProxy(ColoringProxy):getColorGroups())) do
		if iter_9_1:getState() == ColorGroup.StateFinish and iter_9_1:getHasAward() then
			self:sendNotification(GAME.COLORING_ACHIEVE, {
				activityId = self.viewComponent.activity.id,
				id = iter_9_1.id
			})

			break
		end
	end

	return
end

return SpringFestival2026ColoringAnshanMediator
