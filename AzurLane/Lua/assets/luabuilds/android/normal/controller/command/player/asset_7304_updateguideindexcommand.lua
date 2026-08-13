class = var_0_10000

local var_0_0 = "UpdateGuideIndexCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().index
	local var_1_1 = var_2.callback
	local var_1_2 = var_2.isNewVersion

	print = var_1_10006

	var_1_10006("update index.....", var_1_2 and "newVer" or "oldVer", var_1_0)

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 11016, {
		guide_index = var_1_0,
		type = var_1_2 and 1 or 0
	})

	getProxy = var_6
	PlayerProxy = var_1_3

	local var_1_4 = var_6(var_1_3)
	local var_1_5 = var_6.getData(var_1_4)

	var_6.UpdateGuideIndex(var_1_5, var_1_2, var_1_0)

	getProxy = var_7
	PlayerProxy = var_1_5

	local var_1_6 = var_7(var_1_5)

	var_7.updatePlayer(var_1_6, var_6)

	pg = var_7

	local var_1_7 = var_7.SeriesGuideMgr.GetInstance()

	var_7.setPlayer(var_1_7, var_6)

	pg = var_7

	local var_1_8 = var_7.SeriesGuideMgr.GetInstance()
	local var_1_10

	if var_7.isEnd(var_1_8) then
		pg = var_1_10

		local var_1_9 = var_1_10.TrackerMgr.GetInstance()

		var_1_10 = var_1_10.Tracking
		TRACKING_TUTORIAL_COMPLETE_1 = var_9

		var_1_10(var_1_9, var_9)

		pg = var_1_10

		local var_1_11 = var_1_10.TrackerMgr.GetInstance()

		var_1_10 = var_1_10.Tracking
		TRACKING_GUIDE_COMPLETE = var_9

		var_1_10(var_1_11, var_9)
	end

	if var_1_1 then
		var_1_1()
	end

	pg = var_1_10

	local var_1_12 = var_1_10.SeriesGuideMgr.GetInstance()

	if var_7.isEnd(var_1_12) then
		pg = var_7

		local var_1_13 = var_7.m02
		local var_1_14 = var_7.sendNotification

		GAME = var_9

		var_1_14(var_1_13, var_9.SERIES_GUIDE_END)
	end

	return
end

return var_0_1
