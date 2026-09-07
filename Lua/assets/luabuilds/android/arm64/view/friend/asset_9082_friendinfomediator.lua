local FriendInfoMediator = class("FriendInfoMediator", import("..base.ContextMediator"))

FriendInfoMediator.OPEND_FRIEND = "FriendInfoMediator:OPEND_FRIEND"
FriendInfoMediator.OPEN_RESUME = "FriendInfoMediator:OPEN_RESUME"
FriendInfoMediator.OPEN_BACKYARD = "FriendInfoMediator:OPEN_BACKYARD"
FriendInfoMediator.TOGGLE_BLACK = "FriendInfoMediator:TOGGLE_BLACK"
FriendInfoMediator.INFORM = "FriendInfoMediator:INFORM"
FriendInfoMediator.INFORM_BACKYARD = "FriendInfoMediator:INFORM_BACKYARD"
FriendInfoMediator.OPEN_ISLAND_CARD = "FriendInfoMediator:OPEN_ISLAND_CARD"

function FriendInfoMediator:register()
	local var_1_0 = self.contextData.friend

	assert(self.contextData.friend, "friend is nil")
	self.viewComponent:setFriend(self.contextData.friend)
	self:bind(FriendInfoMediator.OPEN_ISLAND_CARD, function(arg_2_0)
		self:addSubLayers(Context.New({
			mediator = IslandOtherCardMediator,
			viewComponent = IslandOtherCardLayer,
			data = {
				userId = self.contextData.friend.id
			}
		}))

		return
	end)
	self:bind(FriendInfoMediator.INFORM_BACKYARD, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		self:sendNotification(GAME.INFORM_THEME_TEMPLATE, {
			uid = arg_3_1,
			content = arg_3_2,
			tid = arg_3_3,
			playerName = arg_3_4
		})

		return
	end)
	self:bind(FriendInfoMediator.OPEND_FRIEND, function(arg_4_0)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			yesText = "text_apply",
			limit = 20,
			type = MSGBOX_TYPE_INPUT,
			placeholder = i18n("friend_request_msg_placeholder"),
			title = i18n("friend_request_msg_title"),
			onYes = function(arg_5_0)
				self:sendNotification(GAME.FRIEND_SEND_REQUEST, {
					id = var_1_0.id,
					msg = arg_5_0
				})

				return
			end
		})

		return
	end)
	self:bind(FriendInfoMediator.OPEN_RESUME, function(arg_6_0)
		self:addSubLayers(Context.New({
			mediator = resumeMediator,
			viewComponent = resumeLayer,
			data = {
				player = var_1_0,
				parent = self.contextData.parent
			}
		}))

		return
	end)
	self:bind(FriendInfoMediator.OPEN_BACKYARD, function(arg_7_0)
		self:sendNotification(GAME.VISIT_BACKYARD, var_1_0.id)

		return
	end)
	self:bind(FriendInfoMediator.TOGGLE_BLACK, function(arg_8_0)
		if getProxy(FriendProxy):getBlackPlayerById(var_1_0.id) ~= nil then
			self:sendNotification(GAME.FRIEND_RELIEVE_BLACKLIST, var_1_0.id)
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = false,
				content = i18n("friend_confirm_add_blacklist", var_1_0.name),
				onYes = function()
					self:sendNotification(GAME.FRIEND_ADD_BLACKLIST, var_1_0)

					return
				end
			})
		end

		return
	end)
	self:bind(FriendInfoMediator.INFORM, function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		self:sendNotification(GAME.INFORM, {
			playerId = arg_10_1,
			info = arg_10_2,
			content = arg_10_3
		})

		return
	end)

	local var_1_1 = getProxy(FriendProxy)

	if not var_1_1:getBlackList() then
		self:sendNotification(GAME.GET_BLACK_LIST)
	end

	self.viewComponent:setFriendProxy(var_1_1)

	return
end

function FriendInfoMediator:listNotificationInterests()
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

function FriendInfoMediator:handleNotification(arg_12_1)
	local var_12_0 = arg_12_1:getName()
	local var_12_1 = arg_12_1:getBody()

	if var_12_0 == GAME.VISIT_BACKYARD_DONE then
		self.viewComponent:emit(BaseUI.ON_CLOSE)
		self:sendNotification(GAME.GO_SCENE, SCENE.COURTYARD, {
			player = var_12_1.player,
			dorm = var_12_1.dorm,
			mode = CourtYardConst.SYSTEM_VISIT
		})
	elseif var_12_0 == GAME.GET_BLACK_LIST_DONE or var_12_0 == GAME.FRIEND_ADD_BLACKLIST_DONE or var_12_0 == GAME.FRIEND_RELIEVE_BLACKLIST_DONE then
		self.viewComponent:updateBlack()
	elseif var_12_0 == GAME.INFORM_DONE or var_12_0 == GAME.INFORM_THEME_TEMPLATE_DONE then
		self.viewComponent:closeInfromPanel()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			parent = self.contextData.parent,
			content = i18n("inform_sueecss_tip")
		})
	elseif var_12_0 == GAME.FINISH_STAGE then
		self.viewComponent:closeView()
	end

	return
end

return FriendInfoMediator
