local PublicGuildCommitDonateCommand = class("PublicGuildCommitDonateCommand", pm.SimpleCommand)

function PublicGuildCommitDonateCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = getProxy(GuildProxy):GetPublicGuild()
	local var_1_2 = var_1_1:GetDonateTaskById(var_1_0)

	if not var_1_2 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_not_exist_donate_task"))

		return
	end

	if not var_1_2:canCommit() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	if not var_1_1:HasDonateCnt() then
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

			var_1_1:UpdateDonateTasks(var_2_0)
			var_1_1:IncDonateCount()

			local var_2_1 = getProxy(PlayerProxy)
			local var_2_2 = var_2_1:getData()
			local var_2_3 = var_1_2:getConfig("award_contribution")

			var_2_2:addResources({
				guildCoin = var_2_3
			})
			var_2_1:updatePlayer(var_2_2)
			self:sendNotification(GAME.CONSUME_ITEM, Drop.Create((var_1_2:getCommitItem())))

			local var_2_4 = {}

			table.insert(var_2_4, (Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = PlayerConst.ResGuildCoin,
				count = var_2_3
			})))
			self:sendNotification(GAME.PUBLIC_GUILD_COMMIT_DONATE_DONE, {
				awards = var_2_4
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("guild_dissolve_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return PublicGuildCommitDonateCommand
