local MetaCharacterTacticsSwitchCommand = class("MetaCharacterTacticsSwitchCommand", pm.SimpleCommand)

function MetaCharacterTacticsSwitchCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.shipID
	local var_1_2 = var_1_0.skillID

	print("63307 switch skill", tostring(var_1_0.shipID), tostring(var_1_0.skillID))
	pg.ConnectionMgr.GetInstance():Send(63307, {
		ship_id = var_1_0.shipID,
		skill_id = var_1_0.skillID
	}, 63308, function(arg_2_0)
		if arg_2_0.result == 0 then
			print("63308 switch success")
			getProxy(MetaCharacterProxy):switchMetaTacticsSkill(var_1_1, var_1_2)
			getProxy(MetaCharacterProxy):tryRemoveMetaSkillLevelMaxInfo(var_1_1, var_1_2)
			self:sendNotification(GAME.TACTICS_META_SWITCH_SKILL_DONE, {
				metaShipID = var_1_1,
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

return MetaCharacterTacticsSwitchCommand
