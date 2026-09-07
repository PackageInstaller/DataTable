local UpgradeCommanderCommand = class("UpgradeCommanderCommand", pm.SimpleCommand)

function UpgradeCommanderCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.materialIds
	local var_1_3 = getProxy(CommanderProxy)
	local var_1_4 = var_1_3:getCommanderById(var_1_0.id)

	if not var_1_4 then
		return
	end

	local var_1_5 = var_1_4:getSkill(var_1_0.skillId)

	if not var_1_5 then
		return
	end

	if var_1_4:isMaxLevel() and var_1_5:isMaxLevel() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("commander_can_not_be_upgrade"))

		return
	end

	local var_1_6 = getProxy(FleetProxy):getCommandersInFleet()

	if _.any(var_1_0.materialIds, function(arg_2_0)
		return table.contains(var_1_6, arg_2_0)
	end) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("commander_anyone_is_in_fleet"))

		return
	end

	local var_1_7 = getProxy(ChapterProxy):getActiveChapter()

	if var_1_7 then
		_.each(var_1_7.fleets, function(arg_3_0)
			if _.any(_.values((arg_3_0:getCommanders())), function(arg_4_0)
				return arg_4_0.id == var_1_1
			end) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("commander_is_in_battle"))

				return
			end

			return
		end)
	end

	local var_1_8 = 0
	local var_1_9 = 0
	local var_1_10 = CommanderCatUtil.CalcCommanderConsume(var_1_0.materialIds)

	for iter_1_0, iter_1_1 in ipairs(var_1_0.materialIds) do
		local var_1_11 = var_1_3:getCommanderById(iter_1_1)

		if not var_1_11 or var_1_0.id == iter_1_1 then
			return
		end

		var_1_8 = var_1_8 + var_1_11:getDestoryedSkillExp(var_1_4.groupId)
		var_1_9 = var_1_9 + var_1_11:getDestoryedExp(var_1_4.groupId)
	end

	local var_1_12 = math.floor(var_1_9)
	local var_1_13 = math.floor(var_1_8)
	local var_1_14 = getProxy(PlayerProxy)
	local var_1_15 = var_1_14:getData()

	if var_1_10 > var_1_15.gold then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(25008, {
		targetid = var_1_0.id,
		materialid = var_1_0.materialIds
	}, 25009, function(arg_5_0)
		if arg_5_0.result == 0 then
			var_1_4:addExp(var_1_12)
			var_1_5:addExp(var_1_13)
			var_1_15:consume({
				gold = var_1_10
			})
			var_1_14:updatePlayer(var_1_15)
			var_1_3:updateCommander(var_1_4)
			self:sendNotification(GAME.COMMANDER_UPGRADE_DONE, {
				commander = var_1_4,
				oldCommander = Clone(var_1_4)
			})

			for iter_5_0, iter_5_1 in ipairs(var_1_2) do
				var_1_3:removeCommanderById(iter_5_1)
				self:clearActivityCommanders(iter_5_1)
			end

			getProxy(ChapterProxy):RemoveEliteFleetCommander(var_1_2)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_play_erro", arg_5_0.result))
		end

		return
	end)

	return
end

function UpgradeCommanderCommand:clearActivityCommanders(arg_6_1)
	getProxy(FleetProxy):removeActivityFleetCommander(arg_6_1)

	return
end

return UpgradeCommanderCommand
