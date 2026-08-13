class = var_0_10000

local var_0_0 = "GuildCommitDonateCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().taskId

	getProxy = var_1_10004
	GuildProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)

	if not var_4.getData(var_1_1) then
		pg = var_1_1

		local var_1_2 = var_1_1.TipsMgr.GetInstance()
		local var_1_3 = var_6.ShowTips

		i18n = var_1_10008

		var_1_3(var_1_2, var_1_10008("guild_no_exist"))

		return
	end

	local var_1_4 = var_5

	if not var_5.getDonateTaskById(var_1_4, var_1_0) then
		pg = var_1_4

		local var_1_5 = var_1_4.TipsMgr.GetInstance()
		local var_1_6 = var_7.ShowTips

		i18n = var_1_10009

		var_1_6(var_1_5, var_1_10009("guild_not_exist_donate_task"))

		return
	end

	if not var_6:canCommit() then
		pg = var_7

		local var_1_7 = var_7.TipsMgr.GetInstance()
		local var_1_8 = var_7.ShowTips

		i18n = var_1_10009

		var_1_8(var_1_7, var_1_10009("common_no_resource"))

		return
	end

	local var_1_10

	if not var_5:canDonate() then
		pg = var_1_10

		local var_1_9 = var_1_10.TipsMgr.GetInstance()

		var_1_10 = var_1_10.ShowTips
		i18n = var_1_10009

		var_1_10(var_1_9, var_1_10009("guild_donate_times_not enough"))

		return
	end

	pg = var_1_10

	local var_1_11 = var_1_10.ConnectionMgr.GetInstance()

	var_7.Send(var_1_11, 62002, {
		id = var_1_0
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
				table = var_8

				var_8.insert(var_2_0, var_2_10007)
			end

			getProxy = var_2
			PlayerProxy = var_2_10003

			local var_2_1 = var_2(var_2_10003)

			var_2_10003 = var_2.getData(var_2_1)

			local var_2_2 = var_0
			local var_2_3 = var_4.getData(var_2_2)
			local var_2_4 = var_4.getMemberById(var_2_3, var_2_10003.id)
			local var_2_5 = var_5.AddLiveness
			local var_2_6 = var_0

			var_2_5(var_2_4, var_8.GetLivenessAddition(var_2_6))
			var_4:updateDonateTasks(var_2_0)
			var_4:updateDonateCount()

			local var_2_7 = var_0

			var_6.updateGuild(var_2_7, var_4)

			local var_2_8 = var_0
			local var_2_9 = var_6.getConfig(var_2_8, "award_contribution")

			var_2_10003:addResources({
				guildCoin = var_2_9
			})
			var_2:updatePlayer(var_2_10003)

			local var_2_10 = var_0
			local var_2_11 = var_7.getCommitItem(var_2_10)
			local var_2_12 = arg_1_0
			local var_2_13 = var_8.sendNotification

			GAME = var_2_10010

			local var_2_14 = var_2_10010.CONSUME_ITEM

			Drop = var_2_10011

			var_2_13(var_2_12, var_2_14, var_2_10011.Create(var_2_11))

			local var_2_15 = {}

			Drop = var_2_12

			local var_2_16 = var_2_12.New
			local var_2_17 = {}

			DROP_TYPE_RESOURCE = var_11
			var_2_17.type = var_11
			PlayerConst = var_11
			var_2_17.id = var_11.ResGuildCoin
			var_2_17.count = var_2_9

			local var_2_18 = var_2_16(var_2_17)

			table = var_2_17

			var_2_17.insert(var_2_15, var_2_18)

			local var_2_19 = var_0
			local var_2_20 = var_10.getConfig(var_2_19, "award_capital")
			local var_2_21 = var_0
			local var_2_22 = var_11.getConfig(var_2_21, "award_tech_exp")
			local var_2_23 = arg_1_0
			local var_2_24 = var_12.sendNotification

			GAME = var_2_10014

			var_2_24(var_2_23, var_2_10014.GUILD_COMMIT_DONATE_DONE, {
				awards = var_2_15,
				capital = var_2_20,
				techPoint = var_2_22
			})
		else
			pg = var_2_0

			local var_2_25 = var_2_0.TipsMgr.GetInstance()
			local var_2_26 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_26(var_2_25, var_2_10003("guild_dissolve_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
