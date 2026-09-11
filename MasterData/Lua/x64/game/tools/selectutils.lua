return {
	SingleSelect = function(arg_1_0, arg_1_1)
		local var_1_0 = arg_1_1

		return function(arg_3_0)
			local var_3_0

			if arg_3_0 ~= var_1_0 then
				var_3_0, var_1_0 = var_1_0, arg_3_0
			else
				var_3_0, var_1_0 = var_1_0
			end

			if arg_1_0 and arg_1_0.afterValueChange then
				arg_1_0.afterValueChange(var_3_0, var_1_0)
			end
		end, function()
			return var_1_0
		end
	end,
	MultiSelect = function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_4_2 or {}

		return function(arg_6_0)
			local var_6_0 = table.indexof(var_4_0, arg_6_0)

			if var_6_0 then
				table.remove(var_4_0, var_6_0)

				if arg_4_1 and arg_4_1.afterRemove then
					arg_4_1.afterRemove(arg_6_0)
				end
			elseif #var_4_0 < arg_4_0 then
				table.insert(var_4_0, arg_6_0)

				if arg_4_1 and arg_4_1.afterInsert then
					arg_4_1.afterInsert(arg_6_0)
				end

				var_6_0 = #var_4_0 + 1
			end

			return var_6_0
		end, function()
			return var_4_0
		end, function()
			table.clean(var_4_0)

			if arg_4_1 and arg_4_1.afterClear then
				arg_4_1.afterClear()
			end
		end
	end
}
