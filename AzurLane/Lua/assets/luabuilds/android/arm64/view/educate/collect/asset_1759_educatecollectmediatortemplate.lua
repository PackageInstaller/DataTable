class = var_0_10000

local var_0_0 = "EducateCollectMediatorTemplate"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.EducateContextMediator"))

var_0_1.UNLOCK = "EducateCollectMediatorTemplate.UNLOCK"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.UNLOCK, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.EDUCATE_BUY_COLLECT, {
			type = arg_2_1.type,
			id = arg_2_1.id,
			cost = arg_2_1.cost
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	EducateProxy = var_1_10002
	var_3_0[1] = var_1_10002.CLEAR_NEW_TIP
	GAME = var_2
	var_3_0[2] = var_2.EDUCATE_BUY_COLLECT_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1
	local var_4_3 = arg_4_1.getBody(var_4_2)

	EducateProxy = var_4_0

	if var_4_1 == var_4_0.CLEAR_NEW_TIP then
		local var_4_4 = var_4_3.index

		EducateTipHelper = var_4_2

		if var_4_4 ~= var_4_2.NEW_MEMORY then
			var_4_4 = var_4_3.index
			EducateTipHelper = var_5

			if var_4_4 == var_5.NEW_POLAROID then
				local var_4_5 = arg_4_0.viewComponent

				var_4_4.Flush(var_4_5)

				goto label_4_0

				GAME = var_4_4

				if var_4_1 == var_4_4.EDUCATE_BUY_COLLECT_DONE then
					local var_4_6 = arg_4_0.viewComponent

					var_4.Flush(var_4_6)
				end
			end

			::label_4_0::

			return
		end
	end
end

return var_0_1
