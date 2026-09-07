local ResetCommanderTalentsCommand = class("ResetCommanderTalentsCommand", pm.SimpleCommand)

function ResetCommanderTalentsCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = getProxy(CommanderProxy)
	local var_1_2 = var_1_1:getCommanderById(var_1_0)

	if not var_1_2 then
		return
	end

	if pg.TimeMgr.GetInstance():GetServerTime() < var_1_2:GetNextResetAbilityTime() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("commander_reset_talent_time_no_rearch"))

		return
	end

	local var_1_3 = var_1_2:getTalentOrigins()
	local var_1_4 = var_1_2:getTalents()

	if #var_1_3 == #var_1_4 and _.all(var_1_3, function(arg_2_0)
		return _.any(var_1_4, function(arg_3_0)
			return arg_3_0.id == arg_2_0.id
		end)
	end) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("commander_reset_talent_is_not_need"))

		return
	end

	local var_1_5 = getProxy(PlayerProxy)
	local var_1_6 = var_1_5:getData()
	local var_1_7 = var_1_2:getResetTalentConsume()

	if var_1_7 > var_1_6.gold then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(25014, {
		commanderid = var_1_0
	}, 25015, function(arg_4_0)
		if arg_4_0.result == 0 then
			var_1_6:consume({
				gold = var_1_7
			})
			var_1_5:updatePlayer(var_1_6)
			var_1_2:resetTalents()
			var_1_2:updatePt(0)
			var_1_2:updateNotLearnedList({})
			var_1_1:updateCommander(var_1_2)
			var_1_2:updateAbilityTime(pg.TimeMgr.GetInstance():GetServerTime())
			self:sendNotification(GAME.COMMANDER_RESET_TALENTS_DONE)
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_reset_talent_success"))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_reset_talent_erro", arg_4_0.result))
		end

		return
	end)

	return
end

return ResetCommanderTalentsCommand
