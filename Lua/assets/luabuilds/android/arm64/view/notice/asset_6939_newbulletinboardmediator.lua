local NewBulletinBoardMediator = class("NewBulletinBoardMediator", import("..base.ContextMediator"))

NewBulletinBoardMediator.SET_STOP_REMIND = "set_stop_remind"
NewBulletinBoardMediator.GO_SCENE = "go_scene"
NewBulletinBoardMediator.TRACK_OPEN_URL = "track_open_url"

function NewBulletinBoardMediator:register()
	local var_1_0 = getProxy(ServerNoticeProxy)

	var_1_0:setStopNewTip()
	self.viewComponent:initNotices((var_1_0:getServerNotices(false)))
	self:bind(NewBulletinBoardMediator.SET_STOP_REMIND, function(arg_2_0, arg_2_1)
		getProxy(ServerNoticeProxy):setStopRemind(arg_2_1)

		return
	end)
	self:bind(NewBulletinBoardMediator.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		self:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	self:bind(NewBulletinBoardMediator.TRACK_OPEN_URL, function(arg_4_0, arg_4_1)
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildNotice(arg_4_1))

		return
	end)

	return
end

function NewBulletinBoardMediator:initNotificationHandleDic()
	self.handleDic = {}

	return
end

return NewBulletinBoardMediator
