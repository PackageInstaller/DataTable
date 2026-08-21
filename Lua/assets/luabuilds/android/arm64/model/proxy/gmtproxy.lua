local var_0_0 = class("GMTProxy", import(".NetProxy"))

function var_0_0.register(arg_1_0)
	arg_1_0:on(50115, function(arg_2_0)
		pg.GMTMgr.GetInstance():showGMT(arg_2_0.timestamp)

		return
	end)

	return
end

return var_0_0
