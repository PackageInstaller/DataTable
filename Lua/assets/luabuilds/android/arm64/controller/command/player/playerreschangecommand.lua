local var_0_0 = class("PlayerResChangeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = false

	for iter_1_0 = #pg.player_resource.all, 1, -1 do
		if var_1_0.oldPlayer:getResource(pg.player_resource.all[iter_1_0]) ~= var_1_0.newPlayer:getResource(pg.player_resource.all[iter_1_0]) then
			var_1_1 = true

			break
		end
	end

	if var_1_1 then
		arg_1_0:UpdateActivies(var_1_0.oldPlayer, var_1_0.newPlayer)
	end

	return
end

local function var_0_1(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 == PlayerConst.ResDiamond then
		return arg_2_1:getChargeGem() - arg_2_0:getChargeGem()
	elseif arg_2_2 == PlayerConst.ResFreeDiamond then
		return arg_2_1:getFreeGem() - arg_2_0:getFreeGem()
	end

	return arg_2_1:getResource(arg_2_2) - arg_2_0:getResource(arg_2_2)
end

function var_0_0.UpdateActivies(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.activityProxy = arg_3_0.activityProxy or getProxy(ActivityProxy)

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.activityProxy:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK)) do
		local var_3_1 = iter_3_1:getConfig("config_id")

		assert(var_3_1)

		var_3_0[var_3_1] = var_3_0[var_3_1] or arg_3_2:getResource(var_3_1) - arg_3_1:getResource(var_3_1)

		var_0_0.UpdateActivity(iter_3_1, var_3_0[var_3_1])
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_0.activityProxy:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_BOSS_RANK)) do
		local var_3_2 = iter_3_3:getConfig("config_id")

		assert(var_3_2)

		var_3_0[var_3_2] = var_3_0[var_3_2] or arg_3_2:getResource(var_3_2) - arg_3_1:getResource(var_3_2)

		var_0_0.UpdateActivity(iter_3_3, var_3_0[var_3_2])
	end

	for iter_3_4, iter_3_5 in ipairs(arg_3_0.activityProxy:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_RETURN_AWARD)) do
		assert(pg.activity_template_headhunting[iter_3_5.id])

		var_3_0[pg.activity_template_headhunting[iter_3_5.id].pt] = var_3_0[pg.activity_template_headhunting[iter_3_5.id].pt] or arg_3_2:getResource(pg.activity_template_headhunting[iter_3_5.id].pt) - arg_3_1:getResource(pg.activity_template_headhunting[iter_3_5.id].pt)

		var_0_0.UpdateActivity(iter_3_5, var_3_0[pg.activity_template_headhunting[iter_3_5.id].pt])
	end

	for iter_3_6, iter_3_7 in ipairs(arg_3_0.activityProxy:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PIZZA_PT)) do
		local var_3_3 = iter_3_7:getDataConfig("pt")

		assert(var_3_3)

		var_3_0[var_3_3] = var_3_0[var_3_3] or arg_3_2:getResource(var_3_3) - arg_3_1:getResource(var_3_3)

		var_0_0.UpdateActivity(iter_3_7, var_3_0[var_3_3])
	end

	for iter_3_8, iter_3_9 in ipairs(arg_3_0.activityProxy:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_BUFF)) do
		local var_3_4 = iter_3_9:getDataConfig("pt")

		if var_3_4 > 0 then
			assert(var_3_4)

			if var_3_4 == PlayerConst.ResDiamond then
				local var_3_5 = {
					PlayerConst.ResFreeDiamond,
					PlayerConst.ResDiamond
				}

				if not {
					PlayerConst.ResFreeDiamond,
					PlayerConst.ResDiamond
				} then
					var_3_5 = {
						var_3_4
					}
				end

				local var_3_6 = 0

				for iter_3_10, iter_3_11 in ipairs(var_3_5) do
					var_3_0[iter_3_11] = var_3_0[iter_3_11] or var_0_1(arg_3_1, arg_3_2, iter_3_11)
					var_3_6 = var_3_6 + var_3_0[iter_3_11]
				end

				var_0_0.UpdateActivity(iter_3_9, var_3_6)
			end
		end
	end

	return
end

function var_0_0.UpdateActivity(arg_4_0, arg_4_1)
	local var_4_0 = getProxy(ActivityProxy)
	local var_4_1 = arg_4_0:getConfig("type")

	arg_4_0 = var_4_0:getActivityById(arg_4_0.id)

	if var_4_1 == ActivityConst.ACTIVITY_TYPE_PT_RANK then
		if not arg_4_0:isEnd() and arg_4_1 > 0 then
			arg_4_0.data1 = arg_4_0.data1 + arg_4_1

			var_4_0:updateActivity(arg_4_0)
		end
	elseif var_4_1 == ActivityConst.ACTIVITY_TYPE_BOSS_RANK then
		if arg_4_1 ~= 0 then
			arg_4_0.data1 = arg_4_0.data1 + arg_4_1

			var_4_0:updateActivity(arg_4_0)
		end
	elseif var_4_1 == ActivityConst.ACTIVITY_TYPE_RETURN_AWARD then
		assert(pg.activity_template_headhunting[arg_4_0.id])

		if arg_4_1 ~= 0 then
			arg_4_0.data3 = arg_4_0.data3 + arg_4_1

			var_4_0:updateActivity(arg_4_0)
		end
	elseif var_4_1 == ActivityConst.ACTIVITY_TYPE_PIZZA_PT then
		local var_4_2 = arg_4_0:getDataConfig("pt")

		arg_4_1 = arg_4_0:getDataConfig("type") == 1 and math.max(arg_4_1, 0) or arg_4_0:getDataConfig("type") == 2 and math.min(arg_4_1, 0) or 0

		if not arg_4_0:isEnd() and arg_4_1 ~= 0 then
			arg_4_0.data1 = arg_4_0.data1 + math.abs(arg_4_1)

			var_4_0:updateActivity(arg_4_0)
		end
	elseif var_4_1 == ActivityConst.ACTIVITY_TYPE_PT_BUFF and arg_4_0:getDataConfig("pt") > 0 then
		local var_4_3 = arg_4_0:getDataConfig("type") == 2

		arg_4_1 = arg_4_0:getDataConfig("type") == 1 and math.max(arg_4_1, 0) or var_4_3 and math.min(arg_4_1, 0) or 0

		if not arg_4_0:isEnd() and (arg_4_1 > 0 or var_4_3) then
			arg_4_0.data1 = arg_4_0.data1 + math.abs(arg_4_1)

			var_4_0:updateActivity(arg_4_0)
		end
	end

	return
end

return var_0_0
