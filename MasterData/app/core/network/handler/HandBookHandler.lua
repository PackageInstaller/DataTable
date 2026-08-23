local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Handbook_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			if arg_1_2.id == g.core.network.proto.UR_ARTIFACT_HB then
				g.core.model.User.artifactHandBookData:updateURHandBook(arg_1_2)
			elseif arg_1_2.id == g.core.network.proto.ARTIFACT_HB then
				g.core.model.User.artifactHandBookData:updateHandBook(arg_1_2)
			elseif arg_1_2.id == g.core.network.proto.PET_HB then
				g.core.model.User.petHandBookData:updateHandBook(arg_1_2)
			elseif arg_1_2.id == g.core.network.proto.UR_PET_HB then
				g.core.model.User.petHandBookData:onS2CHandbookInfo(arg_1_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HANDBOOK_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Handbook_Sync = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			if arg_2_2.id == g.core.network.proto.ARTIFACT_HB then
				-- block empty
			elseif arg_2_2.id == g.core.network.proto.SKIN_HB then
				-- block empty
			elseif arg_2_2.id == g.core.network.proto.PET_HB then
				-- block empty
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HANDBOOK_SYNC, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Handbook_OneKeyUpgrade = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			if arg_3_2.tp == g.core.network.proto.KNIGHT_HB then
				g.core.model.User.handBookData:onS2CKnightHandBookOneKeyUpgrade(arg_3_2)
			elseif arg_3_2.tp == g.core.network.proto.ARTIFACT_HB then
				g.core.model.User.artifactHandBookData:updateHandBook(arg_3_2)
			elseif arg_3_2.tp == g.core.network.proto.UR_ARTIFACT_HB then
				g.core.model.User.artifactHandBookData:updateURHandBook(arg_3_2)
			elseif arg_3_2.tp == g.core.network.proto.PET_HB then
				g.core.model.User.petHandBookData:onS2CPetHandBookOneKeyUpgrade(arg_3_2)
			elseif arg_3_2.tp == g.core.network.proto.UR_PET_HB then
				g.core.model.User.petHandBookData:onS2CHandbookInfo(arg_3_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HANDBOOK_ONEKEYUPGRADE, false, arg_3_1, arg_3_2)
		end
	end
}
