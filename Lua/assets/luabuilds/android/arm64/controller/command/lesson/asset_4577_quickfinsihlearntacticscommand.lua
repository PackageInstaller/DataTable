local QuickFinsihLearnTacticsCommand = class("QuickFinsihLearnTacticsCommand", pm.SimpleCommand)

function QuickFinsihLearnTacticsCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.shipId
	local var_1_2 = getProxy(NavalAcademyProxy)
	local var_1_3 = var_1_0.callback
	local var_1_4 = var_1_0.onConfirm
	local var_1_5 = var_1_2:getStudentById(var_1_0.shipId)
	local var_1_6 = getProxy(BayProxy)
	local var_1_7 = var_1_6:getShipById(var_1_5.shipId)
	local var_1_8 = var_1_5:getSkillId(var_1_7)

	pg.ConnectionMgr.GetInstance():Send(22014, {
		roomid = var_1_0.shipId
	}, 22015, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2:updateUsedDailyFinishCnt()
			self:sendNotification(GAME.QUICK_FINISH_LEARN_TACTICS_DONE)

			local var_2_0 = Clone(var_1_7.skills[var_1_8])

			var_1_7:addSkillExp(var_2_0.id, var_1_5.exp)
			var_1_6:updateShip(var_1_7)
			var_1_2:SaveRecentShip(var_1_5.shipId)
			var_1_2:deleteStudent(var_1_1)
			self:sendNotification(GAME.CANCEL_LEARN_TACTICS_DONE, {
				id = var_1_1,
				shipId = var_1_5.shipId,
				totalExp = var_1_5.exp,
				oldSkill = var_2_0,
				newSkill = var_1_7.skills[var_1_8],
				onConfirm = var_1_4,
				newShipVO = var_1_7
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("lesson_quickfinsh", arg_2_0.result))
		end

		if var_1_3 ~= nil then
			var_1_3()
		end

		return
	end)

	return
end

return QuickFinsihLearnTacticsCommand
