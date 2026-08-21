local var_0_0 = class("WorldCollectionMediator", import("..base.ContextMediator"))

var_0_0.ON_ACHIEVE_STAR = "WorldCollectionMediator.ON_ACHIEVE_STAR"
var_0_0.ON_ACHIEVE_OVERVIEW = "WorldCollectionMediator.ON_ACHIEVE_OVERVIEW"
var_0_0.ON_MAP = "WorldCollectionMediator.ON_MAP"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_ACHIEVE_STAR, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.WORLD_ACHIEVE, {
			list = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_ACHIEVE_OVERVIEW, function(arg_3_0)
		arg_1_0:sendNotification(WorldMediator.OnOpenMarkMap, {
			mode = "Achievement"
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_MAP, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(var_0_0.ON_MAP, {
			entrance = arg_4_1,
			mapTypes = {
				"complete_chapter",
				"base_chapter"
			}
		})

		return
	end)
	arg_1_0.viewComponent:SetAchievementList(nowWorld():GetAtlas():GetAchEntranceList())

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		GAME.WORLD_ACHIEVE_DONE
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getBody()

	if arg_6_1:getName() == GAME.WORLD_ACHIEVE_DONE then
		arg_6_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_6_1:getBody().drops, function()
			arg_6_0.viewComponent:flushAchieveUpdate(var_6_0.list)

			return
		end)
	end

	return
end

return var_0_0
