class = var_0_10000

local var_0_0 = "LockCommanderCommande"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().commanderId
	local var_1_1 = var_2.flag

	getProxy = var_1_10005
	CommanderProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	if not var_5.getCommanderById(var_1_2, var_1_0) or var_6:getLock() == var_1_1 then
		return
	end

	local function var_1_3()
		pg = var_2_10000

		local var_2_0 = var_2_10000.ConnectionMgr.GetInstance()

		var_0.Send(var_2_0, 25016, {
			commanderid = var_1_0,
			flag = var_1_1
		}, 25017, function(arg_3_0)
			local var_3_3

			if arg_3_0.result == 0 then
				local var_3_0 = var_0

				var_3_3.setLock(var_3_0, var_1_1)

				local var_3_1 = var_0

				var_3_3.updateCommander(var_3_1, var_0)

				local var_3_2 = arg_1_0

				var_3_3 = var_3_3.sendNotification
				GAME = var_3_10004

				var_3_3(var_3_2, var_3_10004.COMMANDER_LOCK_DONE, {
					commander = var_0,
					flag = var_1_1
				})
			else
				pg = var_3_3

				local var_3_4 = var_3_3.TipsMgr.GetInstance()
				local var_3_5 = var_1.ShowTips

				i18n = var_3_10004

				var_3_5(var_3_4, var_3_10004("commander_lock_erro", arg_3_0.result))
			end

			return
		end)

		return
	end

	if var_1_1 == 0 then
		pg = var_1_2

		local var_1_4 = var_1_2.SecondaryPWDMgr.GetInstance()

		var_8.LimitedOperation(var_1_4, var_8.UNLOCK_COMMANDER, var_1_0, var_1_3)
	else
		var_1_3()
	end

	return
end

return var_0_1
