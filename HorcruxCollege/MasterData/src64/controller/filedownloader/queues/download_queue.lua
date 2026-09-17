local var_0_0 = {}
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = 0

function var_0_0.getCount()
	return var_0_3
end

function var_0_0.getFileNameByURL(arg_3_0, arg_3_1)
	return var_0_2[arg_3_1]
end

setmetatable(var_0_0, {
	__index = var_0_1,
	__newindex = function(arg_1_0, arg_1_1, arg_1_2)
		if arg_1_2 == nil then
			if var_0_1[arg_1_1] then
				var_0_1[arg_1_1] = nil
				var_0_2[var_0_1[arg_1_1]] = nil
				var_0_3 = var_0_3 - 1
			end

			return
		end

		assert(type(arg_1_2) == "string", "Error Type For _download_queue")

		if not var_0_1[arg_1_1] then
			var_0_1[arg_1_1] = arg_1_2
			var_0_2[arg_1_2] = arg_1_1
			var_0_3 = var_0_3 + 1
		end
	end
})

return var_0_0
