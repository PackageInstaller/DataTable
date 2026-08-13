class = var_0_10000

local var_0_0 = "TransitionMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.FINISH = "TransitionMediator:FINISH"

function var_0_1.register(arg_1_0)
	return
end

function var_0_1.remove(arg_2_0)
	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.LOAD_SCENE_DONE
	GAME = var_2
	var_3_0[2] = var_2.BEGIN_STAGE_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	GAME = var_4_1

	if var_4_0 == var_4_1.LOAD_SCENE_DONE then
		SCENE = var_4

		if var_4_2 == var_4.TRANSITION then
			arg_4_0.contextData.afterLoadFunc()
		end
	else
		GAME = var_4

		if var_4_0 == var_4.BEGIN_STAGE_DONE then
			getProxy = var_4
			ContextProxy = var_1_10005

			local var_4_3 = var_4(var_1_10005)
			local var_4_4 = var_4.getContextByMediator

			BattleMediator = var_1_10006

			if var_4_4(var_4_3, var_1_10006) then
				getProxy = var_4_3
				ContextProxy = var_1_10006

				local var_4_5 = var_4_3(var_1_10006)

				var_5.RemoveContext(var_4_5, var_4)
			end

			local var_4_6 = arg_4_0
			local var_4_7 = arg_4_0.sendNotification

			GAME = var_1_10007

			local var_4_8 = var_1_10007.CHANGE_SCENE

			SCENE = var_1_10008

			var_4_7(var_4_6, var_4_8, var_1_10008.COMBATLOAD, var_4_2)
		end
	end

	return
end

return var_0_1
