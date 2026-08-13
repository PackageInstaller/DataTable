class = var_0_10000

local var_0_0 = ""

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1

	if not arg_1_1.getBody(var_1_0).shipId then
		return
	end

	getProxy = var_1_0
	BayProxy = var_1_10006

	local var_1_1 = var_1_0(var_1_10006)

	if not var_4.getShipById(var_1_1, var_3) then
		return
	end

	local var_1_2 = var_5
	local var_1_3, var_1_4 = var_5.canUpgradeMaxLevel(var_1_2)

	if not var_1_3 then
		pg = var_1_2

		local var_1_5 = var_1_2.TipsMgr.GetInstance()

		var_1_2.ShowTips(var_1_5, var_1_4)

		return
	end

	pg = var_1_2

	local var_1_6 = var_1_2.ConnectionMgr.GetInstance()

	var_8.Send(var_1_6, 12038, {
		ship_id = var_3
	}, 12039, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			Clone = var_2_0
			var_2_0 = var_2_0(var_0)
			var_2_10004 = var_0

			local var_2_1 = var_2.getNextMaxLevelConsume(var_2_10004)
			local var_2_2 = var_0
			local var_2_3 = var_3.getNextMaxLevel(var_2_2)
			local var_2_4 = var_0

			var_2_10004.updateMaxLevel(var_2_4, var_2_3)

			_ = var_2_10004

			var_2_10004.each(var_2_1, function(arg_3_0)
				local var_3_0 = arg_1_0
				local var_3_1 = var_1.sendNotification

				GAME = var_3_10004

				var_3_1(var_3_0, var_3_10004.CONSUME_ITEM, arg_3_0)

				return
			end)

			local var_2_5 = var_0

			var_2_10004.addExp(var_2_5, 0, true)

			local var_2_6 = arg_1_0

			var_2_10004 = var_2_10004.sendNotification
			GAME = var_7

			var_2_10004(var_2_6, var_7.UPGRADE_MAX_LEVEL_DONE, {
				oldShip = var_2_0,
				newShip = var_0,
				callback = function()
					local var_4_0 = var_0

					var_0.updateShip(var_4_0, var_0)

					return
				end
			})
		else
			pg = var_2_0

			local var_2_7 = var_2_0.TipsMgr.GetInstance()
			local var_2_8 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_8(var_2_7, var_2_10004("ship_buildShip_error", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
