return {
	new = function(arg_1_0)
		local var_1_0 = {}

		setmetatable(var_1_0, arg_1_0)

		arg_1_0.__index = arg_1_0
		var_1_0.pool = {}
		var_1_0.activePool = {}

		return var_1_0
	end,
	createObject = function(self, arg_2_1)
		if arg_2_1 ~= nil then
			arg_2_1:setVisible(false)

			arg_2_1.isActive = false

			table.insert(self.pool, arg_2_1)
		end
	end,
	getObject = function(self, arg_3_1)
		for iter_3_0, iter_3_1 in ipairs(self.pool) do
			if not iter_3_1.isActive and (not arg_3_1 or iter_3_1.type == arg_3_1) then
				iter_3_1.isActive = true

				iter_3_1:setVisible(true)
				table.insert(self.activePool, iter_3_1)

				return iter_3_1
			end
		end

		return nil
	end,
	getObjectsByType = function(self, arg_4_1)
		local var_4_0 = {}

		for iter_4_0, iter_4_1 in pairs(self.pool) do
			if iter_4_1.type == arg_4_1 then
				table.insert(var_4_0, iter_4_1)
			end
		end

		return var_4_0
	end,
	recycleObject = function(self, arg_5_1, arg_5_2)
		arg_5_2 = arg_5_2 or false

		for iter_5_0, iter_5_1 in pairs(self.activePool) do
			if iter_5_1 == arg_5_1 then
				arg_5_1.isActive = false

				arg_5_1:setVisible(arg_5_2)
				table.remove(self.activePool, iter_5_0)

				if arg_5_1.reset then
					arg_5_1.reset()
				end

				return
			end
		end
	end,
	clearAllActiveObject = function(self)
		for iter_6_0, iter_6_1 in pairs(self.activePool) do
			iter_6_1.isActive = false

			iter_6_1:setVisible(false)

			if iter_6_1.rest then
				iter_6_1.rest()
			end
		end

		self.activePool = {}
	end,
	clearAllActiveObjectByType = function(self, arg_7_1)
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs(self.activePool) do
			if iter_7_1.type == arg_7_1 then
				iter_7_1.isActive = false

				iter_7_1:setVisible(false)

				if iter_7_1.rest then
					iter_7_1.rest()
				end

				table.insert(var_7_0, iter_7_0)
			end
		end

		for iter_7_2, iter_7_3 in ipairs(var_7_0) do
			self.activePool[iter_7_3] = nil
		end
	end,
	destroy = function(arg_8_0)
		arg_8_0.pool = {}
	end
}
