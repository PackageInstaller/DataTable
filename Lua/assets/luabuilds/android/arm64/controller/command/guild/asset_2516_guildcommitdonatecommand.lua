local GuildCommitDonateCommand = class("GuildCommitDonateCommand", pm.SimpleCommand)

function GuildCommitDonateCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().taskId
	local var_1_1 = getProxy(GuildProxy)
	local var_1_2 = var_1_1:getData()

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
			local var_2_0 = {}

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.donate_tasks) do
				table.insert(var_2_0, (GuildDonateTask.New({
					id = iter_2_1
				})))
			end

			local var_2_1 = getProxy(PlayerProxy)
			local var_2_2 = var_2_1:getData()
			local var_2_3 = var_1_1:getData()

			var_2_3:getMemberById(var_2_2.id):AddLiveness(var_1_3:GetLivenessAddition())
			var_2_3:updateDonateTasks(var_2_0)
			var_2_3:updateDonateCount()
			var_1_1:updateGuild(var_2_3)

			local var_2_4 = var_1_3:getConfig("award_contribution")

			var_2_2:addResources({
				guildCoin = var_2_4
			})
			var_2_1:updatePlayer(var_2_2)
			self:sendNotification(GAME.CONSUME_ITEM, Drop.Create((var_1_3:getCommitItem())))

			local var_2_5 = {}

			table.insert(var_2_5, (Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = PlayerConst.ResGuildCoin,
				count = var_2_4
			})))
			self:sendNotification(GAME.GUILD_COMMIT_DONATE_DONE, {
				awards = var_2_5,
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

return GuildCommitDonateCommand
