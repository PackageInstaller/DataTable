local var_0_0 = class("FriendInfoMediator", import("..base.ContextMediator"))

var_0_0.OPEND_FRIEND = "FriendInfoMediator:OPEND_FRIEND"
var_0_0.OPEN_RESUME = "FriendInfoMediator:OPEN_RESUME"
var_0_0.OPEN_BACKYARD = "FriendInfoMediator:OPEN_BACKYARD"
var_0_0.TOGGLE_BLACK = "FriendInfoMediator:TOGGLE_BLACK"
var_0_0.INFORM = "FriendInfoMediator:INFORM"
var_0_0.INFORM_BACKYARD = "FriendInfoMediator:INFORM_BACKYARD"
var_0_0.OPEN_ISLAND_CARD = "FriendInfoMediator:OPEN_ISLAND_CARD"

function var_0_0.register(arg_1_0)
	local var_1_0 = arg_1_0.contextData.friend

	assert(arg_1_0.contextData.friend, "friend is nil")
	arg_1_0.viewComponent:setFriend(arg_1_0.contextData.friend)
	arg_1_0:bind(var_0_0.OPEN_ISLAND_CARD, function(arg_2_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = IslandOtherCardMediator,
			viewComponent = IslandOtherCardLayer,
			data = {
				userId = arg_1_0.contextData.friend.id
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.INFORM_BACKYARD, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		arg_1_0:sendNotification(GAME.INFORM_THEME_TEMPLATE, {
			uid = arg_3_1,
			content = arg_3_2,
			tid = arg_3_3,
			playerName = arg_3_4
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEND_FRIEND, function(arg_4_0)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			yesText = "text_apply",
			limit = 20,
			type = MSGBOX_TYPE_INPUT,
			placeholder = i18n("friend_request_msg_placeholder"),
			title = i18n("friend_request_msg_title"),
			onYes = function(arg_5_0)
				arg_1_0:sendNotification(GAME.FRIEND_SEND_REQUEST, {
					id = var_1_0.id,
					msg = arg_5_0
				})

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_RESUME, function(arg_6_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = resumeMediator,
			viewComponent = resumeLayer,
			data = {
				player = var_1_0,
				parent = arg_1_0.contextData.parent
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_BACKYARD, function(arg_7_0)
		arg_1_0:sendNotification(GAME.VISIT_BACKYARD, var_1_0.id)

		return
	end)
	arg_1_0:bind(var_0_0.TOGGLE_BLACK, function(arg_8_0)
		local var_8_0 = getProxy(FriendProxy)
		local var_8_1 = var_1_0.id

		if var_8_0:getBlackPlayerById(var_1_0.id) ~= nil then
			arg_1_0:sendNotification(GAME.FRIEND_RELIEVE_BLACKLIST, var_8_1)
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = false,
				content = i18n("friend_confirm_add_blacklist", var_1_0.name),
				onYes = function()
					arg_1_0:sendNotification(GAME.FRIEND_ADD_BLACKLIST, var_1_0)

					return
				end
			})
		end

		return
	end)
	arg_1_0:bind(var_0_0.INFORM, function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		arg_1_0:sendNotification(GAME.INFORM, {
			playerId = arg_10_1,
			info = arg_10_2,
			content = arg_10_3
		})

		return
	end)

	local var_1_1 = getProxy(FriendProxy)

	if not var_1_1:getBlackList() then
		arg_1_0:sendNotification(GAME.GET_BLACK_LIST)
	end

	arg_1_0.viewComponent:setFriendProxy(var_1_1)

	return
end

function var_0_0.listNotificationInterests(arg_11_0)
	return {
		GAME.VISIT_BACKYARD_DONE,
		GAME.GET_BLACK_LIST_DONE,
		GAME.FRIEND_ADD_BLACKLIST_DONE,
		GAME.FRIEND_RELIEVE_BLACKLIST_DONE,
		GAME.INFORM_DONE,
		GAME.INFORM_THEME_TEMPLATE_DONE,
		GAME.FINISH_STAGE
	}
end

function var_0_0.handleNotification(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:getName()
	local var_12_1 = arg_12_1:getBody()

	if var_12_0 == GAME.VISIT_BACKYARD_DONE then
		arg_12_0.viewComponent:emit(BaseUI.ON_CLOSE)
		arg_12_0:sendNotification(GAME.GO_SCENE, SCENE.COURTYARD, {
			player = var_12_1.player,
			dorm = var_12_1.dorm,
			mode = CourtYardConst.SYSTEM_VISIT
		})
	elseif var_12_0 == GAME.GET_BLACK_LIST_DONE or var_12_0 == GAME.FRIEND_ADD_BLACKLIST_DONE or var_12_0 == GAME.FRIEND_RELIEVE_BLACKLIST_DONE then
		arg_12_0.viewComponent:updateBlack()
	elseif var_12_0 == GAME.INFORM_DONE or var_12_0 == GAME.INFORM_THEME_TEMPLATE_DONE then
		arg_12_0.viewComponent:closeInfromPanel()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			parent = arg_12_0.contextData.parent,
			content = i18n("inform_sueecss_tip")
		})
	elseif var_12_0 == GAME.FINISH_STAGE then
		arg_12_0.viewComponent:closeView()
	end

	return
end

return var_0_0
