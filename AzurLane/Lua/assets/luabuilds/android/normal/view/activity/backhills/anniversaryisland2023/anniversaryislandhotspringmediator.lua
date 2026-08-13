class = var_0_10000

local var_0_0 = "AnniversaryIslandHotSpringMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.BackHills.NewYearFestival.NewYearHotSpringMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.OPEN_CHUANWU, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0

		var_3.OnSelShips(var_2_0, arg_2_1, arg_2_2)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_3
	arg_1_0.activity = var_1_2(var_1_1, var_3.ACTIVITY_TYPE_HOTSPRING_2)

	local var_1_3 = arg_1_0.viewComponent

	var_2.SetActivity(var_1_3, var_1)
	arg_1_0:bind(var_0_1.OPEN_INFO, function()
		local var_3_0 = arg_1_0
		local var_3_1 = var_0.addSubLayers

		Context = var_2_10002

		local var_3_2 = var_2_10002.New
		local var_3_3 = {}

		AnniversaryIslandSpringShipSelectMediator = var_2_10004
		var_3_3.mediator = var_2_10004
		AnniversaryIslandSpringShipSelectLayer = var_2_10004
		var_3_3.viewComponent = var_2_10004
		var_3_3.data = {
			actId = var_0.id
		}

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)

	return
end

function var_0_1.OnSelected(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	Clone = var_1_10004

	local var_4_0 = arg_4_0.activity
	local var_4_1 = var_1_10004(var_5.GetShipIds(var_4_0))

	_ = var_5

	local var_4_2 = var_5.each

	_ = var_4_0

	local var_4_3 = var_4_0.range
	local var_4_4 = arg_4_0.activity

	var_4_2(var_4_3(var_7.GetSlotCount(var_4_4)), function(arg_5_0)
		local var_5_0 = var_4_1
		local var_5_1

		if not var_4_1[arg_5_0] then
			var_5_1 = 0
		end

		var_5_0[arg_5_0] = var_5_1

		return
	end)

	if arg_4_2 == nil or #arg_4_2 == 0 then
		var_4_2 = var_4_1[arg_4_1]

		local var_4_6

		if 0 < var_4_2 then
			local var_4_5 = arg_4_0

			var_4_6 = arg_4_0.sendNotification
			GAME = var_4_4

			local var_4_7 = var_4_4.ACTIVITY_OPERATION
			local var_4_8 = {
				activity_id = arg_4_0.activity.id
			}

			Spring2Activity = var_10
			var_4_8.cmd = var_10.OPERATION_SETSHIP
			var_4_8.kvargs1 = {
				{
					value = 0,
					key = arg_4_1
				}
			}

			var_4_6(var_4_5, var_4_7, var_4_8)
		end

		existCall = var_4_6

		var_4_6(arg_4_3)

		return
	end

	_ = var_4_2

	local var_4_9 = var_4_2.filter(arg_4_2, function(arg_6_0)
		table = var_2_10001

		return not var_2_10001.contains(var_4_1, arg_6_0)
	end)

	table = var_6

	var_6.Foreach(var_4_1, function(arg_7_0, arg_7_1)
		if arg_7_1 ~= 0 then
			table = var_2_10002

			if var_2_10002.contains(arg_4_2, arg_7_1) then
				return
			end

			var_4_1[arg_7_0] = 0

			return
		end
	end)

	if #var_4_9 == 1 and var_4_1[arg_4_1] == 0 then
		var_4_1[arg_4_1] = var_4_9[1]
	else
		local var_4_10 = 0

		_ = var_7

		var_7.each(var_4_9, function(arg_8_0)
			while var_4_10 <= #var_4_1 do
				var_4_10 = var_4_10 + 1

				if var_4_1[var_4_10] == 0 then
					break
				end
			end

			var_4_1[var_4_10] = arg_8_0

			return
		end)
	end

	local var_4_11 = {}
	local var_4_12 = arg_4_0.activity
	local var_4_13 = var_7.GetShipIds(var_4_12)

	table = var_4_12

	var_4_12.Foreach(var_4_1, function(arg_9_0, arg_9_1)
		local var_9_0

		if not var_4_13[arg_9_0] then
			var_9_0 = 0
		end

		if var_9_0 ~= arg_9_1 then
			table = var_2_10003

			var_2_10003.insert(var_4_11, {
				key = arg_9_0,
				value = arg_9_1
			})
		end

		return
	end)

	if #var_4_11 > 0 then
		local var_4_14 = arg_4_0
		local var_4_15 = arg_4_0.sendNotification

		GAME = var_10

		local var_4_16 = var_10.ACTIVITY_OPERATION
		local var_4_17 = {
			activity_id = arg_4_0.activity.id
		}

		Spring2Activity = var_12
		var_4_17.cmd = var_12.OPERATION_SETSHIP
		var_4_17.kvargs1 = var_4_11

		var_4_15(var_4_14, var_4_16, var_4_17)
	end

	arg_4_3()

	return
end

function var_0_1.listNotificationInterests(arg_10_0)
	local var_10_0 = {}

	PlayerProxy = var_1_10002
	var_10_0[1] = var_1_10002.UPDATED
	ActivityProxy = var_2
	var_10_0[2] = var_2.ACTIVITY_UPDATED
	ActivityProxy = var_2
	var_10_0[3] = var_2.ACTIVITY_SHOW_AWARDS
	var_10_0[4] = var_0_1.OPEN_CHUANWU

	return var_10_0
end

function var_0_1.handleNotification(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1
	local var_11_2 = arg_11_1.getBody(var_11_1)

	if var_11_0 == nil then
		-- block empty
	else
		ActivityProxy = var_11_1

		local var_11_4

		if var_11_0 == var_11_1.ACTIVITY_SHOW_AWARDS then
			local var_11_3 = arg_11_0.viewComponent

			var_11_4 = var_11_4.emit
			BaseUI = var_1_10006

			var_11_4(var_11_3, var_1_10006.ON_ACHIEVE, var_11_2.awards, var_11_2.callback)
		else
			ActivityProxy = var_11_4

			if var_11_0 == var_11_4.ACTIVITY_UPDATED then
				local var_11_5 = var_11_2
				local var_11_6 = var_11_2.getConfig(var_11_5, "type")

				ActivityConst = var_11_5

				if var_11_6 == var_11_5.ACTIVITY_TYPE_HOTSPRING_2 then
					arg_11_0.activity = var_11_2

					local var_11_7 = arg_11_0.viewComponent

					var_4.SetActivity(var_11_7, var_11_2)

					local var_11_8 = arg_11_0.viewComponent

					var_4.UpdateView(var_11_8)
				end
			elseif var_11_0 == var_0_1.OPEN_CHUANWU then
				local var_11_9 = arg_11_0.viewComponent
				local var_11_10 = var_4.emit
				local var_11_11 = var_0_1.OPEN_CHUANWU

				unpack = var_1_10007

				var_11_10(var_11_9, var_11_11, var_1_10007(var_11_2))
			end
		end
	end

	return
end

return var_0_1
