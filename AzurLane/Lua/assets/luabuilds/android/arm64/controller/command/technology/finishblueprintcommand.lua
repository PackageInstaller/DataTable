class = var_0_10000

local var_0_0 = "FinishBluePrintCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	getProxy = var_1_0
	TechnologyProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)

	if not var_4.getBluePrintById(var_1_2, var_1_1) then
		return
	end

	if not var_5:isFinished() then
		return
	end

	pg = var_6

	local var_1_3 = var_6.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 63202, {
		blueprint_id = var_1_1
	}, 63203, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			Ship = var_2_0
			var_2_0 = var_2_0.New(arg_2_0.ship)
			getProxy = var_2_10002
			BayProxy = var_2_10004

			local var_2_1 = var_2_10002(var_2_10004)

			var_2.addShip(var_2_1, var_2_0)

			local var_2_2 = var_0

			var_3.unlock(var_2_2, var_2_0.id)

			local var_2_3 = var_0

			var_3.updateBluePrint(var_2_3, var_0)

			local var_2_4 = arg_1_0
			local var_2_5 = var_3.sendNotification

			GAME = var_6

			var_2_5(var_2_4, var_6.FINISH_SHIP_BLUEPRINT_DONE, {
				ship = var_2_0
			})

			local var_2_6 = {
				[6] = true,
				[5] = true
			}

			PLATFORM_CODE = var_2_10004
			PLATFORM_JP = var_2_4

			if var_2_10004 == var_2_4 then
				local var_2_7 = var_0

				if var_2_6[var_2_10004.getConfig(var_2_7, "blueprint_version")] then
					pg = var_2_10004

					local var_2_8 = var_2_10004.TrackerMgr.GetInstance()

					var_2_10004 = var_2_10004.Tracking
					TRACKING_SHIPWORKS_COMPLETE = var_7

					var_2_10004(var_2_8, var_7, var_2_0.configId)
				end
			end
		else
			pg = var_2_0

			local var_2_9 = var_2_0.TipsMgr.GetInstance()
			local var_2_10 = var_1.ShowTips

			i18n = var_2_10004

			var_2_10(var_2_9, var_2_10004("printblue_build_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
