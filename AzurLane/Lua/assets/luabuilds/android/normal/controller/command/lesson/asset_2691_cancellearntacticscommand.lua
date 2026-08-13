class = var_0_10000

local var_0_0 = "CancelLearnTacticsCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = var_2.type

	getProxy = var_1_10005
	NavalAcademyProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	if not var_5.ExistStudent(var_1_2, var_1_0) then
		return
	end

	local var_1_3 = var_5:getStudentById(var_1_0)
	local var_1_4 = var_2.callback
	local var_1_5 = var_2.onConfirm

	if not var_1_3 then
		existCall = var_1_10009

		var_1_10009(var_1_4)

		return
	end

	getProxy = var_1_10009
	BayProxy = var_1_10010

	local var_1_6 = var_1_10009(var_1_10010)
	local var_1_7 = var_9.getShipById(var_1_6, var_1_3.shipId)
	local var_1_8 = var_1_3:getSkillId(var_1_7)
	local var_1_10

	if not var_1_7.skills[var_1_8] then
		pg = var_1_10

		local var_1_9 = var_1_10.TipsMgr.GetInstance()

		var_1_10 = var_1_10.ShowTips
		i18n = var_1_10014

		var_1_10(var_1_9, var_1_10014("tactics_noskill_erro"))

		return
	end

	pg = var_1_10

	local var_1_11 = var_1_10.ConnectionMgr.GetInstance()

	var_12.Send(var_1_11, 22203, {
		room_id = var_1_0,
		type = var_1_1
	}, 22204, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			Clone = var_2_0
			var_2_0 = var_2_0(var_1_7.skills[var_1_8])
			var_2_10003 = var_1_7

			var_2.addSkillExp(var_2_10003, var_2_0.id, arg_2_0.exp)

			var_2_10003 = var_0

			var_2.updateShip(var_2_10003, var_1_7)

			var_2_10003 = var_0

			var_2.deleteStudent(var_2_10003, var_1_0)

			var_2_10003 = var_0

			var_2.SaveRecentShip(var_2_10003, var_1_3.shipId)

			var_2_10003 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = var_4

			var_2_1(var_2_10003, var_4.CANCEL_LEARN_TACTICS_DONE, {
				id = var_1_0,
				shipId = var_1_3.shipId,
				totalExp = arg_2_0.exp,
				oldSkill = var_2_0,
				newSkill = var_1_7.skills[var_1_8],
				onConfirm = var_1_5,
				newShipVO = var_1_7
			})
		else
			pg = var_2_0

			local var_2_2 = var_2_0.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_3(var_2_2, var_2_10003("lesson_endToLearn", arg_2_0.result))
		end

		if var_1_4 ~= nil then
			var_1_4()
		end

		return
	end)

	return
end

return var_0_1
