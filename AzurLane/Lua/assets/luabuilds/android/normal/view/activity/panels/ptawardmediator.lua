class = var_0_10000

local var_0_0 = "PtAwardMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	ActivityMediator = var_1_10003

	var_1_1(var_1_0, var_1_10003.EVENT_PT_OPERATION, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.ACT_NEW_PT, arg_2_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	ActivityProxy = var_1_10002
	var_3_0[1] = var_1_10002.ACTIVITY_UPDATED
	GAME = var_2
	var_3_0[2] = var_2.ACT_NEW_PT_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	if var_4_0 == nil then
		goto label_4_0
	end

	ActivityProxy = var_4_1

	if var_4_0 ~= var_4_1.ACTIVITY_ADDED then
		ActivityProxy = var_4_4

		do
			local var_4_4

			if var_4_0 == var_4_4.ACTIVITY_UPDATED then
				local var_4_3 = var_4_2

				var_4_4 = var_4_2.getConfig(var_4_3, "type")
				ActivityConst = var_4_3

				if var_4_4 == var_4_3.ACTIVITY_TYPE_PT_BUFF and var_4_2:getDataConfig("pt") == arg_4_0.contextData.ptId then
					local var_4_5

					if arg_4_0.contextData.ptData then
						var_4_5 = arg_4_0.contextData.ptData

						var_4_4.Update(var_4_5, var_4_2)
					else
						var_4_4 = arg_4_0.contextData
						ActivityBossPtData = var_4_5
						var_4_4.ptData = var_4_5.New(var_4_2)
					end

					local var_4_6 = arg_4_0.viewComponent

					var_4_4.UpdateView(var_4_6)
				end
			else
				GAME = var_4_4

				if var_4_0 == var_4_4.ACT_NEW_PT_DONE then
					local var_4_7 = arg_4_0.viewComponent
					local var_4_8 = var_4.emit

					BaseUI = var_1_10006

					var_4_8(var_4_7, var_1_10006.ON_ACHIEVE, var_4_2.awards)
				end
			end
		end

		::label_4_0::

		return
	end
end

function var_0_1.remove(arg_5_0)
	return
end

return var_0_1
