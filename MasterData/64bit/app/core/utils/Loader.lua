return {
	readOnly = function(arg_1_0)
		local var_1_0

		return setmetatable({}, {
			__index = function(arg_2_0, arg_2_1)
				if not var_1_0 then
					local var_2_0 = require(arg_1_0)

					var_1_0 = var_2_0.new and var_2_0.new() or var_2_0
				end

				return var_1_0[arg_2_1]
			end,
			__newindex = function(arg_3_0, arg_3_1, arg_3_2)
				assert(false, "DO NOT write data into a read only table or object!")
			end
		})
	end,
	dynamic = function(arg_4_0)
		local var_4_0

		local function var_4_1()
			if not var_4_0 then
				local var_5_0 = require(arg_4_0)

				var_4_0 = type(rawget(var_5_0, "new")) == "function" and var_5_0.new() or var_5_0
			end
		end

		return setmetatable({}, {
			__index = function(arg_6_0, arg_6_1)
				if arg_6_1 == "resetInstance" then
					return function()
						var_4_0 = nil
					end
				end

				var_4_1()

				return var_4_0[arg_6_1]
			end,
			__newindex = function(arg_8_0, arg_8_1, arg_8_2)
				var_4_1()

				var_4_0[arg_8_1] = arg_8_2
			end
		})
	end,
	proxy = function(arg_9_0, arg_9_1)
		local var_9_0 = {
			_expired = false,
			isProxy = true,
			_indexCache = {},
			__pindex = function(self, arg_10_1)
				self:_resetInternal()

				if not self._client[arg_10_1] then
					return nil
				end

				if self._indexCache[arg_10_1] then
					return self._indexCache[arg_10_1]
				end

				if type(self._client[arg_10_1]) ~= "function" then
					return self._client[arg_10_1]
				else
					self._indexCache[arg_10_1] = function(arg_11_0)
						if arg_11_0 and arg_11_0 == self then
							arg_11_0 = self._client
						end

						return self._client[arg_10_1](arg_11_0, ...)
					end

					return self._indexCache[arg_10_1]
				end
			end,
			__pnewindex = function(self, arg_12_1, arg_12_2)
				self:_resetInternal()

				self._client[arg_12_1] = arg_12_2
			end
		}

		function var_9_0.setClient(arg_13_0, arg_13_1)
			arg_13_0._client = arg_13_1

			setmetatable(arg_13_0, {
				__index = var_9_0.__pindex,
				__newindex = var_9_0.__pnewindex
			})
		end

		function var_9_0:getClient()
			return self._client
		end

		function var_9_0.clearClient(arg_15_0)
			arg_15_0._client = nil
			arg_15_0._indexCache = nil

			setmetatable(arg_15_0, {})
		end

		function var_9_0.expired(arg_16_0)
			arg_16_0._expired = true
		end

		function var_9_0:isExpired()
			return self._expired
		end

		function var_9_0:reset(arg_18_1)
			if arg_18_1 then
				self:_resetInternal()
			end

			self._expired = false
		end

		function var_9_0:_resetInternal()
			if self._expired then
				self._expired = false

				if arg_9_1 then
					self:setClient((require(arg_9_1, true)))
				end
			end
		end

		function var_9_0.clear(arg_20_0)
			return
		end

		var_9_0:setClient(arg_9_0)

		return var_9_0
	end
}
