local InstagramChatMediator = class("InstagramChatMediator", import("...base.ContextMediator"))

InstagramChatMediator.CHANGE_CARE = "InstagramChatMediator:CHANGE_CARE"
InstagramChatMediator.REPLY = "InstagramChatMediator:REPLY"
InstagramChatMediator.GET_REDPACKET = "InstagramChatMediator:GET_REDPACKET"
InstagramChatMediator.SET_CURRENT_TOPIC = "InstagramChatMediator:SET_CURRENT_TOPIC"
InstagramChatMediator.SET_CURRENT_BACKGROUND = "InstagramChatMediator:SET_CURRENT_BACKGROUND"
InstagramChatMediator.SET_READED = "InstagramChatMediator:SET_READED"
InstagramChatMediator.CLOSE_ALL = "InstagramChatMediator:CLOSE_ALL"
InstagramChatMediator.ON_OFFICIAL_ACCOUNTS_OPERATE = "InstagramChatMediator:ON_OFFICIAL_ACCOUNTS_OPERATE"
InstagramChatMediator.BACK_PRESSED = "InstagramChatMediator:BACK_PRESSED"

function InstagramChatMediator:register()
	self:bind(InstagramChatMediator.CHANGE_CARE, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.ACT_INSTAGRAM_CHAT, {
			operation = ActivityConst.INSTAGRAM_CHAT_SET_CARE,
			characterId = arg_2_1,
			care = arg_2_2
		})

		return
	end)
	self:bind(InstagramChatMediator.REPLY, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		self:sendNotification(GAME.ACT_INSTAGRAM_CHAT, {
			isRedPacket = false,
			operation = ActivityConst.INSTAGRAM_CHAT_REPLY,
			topicId = arg_3_1,
			wordId = arg_3_2,
			replyId = arg_3_3
		})

		return
	end)
	self:bind(InstagramChatMediator.GET_REDPACKET, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		self:sendNotification(GAME.ACT_INSTAGRAM_CHAT, {
			isRedPacket = true,
			operation = ActivityConst.INSTAGRAM_CHAT_REPLY,
			topicId = arg_4_1,
			wordId = arg_4_2,
			replyId = arg_4_3
		})

		return
	end)
	self:bind(InstagramChatMediator.SET_CURRENT_TOPIC, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.ACT_INSTAGRAM_CHAT, {
			operation = ActivityConst.INSTAGRAM_CHAT_SET_TOPIC,
			topicId = arg_5_1
		})

		return
	end)
	self:bind(InstagramChatMediator.SET_CURRENT_BACKGROUND, function(arg_6_0, arg_6_1, arg_6_2)
		self:sendNotification(GAME.ACT_INSTAGRAM_CHAT, {
			operation = ActivityConst.INSTAGRAM_CHAT_SET_SKIN,
			characterId = arg_6_1,
			skinId = arg_6_2
		})

		return
	end)
	self:bind(InstagramChatMediator.SET_READED, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.ACT_INSTAGRAM_CHAT, {
			operation = ActivityConst.INSTAGRAM_CHAT_SET_READTIP,
			topicIdList = arg_7_1
		})

		return
	end)
	self:bind(InstagramChatMediator.CLOSE_ALL, function(arg_8_0)
		self:sendNotification(InstagramMainMediator.CLOSE_ALL)

		return
	end)
	self:bind(InstagramChatMediator.ON_OFFICIAL_ACCOUNTS_OPERATE, function(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
		self:sendNotification(GAME.ACT_INSTAGRAM_OP, {
			cmd = arg_9_1 or 0,
			arg1 = arg_9_2 or 0,
			arg2 = arg_9_3 or 0,
			arg3 = arg_9_4 or 0
		})

		return
	end)

	return
end

function InstagramChatMediator:listNotificationInterests()
	return {
		GAME.ACT_INSTAGRAM_CHAT_DONE,
		GAME.ACT_INSTAGRAM_OP_DONE,
		InstagramChatMediator.BACK_PRESSED
	}
end

function InstagramChatMediator:handleNotification(arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1:getBody()

	if var_11_0 == GAME.ACT_INSTAGRAM_CHAT_DONE then
		local var_11_2 = getProxy(InstagramChatProxy)
		local var_11_3 = false
		local var_11_4 = false

		if var_11_1.operation == ActivityConst.INSTAGRAM_CHAT_REPLY then
			if var_11_1.awards ~= nil then
				self.viewComponent:SetEndAniEvent(self.viewComponent.redPacketGot, function()
					self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1.awards)

					return
				end)
				self.viewComponent:UpdateRedPacketUI(var_11_1.redPacketId)
			end

			var_11_3 = true
		elseif var_11_1.operation == ActivityConst.INSTAGRAM_CHAT_SET_SKIN then
			-- block empty
		elseif var_11_1.operation == ActivityConst.INSTAGRAM_CHAT_SET_CARE then
			-- block empty
		elseif var_11_1.operation == ActivityConst.INSTAGRAM_CHAT_SET_TOPIC then
			-- block empty
		elseif var_11_1.operation == ActivityConst.INSTAGRAM_CHAT_SET_READTIP then
			self:sendNotification(InstagramMainMediator.CHANGE_CHAT_TIP)

			var_11_4 = true
		end

		if var_11_1.operation == ActivityConst.INSTAGRAM_CHAT_REPLY then
			if var_11_1.awards ~= nil then
				self.viewComponent:ChangeFresh()
			else
				self.viewComponent:SetEndAniEvent(self.viewComponent.optionPanel, function()
					self.viewComponent:UpdateCharaList(var_11_3, var_11_4)

					return
				end)
				self.viewComponent.optionPanel:GetComponent(typeof(Animation)):Play("anim_newinstagram_option_out")
			end
		else
			self.viewComponent:UpdateCharaList(var_11_3, var_11_4)
		end
	elseif var_11_0 == GAME.ACT_INSTAGRAM_OP_DONE then
		if var_11_1.cmd == ActivityConst.INSTAGRAM_OP_SHARE then
			pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeInstagram)
		elseif var_11_1.cmd == ActivityConst.INSTAGRAM_OP_LIKE then
			self.viewComponent:UpdateLinkBtn(var_11_1.id)
			pg.TipsMgr.GetInstance():ShowTips(i18n("ins_click_like_success"))
		elseif var_11_1.cmd == ActivityConst.INSTAGRAM_OP_COMMENT then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ins_push_comment_success"))
			self.viewComponent:UpdateCommentList(var_11_1.id)
			self.viewComponent:AddOfficialAccountsTimer()
			self.viewComponent:ReadOfficialAccountComment()
			self.viewComponent:RefreshOfficialAccountTips()
			self:sendNotification(InstagramMainMediator.CHANGE_CHAT_TIP)
		elseif var_11_1.cmd == ActivityConst.INSTAGRAM_OP_ACTIVE or var_11_1.cmd == ActivityConst.INSTAGRAM_OP_UPDATE then
			self.viewComponent:UpdateCommentList(var_11_1.id)
			self.viewComponent:AddOfficialAccountsTimer()
			self.viewComponent:ReadOfficialAccountComment()
			self.viewComponent:RefreshOfficialAccountTips()
			self:sendNotification(InstagramMainMediator.CHANGE_CHAT_TIP)
		elseif var_11_1.cmd == ActivityConst.INSTAGRAM_OP_MARK_READ then
			self.viewComponent:RefreshOfficialAccountTips()
			self:sendNotification(InstagramMainMediator.CHANGE_CHAT_TIP)
		end
	elseif var_11_0 == InstagramChatMediator.BACK_PRESSED then
		self.viewComponent:onBackPressed()
	end

	return
end

return InstagramChatMediator
