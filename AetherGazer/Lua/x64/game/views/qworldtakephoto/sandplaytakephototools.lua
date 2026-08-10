local var_0_0 = require("game.config.SandplayThingCfg")

return {
	TrackPhoto = function(arg_1_0, arg_1_1)
		local var_1_0 = QWorldMgr:GetQWorldEntityMgr()
		local var_1_1 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_1_0)

		if var_1_1 then
			QWorldAction.SendUpdateThingTrackToSDK(arg_1_0, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.TRACK)

			local var_1_2 = QWorldMgr:GetQWorldEntityMgr():GetTrackEntityIds()

			for iter_1_0, iter_1_1 in ipairs(var_1_2) do
				local var_1_3 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(iter_1_1)

				if var_1_3.thingCfg and var_1_3.thingCfg.label[1] and SandPlayTakePhotoTools.CheckIsPhotoTag(var_1_3.thingCfg.label[1]) and var_1_3 then
					var_1_3:RemoveMiniMapEntity(QWorldEntityMiniMapTag.Thing, SandplayThingCfg[var_1_3.configId].label[1])
				end
			end

			var_1_0:TrackId(arg_1_0)

			local var_1_4 = SandplayThingCfg[arg_1_1].label[1]
			local var_1_5 = SandplayTagCfg[var_1_4]

			var_1_1:AddMiniMapEntity(QWorldEntityMiniMapTag.Thing, var_1_4)
		end
	end,
	CheckIsPhotoTag = function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(QuanzhouPhotoCfg.all) do
			local var_2_0 = QuanzhouPhotoCfg[iter_2_1].thing_id
			local var_2_1 = SandplayThingCfg[var_2_0]

			if var_2_1 and var_2_1.label[1] == arg_2_0 then
				return true
			end
		end

		return false
	end
}
