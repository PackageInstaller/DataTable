class = var_0_10000

local var_0_0 = "MetaCharacterTacticsRequestCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	print = var_1_10004

	var_1_10004("63313 request tactics info")

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 63313, {
		ship_id = var_1_0
	}, 63314, function(arg_2_0)
		print = var_2_10001

		var_2_10001("63314 requset success")

		local var_2_0 = {}

		ipairs = var_2

		local var_2_1

		if not arg_2_0.tasks then
			var_2_1 = {}
		end

		for iter_2_0, iter_2_1 in var_2(var_2_1) do
			if not var_2_0[iter_2_1.skill_id] then
				var_2_0[var_7] = {}
			end

			table = var_8

			var_8.insert(var_2_0[var_7], {
				taskID = iter_2_1.task_id,
				finishCount = iter_2_1.finish_cnt
			})
		end

		local var_2_2 = {}

		ipairs = var_3

		local var_2_3

		if not arg_2_0.skill_exp then
			var_2_3 = {}
		end

		for iter_2_2, iter_2_3 in var_3(var_2_3) do
			var_2_2[iter_2_3.skill_id] = iter_2_3.exp
			print = var_8

			var_8("skill", iter_2_3.skill_id, iter_2_3.exp)
		end

		local var_2_4 = {
			shipID = arg_2_0.ship_id,
			doubleExp = arg_2_0.double_exp,
			normalExp = arg_2_0.exp
		}
		local var_2_5

		if not arg_2_0.skill_id then
			var_2_5 = 0
		end

		var_2_4.curSkillID = var_2_5
		var_2_4.switchCount = arg_2_0.switch_cnt
		var_2_4.taskInfoTable = var_2_0
		var_2_4.skillExpTable = var_2_2
		getProxy = var_4
		MetaCharacterProxy = var_5

		local var_2_6 = var_4(var_5)

		var_4.setMetaTacticsInfo(var_2_6, arg_2_0)

		local var_2_7 = arg_1_0
		local var_2_8 = var_4.sendNotification

		GAME = var_6

		var_2_8(var_2_7, var_6.TACTICS_META_INFO_REQUEST_DONE, var_2_4)

		return
	end)

	return
end

return var_0_1
