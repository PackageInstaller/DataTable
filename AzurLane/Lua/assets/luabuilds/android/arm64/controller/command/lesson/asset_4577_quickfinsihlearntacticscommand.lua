class = var_0_10000

local var_0_0 = "QuickFinsihLearnTacticsCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).shipId

	getProxy = var_1_0
	NavalAcademyProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_2.callback
	local var_1_4 = var_2.onConfirm
	local var_1_5 = var_1_2:getStudentById(var_1_1)

	getProxy = var_1_10008
	BayProxy = var_10

	local var_1_6 = var_1_10008(var_10)
	local var_1_7 = var_8.getShipById(var_1_6, var_1_5.shipId)
	local var_1_8 = var_1_5:getSkillId(var_1_7)

	pg = var_1_6

	local var_1_9 = var_1_6.ConnectionMgr.GetInstance()

	var_11.Send(var_1_9, 22014, {
		roomid = var_1_1
	}, 22015, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_2

			var_2_2.updateUsedDailyFinishCnt(var_2_0)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10004

			var_2_2(var_2_1, var_2_10004.QUICK_FINISH_LEARN_TACTICS_DONE)

			Clone = var_2_2
			var_2_2 = var_2_2(var_1_7.skills[var_1_8])
			var_2_10004 = var_1_7

			var_2.addSkillExp(var_2_10004, var_2_2.id, var_1_5.exp)

			var_2_10004 = var_0

			var_2.updateShip(var_2_10004, var_1_7)

			var_2_10004 = var_1_2

			var_2.SaveRecentShip(var_2_10004, var_1_5.shipId)

			var_2_10004 = var_1_2

			var_2.deleteStudent(var_2_10004, var_1_1)

			var_2_10004 = arg_1_0

			local var_2_3 = var_2.sendNotification

			GAME = var_5

			var_2_3(var_2_10004, var_5.CANCEL_LEARN_TACTICS_DONE, {
				id = var_1_1,
				shipId = var_1_5.shipId,
				totalExp = var_1_5.exp,
				oldSkill = var_2_2,
				newSkill = var_1_7.skills[var_1_8],
				onConfirm = var_1_4,
				newShipVO = var_1_7
			})
		else
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_5(var_2_4, var_2_10004("lesson_quickfinsh", arg_2_0.result))
		end

		if var_1_3 ~= nil then
			var_1_3()
		end

		return
	end)

	return
end

return var_0_1
