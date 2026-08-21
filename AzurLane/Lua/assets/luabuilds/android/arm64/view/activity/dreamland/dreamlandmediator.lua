local var_0_0 = class("DreamlandMediator", import("view.activity.BackHills.AnniversaryIsland2023.AnniversaryIslandHotSpringMediator"))

var_0_0.GET_MAP_AWARD = "DreamlandMediator:GET_MAP_AWARD"
var_0_0.GET_EXPLORE_AWARD = "DreamlandMediator:GET_EXPLORE_AWARD"
var_0_0.RECORD_EXPLORE = "DreamlandMediator:RECORD_EXPLORE"
var_0_0.HOT_SPRING_OP = "DreamlandMediator:HOT_SPRING_OP"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.HOT_SPRING_OP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0.maxSlotCnt = arg_2_2

		arg_1_0:OnSelShips(arg_2_1, arg_2_3)

		return
	end)
	arg_1_0:bind(var_0_0.GET_MAP_AWARD, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.ACTIVITY_DREAMLAND_OP, {
			activity_id = arg_3_1,
			cmd = DreamlandData.OP_GET_MAP_AWARD,
			arg1 = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.GET_EXPLORE_AWARD, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:sendNotification(GAME.ACTIVITY_DREAMLAND_OP, {
			activity_id = arg_4_1,
			cmd = DreamlandData.OP_GET_EXPLORE_AWARD,
			arg1 = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.RECORD_EXPLORE, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		arg_1_0:sendNotification(GAME.ACTIVITY_DREAMLAND_OP, {
			activity_id = arg_5_1,
			cmd = DreamlandData.OP_RECORD_EXPLORE,
			arg1 = arg_5_3
		})

		return
	end)

	arg_1_0.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2)

	return
end

function var_0_0.GetGetSlotCount(arg_6_0)
	return arg_6_0.maxSlotCnt or 0
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		GAME.ACTIVITY_DREAMLAND_OP_DONE,
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.STORY_UPDATE_DONE
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.ACTIVITY_DREAMLAND_OP_DONE then
		arg_8_0.viewComponent:UpdateActivity(var_8_1.activity, var_8_1.cmd)

		if #var_8_1.awards > 0 then
			arg_8_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1.awards)
		end
	elseif var_8_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_8_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_HOTSPRING_2 then
			arg_8_0.activity = var_8_1

			arg_8_0.viewComponent:UpdateSpringActivity(var_8_1)
		end
	elseif var_8_0 == GAME.STORY_UPDATE_DONE then
		arg_8_0.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2)

		arg_8_0.viewComponent:UpdateSpringActivity(arg_8_0.activity)
	end

	return
end

return var_0_0
