class = var_0_10000

local var_0_0 = "OrientedPathFinding"

PathFinding = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003)
local var_0_2 = OrientedPathFinding

function var_0_2.Find(arg_1_0, arg_1_1, arg_1_2)
	arg_1_1 = {
		row = arg_1_1.row,
		column = arg_1_1.column
	}
	arg_1_2 = {
		row = arg_1_2.row,
		column = arg_1_2.column
	}

	if arg_1_0.cells[arg_1_1.row][arg_1_1.column].priority < 0 or arg_1_0.cells[arg_1_2.row][arg_1_2.column].priority < 0 then
		return 0, {}
	else
		return arg_1_0:_Find(arg_1_1, arg_1_2)
	end

	return
end

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

function var_0_2._Find(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_2.PrioForbidden
	local var_2_1 = {}
	local var_2_2 = {
		arg_2_1
	}
	local var_2_3 = {}
	local var_2_4 = {
		[arg_2_1.row] = {
			[arg_2_1.column] = {
				priority = 0,
				path = {}
			}
		}
	}

	while #var_2_2 > 0 do
		table = var_8

		if var_8.remove(var_2_2, 1).row == arg_2_2.row and var_8.column == arg_2_2.column then
			var_2_0 = var_2_4[var_8.row][var_8.column].priority
			var_2_1 = var_9.path

			break
		end

		table = var_9

		var_9.insert(var_2_3, var_8)

		_ = var_9

		var_9.each(var_0_3, function(arg_3_0)
			local var_3_0 = {
				row = var_0.row + arg_3_0[1],
				column = var_0.column + arg_3_0[2]
			}

			_ = var_2

			local var_3_1

			if not var_2.any(var_2_2, function(arg_4_0)
				return arg_4_0.row == var_3_0.row and arg_4_0.column == var_3_0.column
			end) then
				_ = var_3_1
				var_3_1 = var_3_1.any(var_2_3, function(arg_5_0)
					return arg_5_0.row == var_3_0.row and arg_5_0.column == var_3_0.column
				end)
			end

			if not var_3_1 and var_3_0.row >= 0 and var_3_0.row < arg_2_0.rows and var_3_0.column >= 0 and var_3_0.column < arg_2_0.columns and not var_0_2.IsDirectionForbidden(arg_2_0.cells[var_0.row][var_0.column], arg_3_0[1], arg_3_0[2]) then
				local var_3_2

				if var_2_4[var_0.row][var_0.column].priority + arg_2_0.cells[var_3_0.row][var_3_0.column].priority < var_0_2.PrioObstacle then
					Clone = var_3_2
					var_3_2 = var_3_2(var_3)
					table = var_6

					var_6.insert(var_3_2.path, var_3_0)

					var_3_2.priority = var_4

					local var_3_3 = var_2_4
					local var_3_4 = var_3_0.row
					local var_3_5

					if not var_2_4[var_3_0.row] then
						var_3_5 = {}
					end

					var_3_3[var_3_4] = var_3_5
					var_2_4[var_3_0.row][var_3_0.column] = var_3_2

					local var_3_6 = 0

					for iter_3_0 = #var_2_2, 1, -1 do
						local var_3_7 = var_2_2[iter_3_0]
						local var_3_8 = var_2_4[var_3_7.row][var_3_7.column]

						if var_3_2.priority >= var_3_8.priority then
							var_3_6 = iter_3_0

							break
						end
					end

					table = var_7

					var_7.insert(var_2_2, var_3_6 + 1, var_3_0)
				else
					math = var_3_2
					var_2_0 = var_3_2.min(var_2_0, var_4)
				end
			end

			return
		end)
	end

	if var_2_0 >= var_0_2.PrioObstacle then
		local var_2_5 = 1000000
		local var_2_6 = var_0_2.PrioForbidden

		pairs = var_10

		for iter_2_0, iter_2_1 in var_10(var_2_4) do
			pairs = var_1_10015

			for iter_2_2, iter_2_3 in var_1_10015(iter_2_1) do
				math = var_1_10020
				var_1_10020 = var_1_10020.abs(arg_2_2.row - iter_2_0)
				math = var_1_10021

				if var_1_10020 + var_1_10021.abs(arg_2_2.column - iter_2_2) < var_2_5 or var_1_10020 == var_2_5 and iter_2_3.priority < var_2_6 then
					var_2_5 = var_1_10020
					var_2_6 = iter_2_3.priority
					var_2_1 = iter_2_3.path
				end
			end
		end
	end

	return var_2_0, var_2_1
end

function var_0_2.IsDirectionForbidden(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.forbiddens

	ChapterConst = var_1_10004

	if var_6_0 == var_1_10004.ForbiddenNone then
		return
	end

	local var_6_1

	if arg_6_1 ~= 0 then
		if arg_6_1 < 0 then
			ChapterConst = var_4

			if not var_4.ForbiddenUp then
				::label_6_0::

				ChapterConst = var_4
				var_6_1 = var_4.ForbiddenDown
			end

			goto label_6_2

			if arg_6_2 < 0 then
				ChapterConst = var_4

				if not var_4.ForbiddenLeft then
					::label_6_1::

					ChapterConst = var_4
					var_6_1 = var_4.ForbiddenRight
				end

				::label_6_2::

				bit = var_4

				return var_4.band(var_6_1, arg_6_0.forbiddens) > 0
			end
		end
	end
end

return var_0_2
