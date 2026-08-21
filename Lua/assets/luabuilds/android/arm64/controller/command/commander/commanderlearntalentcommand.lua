local var_0_0 = class("CommanderLearnTalentCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.talentId
	local var_1_2 = var_1_0.replaceid or 0
	local var_1_3 = getProxy(CommanderProxy)
	local var_1_4 = var_1_3:getCommanderById(var_1_0.id)

	if not var_1_4 then
		return
	end

	if not _.any(var_1_4:getNotLearnedList(), function(arg_2_0)
		return arg_2_0.id == var_1_1
	end) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("commander_talent_not_exist"))

		return
	end

	local var_1_5 = var_1_4:getTalents()

	if var_1_2 ~= 0 and not _.any(var_1_5, function(arg_3_0)
		return arg_3_0.id == var_1_2
	end) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("commander_replace_talent_not_exist"))

		return
	end

	local var_1_6 = CommanderTalent.New({
		id = var_1_0.talentId
	})
	local var_1_7 = getProxy(PlayerProxy)

	if var_1_6:getConfig("cost") > getProxy(PlayerProxy):getData().gold then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(25012, {
		commanderid = var_1_0.id,
		targetid = var_1_0.talentId,
		replaceid = var_1_2
	}, 25013, function(arg_4_0)
		if arg_4_0.result == 0 then
			var_0:consume({
				gold = var_0
			})
			var_1_7:updatePlayer(var_0)

			local var_4_0 = var_1_4:getSameGroupTalent(var_1_6.groupId)

			if var_4_0 then
				var_1_4:deleteTablent(var_4_0.id)
			end

			if var_1_2 ~= 0 then
				var_1_4:deleteTablent(var_1_2)
			end

			var_1_4:addTalent(var_1_6)
			var_1_4:updatePt(var_1_4.pt + 1)
			var_1_4:updateNotLearnedList({})
			var_1_3:updateCommander(var_1_4)
			arg_1_0:sendNotification(GAME.COMMANDER_LEARN_TALENTS_DONE, {
				commander = var_1_4
			})
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_talent_learned", var_1_6:getConfig("name")))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_talent_learn_erro", arg_4_0.result))
		end

		return
	end)

	return
end

return var_0_0
