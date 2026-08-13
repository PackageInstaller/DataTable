class = var_0_10000

local var_0_0 = "UpgradeCommanderCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.materialIds
	local var_1_2 = var_2.skillId

	getProxy = var_1_10006
	CommanderProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)

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
			i18n = var_1_10012

			var_1_5(var_1_4, var_1_10012("commander_can_not_be_upgrade"))

			return
		end
	end

	getProxy = var_1_5
	FleetProxy = var_1_4

	local var_1_6 = var_1_5(var_1_4)
	local var_1_7 = var_9.getCommandersInFleet(var_1_6)

	_ = var_1_4

	local var_1_8, var_1_9

	if var_1_4.any(var_1_1, function(arg_2_0)
		table = var_2_10001

		return var_2_10001.contains(var_1_7, arg_2_0)
	end) then
		pg = var_1_9
		var_1_8 = var_1_9.TipsMgr.GetInstance()
		var_1_9 = var_1_9.ShowTips
		i18n = var_14

		var_1_9(var_1_8, var_14("commander_anyone_is_in_fleet"))

		return
	end

	getProxy = var_1_9
	ChapterProxy = var_1_8

	local var_1_10 = var_1_9(var_1_8)

	if var_11.getActiveChapter(var_1_10) then
		_ = var_1_6

		var_1_6.each(var_11.fleets, function(arg_3_0)
			local var_3_0 = arg_3_0:getCommanders()

			_ = var_2_10002

			local var_3_1 = var_2_10002.any

			_ = var_2_10004

			if var_3_1(var_2_10004.values(var_3_0), function(arg_4_0)
				return arg_4_0.id == var_1_0
			end) then
				pg = var_2

				local var_3_2 = var_2.TipsMgr.GetInstance()
				local var_3_3 = var_2.ShowTips

				i18n = var_5

				var_3_3(var_3_2, var_5("commander_is_in_battle"))

				return
			end

			return
		end)
	end

	local var_1_11 = 0
	local var_1_12 = 0

	CommanderCatUtil = var_14

	local var_1_13 = var_14.CalcCommanderConsume(var_1_1)

	ipairs = var_1_10015

	for iter_1_0, iter_1_1 in var_1_10015(var_1_1) do
		if not var_6:getCommanderById(iter_1_1) or var_1_0 == iter_1_1 then
			return
		end

		var_1_11 = var_1_11 + var_1_10020:getDestoryedSkillExp(var_7.groupId)
		var_1_12 = var_1_12 + var_1_10020:getDestoryedExp(var_7.groupId)
	end

	math = var_15

	local var_1_14 = var_15.floor(var_1_12)

	math = var_15

	local var_1_15 = var_15.floor(var_1_11)

	getProxy = var_15
	PlayerProxy = var_17

	local var_1_16 = var_15(var_17)
	local var_1_18

	if var_15.getData(var_1_16).gold < var_1_13 then
		pg = var_1_18

		local var_1_17 = var_1_18.TipsMgr.GetInstance()

		var_1_18 = var_1_18.ShowTips
		i18n = var_1_10020

		var_1_18(var_1_17, var_1_10020("common_no_resource"))

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
			var_2_10004 = var_0

			var_2.addExp(var_2_10004, var_1_14)

			var_2_10004 = var_0

			var_2.addExp(var_2_10004, var_1_15)

			var_2_10004 = var_0

			var_2.consume(var_2_10004, {
				gold = var_1_13
			})

			var_2_10004 = var_0

			var_2.updatePlayer(var_2_10004, var_0)

			var_2_10004 = var_0

			var_2.updateCommander(var_2_10004, var_0)

			var_2_10004 = arg_1_0

			local var_5_1 = var_2.sendNotification

			GAME = var_5

			var_5_1(var_2_10004, var_5.COMMANDER_UPGRADE_DONE, {
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
			ChapterProxy = var_2_10004
			var_2_10004 = var_2(var_2_10004)

			var_2.RemoveEliteFleetCommander(var_2_10004, var_1_1)
		else
			pg = var_5_0

			local var_5_4 = var_5_0.TipsMgr.GetInstance()
			local var_5_5 = var_1.ShowTips

			i18n = var_2_10004

			var_5_5(var_5_4, var_2_10004("commander_play_erro", arg_5_0.result))
		end

		return
	end)

	return
end

function var_0_1.clearActivityCommanders(arg_6_0, arg_6_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10004

	local var_6_0 = var_1_10002(var_1_10004)

	var_2.removeActivityFleetCommander(var_6_0, arg_6_1)

	return
end

return var_0_1
