local GetCommanderCommand = class("GetCommanderCommand", pm.SimpleCommand)

function GetCommanderCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.callback
	local var_1_3 = defaultValue(var_1_0.notify, true)
	local var_1_4 = getProxy(CommanderProxy)
	local var_1_5 = var_1_4:getBoxById(var_1_0.id)

	if getProxy(PlayerProxy):getRawData().commanderBagMax <= var_1_4:getCommanderCnt() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("commander_capcity_is_max"))

		if var_1_0.callback then
			var_1_0.callback()
		end

		return
	end

	if var_1_5:getState() ~= CommanderBox.STATE_FINISHED then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(25004, {
		boxid = var_1_0.id
	}, 25005, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = Commander.New(arg_2_0.commander)

			var_1_4:addCommander(var_2_0)
			var_1_5:finish()

			if var_1_3 then
				self:sendNotification(GAME.COMMANDER_ON_OPEN_BOX_DONE, {
					commander = var_2_0:clone(),
					boxId = var_1_1,
					callback = var_1_2
				})
			elseif var_1_2 then
				var_1_2(var_2_0)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_acquire_erro", arg_2_0.result))

			if var_1_2 then
				var_1_2()
			end
		end

		return
	end)

	return
end

return GetCommanderCommand
