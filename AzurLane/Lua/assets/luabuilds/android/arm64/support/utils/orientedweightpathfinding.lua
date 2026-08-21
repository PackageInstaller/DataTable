local var_0_0 = class("OrientedWeightPathFinding", OrientedPathFinding)

OrientedWeightPathFinding = var_0_0

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

local function var_0_2(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = var_0_0.PrioForbidden
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

	while #{
		arg_1_3
	} > 0 do
		local var_1_5 = table.remove({
			arg_1_3
		}, 1)

		if var_1_5.row == arg_1_4.row and var_1_5.column == arg_1_4.column then
			var_1_0 = ({
				[arg_1_3.row] = {
					[arg_1_3.column] = {
						priority = 0,
						enemyCount = 0,
						path = {}
					}
				}
			})[var_1_5.row][var_1_5.column].priority
			var_1_1 = ({
				[arg_1_3.row] = {
					[arg_1_3.column] = {
						priority = 0,
						enemyCount = 0,
						path = {}
					}
				}
			})[var_1_5.row][var_1_5.column].path

			break
		end

		table.insert({}, var_1_5)
		_.each(var_0_1, function(arg_2_0)
			local var_2_0 = {
				row = var_1_5.row + arg_2_0[1],
				column = var_1_5.column + arg_2_0[2]
			}

			if not _.any(var_1_3, function(arg_3_0)
				return arg_3_0.row == var_2_0.row and arg_3_0.column == var_2_0.column
			end) and ({
				row = var_1_5.row + arg_2_0[1],
				column = var_1_5.column + arg_2_0[2]
			}).row >= 0 and ({
				row = var_1_5.row + arg_2_0[1],
				column = var_1_5.column + arg_2_0[2]
			}).row < arg_1_1 and ({
				row = var_1_5.row + arg_2_0[1],
				column = var_1_5.column + arg_2_0[2]
			}).column >= 0 and ({
				row = var_1_5.row + arg_2_0[1],
				column = var_1_5.column + arg_2_0[2]
			}).column < arg_1_2 and not var_0_0.IsDirectionForbidden(arg_1_0[var_1_5.row][var_1_5.column], arg_2_0[1], arg_2_0[2]) then
				local var_2_1 = var_1_4[var_1_5.row][var_1_5.column]
				local var_2_2 = var_1_4[var_1_5.row][var_1_5.column].priority + arg_1_0[({
					row = var_1_5.row + arg_2_0[1],
					column = var_1_5.column + arg_2_0[2]
				}).row][({
					row = var_1_5.row + arg_2_0[1],
					column = var_1_5.column + arg_2_0[2]
				}).column].priority

				if var_1_4[var_1_5.row][var_1_5.column].priority + arg_1_0[({
					row = var_1_5.row + arg_2_0[1],
					column = var_1_5.column + arg_2_0[2]
				}).row][({
					row = var_1_5.row + arg_2_0[1],
					column = var_1_5.column + arg_2_0[2]
				}).column].priority < var_0_0.PrioObstacle then
					local var_2_3 = Clone(var_2_1)

					table.insert(var_2_3.path, {
						row = var_1_5.row + arg_2_0[1],
						column = var_1_5.column + arg_2_0[2]
					})

					var_2_3.priority = var_2_2
					var_2_3.enemyCount = var_2_1.enemyCount + (var_1_4[var_1_5.row][var_1_5.column].enemyCount + (arg_1_0[({
						row = var_1_5.row + arg_2_0[1],
						column = var_1_5.column + arg_2_0[2]
					}).row][({
						row = var_1_5.row + arg_2_0[1],
						column = var_1_5.column + arg_2_0[2]
					}).column].isEnemy and 1 or 0))

					local var_2_4 = _.detect(var_1_2, function(arg_4_0)
						return arg_4_0.row == var_2_0.row and arg_4_0.column == var_2_0.column
					end)
					local var_2_5 = not var_2_4

					if var_2_4 then
						var_2_5 = var_1_4[({
							row = var_1_5.row + arg_2_0[1],
							column = var_1_5.column + arg_2_0[2]
						}).row][({
							row = var_1_5.row + arg_2_0[1],
							column = var_1_5.column + arg_2_0[2]
						}).column].enemyCount > var_2_3.enemyCount or var_1_4[({
							row = var_1_5.row + arg_2_0[1],
							column = var_1_5.column + arg_2_0[2]
						}).row][({
							row = var_1_5.row + arg_2_0[1],
							column = var_1_5.column + arg_2_0[2]
						}).column].enemyCount == var_2_3.enemyCount and var_1_4[({
							row = var_1_5.row + arg_2_0[1],
							column = var_1_5.column + arg_2_0[2]
						}).row][({
							row = var_1_5.row + arg_2_0[1],
							column = var_1_5.column + arg_2_0[2]
						}).column].priority > var_2_3.priority

						if var_2_5 then
							table.removebyvalue(var_1_2, var_2_4)
						end
					end

					if var_2_5 then
						local var_2_6 = var_1_4[({
							row = var_1_5.row + arg_2_0[1],
							column = var_1_5.column + arg_2_0[2]
						}).row]

						if not var_1_4[({
							row = var_1_5.row + arg_2_0[1],
							column = var_1_5.column + arg_2_0[2]
						}).row] then
							var_2_6 = {}
						end

						var_1_4[({
							row = var_1_5.row + arg_2_0[1],
							column = var_1_5.column + arg_2_0[2]
						}).row] = var_2_6
						var_1_4[({
							row = var_1_5.row + arg_2_0[1],
							column = var_1_5.column + arg_2_0[2]
						}).row][({
							row = var_1_5.row + arg_2_0[1],
							column = var_1_5.column + arg_2_0[2]
						}).column] = var_2_3

						local var_2_7 = 0

						for iter_2_0 = #var_1_2, 1, -1 do
							if var_2_3.enemyCount > var_1_4[var_1_2[iter_2_0].row][var_1_2[iter_2_0].column].enemyCount or var_2_3.enemyCount == var_1_4[var_1_2[iter_2_0].row][var_1_2[iter_2_0].column].enemyCount and var_2_3.priority >= var_1_4[var_1_2[iter_2_0].row][var_1_2[iter_2_0].column].priority then
								var_2_7 = iter_2_0

								break
							end
						end

						table.insert(var_1_2, var_2_7 + 1, {
							row = var_1_5.row + arg_2_0[1],
							column = var_1_5.column + arg_2_0[2]
						})
					end
				else
					var_1_0 = math.min(var_1_0, var_2_2)
				end
			end

			return
		end)
	end

	if var_1_0 >= var_0_0.PrioObstacle then
		local var_1_6 = 1000000

		for iter_1_0, iter_1_1 in pairs({
			[arg_1_3.row] = {
				[arg_1_3.column] = {
					priority = 0,
					enemyCount = 0,
					path = {}
				}
			}
		}) do
			for iter_1_2, iter_1_3 in pairs(iter_1_1) do
				local var_1_7 = math.abs(arg_1_4.row - iter_1_0) + math.abs(arg_1_4.column - iter_1_2)
				local var_1_8

				if var_1_7 < var_1_6 or var_1_7 == var_1_6 and var_0_0.PrioForbidden > iter_1_3.priority then
					var_1_6 = var_1_7
					var_1_8 = iter_1_3.priority
					var_1_1 = iter_1_3.path
				end
			end
		end
	end

	return var_1_0, var_1_1
end

function var_0_0.StaticFind(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
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
		return var_0_2(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	end

	return
end

return var_0_0
