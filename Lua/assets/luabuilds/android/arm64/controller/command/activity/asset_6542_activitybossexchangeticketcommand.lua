local ActivityBossExchangeTicketCommand = class("ActivityBossExchangeTicketCommand", pm.SimpleCommand)

function ActivityBossExchangeTicketCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().stageId

	if not var_1_0 then
		return
	end

	local var_1_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

	if not var_1_1 or var_1_1:isEnd() then
		return
	end

	local var_1_2 = pg.activity_event_worldboss[var_1_1:getConfig("config_id")]

	if not var_1_2 then
		return
	end

	local var_1_3 = var_1_2.ticket

	if getProxy(PlayerProxy):getRawData():getResource(var_1_2.ticket) <= 0 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 1,
		activity_id = var_1_1.id,
		arg1 = var_1_0,
		arg_list = {}
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(PlayerProxy):getRawData():consume({
				[id2res(var_1_3)] = 1
			})
			self:sendNotification(GAME.ACT_BOSS_NORMAL_UPDATE, {
				num = 1,
				stageId = var_1_0
			})
			self:sendNotification(GAME.ACT_BOSS_EXCHANGE_TICKET_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return ActivityBossExchangeTicketCommand
