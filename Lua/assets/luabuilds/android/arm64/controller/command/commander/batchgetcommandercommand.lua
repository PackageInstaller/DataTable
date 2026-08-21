local var_0_0 = class("BatchGetCommanderCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = {}
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1:getBody().boxIds) do
		table.insert({}, function(arg_2_0)
			if arg_1_0:CheckFullCapacity() then
				arg_2_0()

				return
			end

			arg_1_0:sendNotification(GAME.COMMANDER_ON_OPEN_BOX, {
				notify = false,
				id = iter_1_1,
				callback = function(arg_3_0)
					if arg_3_0 then
						table.insert(var_1_0, arg_3_0)
						table.insert(var_1_1, iter_1_1)
					end

					arg_2_0()

					return
				end
			})

			return
		end)
	end

	seriesAsync({}, function()
		arg_1_0:sendNotification(GAME.COMMANDER_ON_BATCH_DONE, {
			boxIds = var_1_1,
			commanders = var_1_0
		})

		return
	end)

	return
end

function var_0_0.CheckFullCapacity(arg_5_0)
	local var_5_9000
	local var_5_0 = getProxy(PlayerProxy)

	if var_5_0.getRawData(var_5_9000).commanderBagMax <= getProxy(CommanderProxy).getCommanderCnt(var_5_0) then
		return true
	end

	return false
end

return var_0_0
