class = var_0_10000

local var_0_0 = "FriendMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.SEARCH_FRIEND = "FriendMediator:SEARCH_FRIEND"
var_0_1.ADD_FRIEND = "FriendMediator:ADD_FRIEND"
var_0_1.ACCEPT_REQUEST = "FriendMediator:ACCEPT_REQUEST"
var_0_1.REFUSE_REQUEST = "FriendMediator:REFUSE_REQUEST"
var_0_1.DELETE_FRIEND = "FriendMediator:DELETE_FRIEND"
var_0_1.OPEN_RESUME = "FriendMediator:OPEN_RESUME"
var_0_1.OPEN_RESUME_BY_VO = "FriendMediator:OPEN_RESUME_BY_VO"
var_0_1.REFUSE_ALL_REQUEST = "FriendMediator:REFUSE_ALL_REQUEST"
var_0_1.OPEN_CHATROOM = "FriendMediator:OPEN_CHATROOM"
var_0_1.VISIT_BACKYARD = "FriendMediator:VISIT_BACKYRAD"
var_0_1.RELIEVE_BLACKLIST = "FriendMediator:RELIEVE_BLACKLIST"
var_0_1.GET_BLACK_LIST = "FriendMediator:GET_BLACK_LIST"
var_0_1.INFORM = "FriendMediator:INFORM"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	FriendProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1 = var_1.getAllFriends(var_1_0)
	local var_1_2 = arg_1_0.viewComponent

	var_3.setFriendVOs(var_1_2, var_1_1)

	getProxy = var_3
	PlayerProxy = var_1_2

	local var_1_3 = var_3(var_1_2)
	local var_1_4 = var_3.getData(var_1_3)
	local var_1_5 = arg_1_0.viewComponent

	var_5.setPlayer(var_1_5, var_1_4)

	getProxy = var_5
	NotificationProxy = var_1_5

	local var_1_6 = var_5(var_1_5)
	local var_1_7 = var_5.getRequests(var_1_6)
	local var_1_8 = arg_1_0.viewComponent

	var_7.setRequests(var_1_8, var_1_7)

	local var_1_9 = var_1:getBlackList()
	local var_1_10 = arg_1_0.viewComponent

	var_8.setBlackList(var_1_10, var_1_9)
	arg_1_0:bind(var_0_1.GET_BLACK_LIST, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10003

		var_2_1(var_2_0, var_2_10003.GET_BLACK_LIST)

		return
	end)
	arg_1_0:bind(var_0_1.SEARCH_FRIEND, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.FRIEND_SEARCH, {
			type = arg_3_1,
			keyword = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHATROOM, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_4_2 = var_2_10004.New
		local var_4_3 = {}

		ChatRoomMediator = var_2_10006
		var_4_3.mediator = var_2_10006
		ChatRoomLayer = var_2_10006
		var_4_3.viewComponent = var_2_10006
		var_4_3.data = {
			friendVO = arg_4_1
		}

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)
	arg_1_0:bind(var_0_1.ADD_FRIEND, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.FRIEND_SEND_REQUEST, {
			id = arg_5_1,
			msg = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ACCEPT_REQUEST, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.FRIEND_ACCEPT_REQUEST, arg_6_1)

		return
	end)
	arg_1_0:bind(var_0_1.REFUSE_ALL_REQUEST, function(arg_7_0)
		local var_7_0 = arg_1_0
		local var_7_1 = var_1.sendNotification

		GAME = var_2_10003

		var_7_1(var_7_0, var_2_10003.FRIEND_REJECT_REQUEST, 0)

		return
	end)
	arg_1_0:bind(var_0_1.REFUSE_REQUEST, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_1_0
		local var_8_1 = var_3.sendNotification

		GAME = var_2_10005

		var_8_1(var_8_0, var_2_10005.FRIEND_REJECT_REQUEST, arg_8_1.id)

		if arg_8_2 then
			local var_8_2 = arg_1_0
			local var_8_3 = var_3.sendNotification

			GAME = var_5

			var_8_3(var_8_2, var_5.FRIEND_ADD_BLACKLIST, arg_8_1)
		end

		return
	end)
	arg_1_0:bind(var_0_1.DELETE_FRIEND, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.sendNotification

		GAME = var_2_10004

		var_9_1(var_9_0, var_2_10004.FRIEND_DELETE, arg_9_1)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_RESUME, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_1_0
		local var_10_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_10_2 = var_2_10004.FRIEND_SEARCH
		local var_10_3 = {}

		SearchFriendCommand = var_2_10006
		var_10_3.type = var_2_10006.SEARCH_TYPE_RESUME
		var_10_3.keyword = arg_10_1

		var_10_1(var_10_0, var_10_2, var_10_3)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_RESUME_BY_VO, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_1_0

		var_2.openResume(var_11_0, arg_11_1)

		return
	end)
	arg_1_0:bind(var_0_1.VISIT_BACKYARD, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_1_0
		local var_12_1 = var_2.sendNotification

		GAME = var_2_10004

		var_12_1(var_12_0, var_2_10004.VISIT_BACKYARD, arg_12_1)

		return
	end)
	arg_1_0:bind(var_0_1.RELIEVE_BLACKLIST, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_1_0
		local var_13_1 = var_2.sendNotification

		GAME = var_2_10004

		var_13_1(var_13_0, var_2_10004.FRIEND_RELIEVE_BLACKLIST, arg_13_1)

		return
	end)
	arg_1_0:bind(var_0_1.INFORM, function(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
		local var_14_0 = arg_1_0
		local var_14_1 = var_4.sendNotification

		GAME = var_2_10006

		var_14_1(var_14_0, var_2_10006.INFORM, {
			playerId = arg_14_1,
			info = arg_14_2,
			content = arg_14_3
		})

		return
	end)
	arg_1_0:updateChatNotification()

	return
end

function var_0_1.updateChatNotification(arg_15_0)
	getProxy = var_1_10001
	FriendProxy = var_1_10002

	local var_15_0 = var_1_10001(var_1_10002)
	local var_15_1 = var_1.getNewMsgCount(var_15_0)
	local var_15_2 = arg_15_0.viewComponent

	var_3.updateChatNotification(var_15_2, var_15_1)

	return
end

function var_0_1.openResume(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.addSubLayers

	Context = var_1_10004

	local var_16_2 = var_1_10004.New
	local var_16_3 = {}

	resumeMediator = var_1_10006
	var_16_3.mediator = var_1_10006
	resumeLayer = var_1_10006
	var_16_3.viewComponent = var_1_10006
	var_16_3.data = {
		player = arg_16_1
	}

	var_16_1(var_16_0, var_16_2(var_16_3))

	return
end

function var_0_1.listNotificationInterests(arg_17_0)
	local var_17_0 = {}

	GAME = var_1_10002
	var_17_0[1] = var_1_10002.FRIEND_SEARCH_DONE
	GAME = var_2
	var_17_0[2] = var_2.FRIEND_SEND_REQUEST_DONE
	NotificationProxy = var_2
	var_17_0[3] = var_2.FRIEND_REQUEST_REMOVED
	NotificationProxy = var_2
	var_17_0[4] = var_2.FRIEND_REQUEST_ADDED
	FriendProxy = var_2
	var_17_0[5] = var_2.FRIEND_REMOVED
	FriendProxy = var_2
	var_17_0[6] = var_2.FRIEND_ADDED
	FriendProxy = var_2
	var_17_0[7] = var_2.FRIEND_UPDATED
	GAME = var_2
	var_17_0[8] = var_2.VISIT_BACKYARD_DONE
	GAME = var_2
	var_17_0[9] = var_2.FRIEND_RELIEVE_BLACKLIST_DONE
	FriendProxy = var_2
	var_17_0[10] = var_2.RELIEVE_BLACKLIST
	FriendProxy = var_2
	var_17_0[11] = var_2.BLACK_LIST_UPDATED
	FriendProxy = var_2
	var_17_0[12] = var_2.ADD_INTO_BLACKLIST
	GAME = var_2
	var_17_0[13] = var_2.INFORM_DONE

	return var_17_0
end

function var_0_1.handleNotification(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:getName()
	local var_18_1 = arg_18_1
	local var_18_2 = arg_18_1.getBody(var_18_1)

	GAME = var_18_1

	local var_18_3

	if var_18_0 == var_18_1.FRIEND_SEARCH_DONE then
		var_18_3 = var_18_2.type
		SearchFriendCommand = var_1_10005

		if var_18_3 == var_1_10005.SEARCH_TYPE_RESUME then
			var_1_10005 = arg_18_0

			arg_18_0.openResume(var_1_10005, var_18_2.list[1])
		else
			var_1_10005 = arg_18_0.viewComponent

			var_18_3.setSearchResult(var_1_10005, var_18_2.list)

			var_1_10005 = arg_18_0.viewComponent
			var_18_3 = var_18_3.updatePage
			FriendScene = var_1_10006

			var_18_3(var_1_10005, var_1_10006.SEARCH_PAGE)

			table = var_18_3
			var_18_3 = var_18_3.getCount(var_18_2.list)

			if 0 < var_18_3 then
				pg = var_18_3
				var_1_10005 = var_18_3.TipsMgr.GetInstance()
				var_18_3 = var_18_3.ShowTips
				i18n = var_1_10006

				var_18_3(var_1_10005, var_1_10006("friend_search_succeed"))
			end
		end

		goto label_18_0
	end

	GAME = var_18_3

	local var_18_4

	if var_18_0 == var_18_3.FRIEND_SEND_REQUEST_DONE then
		var_1_10005 = arg_18_0.viewComponent

		var_18_4.removeSearchResult(var_1_10005, var_18_2)

		var_1_10005 = arg_18_0.viewComponent
		var_18_4 = var_18_4.updatePage
		FriendScene = var_1_10006

		var_18_4(var_1_10005, var_1_10006.SEARCH_PAGE)

		goto label_18_0
	end

	NotificationProxy = var_18_4

	if var_18_0 ~= var_18_4.FRIEND_REQUEST_REMOVED then
		NotificationProxy = var_4

		if var_18_0 == var_4.FRIEND_REQUEST_ADDED then
			getProxy = var_4
			NotificationProxy = var_1_10005
			var_1_10006 = var_4(var_1_10005)
			var_1_10005 = var_4.getRequests(var_1_10006)
			var_1_10007 = arg_18_0.viewComponent

			var_1_10006.setRequests(var_1_10007, var_1_10005)

			var_1_10007 = arg_18_0.viewComponent
			var_1_10006 = var_1_10006.updatePage
			FriendScene = var_8

			var_1_10006(var_1_10007, var_8.REQUEST_PAGE)

			var_1_10007 = arg_18_0.viewComponent

			var_1_10006.updateRequestTip(var_1_10007)

			goto label_18_0
		end

		FriendProxy = var_4

		if var_18_0 ~= var_4.FRIEND_REMOVED then
			FriendProxy = var_4

			if var_18_0 ~= var_4.FRIEND_ADDED then
				FriendProxy = var_4

				if var_18_0 == var_4.FRIEND_UPDATED then
					getProxy = var_4
					FriendProxy = var_1_10005
					var_1_10006 = var_4(var_1_10005)
					var_1_10005 = var_4.getAllFriends(var_1_10006)
					var_1_10007 = arg_18_0.viewComponent

					var_1_10006.setFriendVOs(var_1_10007, var_1_10005)

					var_1_10007 = arg_18_0.viewComponent
					var_1_10006 = var_1_10006.updatePage
					FriendScene = var_8

					var_1_10006(var_1_10007, var_8.FRIEND_PAGE)

					FriendProxy = var_1_10006

					if var_18_0 == var_1_10006.FRIEND_UPDATED then
						var_1_10007 = arg_18_0

						arg_18_0.updateChatNotification(var_1_10007)
					end

					goto label_18_0
				end

				FriendProxy = var_4

				if var_18_0 ~= var_4.RELIEVE_BLACKLIST then
					FriendProxy = var_4

					if var_18_0 ~= var_4.BLACK_LIST_UPDATED then
						FriendProxy = var_4

						if var_18_0 == var_4.ADD_INTO_BLACKLIST then
							getProxy = var_4
							FriendProxy = var_1_10005
							var_1_10006 = var_4(var_1_10005)

							local var_18_5 = var_4.getBlackList(var_1_10006)

							var_1_10007 = arg_18_0.viewComponent

							var_1_10006.setBlackList(var_1_10007, var_18_5)

							var_1_10007 = arg_18_0.viewComponent
							var_1_10006 = var_1_10006.updatePage
							FriendScene = var_8

							var_1_10006(var_1_10007, var_8.BLACKLIST_PAGE)
						else
							GAME = var_4

							local var_18_7

							if var_18_0 == var_4.VISIT_BACKYARD_DONE then
								local var_18_6 = arg_18_0

								var_18_7 = arg_18_0.sendNotification
								GAME = var_1_10006

								local var_18_8 = var_1_10006.GO_SCENE

								SCENE = var_1_10007

								local var_18_9 = var_1_10007.COURTYARD
								local var_18_10 = {
									player = var_18_2.player,
									dorm = var_18_2.dorm
								}

								CourtYardConst = var_9
								var_18_10.mode = var_9.SYSTEM_VISIT

								var_18_7(var_18_6, var_18_8, var_18_9, var_18_10)
							else
								GAME = var_18_7

								if var_18_0 == var_18_7.INFORM_DONE then
									local var_18_11 = arg_18_0.viewComponent

									var_4.closeInfromPanel(var_18_11)

									pg = var_4

									local var_18_12 = var_4.MsgboxMgr.GetInstance()
									local var_18_13 = var_4.ShowMsgBox
									local var_18_14 = {
										hideNo = true,
										parent = arg_18_0.contextData.parent
									}

									i18n = var_7
									var_18_14.content = var_7("inform_sueecss_tip")

									var_18_13(var_18_12, var_18_14)
								end
							end
						end

						::label_18_0::

						return
					end
				end
			end
		end
	end
end

return var_0_1
