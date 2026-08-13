class = var_0_10000

local var_0_0 = "StopBluePrintCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.callback

	getProxy = var_1_10005
	TechnologyProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	if not var_5.getBluePrintById(var_1_2, var_1_0) then
		return
	end

	if not var_6:isDeving() and not var_6:isFinished() then
		return
	end

	pg = var_7

	local var_1_3 = var_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_3, 63206, {
		blueprint_id = var_1_0
	}, 63207, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			pg = var_2_1

			local var_2_0 = var_2_1.TimeMgr.GetInstance()

			var_2_1 = var_2_1.GetServerTime(var_2_0) - var_0.startTime
			var_2_10004 = var_0

			var_2.updateStartUpTime(var_2_10004, var_2_1)

			var_2_10004 = var_0

			var_2.reset(var_2_10004)

			var_2_10004 = var_0

			var_2.updateBluePrint(var_2_10004, var_0)

			var_2_10004 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = var_5

			var_2_2(var_2_10004, var_5.STOP_BLUEPRINT_DONE, {
				id = var_0.id
			})

			if var_1_1 then
				var_1_1()
			end
		else
			pg = var_2_1

			local var_2_3 = var_2_1.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			i18n = var_2_10004

			var_2_4(var_2_3, var_2_10004("technology_stop_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
