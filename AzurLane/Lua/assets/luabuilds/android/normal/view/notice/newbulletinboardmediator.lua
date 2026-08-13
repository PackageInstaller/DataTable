class = var_0_10000

local var_0_0 = "NewBulletinBoardMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.SET_STOP_REMIND = "set_stop_remind"
var_0_1.GO_SCENE = "go_scene"
var_0_1.TRACK_OPEN_URL = "track_open_url"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	ServerNoticeProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)

	var_1.setStopNewTip(var_1_0)

	local var_1_1 = var_1:getServerNotices(false)
	local var_1_2 = arg_1_0.viewComponent

	var_3.initNotices(var_1_2, var_1_1)
	arg_1_0:bind(var_0_1.SET_STOP_REMIND, function(arg_2_0, arg_2_1)
		getProxy = var_2_10002
		ServerNoticeProxy = var_2_10003

		local var_2_0 = var_2_10002(var_2_10003)

		var_2.setStopRemind(var_2_0, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.GO_SCENE, arg_3_1, ...)

		return
	end)
	arg_1_0:bind(var_0_1.TRACK_OPEN_URL, function(arg_4_0, arg_4_1)
		pg = var_2_10002

		local var_4_0 = var_2_10002.GameTrackerMgr.GetInstance()
		local var_4_1 = var_2.Record

		GameTrackerBuilder = var_2_10004

		var_4_1(var_4_0, var_2_10004.BuildNotice(arg_4_1))

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_5_0)
	arg_5_0.handleDic = {}

	return
end

return var_0_1
