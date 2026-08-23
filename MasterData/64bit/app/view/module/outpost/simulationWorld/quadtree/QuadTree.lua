local var_0_0 = table.insert
local var_0_1 = table.remove
local var_0_2 = ipairs
local var_0_3 = {}

local function var_0_4(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = var_0_1(var_0_3) or require("app.view.module.outpost.simulationWorld.quadtree.QuadNode").new()

	var_1_0.x = arg_1_0
	var_1_0.y = arg_1_1
	var_1_0.width = arg_1_2
	var_1_0.height = arg_1_3
	var_1_0.depth = arg_1_4
	var_1_0.capacity = arg_1_5
	var_1_0.maxDepth = arg_1_6
	var_1_0.root = arg_1_7

	return var_1_0
end

local function var_0_5(arg_2_0)
	arg_2_0:release()
	var_0_0(var_0_3, arg_2_0)
end

local QuadTree = class("QuadTree")

function QuadTree:ctor(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	arg_3_5 = arg_3_5 or 4
	arg_3_6 = arg_3_6 or 4
	self.root = var_0_4(arg_3_1, arg_3_2, arg_3_3, arg_3_4, 0, arg_3_5, arg_3_6, self)
	self._dirtyRenderObject = {}
end

function QuadTree:addRenderDirty(arg_4_1)
	var_0_0(self._dirtyRenderObject, arg_4_1)
end

function QuadTree:refreshRender()
	local var_5_0 = false

	for iter_5_0, iter_5_1 in var_0_2(self._dirtyRenderObject) do
		if iter_5_1.node then
			self:updateDependencies(iter_5_1)

			var_5_0 = true
		end
	end

	self._dirtyRenderObject = {}

	return var_5_0
end

function QuadTree:insert(arg_6_1)
	if not QuadTree.contains(arg_6_1.x, arg_6_1.y, self.root) then
		return false
	end

	QuadTree.recursiveInsert(self.root, arg_6_1)

	return true
end

function QuadTree:queryRange(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = {}
	local var_7_1 = {}

	QuadTree.recursiveQueryRange(self.root, arg_7_1, arg_7_2, arg_7_3 * arg_7_3, var_0_4(arg_7_1 - arg_7_3 * 0.5, arg_7_2 - arg_7_3 * 0.5, arg_7_3, arg_7_3, 0, self.root.capacity, self.root.maxDepth), var_7_0, var_7_1)

	return var_7_0, var_7_1
end

function QuadTree:queryRect(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2 = var_0_4(arg_8_1, arg_8_2, arg_8_3, arg_8_4, 0, self.root.capacity, self.root.maxDepth)

	QuadTree.recursiveQueryRect(self.root, var_8_2, var_8_0, var_8_1)
	var_0_5(var_8_2)

	return var_8_0, var_8_1
end

function QuadTree:remove(arg_9_1)
	if not arg_9_1.node then
		return false
	end

	local var_9_0 = arg_9_1.node

	for iter_9_0, iter_9_1 in var_0_2(arg_9_1.node.entities) do
		if iter_9_1.oid == arg_9_1.oid then
			var_0_1(var_9_0.entities, iter_9_0)

			arg_9_1.node = nil

			QuadTree.tryMery(var_9_0)

			return true
		end
	end

	return false
end

function QuadTree:update(arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_1.node then
		return false
	end

	if QuadTree.contains(arg_10_2, arg_10_3, arg_10_1.node) then
		arg_10_1.x = arg_10_2
		arg_10_1.y = arg_10_3

		return true
	end

	self:remove(arg_10_1)

	arg_10_1.x = arg_10_2
	arg_10_1.y = arg_10_3

	return self:insert(arg_10_1)
end

function QuadTree:updateDependencies(arg_11_1)
	arg_11_1.renderDependenciesBefore = {}

	for iter_11_0, iter_11_1 in var_0_2(arg_11_1.renderDependenciesAfter) do
		iter_11_1.renderDependenciesBefore[arg_11_1.oid] = nil
	end

	arg_11_1.renderDependenciesAfter = {}

	if not arg_11_1.node or arg_11_1:isClear() then
		return
	end

	for iter_11_2, iter_11_3 in var_0_2((self:queryRect(arg_11_1.x - arg_11_1.renderDependWidth * 0.5, arg_11_1.y - arg_11_1.renderDependHeight * 0.5, arg_11_1.renderDependWidth, arg_11_1.renderDependHeight))) do
		if iter_11_3.oid ~= arg_11_1.oid then
			if QuadTree.shouldOcclude(arg_11_1, iter_11_3) then
				arg_11_1.renderDependenciesBefore[iter_11_3.oid] = iter_11_3
			else
				iter_11_3.renderDependenciesBefore[arg_11_1.oid] = arg_11_1

				var_0_0(arg_11_1.renderDependenciesAfter, iter_11_3)
			end
		end
	end
end

function QuadTree:queryRenderList(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = {}
	local var_12_3, var_12_4 = self:queryRect(arg_12_1, arg_12_2, arg_12_3, arg_12_4)

	local function var_12_5(arg_13_0)
		if var_12_2[arg_13_0.oid] then
			dumpError("QuadTree:queryRenderList visit error, entity is locked: " .. arg_13_0.oid)

			return
		end

		if not var_12_1[arg_13_0.oid] then
			var_12_2[arg_13_0.oid] = true

			for iter_13_0, iter_13_1 in pairs(arg_13_0.renderDependenciesBefore) do
				var_12_5(iter_13_1)
			end

			var_12_2[arg_13_0.oid] = false
			var_12_1[arg_13_0.oid] = true

			if var_12_4[arg_13_0.oid] then
				var_0_0(var_12_0, arg_13_0)
			end
		end
	end

	for iter_12_0, iter_12_1 in var_0_2(var_12_3) do
		var_12_5(iter_12_1)
	end

	return var_12_0, var_12_4
end

function QuadTree:clearTree()
	self.root:release()

	self._dirtyRenderObject = {}
end

function QuadTree:queryAllEntity()
	local var_15_0 = {}
	local var_15_1 = {}

	QuadTree.recursiveQueryRect(self.root, self.root, var_15_0, var_15_1)

	return var_15_0, var_15_1
end

function QuadTree:debugLog()
	local var_16_0 = "\n"

	local function var_16_1(arg_17_0, arg_17_1)
		var_16_0 = var_16_0 .. string.rep("| ", arg_17_1) .. "Node at (" .. arg_17_0.x .. ", " .. arg_17_0.y .. ") Size: " .. arg_17_0.width .. "x" .. arg_17_0.height .. " Depth: " .. arg_17_0.depth .. "\n"

		if arg_17_0.children then
			for iter_17_0, iter_17_1 in var_0_2(arg_17_0.children) do
				var_16_1(iter_17_1, arg_17_1 + 1)
			end
		elseif #arg_17_0.entities > 0 then
			var_16_0 = var_16_0 .. string.rep("|-", arg_17_1 + 1) .. "Entities: " .. #arg_17_0.entities .. "\n"

			for iter_17_2, iter_17_3 in var_0_2(arg_17_0.entities) do
				var_16_0 = var_16_0 .. string.rep("| ", arg_17_1 + 2) .. "Entity OID: " .. iter_17_3.oid .. " Position: (" .. iter_17_3.x .. ", " .. iter_17_3.y .. ")\n"
			end
		end
	end

	var_16_1(self.root, 0)

	return {
		"\n"
	}
end

function QuadTree:contains(arg_18_1, arg_18_2)
	return self >= arg_18_2.x and self < arg_18_2.x + arg_18_2.width and arg_18_1 >= arg_18_2.y and arg_18_1 < arg_18_2.y + arg_18_2.height
end

function QuadTree:intersects(arg_19_1)
	return self.x < arg_19_1.x + arg_19_1.width and self.x + self.width > arg_19_1.x and self.y < arg_19_1.y + arg_19_1.height and self.y + self.height > arg_19_1.y
end

function QuadTree:recursiveInsert(arg_20_1)
	if self.children then
		for iter_20_0, iter_20_1 in var_0_2(self.children) do
			if QuadTree.contains(arg_20_1.x, arg_20_1.y, iter_20_1) then
				QuadTree.recursiveInsert(iter_20_1, arg_20_1)

				return
			end
		end
	end

	var_0_0(self.entities, arg_20_1)

	arg_20_1.node = self

	if #self.entities > self.capacity and self.depth < self.maxDepth then
		if not self.children then
			self.children = {}

			var_0_0(self.children, var_0_4(self.x, self.y, self.width / 2, self.height / 2, self.depth + 1, self.capacity, self.maxDepth, self.root))
			var_0_0(self.children, var_0_4(self.x + self.width / 2, self.y, self.width / 2, self.height / 2, self.depth + 1, self.capacity, self.maxDepth, self.root))
			var_0_0(self.children, var_0_4(self.x, self.y + self.height / 2, self.width / 2, self.height / 2, self.depth + 1, self.capacity, self.maxDepth, self.root))
			var_0_0(self.children, var_0_4(self.x + self.width / 2, self.y + self.height / 2, self.width / 2, self.height / 2, self.depth + 1, self.capacity, self.maxDepth, self.root))
		end

		for iter_20_2, iter_20_3 in var_0_2(self.entities) do
			for iter_20_4, iter_20_5 in var_0_2(self.children) do
				if QuadTree.contains(iter_20_3.x, iter_20_3.y, iter_20_5) then
					QuadTree.recursiveInsert(iter_20_5, iter_20_3)

					break
				end
			end
		end

		self.entities = {}
	end
end

function QuadTree:recursiveQueryRect(arg_21_1, arg_21_2, arg_21_3)
	if not self or not QuadTree.intersects(self, arg_21_1) then
		return
	end

	if self.children then
		for iter_21_0, iter_21_1 in var_0_2(self.children) do
			QuadTree.recursiveQueryRect(iter_21_1, arg_21_1, arg_21_2, arg_21_3)
		end
	else
		for iter_21_2, iter_21_3 in var_0_2(self.entities) do
			if not iter_21_3:isClear() and QuadTree.contains(iter_21_3.x, iter_21_3.y, arg_21_1) then
				var_0_0(arg_21_2, iter_21_3)

				arg_21_3[iter_21_3.oid] = iter_21_3
			end
		end
	end
end

function QuadTree:recursiveQueryRange(arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6)
	if not self or not QuadTree.intersects(self, arg_22_4) then
		return
	end

	if self.children then
		for iter_22_0, iter_22_1 in var_0_2(self.children) do
			QuadTree.recursiveQueryRange(iter_22_1, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6)
		end
	else
		for iter_22_2, iter_22_3 in var_0_2(self.entities) do
			if not iter_22_3:isClear() then
				if arg_22_3 >= (iter_22_3.x - arg_22_1) * (iter_22_3.x - arg_22_1) + (iter_22_3.y - arg_22_2) * (iter_22_3.y - arg_22_2) then
					var_0_0(arg_22_5, iter_22_3)

					arg_22_6[iter_22_3.oid] = iter_22_3
				end
			end
		end
	end
end

function QuadTree:tryMery()
	if not self.children or #self.children == 0 then
		return
	end

	local var_23_0 = 0

	for iter_23_0, iter_23_1 in var_0_2(self.children) do
		var_23_0 = var_23_0 + #iter_23_1.entities
	end

	if var_23_0 <= self.capacity then
		for iter_23_2, iter_23_3 in var_0_2(self.children) do
			for iter_23_4, iter_23_5 in var_0_2(iter_23_3.entities) do
				var_0_0(self.entities, iter_23_5)

				iter_23_5.node = self
			end

			var_0_5(iter_23_3)
		end

		self.children = nil
	else
		for iter_23_6, iter_23_7 in var_0_2(self.children) do
			QuadTree.tryMery(iter_23_7)
		end
	end
end

function QuadTree:shouldOcclude(arg_24_1)
	local var_24_2, var_24_3

	if self:isStatic() then
		local var_24_0 = self.y - 35 or self.y

		if arg_24_1:isStatic() then
			local var_24_1 = arg_24_1.y - 35 or arg_24_1.y

			if var_24_0 ~= var_24_1 then
				return var_24_1 < var_24_0
			end

			if self:isStatic() then
				var_24_2 = self.x - 60 or self.x

				if arg_24_1:isStatic() then
					var_24_3 = arg_24_1.x - 60 or arg_24_1.x
				end
			end
		end
	end

	return var_24_3 < var_24_2
end

return QuadTree
