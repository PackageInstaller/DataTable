class = var_0_10000

local var_0_0 = "ActivityDrawAwardCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	ActivityProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)

	if not var_3.getActivityById(var_1_2, var_1_1.activity_id) or var_3:isEnd() then
		return
	end

	switch = var_1_2

	if not var_1_2(var_1_1.op, {
		set_list = function()
			local var_2_0 = var_0

			if not var_0.CheckList(var_2_0, var_1_1.list) then
				return nil
			end

			local var_2_1 = {
				cmd = 1,
				arg1 = 0,
				arg2 = 0,
				activity_id = var_1_1.activity_id
			}

			underscore = var_1
			var_2_1.arg_list = var_1.to_array(var_1_1.list)

			return var_2_1
		end,
		do_draw = function()
			local var_3_0 = var_1_1.count
			local var_3_1 = var_0

			if var_3_0 > var_1.GetDrawTimes(var_3_1) then
				return nil
			end

			return {
				cmd = 2,
				arg2 = 0,
				activity_id = var_1_1.activity_id,
				arg1 = var_1_1.count,
				arg_list = {}
			}
		end,
		count_award = function()
			local var_4_0 = var_0

			if not var_0.CanCountAward(var_4_0, var_1_1.target_id) then
				return nil
			end

			return {
				cmd = 3,
				arg2 = 0,
				activity_id = var_1_1.activity_id,
				arg1 = var_1_1.target_id,
				arg_list = {}
			}
		end
	}, function()
		assert = var_2_10000

		var_2_10000(false, "error draw award activity cmd:" .. var_1_1.op)

		return
	end) then
		return
	end

	pg = var_5

	local var_1_3 = var_5.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 11202, var_4, 11203, function(arg_6_0)
		local var_6_0

		if arg_6_0.result == 0 then
			IslandDropHelper = var_6_0
			var_6_0 = var_6_0.AddItems({
				drop_list = arg_6_0.award_list
			})
			getProxy = var_2
			ActivityProxy = var_2_10003
			var_2_10003 = var_2(var_2_10003)

			local var_6_1 = var_2.getActivityById(var_2_10003, var_1_1.activity_id)

			var_2_10003 = {}
			switch = var_4

			var_4(var_1_1.op, {
				set_list = function()
					local var_7_0 = var_6_1

					var_0.SetList(var_7_0, var_1_1.list)

					return
				end,
				do_draw = function()
					underscore = var_3_10000
					var_2_10003 = var_3_10000.to_array(arg_6_0.number)

					local var_8_0 = var_6_1

					var_0.ResultDraw(var_8_0, var_2_10003)

					return
				end,
				count_award = function()
					var_2_10003 = {
						var_1_1.target_id
					}

					local var_9_0 = var_6_1

					var_0.CountAward(var_9_0, var_1_1.target_id)

					return
				end
			}, function()
				assert = var_3_10000

				var_3_10000(false, "error draw award activity cmd:" .. var_1_1.op)

				return
			end)

			getProxy = var_4
			ActivityProxy = var_5

			local var_6_2 = var_4(var_5)

			var_4.updateActivity(var_6_2, var_6_1)

			local var_6_3 = arg_1_0
			local var_6_4 = var_4.sendNotification

			GAME = var_6

			var_6_4(var_6_3, var_6.ACTIVITY_DRAW_AWARD_OPERATION_DONE, {
				op = var_1_1.op,
				dropData = var_6_0,
				awards = var_2_10003
			})
		else
			pg = var_6_0

			local var_6_5 = var_6_0.TipsMgr.GetInstance()
			local var_6_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_6_6(var_6_5, var_2_10003[arg_6_0.result] .. arg_6_0.result)
		end

		return
	end)

	return
end

return var_0_1
