local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_HarmoniousMystery_Notify = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.homeData:addAndDelHarmoniousMysteryList(arg_1_2)
		end
	end,
	on_S2C_HarmoniousMystery_Infos = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.homeData:initHarmoniousMysteryList(arg_2_2)
		end
	end
}
