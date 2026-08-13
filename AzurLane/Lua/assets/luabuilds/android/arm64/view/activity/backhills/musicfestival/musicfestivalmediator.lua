class = var_0_10000

local var_0_0 = "MusicFestivalMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..TemplateMV.BackHillMediatorTemplate"))

function var_0_1.listNotificationInterests(arg_1_0)
	local var_1_0 = {}

	GAME = var_1_10002
	var_1_0[1] = var_1_10002.SEND_MINI_GAME_OP_DONE
	GAME = var_2
	var_1_0[2] = var_2.ACT_INSTAGRAM_OP_DONE
	ActivityProxy = var_2
	var_1_0[3] = var_2.ACTIVITY_UPDATED

	return var_1_0
end

function var_0_1.handleNotification(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1
	local var_2_1 = arg_2_1.getName(var_2_0)
	local var_2_2 = arg_2_1:getBody()

	GAME = var_2_0

	local var_2_3

	if var_2_1 == var_2_0.SEND_MINI_GAME_OP_DONE then
		var_2_3 = {
			function(arg_3_0)
				if #var_2_2.awards > 0 then
					local var_3_0 = arg_2_0.viewComponent
					local var_3_1 = var_2.emit

					BaseUI = var_2_10005

					var_3_1(var_3_0, var_2_10005.ON_ACHIEVE, var_1, arg_3_0)
				else
					arg_3_0()
				end

				return
			end,
			function(arg_4_0)
				local var_4_0 = arg_2_0.viewComponent

				var_1.UpdateView(var_4_0)

				return
			end
		}
		seriesAsync = var_5

		var_5(var_2_3)

		goto label_2_0
	end

	GAME = var_2_3

	if var_2_1 ~= var_2_3.ACT_INSTAGRAM_OP_DONE then
		ActivityProxy = var_4

		if var_2_1 == var_4.ACTIVITY_UPDATED then
			local var_2_4 = arg_2_0.viewComponent

			var_4.UpdateView(var_2_4)
		end

		::label_2_0::

		return
	end
end

return var_0_1
