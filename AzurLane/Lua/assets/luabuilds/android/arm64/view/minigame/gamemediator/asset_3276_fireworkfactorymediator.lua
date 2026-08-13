class = var_0_10000

local var_0_0 = "FireworkFactoryMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MiniHubMediator"))

function var_0_1.handleNotification(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getName(var_1_0)
	local var_1_2 = arg_1_1
	local var_1_3 = arg_1_1.getBody(var_1_2)

	MiniGameProxy = var_1_0

	if var_1_1 == var_1_0.ON_HUB_DATA_UPDATE then
		local var_1_4 = arg_1_0.viewComponent

		var_4.SetMGHubData(var_1_4, var_1_3)
	else
		GAME = var_4

		local var_1_5

		if var_1_1 == var_4.SEND_MINI_GAME_OP_DONE then
			var_1_5 = var_1_3.cmd
			MiniGameOPCommand = var_1_2

			if var_1_5 == var_1_2.CMD_COMPLETE then
				var_1_5 = var_1_3.argList

				local var_1_6 = var_1_3.cmd
				local var_1_7 = {
					function(arg_2_0)
						getProxy = var_2_10001
						MiniGameProxy = var_2_10003

						local var_2_0 = var_2_10001(var_2_10003)
						local var_2_1 = var_1.GetMiniGameData

						MiniGameDataCreator = var_2_10004

						local var_2_2 = var_2_1(var_2_0, var_2_10004.ShrineGameID)
						local var_2_3

						if not var_1.GetRuntimeData(var_2_2, "count") then
							var_2_3 = 0
						end

						local var_2_4 = var_2_3 + 1
						local var_2_5 = arg_1_0
						local var_2_6 = var_3.sendNotification

						GAME = var_2_10006

						local var_2_7 = var_2_10006.MODIFY_MINI_GAME_DATA
						local var_2_8 = {}

						MiniGameDataCreator = var_2_10008
						var_2_8.id = var_2_10008.ShrineGameID
						var_2_8.map = {
							count = var_2_4
						}

						var_2_6(var_2_5, var_2_7, var_2_8)
						arg_2_0()

						return
					end,
					function(arg_3_0)
						if #var_1_3.awards > 0 then
							local var_3_0 = arg_1_0.viewComponent
							local var_3_1 = var_2.emit

							BaseUI = var_2_10005

							var_3_1(var_3_0, var_2_10005.ON_ACHIEVE, var_1, arg_3_0)
						else
							arg_3_0()
						end

						return
					end,
					function(arg_4_0)
						local var_4_0 = arg_1_0.viewComponent

						var_1.OnGetAwardDone(var_4_0, var_1_3)

						return
					end
				}

				seriesAsync = var_7

				var_7(var_1_7)

				local var_1_8 = arg_1_0.viewComponent

				var_7.OnSendMiniGameOPDone(var_1_8, var_1_3)

				goto label_1_0
			end
		end

		GAME = var_1_5

		if var_1_1 == var_1_5.MODIFY_MINI_GAME_DATA_DONE then
			local var_1_9 = arg_1_0.viewComponent

			var_4.OnModifyMiniGameDataDone(var_1_9, var_1_3)
		else
			var_0_1.super.handleNotification(arg_1_0, arg_1_1)
		end
	end

	::label_1_0::

	return
end

return var_0_1
