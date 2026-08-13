class = var_0_10000

local var_0_0 = "ShootingGameMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MiniHubMediator"))

function var_0_1.handleNotification(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getName(var_1_0)
	local var_1_2 = arg_1_1
	local var_1_3 = arg_1_1.getBody(var_1_2)

	GAME = var_1_0

	if var_1_1 == var_1_0.SEND_MINI_GAME_OP_DONE then
		local var_1_4 = var_1_3.cmd

		MiniGameOPCommand = var_1_2

		if var_1_4 == var_1_2.CMD_COMPLETE then
			local var_1_5 = {
				function(arg_2_0)
					if #var_1_3.awards > 0 then
						local var_2_0 = arg_1_0.viewComponent
						local var_2_1 = var_2.emit

						BaseUI = var_2_10005

						var_2_1(var_2_0, var_2_10005.ON_ACHIEVE, var_1, arg_2_0)
					else
						arg_2_0()
					end

					return
				end,
				function(arg_3_0)
					local var_3_0 = arg_1_0.viewComponent

					var_1.OnGetAwardDone(var_3_0, var_1_3)
					arg_3_0()

					return
				end
			}
			local var_1_6 = arg_1_0.viewComponent

			var_5.updateAfterFinish(var_1_6)

			local var_1_7 = arg_1_0.viewComponent

			var_5.showResultPanel(var_1_7, var_1_3.awards, function()
				seriesAsync = var_2_10000

				var_2_10000(var_1_5)

				local var_4_0 = arg_1_0.viewComponent

				var_0.OnSendMiniGameOPDone(var_4_0, var_1_3)

				return
			end)

			goto label_1_0
		end
	end

	var_0_1.super.handleNotification(arg_1_0, arg_1_1)

	::label_1_0::

	return
end

return var_0_1
