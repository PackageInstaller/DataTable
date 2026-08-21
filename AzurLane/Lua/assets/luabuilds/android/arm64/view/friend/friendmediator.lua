local var_0_0 = class("FriendMediator", import("..base.ContextMediator"))

var_0_0.SEARCH_FRIEND = "FriendMediator:SEARCH_FRIEND"
var_0_0.ADD_FRIEND = "FriendMediator:ADD_FRIEND"
var_0_0.ACCEPT_REQUEST = "FriendMediator:ACCEPT_REQUEST"
var_0_0.REFUSE_REQUEST = "FriendMediator:REFUSE_REQUEST"
var_0_0.DELETE_FRIEND = "FriendMediator:DELETE_FRIEND"
var_0_0.OPEN_RESUME = "FriendMediator:OPEN_RESUME"
var_0_0.OPEN_RESUME_BY_VO = "FriendMediator:OPEN_RESUME_BY_VO"
var_0_0.REFUSE_ALL_REQUEST = "FriendMediator:REFUSE_ALL_REQUEST"
var_0_0.OPEN_CHATROOM = "FriendMediator:OPEN_CHATROOM"
var_0_0.VISIT_BACKYARD = "FriendMediator:VISIT_BACKYRAD"
var_0_0.RELIEVE_BLACKLIST = "FriendMediator:RELIEVE_BLACKLIST"
var_0_0.GET_BLACK_LIST = "FriendMediator:GET_BLACK_LIST"
var_0_0.INFORM = "FriendMediator:INFORM"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(FriendProxy)

	arg_1_0.viewComponent:setFriendVOs((var_1_0:getAllFriends()))
	arg_1_0.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))
	arg_1_0.viewComponent:setRequests((getProxy(NotificationProxy):getRequests()))
	arg_1_0.viewComponent:setBlackList((var_1_0:getBlackList()))
	arg_1_0:bind(var_0_0.GET_BLACK_LIST, function(arg_2_0)
		arg_1_0:sendNotification(GAME.GET_BLACK_LIST)

		return
	end)
	arg_1_0:bind(var_0_0.SEARCH_FRIEND, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.FRIEND_SEARCH, {
			type = arg_3_1,
			keyword = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CHATROOM, function(arg_4_0, arg_4_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChatRoomMediator,
			viewComponent = ChatRoomLayer,
			data = {
				friendVO = arg_4_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ADD_FRIEND, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0:sendNotification(GAME.FRIEND_SEND_REQUEST, {
			id = arg_5_1,
			msg = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ACCEPT_REQUEST, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.FRIEND_ACCEPT_REQUEST, arg_6_1)

		return
	end)
	arg_1_0:bind(var_0_0.REFUSE_ALL_REQUEST, function(arg_7_0)
		arg_1_0:sendNotification(GAME.FRIEND_REJECT_REQUEST, 0)

		return
	end)
	arg_1_0:bind(var_0_0.REFUSE_REQUEST, function(arg_8_0, arg_8_1, arg_8_2)
		arg_1_0:sendNotification(GAME.FRIEND_REJECT_REQUEST, arg_8_1.id)

		if arg_8_2 then
			arg_1_0:sendNotification(GAME.FRIEND_ADD_BLACKLIST, arg_8_1)
		end

		return
	end)
	arg_1_0:bind(var_0_0.DELETE_FRIEND, function(arg_9_0, arg_9_1)
		arg_1_0:sendNotification(GAME.FRIEND_DELETE, arg_9_1)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_RESUME, function(arg_10_0, arg_10_1)
		arg_1_0:sendNotification(GAME.FRIEND_SEARCH, {
			type = SearchFriendCommand.SEARCH_TYPE_RESUME,
			keyword = arg_10_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_RESUME_BY_VO, function(arg_11_0, arg_11_1)
		arg_1_0:openResume(arg_11_1)

		return
	end)
	arg_1_0:bind(var_0_0.VISIT_BACKYARD, function(arg_12_0, arg_12_1)
		arg_1_0:sendNotification(GAME.VISIT_BACKYARD, arg_12_1)

		return
	end)
	arg_1_0:bind(var_0_0.RELIEVE_BLACKLIST, function(arg_13_0, arg_13_1)
		arg_1_0:sendNotification(GAME.FRIEND_RELIEVE_BLACKLIST, arg_13_1)

		return
	end)
	arg_1_0:bind(var_0_0.INFORM, function(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
		arg_1_0:sendNotification(GAME.INFORM, {
			playerId = arg_14_1,
			info = arg_14_2,
			content = arg_14_3
		})

		return
	end)
	arg_1_0:updateChatNotification()

	return
end

function var_0_0.updateChatNotification(arg_15_0)
	arg_15_0.viewComponent:updateChatNotification((getProxy(FriendProxy):getNewMsgCount()))

	return
end

function var_0_0.openResume(arg_16_0, arg_16_1)
	arg_16_0:addSubLayers(Context.New({
		mediator = resumeMediator,
		viewComponent = resumeLayer,
		data = {
			player = arg_16_1
		}
	}))

	return
end

function var_0_0.listNotificationInterests(arg_17_0)
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

function var_0_0.handleNotification(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:getName()
	local var_18_1 = arg_18_1:getBody()

	if var_18_0 == GAME.FRIEND_SEARCH_DONE then
		if var_18_1.type == SearchFriendCommand.SEARCH_TYPE_RESUME then
			arg_18_0:openResume(var_18_1.list[1])
		else
			arg_18_0.viewComponent:setSearchResult(var_18_1.list)
			arg_18_0.viewComponent:updatePage(FriendScene.SEARCH_PAGE)

			if table.getCount(var_18_1.list) > 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("friend_search_succeed"))
			end
		end
	elseif var_18_0 == GAME.FRIEND_SEND_REQUEST_DONE then
		arg_18_0.viewComponent:removeSearchResult(var_18_1)
		arg_18_0.viewComponent:updatePage(FriendScene.SEARCH_PAGE)
	elseif var_18_0 == NotificationProxy.FRIEND_REQUEST_REMOVED or var_18_0 == NotificationProxy.FRIEND_REQUEST_ADDED then
		local var_18_2 = getProxy(NotificationProxy)

		arg_18_0.viewComponent:setRequests((var_18_2:getRequests()))
		arg_18_0.viewComponent:updatePage(FriendScene.REQUEST_PAGE)
		arg_18_0.viewComponent:updateRequestTip()
	elseif var_18_0 == FriendProxy.FRIEND_REMOVED or var_18_0 == FriendProxy.FRIEND_ADDED or var_18_0 == FriendProxy.FRIEND_UPDATED then
		local var_18_3 = getProxy(FriendProxy)

		arg_18_0.viewComponent:setFriendVOs((var_18_3:getAllFriends()))
		arg_18_0.viewComponent:updatePage(FriendScene.FRIEND_PAGE)

		if var_18_0 == FriendProxy.FRIEND_UPDATED then
			arg_18_0:updateChatNotification()
		end
	elseif var_18_0 == FriendProxy.RELIEVE_BLACKLIST or var_18_0 == FriendProxy.BLACK_LIST_UPDATED or var_18_0 == FriendProxy.ADD_INTO_BLACKLIST then
		local var_18_4 = getProxy(FriendProxy)

		arg_18_0.viewComponent:setBlackList((var_18_4:getBlackList()))
		arg_18_0.viewComponent:updatePage(FriendScene.BLACKLIST_PAGE)
	elseif var_18_0 == GAME.VISIT_BACKYARD_DONE then
		arg_18_0:sendNotification(GAME.GO_SCENE, SCENE.COURTYARD, {
			player = var_18_1.player,
			dorm = var_18_1.dorm,
			mode = CourtYardConst.SYSTEM_VISIT
		})
	elseif var_18_0 == GAME.INFORM_DONE then
		arg_18_0.viewComponent:closeInfromPanel()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			parent = arg_18_0.contextData.parent,
			content = i18n("inform_sueecss_tip")
		})
	end

	return
end

return var_0_0
