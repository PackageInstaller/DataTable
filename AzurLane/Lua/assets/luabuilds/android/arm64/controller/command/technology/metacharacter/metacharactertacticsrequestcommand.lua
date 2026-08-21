local var_0_0 = class("MetaCharacterTacticsRequestCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	print("63313 request tactics info")
	pg.ConnectionMgr.GetInstance():Send(63313, {
		ship_id = arg_1_1:getBody().id
	}, 63314, function(arg_2_0)
		print("63314 requset success")

		local var_2_0 = arg_2_0.tasks or {}

		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			if not ({})[iter_2_1.skill_id] then
				({})[iter_2_1.skill_id] = {}
			end

			table.insert(({})[iter_2_1.skill_id], {
				taskID = iter_2_1.task_id,
				finishCount = iter_2_1.finish_cnt
			})
		end

		local var_2_1 = arg_2_0.skill_exp or {}

		for iter_2_2, iter_2_3 in ipairs(var_2_1) do
			({})[iter_2_3.skill_id] = iter_2_3.exp

			print("skill", iter_2_3.skill_id, iter_2_3.exp)
		end

		;({
			shipID = arg_2_0.ship_id,
			doubleExp = arg_2_0.double_exp,
			normalExp = arg_2_0.exp
		}).curSkillID = arg_2_0.skill_id or 0
		;({
			shipID = arg_2_0.ship_id,
			doubleExp = arg_2_0.double_exp,
			normalExp = arg_2_0.exp
		}).switchCount = arg_2_0.switch_cnt
		;({
			shipID = arg_2_0.ship_id,
			doubleExp = arg_2_0.double_exp,
			normalExp = arg_2_0.exp
		}).taskInfoTable = {}
		;({
			shipID = arg_2_0.ship_id,
			doubleExp = arg_2_0.double_exp,
			normalExp = arg_2_0.exp
		}).skillExpTable = {}

		getProxy(MetaCharacterProxy):setMetaTacticsInfo(arg_2_0)
		arg_1_0:sendNotification(GAME.TACTICS_META_INFO_REQUEST_DONE, {
			shipID = arg_2_0.ship_id,
			doubleExp = arg_2_0.double_exp,
			normalExp = arg_2_0.exp
		})

		return
	end)

	return
end

return var_0_0
