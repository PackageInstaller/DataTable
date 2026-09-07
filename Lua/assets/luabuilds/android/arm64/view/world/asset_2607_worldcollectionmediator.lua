local WorldCollectionMediator = class("WorldCollectionMediator", import("..base.ContextMediator"))

WorldCollectionMediator.ON_ACHIEVE_STAR = "WorldCollectionMediator.ON_ACHIEVE_STAR"
WorldCollectionMediator.ON_ACHIEVE_OVERVIEW = "WorldCollectionMediator.ON_ACHIEVE_OVERVIEW"
WorldCollectionMediator.ON_MAP = "WorldCollectionMediator.ON_MAP"

function WorldCollectionMediator:register()
	self:bind(WorldCollectionMediator.ON_ACHIEVE_STAR, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.WORLD_ACHIEVE, {
			list = arg_2_1
		})

		return
	end)
	self:bind(WorldCollectionMediator.ON_ACHIEVE_OVERVIEW, function(arg_3_0)
		self:sendNotification(WorldMediator.OnOpenMarkMap, {
			mode = "Achievement"
		})

		return
	end)
	self:bind(WorldCollectionMediator.ON_MAP, function(arg_4_0, arg_4_1)
		self:sendNotification(WorldCollectionMediator.ON_MAP, {
			entrance = arg_4_1,
			mapTypes = {
				"complete_chapter",
				"base_chapter"
			}
		})

		return
	end)
	self.viewComponent:SetAchievementList(nowWorld():GetAtlas():GetAchEntranceList())

	return
end

function WorldCollectionMediator:listNotificationInterests()
	return {
		GAME.WORLD_ACHIEVE_DONE
	}
end

function WorldCollectionMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getBody()

	if arg_6_1:getName() == GAME.WORLD_ACHIEVE_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_0.drops, function()
			self.viewComponent:flushAchieveUpdate(var_6_0.list)

			return
		end)
	end

	return
end

return WorldCollectionMediator
