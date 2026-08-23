local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Artifact_LevelUp = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_LEVELUP, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Artifact_Star = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_STAR, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Artifact_InheritFormation = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.formationData:updateFormation(arg_3_2.formation)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_INHERITFORMATION, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Artifact_HandbookActivate = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.artifactHandBookData:activeHandBook(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_HANDBOOKACTIVATE, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Artifact_HandbookUpgrade = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.artifactHandBookData:lvUpHandBook(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_HANDBOOKUPGRADE, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Artifact_SpiritLevelUp = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_SPIRITLEVELUP, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Artifact_SpiritStageUp = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_SPIRITSTAGEUP, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Artifact_URHandbook_Active = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.artifactHandBookData:activeURHandBook(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_URHANDBOOK_ACTIVE, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Artifact_URHandbook_Upgrade = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.model.User.artifactHandBookData:lvUpURHandBook(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_URHANDBOOK_UPGRADE, false, arg_9_1, arg_9_2)
		end
	end
}
