local MetaCharacterTacticsRequestCommand = class("MetaCharacterTacticsRequestCommand", pm.SimpleCommand)

function MetaCharacterTacticsRequestCommand:execute(arg_1_1)
	print("63313 request tactics info")
	pg.ConnectionMgr.GetInstance():Send(63313, {
		ship_id = arg_1_1:getBody().id
	}, 63314, function(arg_2_0)
		print("63314 requset success")

		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.tasks or {}) do
			var_2_0[iter_2_1.skill_id] = var_2_0[iter_2_1.skill_id] or {}

			table.insert(var_2_0[iter_2_1.skill_id], {
				taskID = iter_2_1.task_id,
				finishCount = iter_2_1.finish_cnt
			})
		end

		local var_2_1 = {}

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.skill_exp or {}) do
			var_2_1[iter_2_3.skill_id] = iter_2_3.exp

			print("skill", iter_2_3.skill_id, iter_2_3.exp)
		end

		local var_2_2 = {
			shipID = arg_2_0.ship_id,
			doubleExp = arg_2_0.double_exp,
			normalExp = arg_2_0.exp
		}

		var_2_2.curSkillID = arg_2_0.skill_id or 0
		var_2_2.switchCount = arg_2_0.switch_cnt
		var_2_2.taskInfoTable = var_2_0
		var_2_2.skillExpTable = var_2_1

		getProxy(MetaCharacterProxy):setMetaTacticsInfo(arg_2_0)
		self:sendNotification(GAME.TACTICS_META_INFO_REQUEST_DONE, var_2_2)

		return
	end)

	return
end

return MetaCharacterTacticsRequestCommand
