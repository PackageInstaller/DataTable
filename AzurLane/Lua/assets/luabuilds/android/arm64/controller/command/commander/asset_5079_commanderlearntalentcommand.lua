class = var_0_10000

local var_0_0 = "CommanderLearnTalentCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.talentId
	local var_1_2

	if not var_2.replaceid then
		var_1_2 = 0
	end

	getProxy = var_1_10006
	CommanderProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)

	if not var_6.getCommanderById(var_1_3, var_1_0) then
		return
	end

	local var_1_4 = var_7
	local var_1_5 = var_7.getNotLearnedList(var_1_4)

	_ = var_1_3

	if not var_1_3.any(var_1_5, function(arg_2_0)
		return arg_2_0.id == var_1_1
	end) then
		pg = var_9

		local var_1_6 = var_9.TipsMgr.GetInstance()
		local var_1_7 = var_9.ShowTips

		i18n = var_12

		var_1_7(var_1_6, var_12("commander_talent_not_exist"))

		return
	end

	local var_1_8 = var_7:getTalents()

	if var_1_2 ~= 0 then
		_ = var_1_4

		if not var_1_4.any(var_1_8, function(arg_3_0)
			return arg_3_0.id == var_1_2
		end) then
			pg = var_1_4

			local var_1_9 = var_1_4.TipsMgr.GetInstance()

			var_1_4 = var_1_4.ShowTips
			i18n = var_13

			var_1_4(var_1_9, var_13("commander_replace_talent_not_exist"))

			return
		end
	end

	CommanderTalent = var_1_4

	local var_1_10 = var_1_4.New({
		id = var_1_1
	})
	local var_1_11 = var_10.getConfig(var_1_10, "cost")

	getProxy = var_12
	PlayerProxy = var_14

	local var_1_12 = var_12(var_14)
	local var_1_14

	if var_12.getData(var_1_12).gold < var_1_11 then
		pg = var_1_14

		local var_1_13 = var_1_14.TipsMgr.GetInstance()

		var_1_14 = var_1_14.ShowTips
		i18n = var_1_10017

		var_1_14(var_1_13, var_1_10017("common_no_resource"))

		return
	end

	pg = var_1_14

	local var_1_15 = var_1_14.ConnectionMgr.GetInstance()

	var_14.Send(var_1_15, 25012, {
		commanderid = var_1_0,
		targetid = var_1_1,
		replaceid = var_1_2
	}, 25013, function(arg_4_0)
		if arg_4_0.result == 0 then
			local var_4_0 = var_0

			var_1.consume(var_4_0, {
				gold = var_1_11
			})

			local var_4_1 = var_0

			var_1.updatePlayer(var_4_1, var_0)

			local var_4_2 = var_0

			if var_1.getSameGroupTalent(var_4_2, var_0.groupId) then
				var_2_10004 = var_0

				var_2.deleteTablent(var_2_10004, var_1.id)
			end

			if var_1_2 ~= 0 then
				var_2_10004 = var_0

				var_2.deleteTablent(var_2_10004, var_1_2)
			end

			var_2_10004 = var_0

			var_2.addTalent(var_2_10004, var_0)

			var_2_10004 = var_0

			var_2.updatePt(var_2_10004, var_0.pt + 1)

			var_2_10004 = var_0

			var_2.updateNotLearnedList(var_2_10004, {})

			var_2_10004 = var_0

			var_2.updateCommander(var_2_10004, var_0)

			var_2_10004 = arg_1_0

			local var_4_3 = var_2.sendNotification

			GAME = var_5

			var_4_3(var_2_10004, var_5.COMMANDER_LEARN_TALENTS_DONE, {
				commander = var_0
			})

			pg = var_4_3
			var_2_10004 = var_4_3.TipsMgr.GetInstance()

			local var_4_4 = var_2.ShowTips

			i18n = var_5

			local var_4_5 = "commander_talent_learned"
			local var_4_6 = var_0

			var_4_4(var_2_10004, var_5(var_4_5, var_8.getConfig(var_4_6, "name")))
		else
			pg = var_1

			local var_4_7 = var_1.TipsMgr.GetInstance()
			local var_4_8 = var_1.ShowTips

			i18n = var_2_10004

			var_4_8(var_4_7, var_2_10004("commander_talent_learn_erro", arg_4_0.result))
		end

		return
	end)

	return
end

return var_0_1
