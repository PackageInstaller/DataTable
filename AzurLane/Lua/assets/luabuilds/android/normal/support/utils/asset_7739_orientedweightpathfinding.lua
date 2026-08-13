class = var_0_10000

local var_0_0 = "OrientedWeightPathFinding"

OrientedPathFinding = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002)
local var_0_2 = OrientedWeightPathFinding
local var_0_3 = {
	{
		1,
		0
	},
	{
		-1,
		0
	},
	{
		0,
		1
	},
	{
		0,
		-1
	}
}

local function var_0_4(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = var_0_2.PrioForbidden
	local var_1_1 = {}
	local var_1_2 = {
		arg_1_3
	}
	local var_1_3 = {}
	local var_1_4 = {
		[arg_1_3.row] = {
			[arg_1_3.column] = {
				priority = 0,
				enemyCount = 0,
				path = {}
			}
		}
	}

	while #var_1_2 > 0 do
		table = var_10

		if var_10.remove(var_1_2, 1).row == arg_1_4.row and var_10.column == arg_1_4.column then
			var_1_0 = var_1_4[var_10.row][var_10.column].priority
			var_1_1 = var_11.path

			break
		end

		table = var_11

		var_11.insert(var_1_3, var_10)

		_ = var_11

		var_11.each(var_0_3, function(arg_2_0)
			local var_2_0 = {
				row = var_0.row + arg_2_0[1],
				column = var_0.column + arg_2_0[2]
			}

			_ = var_2

			if not var_2.any(var_1_3, function(arg_3_0)
				return arg_3_0.row == var_2_0.row and arg_3_0.column == var_2_0.column
			end) and var_2_0.row >= 0 and var_2_0.row < arg_1_1 and var_2_0.column >= 0 and var_2_0.column < arg_1_2 and not var_0_2.IsDirectionForbidden(arg_1_0[var_0.row][var_0.column], arg_2_0[1], arg_2_0[2]) then
				local var_2_1 = var_1_4[var_0.row][var_0.column]
				local var_2_2 = arg_1_0[var_2_0.row][var_2_0.column]
				local var_2_3 = var_2_1.priority + var_2_2.priority
				local var_2_4 = var_2_1.enemyCount + (var_2_2.isEnemy and 1 or 0)
				local var_2_5

				if var_2_3 < var_0_2.PrioObstacle then
					Clone = var_2_5
					var_2_5 = var_2_5(var_2_1)
					table = var_8

					var_8.insert(var_2_5.path, var_2_0)

					var_2_5.priority = var_2_3
					var_2_5.enemyCount = var_2_1.enemyCount + var_2_4
					_ = var_8

					local var_2_6 = not var_8.detect(var_1_2, function(arg_4_0)
						return arg_4_0.row == var_2_0.row and arg_4_0.column == var_2_0.column
					end)

					if var_8 then
						var_2_6 = var_1_4[var_2_0.row][var_2_0.column].enemyCount > var_2_5.enemyCount or var_10.enemyCount == var_2_5.enemyCount and var_10.priority > var_2_5.priority

						if var_2_6 then
							table = var_11

							var_11.removebyvalue(var_1_2, var_8)
						end
					end

					if var_2_6 then
						local var_2_7 = var_1_4
						local var_2_8 = var_2_0.row
						local var_2_9

						if not var_1_4[var_2_0.row] then
							var_2_9 = {}
						end

						var_2_7[var_2_8] = var_2_9
						var_1_4[var_2_0.row][var_2_0.column] = var_2_5

						local var_2_10 = 0

						for iter_2_0 = #var_1_2, 1, -1 do
							local var_2_11 = var_1_2[iter_2_0]
							local var_2_12 = var_1_4[var_2_11.row][var_2_11.column]

							if var_2_5.enemyCount > var_2_12.enemyCount or var_2_5.enemyCount == var_2_12.enemyCount and var_2_5.priority >= var_2_12.priority then
								var_2_10 = iter_2_0

								break
							end
						end

						table = var_11

						var_11.insert(var_1_2, var_2_10 + 1, var_2_0)
					end
				else
					math = var_2_5
					var_1_0 = var_2_5.min(var_1_0, var_2_3)
				end
			end

			return
		end)
	end

	if var_1_0 >= var_0_2.PrioObstacle then
		local var_1_5 = 1000000
		local var_1_6 = var_0_2.PrioForbidden

		pairs = var_12

		for iter_1_0, iter_1_1 in var_12(var_1_4) do
			pairs = var_1_10017

			for iter_1_2, iter_1_3 in var_1_10017(iter_1_1) do
				math = var_1_10022
				var_1_10022 = var_1_10022.abs(arg_1_4.row - iter_1_0)
				math = var_23

				if var_1_10022 + var_23.abs(arg_1_4.column - iter_1_2) < var_1_5 or var_1_10022 == var_1_5 and var_1_6 > iter_1_3.priority then
					var_1_5 = var_1_10022
					var_1_6 = iter_1_3.priority
					var_1_1 = iter_1_3.path
				end
			end
		end
	end

	return var_1_0, var_1_1
end

function var_0_2.StaticFind(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_3 = {
		row = arg_5_3.row,
		column = arg_5_3.column
	}
	arg_5_4 = {
		row = arg_5_4.row,
		column = arg_5_4.column
	}

	if arg_5_0[arg_5_3.row][arg_5_3.column].priority < 0 or arg_5_0[arg_5_4.row][arg_5_4.column].priority < 0 then
		return 0, {}
	else
		return var_0_4(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	end

	return
end

return var_0_2
