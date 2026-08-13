class = var_0_10000

local var_0_0 = "PlayerResChangeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().oldPlayer
	local var_1_1 = var_2.newPlayer
	local var_1_2 = false

	pg = var_1_10006

	for iter_1_0 = #var_1_10006.player_resource.all, 1, -1 do
		local var_1_3 = var_6[iter_1_0]

		if var_1_0:getResource(var_1_3) ~= var_1_1:getResource(var_1_3) then
			var_1_2 = true

			break
		end
	end

	if var_1_2 then
		arg_1_0:UpdateActivies(var_1_0, var_1_1)
	end

	return
end

local function var_0_2(arg_2_0, arg_2_1, arg_2_2)
	PlayerConst = var_1_10003

	if arg_2_2 == var_1_10003.ResDiamond then
		return arg_2_1:getChargeGem() - arg_2_0:getChargeGem()
	else
		PlayerConst = var_3

		if arg_2_2 == var_3.ResFreeDiamond then
			return arg_2_1:getFreeGem() - arg_2_0:getFreeGem()
		end
	end

	return arg_2_1:getResource(arg_2_2) - arg_2_0:getResource(arg_2_2)
end

function var_0_1.UpdateActivies(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0

	if not arg_3_0.activityProxy then
		getProxy = var_3_0
		ActivityProxy = var_1_10004
		var_3_0 = var_3_0(var_1_10004)
	end

	arg_3_0.activityProxy = var_3_0

	local var_3_1 = {}

	ipairs = var_1_10004

	local var_3_2 = arg_3_0.activityProxy
	local var_3_3 = var_5.getActivitiesByType

	ActivityConst = var_1_10007

	for iter_3_0, iter_3_1 in var_1_10004(var_3_3(var_3_2, var_1_10007.ACTIVITY_TYPE_PT_RANK)) do
		local var_3_4 = iter_3_1

		var_1_10009 = iter_3_1.getConfig(var_3_4, "config_id")
		assert = var_3_4

		var_3_4(var_1_10009)

		local var_3_6

		if not var_3_1[var_1_10009] then
			local var_3_5 = arg_3_2:getResource(var_1_10009)

			var_1_10012 = arg_3_1
			var_3_6 = var_3_5 - arg_3_1.getResource(var_1_10012, var_1_10009)
		end

		var_3_1[var_1_10009] = var_3_6

		var_0_1.UpdateActivity(iter_3_1, var_3_1[var_1_10009])
	end

	ipairs = var_4

	local var_3_7 = arg_3_0.activityProxy
	local var_3_8 = var_5.getActivitiesByType

	ActivityConst = iter_3_0

	for iter_3_2, iter_3_3 in var_4(var_3_8(var_3_7, iter_3_0.ACTIVITY_TYPE_BOSS_RANK)) do
		local var_3_9 = iter_3_3

		var_1_10009 = iter_3_3.getConfig(var_3_9, "config_id")
		assert = var_3_9

		var_3_9(var_1_10009)

		local var_3_11

		if not var_3_1[var_1_10009] then
			local var_3_10 = arg_3_2:getResource(var_1_10009)

			var_1_10012 = arg_3_1
			var_3_11 = var_3_10 - arg_3_1.getResource(var_1_10012, var_1_10009)
		end

		var_3_1[var_1_10009] = var_3_11

		var_0_1.UpdateActivity(iter_3_3, var_3_1[var_1_10009])
	end

	ipairs = var_4

	local var_3_12 = arg_3_0.activityProxy
	local var_3_13 = var_5.getActivitiesByType

	ActivityConst = iter_3_2

	for iter_3_4, iter_3_5 in var_4(var_3_13(var_3_12, iter_3_2.ACTIVITY_TYPE_RETURN_AWARD)) do
		pg = var_1_10009
		var_1_10009 = var_1_10009.activity_template_headhunting[iter_3_5.id]
		assert = var_10

		var_10(var_1_10009)

		local var_3_14

		if not var_3_1[var_1_10009.pt] then
			var_1_10012 = arg_3_2
			var_3_14 = arg_3_2.getResource(var_1_10012, var_10) - arg_3_1:getResource(var_10)
		end

		var_3_1[var_10] = var_3_14

		var_0_1.UpdateActivity(iter_3_5, var_3_1[var_10])
	end

	ipairs = var_4

	local var_3_15 = arg_3_0.activityProxy
	local var_3_16 = var_5.getActivitiesByType

	ActivityConst = iter_3_4

	for iter_3_6, iter_3_7 in var_4(var_3_16(var_3_15, iter_3_4.ACTIVITY_TYPE_PIZZA_PT)) do
		local var_3_17 = iter_3_7
		local var_3_18 = iter_3_7.getDataConfig(var_3_17, "pt")

		assert = var_3_17

		var_3_17(var_3_18)

		local var_3_20

		if not var_3_1[var_3_18] then
			local var_3_19 = arg_3_2:getResource(var_3_18)

			var_1_10012 = arg_3_1
			var_3_20 = var_3_19 - arg_3_1.getResource(var_1_10012, var_3_18)
		end

		var_3_1[var_3_18] = var_3_20

		var_0_1.UpdateActivity(iter_3_7, var_3_1[var_3_18])
	end

	ipairs = var_4

	local var_3_21 = arg_3_0.activityProxy
	local var_3_22 = var_5.getActivitiesByType

	ActivityConst = iter_3_6

	for iter_3_8, iter_3_9 in var_4(var_3_22(var_3_21, iter_3_6.ACTIVITY_TYPE_PT_BUFF)) do
		local var_3_23 = iter_3_9:getDataConfig("pt")

		if 0 < var_3_23 then
			assert = var_10

			var_10(var_3_23)

			PlayerConst = var_10

			if var_3_23 == var_10.ResDiamond then
				local var_3_24 = {}

				PlayerConst = var_11
				var_3_24[1] = var_11.ResFreeDiamond
				PlayerConst = var_11
				var_3_24[2] = var_11.ResDiamond

				if not var_3_24 then
					var_3_24 = {
						var_3_23
					}
				end

				local var_3_25 = 0

				ipairs = var_1_10012

				for iter_3_10, iter_3_11 in var_1_10012(var_3_24) do
					local var_3_26

					if not var_3_1[iter_3_11] then
						var_3_26 = var_0_2(arg_3_1, arg_3_2, iter_3_11)
					end

					var_3_1[iter_3_11] = var_3_26
					var_3_25 = var_3_25 + var_3_1[iter_3_11]
				end

				var_0_1.UpdateActivity(iter_3_9, var_3_25)
			end
		end
	end

	return
end

function var_0_1.UpdateActivity(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_4_0 = var_1_10002(var_1_10003)
	local var_4_1 = arg_4_0:getConfig("type")

	arg_4_0 = var_4_0:getActivityById(arg_4_0.id)
	ActivityConst = var_4

	if var_4_1 == var_4.ACTIVITY_TYPE_PT_RANK then
		if not arg_4_0:isEnd() and 0 < arg_4_1 then
			arg_4_0.data1 = arg_4_0.data1 + arg_4_1

			var_4_0:updateActivity(arg_4_0)
		end
	else
		ActivityConst = var_4

		if var_4_1 == var_4.ACTIVITY_TYPE_BOSS_RANK then
			if arg_4_1 ~= 0 then
				arg_4_0.data1 = arg_4_0.data1 + arg_4_1

				var_4_0:updateActivity(arg_4_0)
			end
		else
			ActivityConst = var_4

			local var_4_2

			if var_4_1 == var_4.ACTIVITY_TYPE_RETURN_AWARD then
				pg = var_4_2
				var_4_2 = var_4_2.activity_template_headhunting[arg_4_0.id]
				assert = var_5

				var_5(var_4_2)

				if arg_4_1 ~= 0 then
					arg_4_0.data3 = arg_4_0.data3 + arg_4_1

					var_4_0:updateActivity(arg_4_0)
				end
			else
				ActivityConst = var_4_2

				local var_4_3

				if var_4_1 == var_4_2.ACTIVITY_TYPE_PIZZA_PT then
					var_4_3 = arg_4_0:getDataConfig("pt")

					if arg_4_0:getDataConfig("type") == 1 then
						math = var_5
						arg_4_1 = var_5.max(arg_4_1, 0)
					elseif arg_4_0:getDataConfig("type") == 2 then
						math = var_5
						arg_4_1 = var_5.min(arg_4_1, 0)
					else
						arg_4_1 = 0
					end

					local var_4_4 = arg_4_0

					if not arg_4_0.isEnd(var_4_4) and arg_4_1 ~= 0 then
						local var_4_5 = arg_4_0.data1

						math = var_4_4
						arg_4_0.data1 = var_4_5 + var_4_4.abs(arg_4_1)

						var_4_0:updateActivity(arg_4_0)
					end
				else
					ActivityConst = var_4_3

					if var_4_1 == var_4_3.ACTIVITY_TYPE_PT_BUFF and arg_4_0:getDataConfig("pt") > 0 then
						local var_4_6 = arg_4_0:getDataConfig("type") == 2

						if arg_4_0:getDataConfig("type") == 1 then
							math = var_6
							arg_4_1 = var_6.max(arg_4_1, 0)
						elseif var_4_6 then
							math = var_6
							arg_4_1 = var_6.min(arg_4_1, 0)
						else
							arg_4_1 = 0
						end

						local var_4_7 = arg_4_0

						if not arg_4_0.isEnd(var_4_7) and (arg_4_1 > 0 or var_4_6) then
							local var_4_8 = arg_4_0.data1

							math = var_4_7
							arg_4_0.data1 = var_4_8 + var_4_7.abs(arg_4_1)

							var_4_0:updateActivity(arg_4_0)
						end
					end
				end
			end
		end
	end

	return
end

return var_0_1
