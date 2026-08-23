local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_CrossActivity_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.recruitData:updateAllCrossRecruitData(arg_1_2.cross_recruit or {})
			g.core.model.User.recruitData:updateLimitArtifact(arg_1_2.control_recruit or {})
		end
	end,
	on_S2C_CrossActivity_SyncInfo = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.recruitData:updateAllCrossRecruitData(arg_2_2.cross_recruit or {})
			g.core.model.User.recruitData:updateLimitArtifact(arg_2_2.control_recruit or {})
		end
	end
}
