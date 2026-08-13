class = var_0_10000

local var_0_0 = "PublicGuildCommitDonateCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	getProxy = var_1_0
	GuildProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.GetPublicGuild(var_1_2)

	if not var_5.GetDonateTaskById(var_1_3, var_1_1) then
		pg = var_1_2

		local var_1_4 = var_1_2.TipsMgr.GetInstance()
		local var_1_5 = var_7.ShowTips

		i18n = var_1_10010

		var_1_5(var_1_4, var_1_10010("guild_not_exist_donate_task"))

		return
	end

	if not var_6:canCommit() then
		pg = var_7

		local var_1_6 = var_7.TipsMgr.GetInstance()
		local var_1_7 = var_7.ShowTips

		i18n = var_1_10010

		var_1_7(var_1_6, var_1_10010("common_no_resource"))

		return
	end

	local var_1_9

	if not var_5:HasDonateCnt() then
		pg = var_1_9

		local var_1_8 = var_1_9.TipsMgr.GetInstance()

		var_1_9 = var_1_9.ShowTips
		i18n = var_1_10010

		var_1_9(var_1_8, var_1_10010("guild_donate_times_not enough"))

		return
	end

	pg = var_1_9

	local var_1_10 = var_1_9.ConnectionMgr.GetInstance()

	var_7.Send(var_1_10, 62002, {
		id = var_1_1
	}, 62003, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = {}
			ipairs = var_2_10002

			for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.donate_tasks) do
				GuildDonateTask = var_2_10007
				var_2_10007 = var_2_10007.New({
					id = iter_2_1
				})
				table = var_2_10008

				var_2_10008.insert(var_2_0, var_2_10007)
			end

			var_2_10004 = var_0

			var_2.UpdateDonateTasks(var_2_10004, var_2_0)

			var_2_10004 = var_0

			var_2.IncDonateCount(var_2_10004)

			getProxy = var_2
			PlayerProxy = var_2_10004

			local var_2_1 = var_2(var_2_10004)
			local var_2_2 = var_2.getData(var_2_1)
			local var_2_3 = var_0

			var_2_10004 = var_2_10004.getConfig(var_2_3, "award_contribution")

			var_2_2:addResources({
				guildCoin = var_2_10004
			})
			var_2:updatePlayer(var_2_2)

			local var_2_4 = var_0
			local var_2_5 = var_5.getCommitItem(var_2_4)
			local var_2_6 = arg_1_0
			local var_2_7 = var_6.sendNotification

			GAME = var_2_10009

			local var_2_8 = var_2_10009.CONSUME_ITEM

			Drop = var_2_10010

			var_2_7(var_2_6, var_2_8, var_2_10010.Create(var_2_5))

			local var_2_9 = {}

			Drop = var_2_4

			local var_2_10 = var_2_4.New
			local var_2_11 = {}

			DROP_TYPE_RESOURCE = var_10
			var_2_11.type = var_10
			PlayerConst = var_10
			var_2_11.id = var_10.ResGuildCoin
			var_2_11.count = var_2_10004

			local var_2_12 = var_2_10(var_2_11)

			table = var_2_6

			var_2_6.insert(var_2_9, var_2_12)

			local var_2_13 = arg_1_0
			local var_2_14 = var_8.sendNotification

			GAME = var_11

			var_2_14(var_2_13, var_11.PUBLIC_GUILD_COMMIT_DONATE_DONE, {
				awards = var_2_9
			})
		else
			pg = var_2_0

			local var_2_15 = var_2_0.TipsMgr.GetInstance()
			local var_2_16 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_16(var_2_15, var_2_10004("guild_dissolve_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
