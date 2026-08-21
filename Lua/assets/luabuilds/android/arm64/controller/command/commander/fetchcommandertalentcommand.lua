local var_0_0 = class("FetchCommanderTalentCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = getProxy(CommanderProxy)

	if not getProxy(CommanderProxy):getCommanderById(var_1_0) then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(25010, {
		commanderid = var_1_0
	}, 25011, function(arg_2_0)
		if arg_2_0.result == 0 then
			for iter_2_0, iter_2_1 in ipairs(arg_2_0.abilityid) do
				table.insert({}, CommanderTalent.New({
					origin = false,
					id = iter_2_1
				}))
			end

			var_0:updateNotLearnedList({})
			var_1_1:updateCommander(var_0)
			arg_1_0:sendNotification(GAME.COMMANDER_FETCH_NOT_LEARNED_TALENT_DONE, {
				commander = var_0,
				list = {}
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_get_skills_done") .. arg_2_0.result .. "-" .. var_1_0)
		end

		return
	end)

	return
end

return var_0_0
