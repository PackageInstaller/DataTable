local var_0_0 = class("GraphPath")

GraphPath = var_0_0

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.points = {}
	arg_1_0.edges = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_1.Points) do
		table.merge({
			id = iter_1_0,
			nexts = {}
		}, iter_1_1)

		arg_1_0.points[iter_1_0] = setmetatable({
			id = iter_1_0,
			nexts = {}
		}, Vector2)
	end

	for iter_1_2, iter_1_3 in pairs(arg_1_1.Edges) do
		if arg_1_0.points[iter_1_3.p1] and arg_1_0.points[iter_1_3.p2] and arg_1_0.points[iter_1_3.p1] ~= arg_1_0.points[iter_1_3.p2] then
			table.insert(arg_1_0.points[iter_1_3.p1].nexts, iter_1_3.p2)
			table.insert(arg_1_0.points[iter_1_3.p2].nexts, iter_1_3.p1)

			arg_1_0.edges[arg_1_0.points[iter_1_3.p1]] = arg_1_0.edges[arg_1_0.points[iter_1_3.p1]] or {}
			arg_1_0.edges[arg_1_0.points[iter_1_3.p1]][arg_1_0.points[iter_1_3.p2]] = iter_1_3
			arg_1_0.edges[arg_1_0.points[iter_1_3.p2]] = arg_1_0.edges[arg_1_0.points[iter_1_3.p2]] or {}
			arg_1_0.edges[arg_1_0.points[iter_1_3.p2]][arg_1_0.points[iter_1_3.p1]] = iter_1_3
		end
	end

	return
end

function var_0_0.getRandomPoint(arg_2_0)
	local var_2_0 = _.values(arg_2_0.points)

	return var_2_0[math.random(1, #var_2_0)]
end

function var_0_0.getPoint(arg_3_0, arg_3_1)
	return arg_3_0.points[arg_3_1]
end

function var_0_0.getEdge(arg_4_0, arg_4_1, arg_4_2)
	return arg_4_0.edges[arg_4_1] and arg_4_0.edges[arg_4_1][arg_4_2]
end

return
