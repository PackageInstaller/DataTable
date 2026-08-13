class = var_0_10000

local var_0_0 = "ActivityDreamlandOPCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	ActivityProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)

	if not var_3.getActivityById(var_1_1, var_1_0.activity_id) or var_4:isEnd() then
		return
	end

	print = var_1_10005

	var_1_10005(var_1_0.activity_id, var_1_0.cmd, var_1_0.arg1, var_1_0.arg2)

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()
	local var_1_3 = var_5.Send
	local var_1_4 = 11202
	local var_1_5 = {
		activity_id = var_1_0.activity_id
	}
	local var_1_6

	if not var_1_0.cmd then
		var_1_6 = 0
	end

	var_1_5.cmd = var_1_6

	local var_1_7

	if not var_1_0.arg1 then
		var_1_7 = 0
	end

	var_1_5.arg1 = var_1_7

	local var_1_8

	if not var_1_0.arg2 then
		var_1_8 = 0
	end

	var_1_5.arg2 = var_1_8
	var_1_5.arg_list = {}

	var_1_3(var_1_2, var_1_4, var_1_5, 11203, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = var_1_0.cmd
			DreamlandData = var_2_10002

			if var_2_0 == var_2_10002.OP_GET_MAP_AWARD then
				table = var_2_0

				var_2_0.insert(var_0.data1_list, var_1_0.arg1)
			else
				var_2_0 = var_1_0.cmd
				DreamlandData = var_2

				if var_2_0 == var_2.OP_GET_EXPLORE_AWARD then
					table = var_2_0

					var_2_0.insert(var_0.data2_list, var_1_0.arg1)
				else
					var_2_0 = var_1_0.cmd
					DreamlandData = var_2

					if var_2_0 == var_2.OP_RECORD_EXPLORE then
						table = var_2_0

						var_2_0.insert(var_0.data3_list, var_1_0.arg1)
					end
				end
			end

			PlayerConst = var_2_0
			var_2_0 = var_2_0.addTranDrop(arg_2_0.award_list)
			var_2_10004 = var_0

			var_2.updateActivity(var_2_10004, var_0)

			var_2_10004 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = var_5

			var_2_1(var_2_10004, var_5.ACTIVITY_DREAMLAND_OP_DONE, {
				activity = var_0,
				cmd = var_1_0.cmd,
				awards = var_2_0
			})
		else
			pg = var_2_0

			local var_2_2 = var_2_0.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_3(var_2_2, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
