local FinishBluePrintCommand = class("FinishBluePrintCommand", pm.SimpleCommand)

function FinishBluePrintCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = getProxy(TechnologyProxy)
	local var_1_2 = var_1_1:getBluePrintById(var_1_0)

	if not var_1_2 then
		return
	end

	if not var_1_2:isFinished() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(63202, {
		blueprint_id = var_1_0
	}, 63203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = Ship.New(arg_2_0.ship)

			getProxy(BayProxy):addShip(var_2_0)
			var_1_2:unlock(var_2_0.id)
			var_1_1:updateBluePrint(var_1_2)
			self:sendNotification(GAME.FINISH_SHIP_BLUEPRINT_DONE, {
				ship = var_2_0
			})

			if PLATFORM_CODE == PLATFORM_JP and ({
				[6] = true,
				[5] = true
			})[var_1_2:getConfig("blueprint_version")] then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_SHIPWORKS_COMPLETE, var_2_0.configId)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("printblue_build_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

return FinishBluePrintCommand
