local MetaCharacterTacticsLevelUpCommand = class("MetaCharacterTacticsLevelUpCommand", pm.SimpleCommand)

function MetaCharacterTacticsLevelUpCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.shipID
	local var_1_2 = var_1_0.skillID

	print("63309 skill levelup", tostring(var_1_0.shipID), tostring(var_1_0.skillID))
	pg.ConnectionMgr.GetInstance():Send(63309, {
		ship_id = var_1_0.shipID,
		skill_id = var_1_0.skillID
	}, 63310, function(arg_2_0)
		if arg_2_0.result == 0 then
			print("63310 skill levelup success")

			local var_2_0 = getProxy(BayProxy)
			local var_2_1 = var_2_0:getShipById(var_1_1)

			var_2_1:upSkillLevelForMeta(var_1_2)
			var_2_0:updateShip(var_2_1)
			self:sendNotification(GAME.TACTICS_META_LEVELUP_SKILL_DONE, {
				skillID = var_1_2,
				leftSwitchCount = arg_2_0.switch_cnt
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return MetaCharacterTacticsLevelUpCommand
