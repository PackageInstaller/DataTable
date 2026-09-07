local GraphPath = class("GraphPath")

GraphPath = GraphPath

function GraphPath:Ctor(arg_1_1)
	self.points = {}
	self.edges = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_1.Points) do
		local var_1_0 = {
			id = iter_1_0,
			nexts = {}
		}

		table.merge(var_1_0, iter_1_1)

		self.points[iter_1_0] = setmetatable(var_1_0, Vector2)
	end

	for iter_1_2, iter_1_3 in pairs(arg_1_1.Edges) do
		if self.points[iter_1_3.p1] and self.points[iter_1_3.p2] and self.points[iter_1_3.p1] ~= self.points[iter_1_3.p2] then
			table.insert(self.points[iter_1_3.p1].nexts, iter_1_3.p2)
			table.insert(self.points[iter_1_3.p2].nexts, iter_1_3.p1)

			self.edges[self.points[iter_1_3.p1]] = self.edges[self.points[iter_1_3.p1]] or {}
			self.edges[self.points[iter_1_3.p1]][self.points[iter_1_3.p2]] = iter_1_3
			self.edges[self.points[iter_1_3.p2]] = self.edges[self.points[iter_1_3.p2]] or {}
			self.edges[self.points[iter_1_3.p2]][self.points[iter_1_3.p1]] = iter_1_3
		end
	end

	return
end

function GraphPath:getRandomPoint()
	local var_2_0 = _.values(self.points)

	return var_2_0[math.random(1, #var_2_0)]
end

function GraphPath:getPoint(arg_3_1)
	return self.points[arg_3_1]
end

function GraphPath:getEdge(arg_4_1, arg_4_2)
	return self.edges[arg_4_1] and self.edges[arg_4_1][arg_4_2]
end

return
