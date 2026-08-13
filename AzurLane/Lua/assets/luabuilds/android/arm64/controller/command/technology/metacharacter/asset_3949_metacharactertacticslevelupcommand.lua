class = var_0_10000

local var_0_0 = "MetaCharacterTacticsLevelUpCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipID
	local var_1_1 = var_2.skillID

	print = var_1_10005

	local var_1_2 = "63309 skill levelup"

	tostring = var_1_10008

	local var_1_3 = var_1_10008(var_1_0)

	tostring = var_1_10009

	var_1_10005(var_1_2, var_1_3, var_1_10009(var_1_1))

	pg = var_1_10005

	local var_1_4 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_4, 63309, {
		ship_id = var_1_0,
		skill_id = var_1_1
	}, 63310, function(arg_2_0)
		if arg_2_0.result == 0 then
			print = var_1

			var_1("63310 skill levelup success")

			getProxy = var_1
			BayProxy = var_3
			var_2_10004 = var_1(var_3)

			local var_2_0 = var_1.getShipById(var_2_10004, var_1_0)

			var_2.upSkillLevelForMeta(var_2_0, var_1_1)
			var_1:updateShip(var_2)

			local var_2_1 = arg_2_0.switch_cnt
			local var_2_2 = arg_1_0

			var_2_10004 = var_2_10004.sendNotification
			GAME = var_2_10007

			var_2_10004(var_2_2, var_2_10007.TACTICS_META_LEVELUP_SKILL_DONE, {
				skillID = var_1_1,
				leftSwitchCount = var_2_1
			})
		else
			pg = var_1

			local var_2_3 = var_1.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_4(var_2_3, var_2_10004("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
