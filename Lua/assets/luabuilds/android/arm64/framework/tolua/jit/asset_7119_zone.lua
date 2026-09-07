local var_0_0 = table.remove

return setmetatable({
	flush = function(arg_1_0)
		for iter_1_0 = #arg_1_0, 1, -1 do
			arg_1_0[iter_1_0] = nil
		end

		return
	end,
	get = function(self)
		return self[#self]
	end
}, {
	__call = function(arg_3_0, arg_3_1)
		if arg_3_1 then
			arg_3_0[#arg_3_0 + 1] = arg_3_1
		else
			return (assert(var_0_0(arg_3_0), "empty zone stack"))
		end

		return
	end
})
