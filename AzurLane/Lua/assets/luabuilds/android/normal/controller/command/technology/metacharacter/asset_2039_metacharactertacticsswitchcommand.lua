class = var_0_10000

local var_0_0 = "MetaCharacterTacticsSwitchCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipID
	local var_1_1 = var_2.skillID

	print = var_1_10005

	local var_1_2 = "63307 switch skill"

	tostring = var_1_10007

	local var_1_3 = var_1_10007(var_1_0)

	tostring = var_8

	var_1_10005(var_1_2, var_1_3, var_8(var_1_1))

	pg = var_1_10005

	local var_1_4 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_4, 63307, {
		ship_id = var_1_0,
		skill_id = var_1_1
	}, 63308, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			print = var_2_2

			var_2_2("63308 switch success")

			getProxy = var_2_2
			MetaCharacterProxy = var_2

			local var_2_0 = var_2_2(var_2)

			var_2_2.switchMetaTacticsSkill(var_2_0, var_1_0, var_1_1)

			getProxy = var_2_2
			MetaCharacterProxy = var_2_0

			local var_2_1 = var_2_2(var_2_0)

			var_2_2.tryRemoveMetaSkillLevelMaxInfo(var_2_1, var_1_0, var_1_1)

			var_2_2 = arg_2_0.switch_cnt
			var_2_10003 = arg_1_0

			local var_2_3 = var_2.sendNotification

			GAME = var_4

			var_2_3(var_2_10003, var_4.TACTICS_META_SWITCH_SKILL_DONE, {
				metaShipID = var_1_0,
				skillID = var_1_1,
				leftSwitchCount = var_2_2
			})
		else
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_5(var_2_4, var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
