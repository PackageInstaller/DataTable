class = var_0_10000

local var_0_0 = var_0_10000("ShipCalcHelper")

function var_0_0.CalcDestoryRes(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = 0
	local var_1_2 = 0
	local var_1_3 = false

	ipairs = var_1_10005

	for iter_1_0, iter_1_1 in var_1_10005(arg_1_0) do
		var_1_10011 = iter_1_1

		local var_1_4, var_1_5

		var_1_4, var_1_10011, var_1_5 = iter_1_1.calReturnRes(var_1_10011)
		var_1_1 = var_1_1 + var_1_4
		var_1_2 = var_1_2 + var_1_10011
		table = var_1_10013
		var_1_10013 = var_1_10013.mergeArray
		var_1_10014 = var_1_0
		underscore = var_1_10015
		var_1_0 = var_1_10013(var_1_10014, var_1_10015.map(var_1_5, function(arg_2_0)
			Drop = var_2_10001

			return var_2_10001.Create(arg_2_0)
		end))
	end

	PlayerConst = var_5

	for iter_1_2 = #var_5.MergeSameDrops(var_1_0), 1, -1 do
		local var_1_6 = var_1[iter_1_2].type

		DROP_TYPE_VITEM = var_1_10011

		if var_1_6 == var_1_10011 then
			var_1_10011 = var_9

			if var_9.getConfig(var_1_10011, "virtual_type") == 20 then
				unpack = var_10
				pg = var_1_10011

				local var_1_7

				var_1_7, var_1_10011 = var_10(var_1_10011.gameset.urpt_chapter_max.description)
				math = var_12

				local var_1_8 = var_12.min
				local var_1_9 = var_9.count

				getProxy = var_1_10014
				BagProxy = var_1_10015
				var_1_10015 = var_1_10014(var_1_10015)
				var_1_3 = var_1_8(var_1_9, var_1_10011 - var_1_10014.GetLimitCntById(var_1_10015, var_1_7)) < var_9.count

				if 0 < var_12 then
					var_9.count = var_12
				else
					table = var_13

					var_13.remove(var_1, iter_1_2)
				end
			end
		end
	end

	pairs = var_5

	for iter_1_3, iter_1_4 in var_5(var_1) do
		local var_1_10 = iter_1_4.count

		if 0 < var_1_10 then
			local var_1_11 = iter_1_4.type

			DROP_TYPE_VITEM = var_11

			if var_1_11 == var_11 then
				Item = var_1_11

				if var_1_11.getConfigData(iter_1_4.id).virtual_type == 20 then
					local var_1_12 = iter_1_4.count

					pg = var_11

					local var_1_13 = var_11.gameset.urpt_chapter_max.description[1]
					local var_1_14 = var_11[2]

					getProxy = var_1_10014
					BagProxy = var_1_10015
					var_1_10015 = var_1_10014(var_1_10015)
					var_1_10014 = var_1_10014.GetLimitCntById(var_1_10015, var_1_13)
					math = var_1_10015
					var_1_3 = var_1_10015.min(var_1_14 - var_1_10014, var_1_12) < var_1_12

					if var_1_10015 <= 0 then
						var_1[iter_1_3].count = 0
					else
						var_1[iter_1_3].count = var_1_10015
					end
				end
			end
		end
	end

	table = var_5

	local var_1_15 = var_5.sort
	local var_1_16 = var_1

	CompareFuncs = var_7

	var_1_15(var_1_16, var_7({
		function(arg_3_0)
			return arg_3_0.id
		end
	}))

	return var_1_1, var_1_2, var_1, var_1_3
end

function var_0_0.GetEliteAndHightLevelShips(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = {}

	ipairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(arg_4_0) do
		if iter_4_1:getRarity() >= 4 then
			table = var_8

			var_8.insert(var_4_0, iter_4_1)
		elseif iter_4_1.level > 1 then
			table = var_8

			var_8.insert(var_4_1, iter_4_1)
		end
	end

	return var_4_0, var_4_1
end

function var_0_0.GetEliteAndHightLevelAndResOverflow(arg_5_0, arg_5_1)
	_ = var_1_10002

	local var_5_0 = var_1_10002.map(arg_5_0, function(arg_6_0)
		assert = var_2_10001

		var_2_10001(arg_5_1[arg_6_0], arg_6_0)

		return arg_5_1[arg_6_0]
	end)
	local var_5_1, var_5_2 = var_0_0.GetEliteAndHightLevelShips(var_5_0)
	local var_5_3, var_5_4, var_5_5, var_5_6 = var_0_0.CalcDestoryRes(var_5_0)

	return var_5_1, var_5_2, var_5_6
end

return var_0_0
