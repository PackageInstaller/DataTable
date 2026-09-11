local SandplayThingCfg = require("game.config.SandplayThingCfg")

return {
	TrackPhoto = function(arg_1_0, arg_1_1)
		local var_1_0 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_1_0)

		if var_1_0 then
			QWorldAction.SendUpdateThingTrackToSDK(arg_1_0, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.TRACK)

			for iter_1_0, iter_1_1 in ipairs((QWorldMgr:GetQWorldEntityMgr():GetTrackEntityIds())) do
				local var_1_1 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(iter_1_1)

				if var_1_1.thingCfg and var_1_1.thingCfg.label[1] and SandPlayTakePhotoTools.CheckIsPhotoTag(var_1_1.thingCfg.label[1]) and var_1_1 then
					var_1_1:RemoveMiniMapEntity(QWorldEntityMiniMapTag.Thing, SandplayThingCfg[var_1_1.configId].label[1])
				end
			end

			QWorldMgr:GetQWorldEntityMgr():TrackId(arg_1_0)
			var_1_0:AddMiniMapEntity(QWorldEntityMiniMapTag.Thing, SandplayThingCfg[arg_1_1].label[1])
		end
	end,
	CheckIsPhotoTag = function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(QuanzhouPhotoCfg.all) do
			if SandplayThingCfg[QuanzhouPhotoCfg[iter_2_1].thing_id] and SandplayThingCfg[QuanzhouPhotoCfg[iter_2_1].thing_id].label[1] == arg_2_0 then
				return true
			end
		end

		return false
	end
}
