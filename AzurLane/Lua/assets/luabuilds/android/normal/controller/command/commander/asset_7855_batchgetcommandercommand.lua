class = var_0_10000

local var_0_0 = "BatchGetCommanderCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().boxIds
	local var_1_1 = {}
	local var_1_2 = {}
	local var_1_3 = {}

	ipairs = var_1_10007

	for iter_1_0, iter_1_1 in var_1_10007(var_1_0) do
		table = var_1_10012

		var_1_10012.insert(var_1_3, function(arg_2_0)
			local var_2_0 = arg_1_0

			if var_1.CheckFullCapacity(var_2_0) then
				arg_2_0()

				return
			end

			local var_2_1 = arg_1_0
			local var_2_2 = var_1.sendNotification

			GAME = var_2_10003

			var_2_2(var_2_1, var_2_10003.COMMANDER_ON_OPEN_BOX, {
				notify = false,
				id = iter_1_1,
				callback = function(arg_3_0)
					if arg_3_0 then
						table = var_3_10001

						var_3_10001.insert(var_1_1, arg_3_0)

						table = var_1

						var_1.insert(var_1_2, iter_1_1)
					end

					arg_2_0()

					return
				end
			})

			return
		end)
	end

	seriesAsync = var_7

	var_7(var_1_3, function()
		local var_4_0 = arg_1_0
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10002

		var_4_1(var_4_0, var_2_10002.COMMANDER_ON_BATCH_DONE, {
			boxIds = var_1_2,
			commanders = var_1_1
		})

		return
	end)

	return
end

function var_0_1.CheckFullCapacity(arg_5_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_5_0 = var_1_10001(var_1_10002)
	local var_5_1 = var_1.getRawData(var_5_0).commanderBagMax

	getProxy = var_1_10003
	CommanderProxy = var_1_10004

	local var_5_2 = var_1_10003(var_1_10004)

	if var_5_1 <= var_3.getCommanderCnt(var_5_2) then
		return true
	end

	return false
end

return var_0_1
