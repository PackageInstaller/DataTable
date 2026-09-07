local WorldOverviewMediator = class("WorldOverviewMediator", import("..base.ContextMediator"))

WorldOverviewMediator.OnAchieveStar = "WorldOverviewMediator.OnAchieveStar"

function WorldOverviewMediator:register()
	self:bind(WorldOverviewMediator.OnAchieveStar, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.WORLD_ACHIEVE, {
			list = arg_2_1
		})

		return
	end)

	return
end

function WorldOverviewMediator:listNotificationInterests()
	return {
		GAME.WORLD_ACHIEVE_DONE
	}
end

function WorldOverviewMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.WORLD_ACHIEVE_DONE then
		-- block empty
	end

	return
end

return WorldOverviewMediator
