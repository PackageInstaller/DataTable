class = var_0_10000

local var_0_0 = "StartLearnTacticsCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = var_2.lessonId
	local var_1_2 = var_2.skillPos
	local var_1_3 = var_2.roomId

	getProxy = var_1_10007
	BagProxy = var_1_10009

	local var_1_4 = var_1_10007(var_1_10009)

	if not var_7.getItemById(var_1_4, var_1_1) or var_8.count == 0 then
		pg = var_1_10009

		local var_1_5 = var_1_10009.TipsMgr.GetInstance()

		var_1_10009 = var_1_10009.ShowTips
		i18n = var_1_10012

		var_1_10009(var_1_5, var_1_10012("buyProp_noResource_error", var_8:getConfig("name")))

		return
	end

	pg = var_1_10009

	local var_1_6 = var_1_10009.ConnectionMgr.GetInstance()

	var_9.Send(var_1_6, 22201, {
		room_id = var_1_3,
		ship_id = var_1_0,
		skill_pos = var_1_2,
		item_id = var_1_1
	}, 22202, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			NavalAcademyProxy = var_2_10003
			var_2_0 = var_2_0(var_2_10003)
			Item = var_2_10002

			local var_2_1 = var_2_10002.getConfigData(var_1_1).usage_arg[1]

			Student = var_2_10003

			local var_2_2 = var_2_10003.New(arg_2_0.class_info)

			var_3.setTime(var_2_2, var_2_1)
			var_3:setLesson(var_1_1)
			var_2_0:addStudent(var_3)

			local var_2_3 = var_0

			var_2_10004.removeItemById(var_2_3, var_0.id, 1)

			local var_2_4 = arg_1_0

			var_2_10004 = var_2_10004.sendNotification
			GAME = var_7

			var_2_10004(var_2_4, var_7.START_TO_LEARN_TACTICS_DONE)
		else
			pg = var_2_0

			local var_2_5 = var_2_0.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_6(var_2_5, var_2_10004("lesson_endToLearn", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
