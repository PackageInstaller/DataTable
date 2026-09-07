local UpdateGuideIndexCommand = class("UpdateGuideIndexCommand", pm.SimpleCommand)

function UpdateGuideIndexCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.index
	local var_1_2 = var_1_0.callback
	local var_1_3 = var_1_0.isNewVersion

	print("update index.....", var_1_0.isNewVersion and "newVer" or "oldVer", var_1_0.index)
	pg.ConnectionMgr.GetInstance():Send(11016, {
		guide_index = var_1_1,
		type = var_1_3 and 1 or 0
	})

	local var_1_4 = getProxy(PlayerProxy):getData()

	var_1_4:UpdateGuideIndex(var_1_3, var_1_1)
	getProxy(PlayerProxy):updatePlayer(var_1_4)
	pg.SeriesGuideMgr.GetInstance():setPlayer(var_1_4)

	if pg.SeriesGuideMgr.GetInstance():isEnd() then
		pg.TrackerMgr.GetInstance():Tracking(TRACKING_TUTORIAL_COMPLETE_1)
		pg.TrackerMgr.GetInstance():Tracking(TRACKING_GUIDE_COMPLETE)
	end

	if var_1_2 then
		var_1_2()
	end

	if pg.SeriesGuideMgr.GetInstance():isEnd() then
		pg.m02:sendNotification(GAME.SERIES_GUIDE_END)
	end

	return
end

return UpdateGuideIndexCommand
