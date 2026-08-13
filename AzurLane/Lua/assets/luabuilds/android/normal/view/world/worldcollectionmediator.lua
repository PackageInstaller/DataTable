class = var_0_10000

local var_0_0 = "WorldCollectionMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_ACHIEVE_STAR = "WorldCollectionMediator.ON_ACHIEVE_STAR"
var_0_1.ON_ACHIEVE_OVERVIEW = "WorldCollectionMediator.ON_ACHIEVE_OVERVIEW"
var_0_1.ON_MAP = "WorldCollectionMediator.ON_MAP"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_ACHIEVE_STAR, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.WORLD_ACHIEVE, {
			list = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_ACHIEVE_OVERVIEW, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.sendNotification

		WorldMediator = var_2_10003

		var_3_1(var_3_0, var_2_10003.OnOpenMarkMap, {
			mode = "Achievement"
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_MAP, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0

		var_2.sendNotification(var_4_0, var_0_1.ON_MAP, {
			entrance = arg_4_1,
			mapTypes = {
				"complete_chapter",
				"base_chapter"
			}
		})

		return
	end)

	local var_1_0 = arg_1_0.viewComponent
	local var_1_1 = var_1.SetAchievementList

	nowWorld = var_3

	local var_1_2 = var_3()
	local var_1_3 = var_3.GetAtlas(var_1_2)

	var_1_1(var_1_0, var_3.GetAchEntranceList(var_1_3))

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.WORLD_ACHIEVE_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1
	local var_6_2 = arg_6_1.getBody(var_6_1)

	GAME = var_6_1

	if var_6_0 == var_6_1.WORLD_ACHIEVE_DONE then
		local var_6_3 = arg_6_0.viewComponent
		local var_6_4 = var_4.emit

		BaseUI = var_1_10006

		var_6_4(var_6_3, var_1_10006.ON_ACHIEVE, var_6_2.drops, function()
			local var_7_0 = arg_6_0.viewComponent

			var_0.flushAchieveUpdate(var_7_0, var_6_2.list)

			return
		end)
	end

	return
end

return var_0_1
