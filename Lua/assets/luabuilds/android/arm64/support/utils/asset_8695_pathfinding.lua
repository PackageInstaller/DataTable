local PathFinding = class("PathFinding")

PathFinding = PathFinding
PathFinding.PrioNormal = 1
PathFinding.PrioObstacle = 1000
PathFinding.PrioForbidden = 1000000

function PathFinding:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.cells = arg_1_1
	self.rows = arg_1_2
	self.columns = arg_1_3

	return
end

function PathFinding:Find(arg_2_1, arg_2_2)
	arg_2_1 = {
		row = arg_2_1.row,
		column = arg_2_1.column
	}
	arg_2_2 = {
		row = arg_2_2.row,
		column = arg_2_2.column
	}

	if self.cells[arg_2_1.row][arg_2_1.column] < 0 or self.cells[arg_2_2.row][arg_2_2.column] < 0 then
		return 0, {}
	else
		return self:_Find(arg_2_1, arg_2_2)
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

function PathFinding:_Find(arg_3_1, arg_3_2)
	local var_3_0 = PathFinding.PrioForbidden
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
		local var_3_5 = table.remove(var_3_2, 1)

		if var_3_5.row == arg_3_2.row and var_3_5.column == arg_3_2.column then
			var_3_0 = var_3_4[var_3_5.row][var_3_5.column].priority
			var_3_1 = var_3_4[var_3_5.row][var_3_5.column].path

			break
		end

		table.insert(var_3_3, var_3_5)
		_.each(var_0_1, function(arg_4_0)
			local var_4_0 = {
				row = var_3_5.row + arg_4_0[1],
				column = var_3_5.column + arg_4_0[2]
			}

			if not (_.any(var_3_2, function(arg_5_0)
				return arg_5_0.row == var_4_0.row and arg_5_0.column == var_4_0.column
			end) or _.any(var_3_3, function(arg_6_0)
				return arg_6_0.row == var_4_0.row and arg_6_0.column == var_4_0.column
			end)) and var_4_0.row >= 0 and var_4_0.row < self.rows and var_4_0.column >= 0 and var_4_0.column < self.columns then
				if var_3_4[var_3_5.row][var_3_5.column].priority + self.cells[var_4_0.row][var_4_0.column] < PathFinding.PrioObstacle then
					local var_4_1 = Clone(var_3_4[var_3_5.row][var_3_5.column])

					table.insert(var_4_1.path, var_4_0)

					var_4_1.priority = var_3_4[var_3_5.row][var_3_5.column].priority + self.cells[var_4_0.row][var_4_0.column]
					var_3_4[var_4_0.row] = var_3_4[var_4_0.row] or {}
					var_3_4[var_4_0.row][var_4_0.column] = var_4_1

					local var_4_2 = 0

					for iter_4_0 = #var_3_2, 1, -1 do
						if var_4_1.priority >= var_3_4[var_3_2[iter_4_0].row][var_3_2[iter_4_0].column].priority then
							var_4_2 = iter_4_0

							break
						end
					end

					table.insert(var_3_2, var_4_2 + 1, var_4_0)
				else
					var_3_0 = math.min(var_3_0, var_3_4[var_3_5.row][var_3_5.column].priority + self.cells[var_4_0.row][var_4_0.column])
				end
			end

			return
		end)
	end

	if var_3_0 >= PathFinding.PrioObstacle then
		local var_3_6 = 1000000

		for iter_3_0, iter_3_1 in pairs(var_3_4) do
			for iter_3_2, iter_3_3 in pairs(iter_3_1) do
				local var_3_7 = math.abs(arg_3_2.row - iter_3_0) + math.abs(arg_3_2.column - iter_3_2)

				if var_3_7 < var_3_6 or var_3_7 == var_3_6 and PathFinding.PrioForbidden > iter_3_3.priority then
					var_3_6 = var_3_7
					var_3_1 = iter_3_3.path
				end
			end
		end
	end

	return var_3_0, var_3_1
end

return PathFinding
