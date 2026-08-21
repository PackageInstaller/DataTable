local var_0_0 = class("", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId

	if not var_1_0 then
		return
	end

	local var_1_1 = getProxy(BayProxy)
	local var_1_2 = var_1_1:getShipById(var_1_0)

	if not var_1_2 then
		return
	end

	local var_1_3, var_1_4 = var_1_2:canUpgradeMaxLevel()

	if not var_1_3 then
		pg.TipsMgr.GetInstance():ShowTips(var_1_4)

		return
	end

	pg.ConnectionMgr.GetInstance():Send(12038, {
		ship_id = var_1_0
	}, 12039, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2:updateMaxLevel((var_1_2:getNextMaxLevel()))
			_.each(var_1_2:getNextMaxLevelConsume(), function(arg_3_0)
				arg_1_0:sendNotification(GAME.CONSUME_ITEM, arg_3_0)

				return
			end)
			var_1_2:addExp(0, true)
			arg_1_0:sendNotification(GAME.UPGRADE_MAX_LEVEL_DONE, {
				oldShip = Clone(var_1_2),
				newShip = var_1_2,
				callback = function()
					var_1_1:updateShip(var_1_2)

					return
				end
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_buildShip_error", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
