local FetchCommanderTalentCommand = class("FetchCommanderTalentCommand", pm.SimpleCommand)

function FetchCommanderTalentCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = getProxy(CommanderProxy)
	local var_1_2 = var_1_1:getCommanderById(var_1_0)

	if not var_1_2 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(25010, {
		commanderid = var_1_0
	}, 25011, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = {}

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.abilityid) do
				table.insert(var_2_0, CommanderTalent.New({
					origin = false,
					id = iter_2_1
				}))
			end

			var_1_2:updateNotLearnedList(var_2_0)
			var_1_1:updateCommander(var_1_2)
			self:sendNotification(GAME.COMMANDER_FETCH_NOT_LEARNED_TALENT_DONE, {
				commander = var_1_2,
				list = var_2_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_get_skills_done") .. arg_2_0.result .. "-" .. var_1_0)
		end

		return
	end)

	return
end

return FetchCommanderTalentCommand
