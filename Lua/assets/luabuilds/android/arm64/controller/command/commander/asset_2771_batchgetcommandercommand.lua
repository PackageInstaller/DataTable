local BatchGetCommanderCommand = class("BatchGetCommanderCommand", pm.SimpleCommand)

function BatchGetCommanderCommand:execute(arg_1_1)
	local var_1_0 = {}
	local var_1_1 = {}
	local var_1_2 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1:getBody().boxIds) do
		table.insert(var_1_2, function(arg_2_0)
			if self:CheckFullCapacity() then
				arg_2_0()

				return
			end

			self:sendNotification(GAME.COMMANDER_ON_OPEN_BOX, {
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

	seriesAsync(var_1_2, function()
		self:sendNotification(GAME.COMMANDER_ON_BATCH_DONE, {
			boxIds = var_1_1,
			commanders = var_1_0
		})

		return
	end)

	return
end

function BatchGetCommanderCommand:CheckFullCapacity()
	local var_5_0 = getProxy(PlayerProxy)

	if var_5_0:getRawData().commanderBagMax <= getProxy(CommanderProxy).getCommanderCnt(var_5_0) then
		return true
	end

	return false
end

return BatchGetCommanderCommand
