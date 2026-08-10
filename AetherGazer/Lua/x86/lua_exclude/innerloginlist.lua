local var_0_0 = require("cjson")

return {
	GetLoginList = function(arg_1_0)
		local var_1_0 = Resources.Load("innerLoginInfo2")

		if var_1_0 then
			local var_1_1 = tostring(var_1_0)
			local var_1_2 = var_0_0.decode(var_1_1)
			local var_1_3 = {}

			for iter_1_0, iter_1_1 in pairs(var_1_2) do
				var_1_3[iter_1_1.id] = iter_1_1
			end

			return var_1_3
		else
			local var_1_4 = Resources.Load("innerLoginInfo")
			local var_1_5 = tostring(var_1_4)
			local var_1_6 = var_0_0.decode(var_1_5)
			local var_1_7 = {}

			for iter_1_2, iter_1_3 in pairs(var_1_6) do
				var_1_7[iter_1_2] = {
					index = 0,
					group = "",
					commit_time = "",
					start_time = "",
					branch = "",
					message = "",
					hash = "",
					server_id = 0,
					id = iter_1_2,
					name = iter_1_3.text,
					ip = iter_1_3.host,
					port = iter_1_3.port
				}
			end

			return var_1_7
		end
	end
}
