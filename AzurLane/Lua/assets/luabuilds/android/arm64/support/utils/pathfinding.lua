class = var_0_10000

local var_0_0 = var_0_10000("PathFinding")
local var_0_1 = PathFinding

var_0_1.PrioNormal = 1
var_0_1.PrioObstacle = 1000
var_0_1.PrioForbidden = 1000000

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.cells = arg_1_1
	arg_1_0.rows = arg_1_2
	arg_1_0.columns = arg_1_3

	return
end

function var_0_1.Find(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1 = {
		row = arg_2_1.row,
		column = arg_2_1.column
	}
	arg_2_2 = {
		row = arg_2_2.row,
		column = arg_2_2.column
	}

	if arg_2_0.cells[arg_2_1.row][arg_2_1.column] < 0 or arg_2_0.cells[arg_2_2.row][arg_2_2.column] < 0 then
		return 0, {}
	else
		return arg_2_0:_Find(arg_2_1, arg_2_2)
	end

	return
end

local var_0_2 = {
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

function var_0_1._Find(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = var_0_1.PrioForbidden
	local var_3_1 = {}
	local var_3_2 = {
		arg_3_1
	}
	local var_3_3 = {}
	local var_3_4 = {
		[arg_3_1.row] = {
			[arg_3_1.column] = {
				priority = 0,
				path = {}
			}
		}
	}

	while #var_3_2 > 0 do
		table = var_8

		if var_8.remove(var_3_2, 1).row == arg_3_2.row and var_8.column == arg_3_2.column then
			var_3_0 = var_3_4[var_8.row][var_8.column].priority
			var_3_1 = var_9.path

			break
		end

		table = var_9

		var_9.insert(var_3_3, var_8)

		_ = var_9

		var_9.each(var_0_2, function(arg_4_0)
			local var_4_0 = {
				row = var_0.row + arg_4_0[1],
				column = var_0.column + arg_4_0[2]
			}

			_ = var_2

			local var_4_1

			if not var_2.any(var_3_2, function(arg_5_0)
				return arg_5_0.row == var_4_0.row and arg_5_0.column == var_4_0.column
			end) then
				_ = var_4_1
				var_4_1 = var_4_1.any(var_3_3, function(arg_6_0)
					return arg_6_0.row == var_4_0.row and arg_6_0.column == var_4_0.column
				end)
			end

			if not var_4_1 and var_4_0.row >= 0 and var_4_0.row < arg_3_0.rows and var_4_0.column >= 0 and var_4_0.column < arg_3_0.columns then
				local var_4_2

				if var_3_4[var_0.row][var_0.column].priority + arg_3_0.cells[var_4_0.row][var_4_0.column] < var_0_1.PrioObstacle then
					Clone = var_4_2
					var_4_2 = var_4_2(var_3)
					table = var_6

					var_6.insert(var_4_2.path, var_4_0)

					var_4_2.priority = var_4

					local var_4_3 = var_3_4
					local var_4_4 = var_4_0.row
					local var_4_5

					if not var_3_4[var_4_0.row] then
						var_4_5 = {}
					end

					var_4_3[var_4_4] = var_4_5
					var_3_4[var_4_0.row][var_4_0.column] = var_4_2

					local var_4_6 = 0

					for iter_4_0 = #var_3_2, 1, -1 do
						local var_4_7 = var_3_2[iter_4_0]
						local var_4_8 = var_3_4[var_4_7.row][var_4_7.column]

						if var_4_2.priority >= var_4_8.priority then
							var_4_6 = iter_4_0

							break
						end
					end

					table = var_7

					var_7.insert(var_3_2, var_4_6 + 1, var_4_0)
				else
					math = var_4_2
					var_3_0 = var_4_2.min(var_3_0, var_4)
				end
			end

			return
		end)
	end

	if var_3_0 >= var_0_1.PrioObstacle then
		local var_3_5 = 1000000
		local var_3_6 = var_0_1.PrioForbidden

		pairs = var_10

		for iter_3_0, iter_3_1 in var_10(var_3_4) do
			pairs = var_1_10015

			for iter_3_2, iter_3_3 in var_1_10015(iter_3_1) do
				math = var_1_10020
				var_1_10020 = var_1_10020.abs(arg_3_2.row - iter_3_0)
				math = var_1_10021

				if var_1_10020 + var_1_10021.abs(arg_3_2.column - iter_3_2) < var_3_5 or var_1_10020 == var_3_5 and iter_3_3.priority < var_3_6 then
					var_3_5 = var_1_10020
					var_3_6 = iter_3_3.priority
					var_3_1 = iter_3_3.path
				end
			end
		end
	end

	return var_3_0, var_3_1
end

return var_0_1
