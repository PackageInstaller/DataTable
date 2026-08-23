local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_SplitDownload_Award = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.splitDownloadData:onS2CSplitDownloadAward(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPLIT_DOWNLOAD_AWARD, false)
		end
	end
}
