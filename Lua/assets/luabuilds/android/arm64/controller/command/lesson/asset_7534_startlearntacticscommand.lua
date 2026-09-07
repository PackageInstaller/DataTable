local StartLearnTacticsCommand = class("StartLearnTacticsCommand", pm.SimpleCommand)

function StartLearnTacticsCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.lessonId
	local var_1_2 = getProxy(BagProxy)
	local var_1_3 = var_1_2:getItemById(var_1_0.lessonId)

	if not var_1_3 or var_1_3.count == 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("buyProp_noResource_error", var_1_3:getConfig("name")))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(22201, {
		room_id = var_1_0.roomId,
		ship_id = var_1_0.shipId,
		skill_pos = var_1_0.skillPos,
		item_id = var_1_0.lessonId
	}, 22202, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = Student.New(arg_2_0.class_info)

			var_2_0:setTime(Item.getConfigData(var_1_1).usage_arg[1])
			var_2_0:setLesson(var_1_1)
			getProxy(NavalAcademyProxy):addStudent(var_2_0)
			var_1_2:removeItemById(var_1_3.id, 1)
			self:sendNotification(GAME.START_TO_LEARN_TACTICS_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("lesson_endToLearn", arg_2_0.result))
		end

		return
	end)

	return
end

return StartLearnTacticsCommand
