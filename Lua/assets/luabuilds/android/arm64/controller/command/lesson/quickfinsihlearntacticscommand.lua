local var_0_0 = class("QuickFinsihLearnTacticsCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(NavalAcademyProxy)
	local var_1_2 = var_1_0.callback
	local var_1_3 = var_1_0.onConfirm
	local var_1_4 = getProxy(NavalAcademyProxy):getStudentById(var_1_0.shipId)
	local var_1_5 = getProxy(BayProxy)
	local var_1_6 = var_1_4:getSkillId((getProxy(BayProxy):getShipById(var_1_4.shipId)))

	pg.ConnectionMgr.GetInstance():Send(22014, {
		roomid = var_1_0.shipId
	}, 22015, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:updateUsedDailyFinishCnt()
			arg_1_0:sendNotification(GAME.QUICK_FINISH_LEARN_TACTICS_DONE)

			local var_2_0 = Clone(var_0.skills[var_1_6])

			var_0:addSkillExp(var_2_0.id, var_1_4.exp)
			var_1_5:updateShip(var_0)
			var_1_1:SaveRecentShip(var_1_4.shipId)
			var_1_1:deleteStudent(var_0)
			arg_1_0:sendNotification(GAME.CANCEL_LEARN_TACTICS_DONE, {
				id = var_0,
				shipId = var_1_4.shipId,
				totalExp = var_1_4.exp,
				oldSkill = var_2_0,
				newSkill = var_0.skills[var_1_6],
				onConfirm = var_1_3,
				newShipVO = var_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("lesson_quickfinsh", arg_2_0.result))
		end

		if var_1_2 ~= nil then
			var_1_2()
		end

		return
	end)

	return
end

return var_0_0
