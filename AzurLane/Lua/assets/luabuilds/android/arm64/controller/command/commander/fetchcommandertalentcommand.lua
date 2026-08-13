class = var_0_10000

local var_0_0 = "FetchCommanderTalentCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	getProxy = var_1_0
	CommanderProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)

	if not var_4.getCommanderById(var_1_2, var_1_1) then
		return
	end

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 25010, {
		commanderid = var_1_1
	}, 25011, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = {}
			ipairs = var_2_10002

			for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.abilityid) do
				table = var_2_10007
				var_2_10007 = var_2_10007.insert

				local var_2_1 = var_2_0

				CommanderTalent = var_2_10010

				var_2_10007(var_2_1, var_2_10010.New({
					origin = false,
					id = iter_2_1
				}))
			end

			var_2_10004 = var_0

			var_2.updateNotLearnedList(var_2_10004, var_2_0)

			var_2_10004 = var_0

			var_2.updateCommander(var_2_10004, var_0)

			var_2_10004 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = var_5

			var_2_2(var_2_10004, var_5.COMMANDER_FETCH_NOT_LEARNED_TALENT_DONE, {
				commander = var_0,
				list = var_2_0
			})
		else
			pg = var_2_0

			local var_2_3 = var_2_0.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			i18n = var_2_10004

			var_2_4(var_2_3, var_2_10004("commander_get_skills_done") .. arg_2_0.result .. "-" .. var_1_1)
		end

		return
	end)

	return
end

return var_0_1
