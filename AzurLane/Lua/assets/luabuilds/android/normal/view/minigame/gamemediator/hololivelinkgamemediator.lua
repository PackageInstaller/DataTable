class = var_0_10000

local var_0_0 = "HoloLiveLinkGameMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MiniHubMediator"))

function var_0_1.handleNotification(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getName()
	local var_1_1 = arg_1_1
	local var_1_2 = arg_1_1.getBody(var_1_1)

	GAME = var_1_1

	if var_1_0 == var_1_1.SEND_MINI_GAME_OP_DONE then
		local var_1_3 = var_1_2.cmd

		MiniGameOPCommand = var_1_10005

		if var_1_3 == var_1_10005.CMD_COMPLETE then
			local var_1_4 = {
				function(arg_2_0)
					if #var_1_2.awards > 0 then
						local var_2_0 = arg_1_0.viewComponent
						local var_2_1 = var_2.emit

						BaseUI = var_2_10004

						var_2_1(var_2_0, var_2_10004.ON_ACHIEVE, var_1, arg_2_0)
					else
						arg_2_0()
					end

					return
				end,
				function(arg_3_0)
					local var_3_0 = arg_1_0.viewComponent

					var_1.playStory(var_3_0)

					return
				end
			}

			seriesAsync = var_5

			var_5(var_1_4)

			goto label_1_0
		end
	end

	var_0_1.super.handleNotification(arg_1_0, arg_1_1)

	::label_1_0::

	return
end

return var_0_1
