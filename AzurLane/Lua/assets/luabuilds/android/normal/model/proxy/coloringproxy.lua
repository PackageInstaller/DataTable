class = var_0_10000

local var_0_0 = "ColoringProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

function var_0_1.register(arg_1_0)
	arg_1_0.colorGroups = {}
	arg_1_0.colorItems = {}

	return
end

function var_0_1.netUpdateData(arg_2_0, arg_2_1)
	arg_2_0.startTime = arg_2_1.start_time

	local var_2_0 = {}

	_ = var_1_10003

	var_1_10003.each(arg_2_1.award_list, function(arg_3_0)
		local var_3_0 = var_2_0
		local var_3_1 = arg_3_0.id

		_ = var_2_10003
		var_3_0[var_3_1] = var_2_10003.map(arg_3_0.award_list, function(arg_4_0)
			return {
				type = arg_4_0.type,
				id = arg_4_0.id,
				count = arg_4_0.number
			}
		end)

		return
	end)

	local var_2_1 = {}

	getProxy = var_4
	ActivityProxy = var_5

	local var_2_2 = var_4(var_5)
	local var_2_3 = var_4.getActivityByType

	ActivityConst = var_1_10007

	if var_2_3(var_2_2, var_1_10007.ACTIVITY_TYPE_COLORING_ALPHA) and not var_5:isEnd() then
		var_2_1 = var_5:getConfig("config_data")
	end

	arg_2_0.colorGroups = {}
	_ = var_6

	var_6.each(var_2_1, function(arg_5_0)
		local var_5_0 = arg_5_0[1]
		local var_5_1 = arg_5_0[2]

		ColorGroup = var_2_10003

		local var_5_2 = var_2_10003.New(var_5_0)

		if var_3.canBeCustomised(var_5_2) then
			COLORING_ACTIVITY_CUSTOMIZED_BANNED = var_4

			if var_4 then
				return
			end
		end

		var_3:setHasAward(var_5_1 > 0)

		if var_5_0 == arg_2_1.id then
			_ = var_4

			var_4.each(arg_2_1.cell_list, function(arg_6_0)
				local var_6_0 = var_0

				var_1.setFill(var_6_0, arg_6_0.row, arg_6_0.column, arg_6_0.color)

				return
			end)
		end

		local var_5_3

		if not var_2_0[var_5_0] then
			var_5_3 = {}
		end

		var_3:setDrops(var_5_3)

		tobool = var_5

		local var_5_5

		if var_5(var_2_0[var_5_0]) then
			local var_5_4 = var_3

			var_5_5 = var_3.setState
			ColorGroup = var_2_10008

			var_5_5(var_5_4, var_2_10008.StateAchieved)
		elseif var_5_0 < arg_2_1.id or var_3:isAllFill() then
			local var_5_6 = var_3

			var_5_5 = var_3.setState
			ColorGroup = var_2_10008

			var_5_5(var_5_6, var_2_10008.StateFinish)
		end

		table = var_5_5

		var_5_5.insert(arg_2_0.colorGroups, var_3)

		return
	end)

	local var_2_4 = 0

	for iter_2_0 = #arg_2_0.colorGroups, 1, -1 do
		local var_2_5 = arg_2_0.colorGroups[iter_2_0]
		local var_2_6 = var_11.getState(var_2_5)

		ColorGroup = var_2_5

		if var_2_6 ~= var_2_5.StateFinish then
			ColorGroup = var_12

			if var_2_6 == var_12.StateAchieved then
				var_2_4 = iter_2_0

				break
			end
		end
	end

	for iter_2_1 = var_2_4 - 1, 1, -1 do
		local var_2_7 = arg_2_0.colorGroups[iter_2_1]

		if not var_11.getState(var_2_7) then
			local var_2_8 = var_11
			local var_2_9 = var_11.setState

			ColorGroup = var_1_10014

			var_2_9(var_2_8, var_1_10014.StateFinish)
		end
	end

	if var_2_4 + 1 <= #arg_2_0.colorGroups then
		local var_2_10 = arg_2_0.colorGroups[var_2_4 + 1]
		local var_2_11 = var_7.setState

		if var_2_4 == 0 then
			ColorGroup = var_2_12

			local var_2_12

			if not var_2_12.StateColoring then
				ColorGroup = var_2_12
				var_2_12 = var_2_12.StateLock
			end

			var_2_11(var_2_10, var_2_12)

			for iter_2_2 = var_2_4 + 2, #arg_2_0.colorGroups do
				local var_2_13 = arg_2_0.colorGroups[iter_2_2]

				if not var_11.getState(var_2_13) then
					local var_2_14 = var_11
					local var_2_15 = var_11.setState

					ColorGroup = var_1_10014

					var_2_15(var_2_14, var_1_10014.StateLock)
				end
			end

			arg_2_0:checkState()

			arg_2_0.colorItems = {}
			ipairs = var_7

			for iter_2_3, iter_2_4 in var_7(arg_2_1.color_list) do
				arg_2_0.colorItems[iter_2_4.id] = iter_2_4.number
			end

			return
		end
	end
end

function var_0_1.getColorItems(arg_7_0)
	return arg_7_0.colorItems
end

function var_0_1.getColorGroups(arg_8_0)
	return arg_8_0.colorGroups
end

function var_0_1.getColorGroup(arg_9_0, arg_9_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_9_0.colorGroups, function(arg_10_0)
		return arg_10_0.id == arg_9_1
	end)
end

function var_0_1.checkState(arg_11_0)
	local var_11_0 = false

	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_11_1 = var_1_10002(var_1_10003)
	local var_11_2 = var_2.getActivityByType

	ActivityConst = var_1_10005

	if var_11_2(var_11_1, var_1_10005.ACTIVITY_TYPE_COLORING_ALPHA) and not var_3:isEnd() then
		pg = var_4

		local var_11_3 = var_4.TimeMgr.GetInstance()
		local var_11_4 = var_4.DiffDay(var_11_3, arg_11_0.startTime, var_4:GetServerTime()) + 1

		ipairs = var_11_3

		for iter_11_0, iter_11_1 in var_11_3(arg_11_0.colorGroups) do
			local var_11_5 = iter_11_1
			local var_11_6 = iter_11_1.getState(var_11_5)

			ColorGroup = var_11_5

			if var_11_6 == var_11_5.StateColoring and iter_11_1:isAllFill() then
				local var_11_7 = iter_11_1
				local var_11_8 = iter_11_1.setState

				ColorGroup = var_1_10013

				var_11_8(var_11_7, var_1_10013.StateFinish)

				var_11_0 = true

				break
			elseif iter_11_0 < var_11_4 then
				local var_11_9 = iter_11_1
				local var_11_10 = iter_11_1.getState(var_11_9)

				ColorGroup = var_11_9

				if var_11_10 == var_11_9.StateAchieved and arg_11_0.colorGroups[iter_11_0 + 1] then
					var_1_10013 = var_11

					local var_11_11 = var_11.getState(var_1_10013)

					ColorGroup = var_1_10013

					if var_11_11 == var_1_10013.StateLock then
						var_1_10013 = var_11

						local var_11_12 = var_11.setState

						ColorGroup = var_1_10014

						var_11_12(var_1_10013, var_1_10014.StateColoring)

						var_11_0 = true

						break
					end
				end
			end
		end
	end

	return var_11_0
end

function var_0_1.CheckTodayTip(arg_12_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_12_0 = var_1_10001(var_1_10002)
	local var_12_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	if var_12_1(var_12_0, var_1_10004.ACTIVITY_TYPE_COLORING_ALPHA) then
		local var_12_2 = var_2

		if not var_2.isEnd(var_12_2) and arg_12_0.startTime then
			pg = var_3

			local var_12_3 = var_3.TimeMgr.GetInstance()

			math = var_12_2

			local var_12_4 = var_12_2.min(var_12_3:DiffDay(arg_12_0.startTime, var_12_3:GetServerTime()) + 1, #arg_12_0.colorGroups)
			local var_12_5 = arg_12_0
			local var_12_6 = arg_12_0.GetViewedPage(var_12_5)

			ipairs = var_12_5

			for iter_12_0, iter_12_1 in var_12_5(arg_12_0.colorGroups) do
				if var_12_4 < iter_12_0 then
					break
				end

				local var_12_7 = iter_12_1
				local var_12_8 = iter_12_1.getState(var_12_7)

				ColorGroup = var_12_7

				if var_12_8 == var_12_7.StateLock then
					break
				end

				local var_12_9 = iter_12_1
				local var_12_10 = iter_12_1.getState(var_12_9)

				ColorGroup = var_12_9

				if var_12_10 ~= var_12_9.StateAchieved and not iter_12_1:canBeCustomised() then
					if var_12_6 < iter_12_0 then
						return true
					end

					local var_12_11 = iter_12_1
					local var_12_12 = iter_12_1.getState(var_12_11)

					ColorGroup = var_12_11

					if var_12_12 == var_12_11.StateFinish or iter_12_1:HasEnoughItem2FillAll(arg_12_0:getColorItems()) then
						return true
					end

					break
				end
			end
		end
	end

	return
end

function var_0_1.IsALLAchieve(arg_13_0)
	if #arg_13_0.colorGroups == 0 then
		return false
	end

	_ = var_1

	return var_1.all(arg_13_0.colorGroups, function(arg_14_0)
		local var_14_1

		if not arg_14_0:canBeCustomised() then
			local var_14_0 = arg_14_0

			var_14_1 = arg_14_0.getState(var_14_0)
			ColorGroup = var_14_0
			var_14_1 = var_14_1 == var_14_0.StateAchieved
		end

		return var_14_1
	end)
end

function var_0_1.GetViewedPage(arg_15_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_15_0 = var_1_10001(var_1_10002)
	local var_15_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	if var_15_1(var_15_0, var_1_10003.ACTIVITY_TYPE_COLORING_ALPHA) then
		local var_15_2 = var_1

		if var_1.isEnd(var_15_2) then
			return 0
		end

		getProxy = var_15_0
		PlayerProxy = var_15_2

		local var_15_3 = var_15_0(var_15_2)
		local var_15_4 = var_2.getRawData(var_15_3)

		PlayerPrefs = var_15_3

		return var_15_3.GetInt("pixelDraw_maxPage_" .. var_1.id .. "_" .. var_15_4.id, 0)
	end
end

function var_0_1.SetViewedPage(arg_16_0, arg_16_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_16_0 = var_1_10002(var_1_10003)
	local var_16_1 = var_2.getActivityByType

	ActivityConst = var_1_10004

	if not var_16_1(var_16_0, var_1_10004.ACTIVITY_TYPE_COLORING_ALPHA) or var_2:isEnd() then
		return
	end

	local var_16_2 = arg_16_0

	if arg_16_1 <= arg_16_0.GetViewedPage(var_16_2) then
		return
	end

	getProxy = var_16_2
	PlayerProxy = var_1_10005

	local var_16_3 = var_16_2(var_1_10005)
	local var_16_4 = var_4.getRawData(var_16_3)

	PlayerPrefs = var_16_3

	return var_16_3.SetInt("pixelDraw_maxPage_" .. var_2.id .. "_" .. var_16_4.id, arg_16_1)
end

return var_0_1
