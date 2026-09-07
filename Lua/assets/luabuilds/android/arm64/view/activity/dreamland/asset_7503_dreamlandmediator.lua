local DreamlandMediator = class("DreamlandMediator", import("view.activity.BackHills.AnniversaryIsland2023.AnniversaryIslandHotSpringMediator"))

DreamlandMediator.GET_MAP_AWARD = "DreamlandMediator:GET_MAP_AWARD"
DreamlandMediator.GET_EXPLORE_AWARD = "DreamlandMediator:GET_EXPLORE_AWARD"
DreamlandMediator.RECORD_EXPLORE = "DreamlandMediator:RECORD_EXPLORE"
DreamlandMediator.HOT_SPRING_OP = "DreamlandMediator:HOT_SPRING_OP"

function DreamlandMediator:register()
	self:bind(DreamlandMediator.HOT_SPRING_OP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self.maxSlotCnt = arg_2_2

		self:OnSelShips(arg_2_1, arg_2_3)

		return
	end)
	self:bind(DreamlandMediator.GET_MAP_AWARD, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.ACTIVITY_DREAMLAND_OP, {
			activity_id = arg_3_1,
			cmd = DreamlandData.OP_GET_MAP_AWARD,
			arg1 = arg_3_2
		})

		return
	end)
	self:bind(DreamlandMediator.GET_EXPLORE_AWARD, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.ACTIVITY_DREAMLAND_OP, {
			activity_id = arg_4_1,
			cmd = DreamlandData.OP_GET_EXPLORE_AWARD,
			arg1 = arg_4_2
		})

		return
	end)
	self:bind(DreamlandMediator.RECORD_EXPLORE, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		self:sendNotification(GAME.ACTIVITY_DREAMLAND_OP, {
			activity_id = arg_5_1,
			cmd = DreamlandData.OP_RECORD_EXPLORE,
			arg1 = arg_5_3
		})

		return
	end)

	self.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2)

	return
end

function DreamlandMediator:GetGetSlotCount()
	return self.maxSlotCnt or 0
end

function DreamlandMediator:listNotificationInterests()
	return {
		GAME.ACTIVITY_DREAMLAND_OP_DONE,
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.STORY_UPDATE_DONE
	}
end

function DreamlandMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.ACTIVITY_DREAMLAND_OP_DONE then
		self.viewComponent:UpdateActivity(var_8_1.activity, var_8_1.cmd)

		if #var_8_1.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1.awards)
		end
	elseif var_8_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_8_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_HOTSPRING_2 then
			self.activity = var_8_1

			self.viewComponent:UpdateSpringActivity(var_8_1)
		end
	elseif var_8_0 == GAME.STORY_UPDATE_DONE then
		self.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2)

		self.viewComponent:UpdateSpringActivity(self.activity)
	end

	return
end

return DreamlandMediator
