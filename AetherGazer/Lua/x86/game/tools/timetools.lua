return {
	StartAfterSeconds = function(arg_1_0, arg_1_1, arg_1_2)
		local var_1_0

		local function var_1_1()
			if var_1_0 ~= nil then
				arg_1_1(unpack(arg_1_2))
				var_1_0:Stop()

				var_1_0 = nil
			end
		end

		if var_1_0 ~= nil then
			var_1_0:Reset()
		else
			var_1_0 = Timer.New(var_1_1, arg_1_0, 1)

			var_1_0:Start()
		end

		return var_1_0
	end
}
