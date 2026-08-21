local var_0_0 = class("PathFinding")

PathFinding = var_0_0
var_0_0.PrioNormal = 1
var_0_0.PrioObstacle = 1000
var_0_0.PrioForbidden = 1000000

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.cells = arg_1_1
	arg_1_0.rows = arg_1_2
	arg_1_0.columns = arg_1_3

	return
end

function var_0_0.Find(arg_2_0, arg_2_1, arg_2_2)
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

function var_0_0._Find(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = var_0_0.PrioForbidden
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

	while #{
		arg_3_1
	} > 0 do
		local var_3_5 = table.remove({
			arg_3_1
		}, 1)

		if var_3_5.row == arg_3_2.row and var_3_5.column == arg_3_2.column then
			var_3_0 = ({
				[arg_3_1.row] = {
					[arg_3_1.column] = {
						priority = 0,
						path = {}
					}
				}
			})[var_3_5.row][var_3_5.column].priority
			var_3_1 = ({
				[arg_3_1.row] = {
					[arg_3_1.column] = {
						priority = 0,
						path = {}
					}
				}
			})[var_3_5.row][var_3_5.column].path

			break
		end

		table.insert({}, var_3_5)
		_.each(var_0_1, function(arg_4_0)
			local var_4_0 = {
				row = var_3_5.row + arg_4_0[1],
				column = var_3_5.column + arg_4_0[2]
			}
			local var_4_1 = _.any(var_3_2, function(arg_5_0)
				return arg_5_0.row == var_4_0.row and arg_5_0.column == var_4_0.column
			end) or _.any(var_3_3, function(arg_6_0)
				return arg_6_0.row == var_4_0.row and arg_6_0.column == var_4_0.column
			end)

			if not var_4_1 and ({
				row = var_3_5.row + arg_4_0[1],
				column = var_3_5.column + arg_4_0[2]
			}).row >= 0 and ({
				row = var_3_5.row + arg_4_0[1],
				column = var_3_5.column + arg_4_0[2]
			}).row < arg_3_0.rows and ({
				row = var_3_5.row + arg_4_0[1],
				column = var_3_5.column + arg_4_0[2]
			}).column >= 0 and ({
				row = var_3_5.row + arg_4_0[1],
				column = var_3_5.column + arg_4_0[2]
			}).column < arg_3_0.columns then
				if var_3_4[var_3_5.row][var_3_5.column].priority + arg_3_0.cells[({
					row = var_3_5.row + arg_4_0[1],
					column = var_3_5.column + arg_4_0[2]
				}).row][({
					row = var_3_5.row + arg_4_0[1],
					column = var_3_5.column + arg_4_0[2]
				}).column] < var_0_0.PrioObstacle then
					local var_4_2 = Clone(var_3_4[var_3_5.row][var_3_5.column])

					table.insert(var_4_2.path, {
						row = var_3_5.row + arg_4_0[1],
						column = var_3_5.column + arg_4_0[2]
					})

					var_4_2.priority = var_3_4[var_3_5.row][var_3_5.column].priority + arg_3_0.cells[({
						row = var_3_5.row + arg_4_0[1],
						column = var_3_5.column + arg_4_0[2]
					}).row][({
						row = var_3_5.row + arg_4_0[1],
						column = var_3_5.column + arg_4_0[2]
					}).column]

					local var_4_3 = var_3_4[({
						row = var_3_5.row + arg_4_0[1],
						column = var_3_5.column + arg_4_0[2]
					}).row]

					if not var_3_4[({
						row = var_3_5.row + arg_4_0[1],
						column = var_3_5.column + arg_4_0[2]
					}).row] then
						var_4_3 = {}
					end

					var_3_4[({
						row = var_3_5.row + arg_4_0[1],
						column = var_3_5.column + arg_4_0[2]
					}).row] = var_4_3
					var_3_4[({
						row = var_3_5.row + arg_4_0[1],
						column = var_3_5.column + arg_4_0[2]
					}).row][({
						row = var_3_5.row + arg_4_0[1],
						column = var_3_5.column + arg_4_0[2]
					}).column] = var_4_2

					local var_4_4 = 0

					for iter_4_0 = #var_3_2, 1, -1 do
						if var_4_2.priority >= var_3_4[var_3_2[iter_4_0].row][var_3_2[iter_4_0].column].priority then
							var_4_4 = iter_4_0

							break
						end
					end

					table.insert(var_3_2, var_4_4 + 1, {
						row = var_3_5.row + arg_4_0[1],
						column = var_3_5.column + arg_4_0[2]
					})
				else
					var_3_0 = math.min(var_3_0, var_3_4[var_3_5.row][var_3_5.column].priority + arg_3_0.cells[({
						row = var_3_5.row + arg_4_0[1],
						column = var_3_5.column + arg_4_0[2]
					}).row][({
						row = var_3_5.row + arg_4_0[1],
						column = var_3_5.column + arg_4_0[2]
					}).column])
				end
			end

			return
		end)
	end

	if var_3_0 >= var_0_0.PrioObstacle then
		local var_3_6 = 1000000

		for iter_3_0, iter_3_1 in pairs({
			[arg_3_1.row] = {
				[arg_3_1.column] = {
					priority = 0,
					path = {}
				}
			}
		}) do
			for iter_3_2, iter_3_3 in pairs(iter_3_1) do
				local var_3_7 = math.abs(arg_3_2.row - iter_3_0) + math.abs(arg_3_2.column - iter_3_2)
				local var_3_8

				if var_3_7 < var_3_6 or var_3_7 == var_3_6 and var_0_0.PrioForbidden > iter_3_3.priority then
					var_3_6 = var_3_7
					var_3_8 = iter_3_3.priority
					var_3_1 = iter_3_3.path
				end
			end
		end
	end

	return var_3_0, var_3_1
end

return var_0_0
