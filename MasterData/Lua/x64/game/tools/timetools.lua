return {
	StartAfterSeconds = function(arg_1_0, arg_1_1, arg_1_2)
		local var_1_0

		if nil ~= nil then
			var_1_0:Reset()
		else
			var_1_0 = Timer.New(function()
				if var_1_0 ~= nil then
					arg_1_1(unpack(arg_1_2))
					var_1_0:Stop()

					var_1_0 = nil
				end
			end, arg_1_0, 1)

			var_1_0:Start()
		end

		return var_1_0
	end
}
