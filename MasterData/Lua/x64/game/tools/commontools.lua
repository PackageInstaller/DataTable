local var_0_0 = {
	UniversalSort = function(arg_1_0, arg_1_1, ...)
		local var_1_0 = {
			...
		}

		return table.sort(arg_1_0, function(arg_2_0, arg_2_1)
			for iter_2_0, iter_2_1 in ipairs(var_1_0) do
				if arg_2_0[iter_2_1] ~= arg_2_1[iter_2_1] then
					if arg_1_1 then
						return arg_2_0[iter_2_1] < arg_2_1[iter_2_1]
					else
						return arg_2_1[iter_2_1] < arg_2_0[iter_2_1]
					end
				end
			end
		end)
	end
}

local function var_0_1(arg_3_0, arg_3_1)
	return arg_3_0 < arg_3_1
end

local function var_0_2(arg_4_0)
	return arg_4_0
end

function var_0_0.UniversalSortEx(arg_5_0, ...)
	local var_5_0 = {
		...
	}

	return table.sort(arg_5_0, function(arg_6_0, arg_6_1)
		for iter_6_0, iter_6_1 in pairs(var_5_0) do
			local var_6_0 = iter_6_1.map or var_0_2
			local var_6_1 = var_6_0(arg_6_0)
			local var_6_2 = var_6_0(arg_6_1)
			local var_6_3 = iter_6_1.lessOp or var_0_1

			if var_6_1 ~= var_6_2 then
				if iter_6_1.ascend then
					return var_6_3(var_6_1, var_6_2)
				else
					return var_6_3(var_6_2, var_6_1)
				end
			end
		end

		return false
	end)
end

function var_0_0.Convert2SamePosition(arg_7_0, arg_7_1)
	arg_7_0.position = arg_7_1.position
end

function var_0_0:GenerateItems(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	self.pool = self.pool or {}

	local var_8_0 = #self.pool
	local var_8_1 = #arg_8_1

	while var_8_1 < arg_8_2 do
		if var_8_0 > 0 then
			self.pool[var_8_0].transform_:SetParent(arg_8_5)
			table.insert(arg_8_1, self.pool[var_8_0])
			table.remove(self.pool, var_8_0)

			var_8_0 = var_8_0 - 1
		else
			table.insert(arg_8_1, (arg_8_3.New((Object.Instantiate(arg_8_4, arg_8_5)))))
		end

		var_8_1 = var_8_1 + 1
	end

	while arg_8_2 < var_8_1 do
		arg_8_1[var_8_1].gameObject_:SetActive(false)
		table.insert(self.pool, arg_8_1[var_8_1])
		table.remove(arg_8_1, var_8_1)

		var_8_1 = var_8_1 - 1
	end

	for iter_8_0 = 1, var_8_1 do
		arg_8_1[iter_8_0].gameObject_:SetActive(true)
	end
end

function var_0_0:SetCommonData(arg_9_1, arg_9_2)
	arg_9_2 = arg_9_2 or clone(ItemTemplateData)
	arg_9_2.number = nil

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		arg_9_2[iter_9_0] = iter_9_1
	end

	self:SetData(arg_9_2)
end

local function var_0_3(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_0 or arg_10_3 then
		var_0_0.Ask(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	elseif arg_10_2 then
		arg_10_2(false, arg_10_4)
	end
end

function var_0_0.Ask(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_3 = arg_11_3 or {}

	if arg_11_0 then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0) do
			local var_11_0 = iter_11_1.flag or string.format("flag_%d", iter_11_0)
			local var_11_2 = iter_11_1.reverseFlag or false

			if arg_11_3[var_11_0] == nil and (iter_11_1.check or nil) and iter_11_1.check() then
				local var_11_3 = {
					isTop = true
				}

				var_11_3.title = iter_11_1.title or GetTips("PROMPT")
				var_11_3.content = iter_11_1.content

				function var_11_3.OkCallback()
					arg_11_3[var_11_0] = not var_11_2

					if iter_11_1.okCallback then
						iter_11_1.okCallback(arg_11_3)
					end

					var_0_3(arg_11_3[var_11_0], arg_11_0, arg_11_1, arg_11_2, arg_11_3)
				end

				function var_11_3.CancelCallback()
					arg_11_3[var_11_0] = var_11_2

					if iter_11_1.cancelCallback then
						iter_11_1.cancelCallback(arg_11_3)
					end

					var_0_3(arg_11_3[var_11_0], arg_11_0, arg_11_1, arg_11_2, arg_11_3)
				end

				ShowMessageBox(var_11_3)

				return
			end
		end
	end

	local var_11_4 = true

	for iter_11_2, iter_11_3 in pairs(arg_11_3) do
		var_11_4 = var_11_4 and iter_11_3
	end

	if arg_11_1 then
		arg_11_1(var_11_4, arg_11_3)
	end
end

return var_0_0
