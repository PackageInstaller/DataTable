class = var_0_10000

local var_0_0 = "CommanderCatteryOPCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).op

	getProxy = var_1_0
	CommanderProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.GetCommanderHome(var_1_2)

	pg = var_1_10005

	local var_1_4 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_4, 25028, {
		type = var_1_1
	}, 25029, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			PlayerConst = var_2_0
			var_2_0 = var_2_0.addTranDrop(arg_2_0.awards)

			local var_2_1 = 0
			local var_2_2 = 0

			var_2_10004 = {}

			if var_1_1 == 1 then
				local var_2_3 = var_1_3

				var_5.IncCleanValue(var_2_3)
			elseif var_1_1 == 2 then
				local var_2_4 = arg_1_0

				var_2_10004 = var_5.AddCommanderExpByFeed(var_2_4)
			elseif var_1_1 == 3 then
				-- block empty
			end

			local var_2_5 = var_1_3
			local var_2_6 = var_5.GetCatteries(var_2_5)
			local var_2_7 = {}

			pairs = var_2_5

			for iter_2_0, iter_2_1 in var_2_5(var_2_6) do
				if iter_2_1:ExistOP(var_1_1) and iter_2_1:CommanderCanOP(var_1_1) then
					local var_2_8 = iter_2_1:GetCommander()

					iter_2_1:ClearOP(var_1_1)

					local var_2_9 = var_2_8

					var_2_8.UpdateHomeOpTime(var_2_9, var_1_1, arg_2_0.op_time)

					getProxy = var_13
					CommanderProxy = var_2_9

					local var_2_10 = var_13(var_2_9)

					var_13.updateCommander(var_2_10, var_2_8)

					table = var_13

					var_13.insert(var_2_7, iter_2_1.id)
				end
			end

			Clone = var_7

			local var_2_11 = var_7(var_1_3)
			local var_2_12 = var_1_3

			var_8.UpdateExpAndLevel(var_2_12, arg_2_0.level, arg_2_0.exp)

			if var_1_3.level > var_2_11.level then
				var_2_2 = var_2_11:GetNextLevelExp() - var_2_11.exp + var_1_3.exp
			else
				var_2_2 = var_1_3.exp - var_2_11.exp
			end

			local var_2_13 = arg_1_0
			local var_2_14 = var_8.sendNotification

			GAME = var_11

			var_2_14(var_2_13, var_11.COMMANDER_CATTERY_OP_DONE, {
				awards = var_2_0,
				cmd = var_1_1,
				opCatteries = var_2_7,
				commanderExps = var_2_10004,
				homeExp = var_2_2
			})
		else
			pg = var_2_0

			local var_2_15 = var_2_0.TipsMgr.GetInstance()
			local var_2_16 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_16(var_2_15, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

function var_0_1.AddCommanderExpByFeed(arg_3_0)
	local var_3_0 = {}

	local function var_3_1(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_0:GetCommanderId()

		getProxy = var_2_10003
		CommanderProxy = var_2_10005

		local var_4_1 = var_2_10003(var_2_10005)
		local var_4_2 = var_3.getCommanderById(var_4_1, var_4_0)

		if var_4.isMaxLevel(var_4_2) then
			arg_4_1 = 0
		end

		var_4:addExp(arg_4_1)

		if not var_5 and var_4:isMaxLevel() then
			arg_4_1 = arg_4_1 - var_4.exp
		end

		table = var_6

		var_6.insert(var_3_0, {
			id = arg_4_0.id,
			value = arg_4_1
		})
		var_3:updateCommander(var_4)

		return
	end

	getProxy = var_1_10003
	CommanderProxy = var_1_10005

	local var_3_2 = var_1_10003(var_1_10005)
	local var_3_3 = var_3.GetCommanderHome(var_3_2)
	local var_3_4 = var_3.GetCatteries(var_3_3)
	local var_3_5 = var_3:getConfig("feed_level")[2]

	pairs = var_3_3

	for iter_3_0, iter_3_1 in var_3_3(var_3_4) do
		if iter_3_1:ExistCommander() and iter_3_1:ExiseFeedOP() then
			var_3_1(iter_3_1, var_3_5)
		end
	end

	return var_3_0
end

return var_0_1
