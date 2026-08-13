class = var_0_10000

local var_0_0 = "ReserveCommanderBoxCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().count

	getProxy = var_1_10004
	CommanderProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.getBoxUseCnt(var_1_1)

	CommanderConst = var_1_1

	local var_1_3

	if var_1_2 == var_1_1.MAX_GETBOX_CNT then
		pg = var_1_3
		var_1_10007 = var_1_3.TipsMgr.GetInstance()
		var_1_3 = var_1_3.ShowTips
		i18n = var_1_10008

		var_1_3(var_1_10007, var_1_10008("commander_reserve_count_is_max"))

		return
	end

	getProxy = var_1_3
	PlayerProxy = var_1_10007

	local var_1_4 = var_1_3(var_1_10007)
	local var_1_5 = var_6.getData(var_1_4)
	local var_1_6 = 0

	for iter_1_0 = var_1_2, var_1_2 + var_1_0 - 1 do
		CommanderConst = var_1_10013
		var_1_6 = var_1_6 + var_1_10013.getBoxComsume(iter_1_0)
	end

	local var_1_8

	if var_1_5.gold < var_1_6 then
		pg = var_1_8

		local var_1_7 = var_1_8.TipsMgr.GetInstance()

		var_1_8 = var_1_8.ShowTips
		i18n = var_11

		var_1_8(var_1_7, var_11("common_no_resource"))

		return
	end

	pg = var_1_8

	local var_1_9 = var_1_8.ConnectionMgr.GetInstance()

	var_9.Send(var_1_9, 25018, {
		type = var_1_0
	}, 25019, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_5

			var_2_2.consume(var_2_0, {
				gold = var_1_6
			})

			local var_2_1 = var_0

			var_2_2.updatePlayer(var_2_1, var_1_5)

			PlayerConst = var_2_2
			var_2_2 = var_2_2.addTranDrop(arg_2_0.awards)
			var_2_10003 = var_0

			var_2.updateBoxUseCnt(var_2_10003, var_1_0)

			var_2_10003 = arg_1_0

			local var_2_3 = var_2.sendNotification

			GAME = var_4

			var_2_3(var_2_10003, var_4.COMMANDER_RESERVE_BOX_DONE, {
				awards = var_2_2
			})
		else
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			i18n = var_2_10003

			var_2_5(var_2_4, var_2_10003("commander_lock_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
