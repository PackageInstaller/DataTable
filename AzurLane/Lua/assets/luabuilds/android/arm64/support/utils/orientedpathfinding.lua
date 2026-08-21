local var_0_0 = class("OrientedPathFinding", PathFinding)

OrientedPathFinding = var_0_0

function var_0_0.Find(arg_1_0, arg_1_1, arg_1_2)
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

local var_0_1 = {
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

function var_0_0._Find(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_0.PrioForbidden
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

	while #{
		arg_2_1
	} > 0 do
		local var_2_5 = table.remove({
			arg_2_1
		}, 1)

		if var_2_5.row == arg_2_2.row and var_2_5.column == arg_2_2.column then
			var_2_0 = ({
				[arg_2_1.row] = {
					[arg_2_1.column] = {
						priority = 0,
						path = {}
					}
				}
			})[var_2_5.row][var_2_5.column].priority
			var_2_1 = ({
				[arg_2_1.row] = {
					[arg_2_1.column] = {
						priority = 0,
						path = {}
					}
				}
			})[var_2_5.row][var_2_5.column].path

			break
		end

		table.insert({}, var_2_5)
		_.each(var_0_1, function(arg_3_0)
			local var_3_0 = {
				row = var_2_5.row + arg_3_0[1],
				column = var_2_5.column + arg_3_0[2]
			}
			local var_3_1 = _.any(var_2_2, function(arg_4_0)
				return arg_4_0.row == var_3_0.row and arg_4_0.column == var_3_0.column
			end) or _.any(var_2_3, function(arg_5_0)
				return arg_5_0.row == var_3_0.row and arg_5_0.column == var_3_0.column
			end)

			if not var_3_1 and ({
				row = var_2_5.row + arg_3_0[1],
				column = var_2_5.column + arg_3_0[2]
			}).row >= 0 and ({
				row = var_2_5.row + arg_3_0[1],
				column = var_2_5.column + arg_3_0[2]
			}).row < arg_2_0.rows and ({
				row = var_2_5.row + arg_3_0[1],
				column = var_2_5.column + arg_3_0[2]
			}).column >= 0 and ({
				row = var_2_5.row + arg_3_0[1],
				column = var_2_5.column + arg_3_0[2]
			}).column < arg_2_0.columns and not var_0_0.IsDirectionForbidden(arg_2_0.cells[var_2_5.row][var_2_5.column], arg_3_0[1], arg_3_0[2]) then
				if var_2_4[var_2_5.row][var_2_5.column].priority + arg_2_0.cells[({
					row = var_2_5.row + arg_3_0[1],
					column = var_2_5.column + arg_3_0[2]
				}).row][({
					row = var_2_5.row + arg_3_0[1],
					column = var_2_5.column + arg_3_0[2]
				}).column].priority < var_0_0.PrioObstacle then
					local var_3_2 = Clone(var_2_4[var_2_5.row][var_2_5.column])

					table.insert(var_3_2.path, {
						row = var_2_5.row + arg_3_0[1],
						column = var_2_5.column + arg_3_0[2]
					})

					var_3_2.priority = var_2_4[var_2_5.row][var_2_5.column].priority + arg_2_0.cells[({
						row = var_2_5.row + arg_3_0[1],
						column = var_2_5.column + arg_3_0[2]
					}).row][({
						row = var_2_5.row + arg_3_0[1],
						column = var_2_5.column + arg_3_0[2]
					}).column].priority

					local var_3_3 = var_2_4[({
						row = var_2_5.row + arg_3_0[1],
						column = var_2_5.column + arg_3_0[2]
					}).row]

					if not var_2_4[({
						row = var_2_5.row + arg_3_0[1],
						column = var_2_5.column + arg_3_0[2]
					}).row] then
						var_3_3 = {}
					end

					var_2_4[({
						row = var_2_5.row + arg_3_0[1],
						column = var_2_5.column + arg_3_0[2]
					}).row] = var_3_3
					var_2_4[({
						row = var_2_5.row + arg_3_0[1],
						column = var_2_5.column + arg_3_0[2]
					}).row][({
						row = var_2_5.row + arg_3_0[1],
						column = var_2_5.column + arg_3_0[2]
					}).column] = var_3_2

					local var_3_4 = 0

					for iter_3_0 = #var_2_2, 1, -1 do
						if var_3_2.priority >= var_2_4[var_2_2[iter_3_0].row][var_2_2[iter_3_0].column].priority then
							var_3_4 = iter_3_0

							break
						end
					end

					table.insert(var_2_2, var_3_4 + 1, {
						row = var_2_5.row + arg_3_0[1],
						column = var_2_5.column + arg_3_0[2]
					})
				else
					var_2_0 = math.min(var_2_0, var_2_4[var_2_5.row][var_2_5.column].priority + arg_2_0.cells[({
						row = var_2_5.row + arg_3_0[1],
						column = var_2_5.column + arg_3_0[2]
					}).row][({
						row = var_2_5.row + arg_3_0[1],
						column = var_2_5.column + arg_3_0[2]
					}).column].priority)
				end
			end

			return
		end)
	end

	if var_2_0 >= var_0_0.PrioObstacle then
		local var_2_6 = 1000000

		for iter_2_0, iter_2_1 in pairs({
			[arg_2_1.row] = {
				[arg_2_1.column] = {
					priority = 0,
					path = {}
				}
			}
		}) do
			for iter_2_2, iter_2_3 in pairs(iter_2_1) do
				local var_2_7 = math.abs(arg_2_2.row - iter_2_0) + math.abs(arg_2_2.column - iter_2_2)
				local var_2_8

				if var_2_7 < var_2_6 or var_2_7 == var_2_6 and var_0_0.PrioForbidden > iter_2_3.priority then
					var_2_6 = var_2_7
					var_2_8 = iter_2_3.priority
					var_2_1 = iter_2_3.path
				end
			end
		end
	end

	return var_2_0, var_2_1
end

function var_0_0.IsDirectionForbidden(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.forbiddens == ChapterConst.ForbiddenNone then
		return
	end

	local var_6_0 = arg_6_1 ~= 0 and (arg_6_1 < 0 and ChapterConst.ForbiddenUp or ChapterConst.ForbiddenDown) or arg_6_2 < 0 and ChapterConst.ForbiddenLeft or ChapterConst.ForbiddenRight

	return bit.band(var_6_0, arg_6_0.forbiddens) > 0
end

return var_0_0
