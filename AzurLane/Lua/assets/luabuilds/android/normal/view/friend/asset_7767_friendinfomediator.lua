class = var_0_10000

local var_0_0 = "FriendInfoMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.OPEND_FRIEND = "FriendInfoMediator:OPEND_FRIEND"
var_0_1.OPEN_RESUME = "FriendInfoMediator:OPEN_RESUME"
var_0_1.OPEN_BACKYARD = "FriendInfoMediator:OPEN_BACKYARD"
var_0_1.TOGGLE_BLACK = "FriendInfoMediator:TOGGLE_BLACK"
var_0_1.INFORM = "FriendInfoMediator:INFORM"
var_0_1.INFORM_BACKYARD = "FriendInfoMediator:INFORM_BACKYARD"
var_0_1.OPEN_ISLAND_CARD = "FriendInfoMediator:OPEN_ISLAND_CARD"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0.contextData.friend

	assert = var_1_10002

	var_1_10002(var_1_0, "friend is nil")

	local var_1_1 = arg_1_0.viewComponent

	var_2.setFriend(var_1_1, var_1_0)
	arg_1_0:bind(var_0_1.OPEN_ISLAND_CARD, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.addSubLayers

		Context = var_2_10003

		local var_2_2 = var_2_10003.New
		local var_2_3 = {}

		IslandOtherCardMediator = var_2_10005
		var_2_3.mediator = var_2_10005
		IslandOtherCardLayer = var_2_10005
		var_2_3.viewComponent = var_2_10005
		var_2_3.data = {
			userId = arg_1_0.contextData.friend.id
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.INFORM_BACKYARD, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		local var_3_0 = arg_1_0
		local var_3_1 = var_5.sendNotification

		GAME = var_2_10007

		var_3_1(var_3_0, var_2_10007.INFORM_THEME_TEMPLATE, {
			uid = arg_3_1,
			content = arg_3_2,
			tid = arg_3_3,
			playerName = arg_3_4
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEND_FRIEND, function(arg_4_0)
		pg = var_2_10001

		local var_4_0 = var_2_10001.MsgboxMgr.GetInstance()
		local var_4_1 = var_1.ShowMsgBox
		local var_4_2 = {
			hideNo = true,
			yesText = "text_apply",
			limit = 20
		}

		MSGBOX_TYPE_INPUT = var_2_10004
		var_4_2.type = var_2_10004
		i18n = var_2_10004
		var_4_2.placeholder = var_2_10004("friend_request_msg_placeholder")
		i18n = var_4
		var_4_2.title = var_4("friend_request_msg_title")

		function var_4_2.onYes(arg_5_0)
			local var_5_0 = arg_1_0
			local var_5_1 = var_1.sendNotification

			GAME = var_3_10003

			var_5_1(var_5_0, var_3_10003.FRIEND_SEND_REQUEST, {
				id = var_1_0.id,
				msg = arg_5_0
			})

			return
		end

		var_4_1(var_4_0, var_4_2)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_RESUME, function(arg_6_0)
		local var_6_0 = arg_1_0
		local var_6_1 = var_1.addSubLayers

		Context = var_2_10003

		local var_6_2 = var_2_10003.New
		local var_6_3 = {}

		resumeMediator = var_2_10005
		var_6_3.mediator = var_2_10005
		resumeLayer = var_2_10005
		var_6_3.viewComponent = var_2_10005
		var_6_3.data = {
			player = var_1_0,
			parent = arg_1_0.contextData.parent
		}

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_BACKYARD, function(arg_7_0)
		local var_7_0 = arg_1_0
		local var_7_1 = var_1.sendNotification

		GAME = var_2_10003

		var_7_1(var_7_0, var_2_10003.VISIT_BACKYARD, var_1_0.id)

		return
	end)
	arg_1_0:bind(var_0_1.TOGGLE_BLACK, function(arg_8_0)
		getProxy = var_2_10001
		FriendProxy = var_2_10002

		local var_8_0 = var_2_10001(var_2_10002)
		local var_8_1 = var_1_0.id
		local var_8_2 = var_8_0

		if var_8_0.getBlackPlayerById(var_8_2, var_8_1) ~= nil then
			local var_8_3 = arg_1_0

			var_8_2 = var_8_2.sendNotification
			GAME = var_2_10006

			var_8_2(var_8_3, var_2_10006.FRIEND_RELIEVE_BLACKLIST, var_8_1)
		else
			pg = var_8_2

			local var_8_4 = var_8_2.MsgboxMgr.GetInstance()
			local var_8_5 = var_4.ShowMsgBox
			local var_8_6 = {
				hideNo = false
			}

			i18n = var_2_10007
			var_8_6.content = var_2_10007("friend_confirm_add_blacklist", var_1_0.name)

			function var_8_6.onYes()
				local var_9_0 = arg_1_0
				local var_9_1 = var_0.sendNotification

				GAME = var_3_10002

				var_9_1(var_9_0, var_3_10002.FRIEND_ADD_BLACKLIST, var_1_0)

				return
			end

			var_8_5(var_8_4, var_8_6)
		end

		return
	end)

	local var_1_2 = arg_1_0

	arg_1_0.bind(var_1_2, var_0_1.INFORM, function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		local var_10_0 = arg_1_0
		local var_10_1 = var_4.sendNotification

		GAME = var_2_10006

		var_10_1(var_10_0, var_2_10006.INFORM, {
			playerId = arg_10_1,
			info = arg_10_2,
			content = arg_10_3
		})

		return
	end)

	getProxy = var_2
	FriendProxy = var_1_2

	local var_1_3 = var_2(var_1_2)

	if not var_2.getBlackList(var_1_3) then
		local var_1_4 = arg_1_0
		local var_1_5 = arg_1_0.sendNotification

		GAME = var_1_10006

		var_1_5(var_1_4, var_1_10006.GET_BLACK_LIST)
	end

	local var_1_6 = arg_1_0.viewComponent

	var_4.setFriendProxy(var_1_6, var_2)

	return
end

function var_0_1.listNotificationInterests(arg_11_0)
	local var_11_0 = {}

	GAME = var_1_10002
	var_11_0[1] = var_1_10002.VISIT_BACKYARD_DONE
	GAME = var_2
	var_11_0[2] = var_2.GET_BLACK_LIST_DONE
	GAME = var_2
	var_11_0[3] = var_2.FRIEND_ADD_BLACKLIST_DONE
	GAME = var_2
	var_11_0[4] = var_2.FRIEND_RELIEVE_BLACKLIST_DONE
	GAME = var_2
	var_11_0[5] = var_2.INFORM_DONE
	GAME = var_2
	var_11_0[6] = var_2.INFORM_THEME_TEMPLATE_DONE
	GAME = var_2
	var_11_0[7] = var_2.FINISH_STAGE

	return var_11_0
end

function var_0_1.handleNotification(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:getName()
	local var_12_1 = arg_12_1
	local var_12_2 = arg_12_1.getBody(var_12_1)

	GAME = var_12_1

	local var_12_4

	if var_12_0 == var_12_1.VISIT_BACKYARD_DONE then
		local var_12_3 = arg_12_0.viewComponent

		var_12_4 = var_12_4.emit
		BaseUI = var_1_10006

		var_12_4(var_12_3, var_1_10006.ON_CLOSE)

		local var_12_5 = arg_12_0

		var_12_4 = arg_12_0.sendNotification
		GAME = var_6

		local var_12_6 = var_6.GO_SCENE

		SCENE = var_1_10007

		local var_12_7 = var_1_10007.COURTYARD
		local var_12_8 = {
			player = var_12_2.player,
			dorm = var_12_2.dorm
		}

		CourtYardConst = var_9
		var_12_8.mode = var_9.SYSTEM_VISIT

		var_12_4(var_12_5, var_12_6, var_12_7, var_12_8)

		goto label_12_0
	end

	GAME = var_12_4

	if var_12_0 ~= var_12_4.GET_BLACK_LIST_DONE then
		GAME = var_4

		if var_12_0 ~= var_4.FRIEND_ADD_BLACKLIST_DONE then
			GAME = var_4

			if var_12_0 == var_4.FRIEND_RELIEVE_BLACKLIST_DONE then
				local var_12_9 = arg_12_0.viewComponent

				var_4.updateBlack(var_12_9)

				goto label_12_0
			end

			GAME = var_4

			if var_12_0 ~= var_4.INFORM_DONE then
				GAME = var_12_12

				do
					local var_12_12

					if var_12_0 == var_12_12.INFORM_THEME_TEMPLATE_DONE then
						local var_12_10 = arg_12_0.viewComponent

						var_12_12.closeInfromPanel(var_12_10)

						pg = var_12_12

						local var_12_11 = var_12_12.MsgboxMgr.GetInstance()

						var_12_12 = var_12_12.ShowMsgBox

						local var_12_13 = {
							hideNo = true,
							parent = arg_12_0.contextData.parent
						}

						i18n = var_7
						var_12_13.content = var_7("inform_sueecss_tip")

						var_12_12(var_12_11, var_12_13)
					else
						GAME = var_12_12

						if var_12_0 == var_12_12.FINISH_STAGE then
							local var_12_14 = arg_12_0.viewComponent

							var_4.closeView(var_12_14)
						end
					end
				end

				::label_12_0::

				return
			end
		end
	end
end

return var_0_1
