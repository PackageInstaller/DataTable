local var_0_0 = class("ActivityDrawAwardCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(ActivityProxy):getActivityById(var_1_0.activity_id)

	if not var_1_1 or var_1_1:isEnd() then
		return
	end

	local var_1_2 = switch(var_1_0.op, {
		set_list = function()
			if not var_1_1:CheckList(var_1_0.list) then
				return nil
			end

			return {
				cmd = 1,
				arg1 = 0,
				arg2 = 0,
				activity_id = var_1_0.activity_id,
				arg_list = underscore.to_array(var_1_0.list)
			}
		end,
		do_draw = function()
			if var_1_0.count > var_1_1:GetDrawTimes() then
				return nil
			end

			return {
				cmd = 2,
				arg2 = 0,
				activity_id = var_1_0.activity_id,
				arg1 = var_1_0.count,
				arg_list = {}
			}
		end,
		count_award = function()
			if not var_1_1:CanCountAward(var_1_0.target_id) then
				return nil
			end

			return {
				cmd = 3,
				arg2 = 0,
				activity_id = var_1_0.activity_id,
				arg1 = var_1_0.target_id,
				arg_list = {}
			}
		end
	}, function()
		assert(false, "error draw award activity cmd:" .. var_1_0.op)

		return
	end)

	if not var_1_2 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(11202, var_1_2, 11203, function(arg_6_0)
		if arg_6_0.result == 0 then
			local var_6_0 = getProxy(ActivityProxy):getActivityById(var_1_0.activity_id)
			local var_6_1 = {}

			switch(var_1_0.op, {
				set_list = function()
					var_6_0:SetList(var_1_0.list)

					return
				end,
				do_draw = function()
					var_6_1 = underscore.to_array(arg_6_0.number)

					var_6_0:ResultDraw(var_6_1)

					return
				end,
				count_award = function()
					var_6_1 = {
						var_1_0.target_id
					}

					var_6_0:CountAward(var_1_0.target_id)

					return
				end
			}, function()
				assert(false, "error draw award activity cmd:" .. var_1_0.op)

				return
			end)
			getProxy(ActivityProxy):updateActivity((getProxy(ActivityProxy):getActivityById(var_1_0.activity_id)))
			arg_1_0:sendNotification(GAME.ACTIVITY_DRAW_AWARD_OPERATION_DONE, {
				op = var_1_0.op,
				dropData = IslandDropHelper.AddItems({
					drop_list = arg_6_0.award_list
				}),
				awards = {}
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_6_0.result] .. arg_6_0.result)
		end

		return
	end)

	return
end

return var_0_0
