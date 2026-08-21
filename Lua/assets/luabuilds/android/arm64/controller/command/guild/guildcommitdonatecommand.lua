local var_0_0 = class("GuildCommitDonateCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().taskId
	local var_1_1 = getProxy(GuildProxy)
	local var_1_2 = getProxy(GuildProxy):getData()

	if not var_1_2 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_no_exist"))

		return
	end

	local var_1_3 = var_1_2:getDonateTaskById(var_1_0)

	if not var_1_3 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_not_exist_donate_task"))

		return
	end

	if not var_1_3:canCommit() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	if not var_1_2:canDonate() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_donate_times_not enough"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(62002, {
		id = var_1_0
	}, 62003, function(arg_2_0)
		if arg_2_0.result == 0 then
			for iter_2_0, iter_2_1 in ipairs(arg_2_0.donate_tasks) do
				table.insert({}, (GuildDonateTask.New({
					id = iter_2_1
				})))
			end

			local var_2_0 = getProxy(PlayerProxy)
			local var_2_1 = var_2_0:getData()
			local var_2_2 = var_1_1:getData()

			var_2_2:getMemberById(var_2_1.id):AddLiveness(var_1_3:GetLivenessAddition())
			var_2_2:updateDonateTasks({})
			var_2_2:updateDonateCount()
			var_1_1:updateGuild(var_2_2)

			local var_2_3 = var_1_3:getConfig("award_contribution")

			var_2_1:addResources({
				guildCoin = var_2_3
			})
			var_2_0:updatePlayer(var_2_1)
			arg_1_0:sendNotification(GAME.CONSUME_ITEM, Drop.Create((var_1_3:getCommitItem())))
			table.insert({}, (Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = PlayerConst.ResGuildCoin,
				count = var_2_3
			})))
			arg_1_0:sendNotification(GAME.GUILD_COMMIT_DONATE_DONE, {
				awards = {},
				capital = var_1_3:getConfig("award_capital"),
				techPoint = var_1_3:getConfig("award_tech_exp")
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("guild_dissolve_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
