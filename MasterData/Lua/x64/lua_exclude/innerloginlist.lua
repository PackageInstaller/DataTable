local cjson = require("cjson")

return {
	GetLoginList = function(arg_1_0)
		local var_1_0 = Resources.Load("innerLoginInfo2")

		if var_1_0 then
			local var_1_1 = {}

			for iter_1_0, iter_1_1 in pairs((cjson.decode((tostring(var_1_0))))) do
				var_1_1[iter_1_1.id] = iter_1_1
			end

			return var_1_1
		else
			local var_1_2 = {}

			for iter_1_2, iter_1_3 in pairs((cjson.decode((tostring((Resources.Load("innerLoginInfo"))))))) do
				var_1_2[iter_1_2] = {
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

			return var_1_2
		end
	end
}
