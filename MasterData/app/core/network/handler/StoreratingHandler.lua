local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Storerating_Notify = function(arg_1_0, arg_1_1, arg_1_2)
		g.core.model.User.UserTitleData:setScorePushState()
	end
}
