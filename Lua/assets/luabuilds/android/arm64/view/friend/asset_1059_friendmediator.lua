local FriendMediator = class("FriendMediator", import("..base.ContextMediator"))

FriendMediator.SEARCH_FRIEND = "FriendMediator:SEARCH_FRIEND"
FriendMediator.ADD_FRIEND = "FriendMediator:ADD_FRIEND"
FriendMediator.ACCEPT_REQUEST = "FriendMediator:ACCEPT_REQUEST"
FriendMediator.REFUSE_REQUEST = "FriendMediator:REFUSE_REQUEST"
FriendMediator.DELETE_FRIEND = "FriendMediator:DELETE_FRIEND"
FriendMediator.OPEN_RESUME = "FriendMediator:OPEN_RESUME"
FriendMediator.OPEN_RESUME_BY_VO = "FriendMediator:OPEN_RESUME_BY_VO"
FriendMediator.REFUSE_ALL_REQUEST = "FriendMediator:REFUSE_ALL_REQUEST"
FriendMediator.OPEN_CHATROOM = "FriendMediator:OPEN_CHATROOM"
FriendMediator.VISIT_BACKYARD = "FriendMediator:VISIT_BACKYRAD"
FriendMediator.RELIEVE_BLACKLIST = "FriendMediator:RELIEVE_BLACKLIST"
FriendMediator.GET_BLACK_LIST = "FriendMediator:GET_BLACK_LIST"
FriendMediator.INFORM = "FriendMediator:INFORM"

function FriendMediator:register()
	local var_1_0 = getProxy(FriendProxy)

	self.viewComponent:setFriendVOs((var_1_0:getAllFriends()))
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))
	self.viewComponent:setRequests((getProxy(NotificationProxy):getRequests()))
	self.viewComponent:setBlackList((var_1_0:getBlackList()))
	self:bind(FriendMediator.GET_BLACK_LIST, function(arg_2_0)
		self:sendNotification(GAME.GET_BLACK_LIST)

		return
	end)
	self:bind(FriendMediator.SEARCH_FRIEND, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.FRIEND_SEARCH, {
			type = arg_3_1,
			keyword = arg_3_2
		})

		return
	end)
	self:bind(FriendMediator.OPEN_CHATROOM, function(arg_4_0, arg_4_1)
		self:addSubLayers(Context.New({
			mediator = ChatRoomMediator,
			viewComponent = ChatRoomLayer,
			data = {
				friendVO = arg_4_1
			}
		}))

		return
	end)
	self:bind(FriendMediator.ADD_FRIEND, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.FRIEND_SEND_REQUEST, {
			id = arg_5_1,
			msg = arg_5_2
		})

		return
	end)
	self:bind(FriendMediator.ACCEPT_REQUEST, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.FRIEND_ACCEPT_REQUEST, arg_6_1)

		return
	end)
	self:bind(FriendMediator.REFUSE_ALL_REQUEST, function(arg_7_0)
		self:sendNotification(GAME.FRIEND_REJECT_REQUEST, 0)

		return
	end)
	self:bind(FriendMediator.REFUSE_REQUEST, function(arg_8_0, arg_8_1, arg_8_2)
		self:sendNotification(GAME.FRIEND_REJECT_REQUEST, arg_8_1.id)

		if arg_8_2 then
			self:sendNotification(GAME.FRIEND_ADD_BLACKLIST, arg_8_1)
		end

		return
	end)
	self:bind(FriendMediator.DELETE_FRIEND, function(arg_9_0, arg_9_1)
		self:sendNotification(GAME.FRIEND_DELETE, arg_9_1)

		return
	end)
	self:bind(FriendMediator.OPEN_RESUME, function(arg_10_0, arg_10_1)
		self:sendNotification(GAME.FRIEND_SEARCH, {
			type = SearchFriendCommand.SEARCH_TYPE_RESUME,
			keyword = arg_10_1
		})

		return
	end)
	self:bind(FriendMediator.OPEN_RESUME_BY_VO, function(arg_11_0, arg_11_1)
		self:openResume(arg_11_1)

		return
	end)
	self:bind(FriendMediator.VISIT_BACKYARD, function(arg_12_0, arg_12_1)
		self:sendNotification(GAME.VISIT_BACKYARD, arg_12_1)

		return
	end)
	self:bind(FriendMediator.RELIEVE_BLACKLIST, function(arg_13_0, arg_13_1)
		self:sendNotification(GAME.FRIEND_RELIEVE_BLACKLIST, arg_13_1)

		return
	end)
	self:bind(FriendMediator.INFORM, function(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
		self:sendNotification(GAME.INFORM, {
			playerId = arg_14_1,
			info = arg_14_2,
			content = arg_14_3
		})

		return
	end)
	self:updateChatNotification()

	return
end

function FriendMediator:updateChatNotification()
	self.viewComponent:updateChatNotification((getProxy(FriendProxy):getNewMsgCount()))

	return
end

function FriendMediator:openResume(arg_16_1)
	self:addSubLayers(Context.New({
		mediator = resumeMediator,
		viewComponent = resumeLayer,
		data = {
			player = arg_16_1
		}
	}))

	return
end

function FriendMediator:listNotificationInterests()
	return {
		GAME.FRIEND_SEARCH_DONE,
		GAME.FRIEND_SEND_REQUEST_DONE,
		NotificationProxy.FRIEND_REQUEST_REMOVED,
		NotificationProxy.FRIEND_REQUEST_ADDED,
		FriendProxy.FRIEND_REMOVED,
		FriendProxy.FRIEND_ADDED,
		FriendProxy.FRIEND_UPDATED,
		GAME.VISIT_BACKYARD_DONE,
		GAME.FRIEND_RELIEVE_BLACKLIST_DONE,
		FriendProxy.RELIEVE_BLACKLIST,
		FriendProxy.BLACK_LIST_UPDATED,
		FriendProxy.ADD_INTO_BLACKLIST,
		GAME.INFORM_DONE
	}
end

function FriendMediator:handleNotification(arg_18_1)
	local var_18_0 = arg_18_1:getName()
	local var_18_1 = arg_18_1:getBody()

	if var_18_0 == GAME.FRIEND_SEARCH_DONE then
		if var_18_1.type == SearchFriendCommand.SEARCH_TYPE_RESUME then
			self:openResume(var_18_1.list[1])
		else
			self.viewComponent:setSearchResult(var_18_1.list)
			self.viewComponent:updatePage(FriendScene.SEARCH_PAGE)

			if table.getCount(var_18_1.list) > 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("friend_search_succeed"))
			end
		end
	elseif var_18_0 == GAME.FRIEND_SEND_REQUEST_DONE then
		self.viewComponent:removeSearchResult(var_18_1)
		self.viewComponent:updatePage(FriendScene.SEARCH_PAGE)
	elseif var_18_0 == NotificationProxy.FRIEND_REQUEST_REMOVED or var_18_0 == NotificationProxy.FRIEND_REQUEST_ADDED then
		self.viewComponent:setRequests((getProxy(NotificationProxy):getRequests()))
		self.viewComponent:updatePage(FriendScene.REQUEST_PAGE)
		self.viewComponent:updateRequestTip()
	elseif var_18_0 == FriendProxy.FRIEND_REMOVED or var_18_0 == FriendProxy.FRIEND_ADDED or var_18_0 == FriendProxy.FRIEND_UPDATED then
		self.viewComponent:setFriendVOs((getProxy(FriendProxy):getAllFriends()))
		self.viewComponent:updatePage(FriendScene.FRIEND_PAGE)

		if var_18_0 == FriendProxy.FRIEND_UPDATED then
			self:updateChatNotification()
		end
	elseif var_18_0 == FriendProxy.RELIEVE_BLACKLIST or var_18_0 == FriendProxy.BLACK_LIST_UPDATED or var_18_0 == FriendProxy.ADD_INTO_BLACKLIST then
		self.viewComponent:setBlackList((getProxy(FriendProxy):getBlackList()))
		self.viewComponent:updatePage(FriendScene.BLACKLIST_PAGE)
	elseif var_18_0 == GAME.VISIT_BACKYARD_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COURTYARD, {
			player = var_18_1.player,
			dorm = var_18_1.dorm,
			mode = CourtYardConst.SYSTEM_VISIT
		})
	elseif var_18_0 == GAME.INFORM_DONE then
		self.viewComponent:closeInfromPanel()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			parent = self.contextData.parent,
			content = i18n("inform_sueecss_tip")
		})
	end

	return
end

return FriendMediator
