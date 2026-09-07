local Context = class("Context")

Context.TRANS_TYPE = {
	CROSS = 1,
	ONE_BY_ONE = 2
}

function Context:Ctor(arg_1_1)
	arg_1_1 = arg_1_1 or {}
	self.mediator = arg_1_1.mediator
	self.viewComponent = arg_1_1.viewComponent
	self.scene = arg_1_1.scene
	self.onRemoved = arg_1_1.onRemoved
	self.cleanStack = defaultValue(arg_1_1.cleanStack, false)
	self.cleanChild = defaultValue(arg_1_1.cleanChild, false)
	self.irregularSequence = defaultValue(arg_1_1.irregularSequence, false)
	self.skipBack = defaultValue(arg_1_1.skipBack, false)
	self.data = arg_1_1.data or {}
	self.parent = arg_1_1.parent
	self.children = {}

	return
end

function Context:extendData(arg_2_1)
	if arg_2_1 == nil then
		return
	end

	assert(type(arg_2_1) == "table", "data object should be a table")

	for iter_2_0, iter_2_1 in pairs(arg_2_1) do
		self.data[iter_2_0] = iter_2_1
	end

	return
end

function Context:addChild(arg_3_1)
	assert(isa(arg_3_1, Context), "should be an instance of Context")
	assert(arg_3_1.parent == nil, "context already has parent")

	arg_3_1.parent = self

	table.insert(self.children, arg_3_1)

	return
end

function Context:addChilds(arg_4_1)
	_.each(arg_4_1, function(arg_5_0)
		self:addChild(arg_5_0)

		return
	end)

	return
end

function Context:hasChild()
	return self.children and #self.children > 0
end

function Context:removeChild(arg_7_1)
	assert(isa(arg_7_1, Context), "should be an instance of Context")

	for iter_7_0, iter_7_1 in ipairs(self.children) do
		if iter_7_1 == arg_7_1 then
			return table.remove(self.children, iter_7_0)
		end
	end

	return nil
end

function Context:retriveLastChild()
	for iter_8_0 = #self.children, 1, -1 do
		return self.children[iter_8_0]:retriveLastChild()
	end

	return self
end

function Context:GetHierarchy()
	local var_9_0 = {
		self
	}
	local var_9_1 = {}

	while #var_9_0 > 0 do
		local var_9_2 = table.remove(var_9_0, 1)

		for iter_9_0, iter_9_1 in ipairs(var_9_2.children) do
			table.insert(var_9_0, iter_9_1)
		end

		table.insert(var_9_1, var_9_2)
	end

	return var_9_1
end

function Context:getContextByMediator(arg_10_1)
	local function var_10_0(arg_11_0, arg_11_1)
		if arg_11_0.mediator == arg_11_1 then
			return arg_11_0
		end

		for iter_11_0, iter_11_1 in ipairs(arg_11_0.children) do
			local var_11_0 = var_10_0(iter_11_1, arg_11_1)

			if var_11_0 ~= nil then
				return var_11_0
			end
		end

		return nil
	end

	return var_10_0(self, arg_10_1)
end

function Context:onContextRemoved()
	return self.onRemoved and self.onRemoved()
end

return Context
