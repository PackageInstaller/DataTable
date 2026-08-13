class = var_0_10000

local var_0_0 = "UpgradeCommanderCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.materialIds
	local var_1_2 = var_2.skillId

	getProxy = var_1_10006
	CommanderProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)

	if not var_6.getCommanderById(var_1_3, var_1_0) then
		return
	end

	if not var_7:getSkill(var_1_2) then
		return
	end

	local var_1_4 = var_7
	local var_1_5

	if var_7.isMaxLevel(var_1_4) then
		var_1_4 = var_8

		if var_8.isMaxLevel(var_1_4) then
			pg = var_1_5
			var_1_4 = var_1_5.TipsMgr.GetInstance()
			var_1_5 = var_1_5.ShowTips
			i18n = var_1_10011

			var_1_5(var_1_4, var_1_10011("commander_can_not_be_upgrade"))

			return
		end
	end

	getProxy = var_1_5
	FleetProxy = var_1_4

	local var_1_6 = var_1_5(var_1_4)
	local var_1_7 = var_9.getCommandersInFleet(var_1_6)

	_ = var_1_6

	local var_1_8, var_1_9

	if var_1_6.any(var_1_1, function(arg_2_0)
		table = var_2_10001

		return var_2_10001.contains(var_1_7, arg_2_0)
	end) then
		pg = var_1_9
		var_1_8 = var_1_9.TipsMgr.GetInstance()
		var_1_9 = var_1_9.ShowTips
		i18n = var_13

		var_1_9(var_1_8, var_13("commander_anyone_is_in_fleet"))

		return
	end

	getProxy = var_1_9
	ChapterProxy = var_1_8

	local var_1_10 = var_1_9(var_1_8)

	if var_11.getActiveChapter(var_1_10) then
		_ = var_1_10

		var_1_10.each(var_11.fleets, function(arg_3_0)
			local var_3_0 = arg_3_0
			local var_3_1 = arg_3_0.getCommanders(var_3_0)

			_ = var_3_0

			local var_3_2 = var_3_0.any

			_ = var_2_10003

			if var_3_2(var_2_10003.values(var_3_1), function(arg_4_0)
				return arg_4_0.id == var_1_0
			end) then
				pg = var_2

				local var_3_3 = var_2.TipsMgr.GetInstance()
				local var_3_4 = var_2.ShowTips

				i18n = var_4

				var_3_4(var_3_3, var_4("commander_is_in_battle"))

				return
			end

			return
		end)
	end

	local var_1_11 = 0
	local var_1_12 = 0

	CommanderCatUtil = var_1_10014

	local var_1_13 = var_1_10014.CalcCommanderConsume(var_1_1)

	ipairs = var_15

	for iter_1_0, iter_1_1 in var_15(var_1_1) do
		if not var_6:getCommanderById(iter_1_1) or var_1_0 == iter_1_1 then
			return
		end

		var_1_11 = var_1_11 + var_20:getDestoryedSkillExp(var_7.groupId)
		var_1_12 = var_1_12 + var_20:getDestoryedExp(var_7.groupId)
	end

	math = var_15

	local var_1_14 = var_15.floor(var_1_12)

	math = var_15

	local var_1_15 = var_15.floor(var_1_11)

	getProxy = var_15
	PlayerProxy = var_16

	local var_1_16 = var_15(var_16)
	local var_1_18

	if var_15.getData(var_1_16).gold < var_1_13 then
		pg = var_1_18

		local var_1_17 = var_1_18.TipsMgr.GetInstance()

		var_1_18 = var_1_18.ShowTips
		i18n = iter_1_1

		var_1_18(var_1_17, iter_1_1("common_no_resource"))

		return
	end

	pg = var_1_18

	local var_1_19 = var_1_18.ConnectionMgr.GetInstance()

	var_17.Send(var_1_19, 25008, {
		targetid = var_1_0,
		materialid = var_1_1
	}, 25009, function(arg_5_0)
		local var_5_0

		if arg_5_0.result == 0 then
			Clone = var_5_0
			var_5_0 = var_5_0(var_0)
			var_2_10003 = var_0

			var_2.addExp(var_2_10003, var_1_14)

			var_2_10003 = var_0

			var_2.addExp(var_2_10003, var_1_15)

			var_2_10003 = var_0

			var_2.consume(var_2_10003, {
				gold = var_1_13
			})

			var_2_10003 = var_0

			var_2.updatePlayer(var_2_10003, var_0)

			var_2_10003 = var_0

			var_2.updateCommander(var_2_10003, var_0)

			var_2_10003 = arg_1_0

			local var_5_1 = var_2.sendNotification

			GAME = var_4

			var_5_1(var_2_10003, var_4.COMMANDER_UPGRADE_DONE, {
				commander = var_0,
				oldCommander = var_5_0
			})

			ipairs = var_5_1

			for iter_5_0, iter_5_1 in var_5_1(var_1_1) do
				local var_5_2 = var_0

				var_7.removeCommanderById(var_5_2, iter_5_1)

				local var_5_3 = arg_1_0

				var_7.clearActivityCommanders(var_5_3, iter_5_1)
			end

			getProxy = var_2
			ChapterProxy = var_2_10003
			var_2_10003 = var_2(var_2_10003)

			var_2.RemoveEliteFleetCommander(var_2_10003, var_1_1)
		else
			pg = var_5_0

			local var_5_4 = var_5_0.TipsMgr.GetInstance()
			local var_5_5 = var_1.ShowTips

			i18n = var_2_10003

			var_5_5(var_5_4, var_2_10003("commander_play_erro", arg_5_0.result))
		end

		return
	end)

	return
end

function var_0_1.clearActivityCommanders(arg_6_0, arg_6_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10003

	local var_6_0 = var_1_10002(var_1_10003)

	var_2.removeActivityFleetCommander(var_6_0, arg_6_1)

	return
end

return var_0_1
