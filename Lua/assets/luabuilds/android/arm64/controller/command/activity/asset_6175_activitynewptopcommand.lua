local ActivityNewPtOPCommand = class("ActivityNewPtOPCommand", pm.SimpleCommand)

function ActivityNewPtOPCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = getProxy(ActivityProxy)
	local var_1_3 = var_1_2:getActivityById(var_1_0.activity_id)

	if not var_1_3 or var_1_3:isEnd() then
		return
	end

	local var_1_4 = {
		activity_id = var_1_0.activity_id
	}

	var_1_4.cmd = var_1_0.cmd or 0
	var_1_4.arg1 = var_1_0.arg1 or 0
	var_1_4.arg2 = var_1_0.arg2 or 0
	var_1_4.arg_list = {}

	pg.ConnectionMgr.GetInstance():Send(11202, var_1_4, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = {}

			if var_1_0.cmd == 1 then
				var_2_0 = PlayerConst.addTranDrop(arg_2_0.award_list)
				var_1_3 = var_1_2:getActivityById(var_1_0.activity_id)

				table.insert(var_1_3.data1_list, var_1_0.arg1)

				if var_1_3:getConfig("type") == ActivityConst.ACTIVITY_TYPE_PIZZA_PT and var_1_0.arg2 and var_1_0.arg2 > 0 then
					table.insert(var_1_3.data2_list, var_1_0.arg2)
				end
			elseif var_1_0.cmd == 2 then
				var_1_3.data3 = arg_2_0.number[1]
			elseif var_1_0.cmd == 3 then
				var_2_0 = PlayerConst.addTranDrop(arg_2_0.award_list)
				var_1_3 = var_1_2:getActivityById(var_1_0.activity_id)

				if var_1_0.arg1 and var_1_0.arg1 > 0 then
					table.insert(var_1_3.data2_list, var_1_0.arg1)
				end

				local var_2_1 = var_1_0.oldBuffId or 0

				for iter_2_0, iter_2_1 in ipairs(var_1_3.data3_list) do
					if iter_2_1 == var_2_1 then
						var_1_3.data3_list[iter_2_0] = var_1_0.arg2
					end
				end
			elseif var_1_0.cmd == 4 then
				var_2_0 = PlayerConst.addTranDrop(arg_2_0.award_list)
				var_1_3 = var_1_2:getActivityById(var_1_0.activity_id)

				for iter_2_2, iter_2_3 in ipairs((var_1_3:getDataConfig("target"))) do
					if iter_2_3 <= var_1_0.arg1 then
						if not table.contains(var_1_3.data1_list, iter_2_3) then
							table.insert(var_1_3.data1_list, iter_2_3)
						end
					else
						break
					end
				end
			elseif var_1_0.cmd == 5 then
				var_1_3.data1 = var_1_3.data1 + arg_2_0.number[1]

				local var_2_2 = getProxy(PlayerProxy)
				local var_2_3 = var_2_2:getRawData()

				var_2_3:consume({
					[id2res(var_1_0.arg1)] = arg_2_0.number[1]
				})
				var_2_2:updatePlayer(var_2_3)
			end

			var_1_2:updateActivity(var_1_3)
			self:sendNotification(GAME.ACT_NEW_PT_DONE, {
				awards = var_2_0,
				callback = var_1_1
			})
		else
			originalPrint(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return ActivityNewPtOPCommand
