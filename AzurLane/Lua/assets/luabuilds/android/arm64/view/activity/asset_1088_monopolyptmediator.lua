class = var_0_10000

local var_0_0 = "MonopolyPtMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	local var_2_0 = {}

	ActivityProxy = var_1_10002
	var_2_0[1] = var_1_10002.ACTIVITY_UPDATED
	ActivityProxy = var_2
	var_2_0[2] = var_2.ACTIVITY_ADDED
	GAME = var_2
	var_2_0[3] = var_2.ACT_NEW_PT_DONE
	GAME = var_2
	var_2_0[4] = var_2.BEGIN_STAGE_DONE

	return var_2_0
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1
	local var_3_2 = arg_3_1.getBody(var_3_1)
	local var_3_3 = arg_3_1:getType()

	ActivityProxy = var_3_1

	if var_3_0 ~= var_3_1.ACTIVITY_UPDATED then
		ActivityProxy = var_5

		if var_3_0 == var_5.ACTIVITY_ADDED then
			arg_3_0:updateGameUI(var_3_2)
		else
			GAME = var_5

			local var_3_5

			if var_3_0 == var_5.ACT_NEW_PT_DONE then
				local var_3_4 = arg_3_0.viewComponent

				var_3_5 = var_3_5.emit
				BaseUI = var_1_10008

				var_3_5(var_3_4, var_1_10008.ON_ACHIEVE, var_3_2.awards, var_3_2.callback)
			else
				GAME = var_3_5

				if var_3_0 == var_3_5.BEGIN_STAGE_DONE then
					local var_3_6 = arg_3_0
					local var_3_7 = arg_3_0.sendNotification

					GAME = var_1_10008

					local var_3_8 = var_1_10008.GO_SCENE

					SCENE = var_1_10009

					var_3_7(var_3_6, var_3_8, var_1_10009.COMBATLOAD, var_3_2)
				end
			end
		end

		return
	end
end

function var_0_1.updateGameUI(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.viewComponent

	var_2.updataActivity(var_4_0, arg_4_1)

	return
end

function var_0_1.remove(arg_5_0)
	return
end

return var_0_1
