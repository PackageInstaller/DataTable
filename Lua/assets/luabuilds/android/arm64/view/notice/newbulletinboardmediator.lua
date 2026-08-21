local var_0_0 = class("NewBulletinBoardMediator", import("..base.ContextMediator"))

var_0_0.SET_STOP_REMIND = "set_stop_remind"
var_0_0.GO_SCENE = "go_scene"
var_0_0.TRACK_OPEN_URL = "track_open_url"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(ServerNoticeProxy)

	var_1_0:setStopNewTip()
	arg_1_0.viewComponent:initNotices((var_1_0:getServerNotices(false)))
	arg_1_0:bind(var_0_0.SET_STOP_REMIND, function(arg_2_0, arg_2_1)
		getProxy(ServerNoticeProxy):setStopRemind(arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_0.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	arg_1_0:bind(var_0_0.TRACK_OPEN_URL, function(arg_4_0, arg_4_1)
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildNotice(arg_4_1))

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_5_0)
	arg_5_0.handleDic = {}

	return
end

return var_0_0
