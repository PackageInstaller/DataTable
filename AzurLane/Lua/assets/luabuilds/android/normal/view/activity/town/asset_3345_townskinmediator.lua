class = var_0_10000

local var_0_0 = "TownSkinMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.UnlockStoryDone = "TownSkinMediator.UnlockStoryDone"

function var_0_1.register(arg_1_0)
	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	local var_2_0 = {
		var_0_1.UnlockStoryDone
	}

	ActivityProxy = var_2
	var_2_0[2] = var_2.ACTIVITY_UPDATED
	GAME = var_2
	var_2_0[3] = var_2.ACTIVITY_STORYUNLOCKED_DONE

	return var_2_0
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1
	local var_3_2 = arg_3_1.getBody(var_3_1)

	GAME = var_3_1

	if var_3_0 == var_3_1.ACTIVITY_STORYUNLOCKED_DONE then
		local var_3_3 = arg_3_0.viewComponent

		var_4.UpdataStoryState(var_3_3, var_3_2)
	else
		ActivityProxy = var_4

		if var_3_0 == var_4.ACTIVITY_UPDATED then
			local var_3_4 = var_3_2
			local var_3_5 = var_3_2.getConfig(var_3_4, "type")

			ActivityConst = var_3_4

			if var_3_5 == var_3_4.ACTIVITY_TYPE_TownSkinStory then
				local var_3_6 = arg_3_0.viewComponent

				var_4.UpdateItemView(var_3_6, var_3_2)
			end
		end
	end

	return
end

return var_0_1
