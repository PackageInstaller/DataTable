local PlayerResChangeCommand = class("PlayerResChangeCommand", pm.SimpleCommand)

function PlayerResChangeCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = false

	for iter_1_0 = #pg.player_resource.all, 1, -1 do
		if var_1_0.oldPlayer:getResource(pg.player_resource.all[iter_1_0]) ~= var_1_0.newPlayer:getResource(pg.player_resource.all[iter_1_0]) then
			var_1_1 = true

			break
		end
	end

	if var_1_1 then
		self:UpdateActivies(var_1_0.oldPlayer, var_1_0.newPlayer)
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

function PlayerResChangeCommand:UpdateActivies(arg_3_1, arg_3_2)
	self.activityProxy = self.activityProxy or getProxy(ActivityProxy)

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(self.activityProxy:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK)) do
		local var_3_1 = iter_3_1:getConfig("config_id")

		assert(var_3_1)

		var_3_0[var_3_1] = var_3_0[var_3_1] or arg_3_2:getResource(var_3_1) - arg_3_1:getResource(var_3_1)

		PlayerResChangeCommand.UpdateActivity(iter_3_1, var_3_0[var_3_1])
	end

	for iter_3_2, iter_3_3 in ipairs(self.activityProxy:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_BOSS_RANK)) do
		local var_3_2 = iter_3_3:getConfig("config_id")

		assert(var_3_2)

		var_3_0[var_3_2] = var_3_0[var_3_2] or arg_3_2:getResource(var_3_2) - arg_3_1:getResource(var_3_2)

		PlayerResChangeCommand.UpdateActivity(iter_3_3, var_3_0[var_3_2])
	end

	for iter_3_4, iter_3_5 in ipairs(self.activityProxy:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_RETURN_AWARD)) do
		assert(pg.activity_template_headhunting[iter_3_5.id])

		var_3_0[pg.activity_template_headhunting[iter_3_5.id].pt] = var_3_0[pg.activity_template_headhunting[iter_3_5.id].pt] or arg_3_2:getResource(pg.activity_template_headhunting[iter_3_5.id].pt) - arg_3_1:getResource(pg.activity_template_headhunting[iter_3_5.id].pt)

		PlayerResChangeCommand.UpdateActivity(iter_3_5, var_3_0[pg.activity_template_headhunting[iter_3_5.id].pt])
	end

	for iter_3_6, iter_3_7 in ipairs(self.activityProxy:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PIZZA_PT)) do
		local var_3_3 = iter_3_7:getDataConfig("pt")

		assert(var_3_3)

		var_3_0[var_3_3] = var_3_0[var_3_3] or arg_3_2:getResource(var_3_3) - arg_3_1:getResource(var_3_3)

		PlayerResChangeCommand.UpdateActivity(iter_3_7, var_3_0[var_3_3])
	end

	for iter_3_8, iter_3_9 in ipairs(self.activityProxy:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_BUFF)) do
		local var_3_4 = iter_3_9:getDataConfig("pt")

		if var_3_4 > 0 then
			assert(var_3_4)

			local var_3_5 = 0

			for iter_3_10, iter_3_11 in ipairs(var_3_4 == PlayerConst.ResDiamond and {
				PlayerConst.ResFreeDiamond,
				PlayerConst.ResDiamond
			} or {
				var_3_4
			}) do
				var_3_0[iter_3_11] = var_3_0[iter_3_11] or var_0_1(arg_3_1, arg_3_2, iter_3_11)
				var_3_5 = var_3_5 + var_3_0[iter_3_11]
			end

			PlayerResChangeCommand.UpdateActivity(iter_3_9, var_3_5)
		end
	end

	return
end

function PlayerResChangeCommand:UpdateActivity(arg_4_1)
	local var_4_0 = getProxy(ActivityProxy)
	local var_4_1 = self:getConfig("type")

	self = var_4_0:getActivityById(self.id)

	if var_4_1 == ActivityConst.ACTIVITY_TYPE_PT_RANK then
		if not self:isEnd() and arg_4_1 > 0 then
			self.data1 = self.data1 + arg_4_1

			var_4_0:updateActivity(self)
		end
	elseif var_4_1 == ActivityConst.ACTIVITY_TYPE_BOSS_RANK then
		if arg_4_1 ~= 0 then
			self.data1 = self.data1 + arg_4_1

			var_4_0:updateActivity(self)
		end
	elseif var_4_1 == ActivityConst.ACTIVITY_TYPE_RETURN_AWARD then
		assert(pg.activity_template_headhunting[self.id])

		if arg_4_1 ~= 0 then
			self.data3 = self.data3 + arg_4_1

			var_4_0:updateActivity(self)
		end
	elseif var_4_1 == ActivityConst.ACTIVITY_TYPE_PIZZA_PT then
		local var_4_2 = self:getDataConfig("pt")

		arg_4_1 = self:getDataConfig("type") == 1 and math.max(arg_4_1, 0) or self:getDataConfig("type") == 2 and math.min(arg_4_1, 0) or 0

		if not self:isEnd() and arg_4_1 ~= 0 then
			self.data1 = self.data1 + math.abs(arg_4_1)

			var_4_0:updateActivity(self)
		end
	elseif var_4_1 == ActivityConst.ACTIVITY_TYPE_PT_BUFF and self:getDataConfig("pt") > 0 then
		local var_4_3 = self:getDataConfig("type") == 2

		arg_4_1 = self:getDataConfig("type") == 1 and math.max(arg_4_1, 0) or var_4_3 and math.min(arg_4_1, 0) or 0

		if not self:isEnd() and (arg_4_1 > 0 or var_4_3) then
			self.data1 = self.data1 + math.abs(arg_4_1)

			var_4_0:updateActivity(self)
		end
	end

	return
end

return PlayerResChangeCommand
