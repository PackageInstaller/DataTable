class = var_0_10000

local var_0_0 = "UnlockCryptolaliaCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.costType

	getProxy = var_1_10005
	PlayerProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)
	local var_1_3 = var_5.getRawData(var_1_2)
	local var_1_4 = var_5.GetCryptolaliaList(var_1_3)
	local var_1_5

	ipairs = var_1_3

	for iter_1_0, iter_1_1 in var_1_3(var_1_4) do
		if iter_1_1.id == var_1_0 then
			var_1_5 = iter_1_1

			break
		end
	end

	if not var_1_5 or not var_1_5:IsLock() then
		pg = var_8

		local var_1_6 = var_8.TipsMgr.GetInstance()
		local var_1_7 = var_8.ShowTips

		i18n = iter_1_0

		var_1_7(var_1_6, iter_1_0("common_activity_end"))

		return
	end

	if not var_1_5:InTime() then
		pg = var_8

		local var_1_8 = var_8.TipsMgr.GetInstance()
		local var_1_9 = var_8.ShowTips

		i18n = iter_1_0

		var_1_9(var_1_8, iter_1_0("common_activity_end"))

		return
	end

	local var_1_10 = var_1_5:GetCost(var_1_1)
	local var_1_12

	if var_5:getResById(var_1_10.id) < var_1_10.count then
		Cryptolalia = var_1_12

		if var_1_1 == var_1_12.COST_TYPE_TICKET then
			pg = var_1_12

			local var_1_11 = var_1_12.TipsMgr.GetInstance()

			var_1_12 = var_1_12.ShowTips
			i18n = var_1_10013

			var_1_12(var_1_11, var_1_10013("cryptolalia_no_ticket"))
		else
			pg = var_1_12

			local var_1_13 = var_1_12.TipsMgr.GetInstance()

			var_1_12 = var_1_12.ShowTips
			i18n = var_1_10013

			var_1_12(var_1_13, var_1_10013("common_no_resource"))
		end

		return
	end

	pg = var_1_12

	local var_1_14 = var_1_12.ConnectionMgr.GetInstance()

	var_10.Send(var_1_14, 16205, {
		id = var_1_0,
		cost_type = var_1_1
	}, 16206, function(arg_2_0)
		if arg_2_0.ret == 0 then
			getProxy = var_1
			PlayerProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			var_2_10004 = var_1.getData(var_2_0)

			var_1.UnlockCryptolalia(var_2_10004, var_1_0)

			var_2_10004 = var_1

			local var_2_1 = var_1.consume
			local var_2_2 = {}

			id2res = var_2_10006
			var_2_2[var_2_10006(var_1_10.id)] = var_1_10.count

			var_2_1(var_2_10004, var_2_2)

			getProxy = var_2_1
			PlayerProxy = var_2_10004
			var_2_10004 = var_2_1(var_2_10004)

			var_2.updatePlayer(var_2_10004, var_1)

			pg = var_2
			var_2_10004 = var_2.TipsMgr.GetInstance()

			local var_2_3 = var_2.ShowTips

			i18n = var_5

			var_2_3(var_2_10004, var_5("cryptolalia_exchange_success"))

			var_2_10004 = arg_1_0

			local var_2_4 = var_2.sendNotification

			GAME = var_5

			var_2_4(var_2_10004, var_5.UNLOCK_CRYPTOLALIA_DONE, {
				id = var_1_0
			})
		else
			pg = var_1

			local var_2_5 = var_1.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_6(var_2_5, var_2_10004[arg_2_0.ret] .. arg_2_0.ret)
		end

		return
	end)

	return
end

return var_0_1
