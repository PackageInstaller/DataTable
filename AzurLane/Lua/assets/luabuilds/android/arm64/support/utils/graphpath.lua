class = var_0_10000

local var_0_0 = var_0_10000("GraphPath")
local var_0_1 = GraphPath

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.points = {}
	arg_1_0.edges = {}
	pairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.Points) do
		local var_1_0 = {
			id = iter_1_0,
			nexts = {}
		}

		table = var_8

		var_8.merge(var_1_0, iter_1_1)

		local var_1_1 = arg_1_0.points

		setmetatable = var_1_10009

		local var_1_2 = var_1_0

		Vector2 = var_1_10012
		var_1_1[iter_1_0] = var_1_10009(var_1_2, var_1_10012)
	end

	pairs = var_2

	for iter_1_2, iter_1_3 in var_2(arg_1_1.Edges) do
		local var_1_3 = arg_1_0.points[iter_1_3.p1]
		local var_1_4 = arg_1_0.points[iter_1_3.p2]

		if var_1_3 and var_1_4 and var_1_3 ~= var_1_4 then
			table = var_9

			var_9.insert(var_1_3.nexts, iter_1_3.p2)

			table = var_9

			var_9.insert(var_1_4.nexts, iter_1_3.p1)

			local var_1_5 = arg_1_0.edges
			local var_1_6

			if not arg_1_0.edges[var_1_3] then
				var_1_6 = {}
			end

			var_1_5[var_1_3] = var_1_6
			arg_1_0.edges[var_1_3][var_1_4] = iter_1_3

			local var_1_7 = arg_1_0.edges
			local var_1_8

			if not arg_1_0.edges[var_1_4] then
				var_1_8 = {}
			end

			var_1_7[var_1_4] = var_1_8
			arg_1_0.edges[var_1_4][var_1_3] = iter_1_3
		end
	end

	return
end

function var_0_1.getRandomPoint(arg_2_0)
	_ = var_1_10001

	local var_2_0 = var_1_10001.values(arg_2_0.points)

	math = var_1_10002

	return var_2_0[var_1_10002.random(1, #var_2_0)]
end

function var_0_1.getPoint(arg_3_0, arg_3_1)
	return arg_3_0.points[arg_3_1]
end

function var_0_1.getEdge(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0

	if arg_4_0.edges[arg_4_1] then
		var_4_0 = arg_4_0.edges[arg_4_1][arg_4_2]
	end

	return var_4_0
end

return
