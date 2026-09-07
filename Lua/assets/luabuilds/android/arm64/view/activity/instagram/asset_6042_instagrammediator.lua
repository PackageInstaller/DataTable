local InstagramMediator = class("InstagramMediator", import("...base.ContextMediator"))

InstagramMediator.ON_LIKE = "InstagramMediator:ON_LIKE"
InstagramMediator.ON_SHARE = "InstagramMediator:ON_SHARE"
InstagramMediator.ON_COMMENT = "InstagramMediator:ON_COMMENT"
InstagramMediator.ON_REPLY_UPDATE = "InstagramMediator:ON_REPLY_UPDATE"
InstagramMediator.ON_READED = "InstagramMediator:ON_READED"
InstagramMediator.ON_COMMENT_LIST_UPDATE = "InstagramMediator:ON_COMMENT_LIST_UPDATE"
InstagramMediator.ON_REFRESH_TIP = "InstagramMediator:ON_REFRESH_TIP"
InstagramMediator.CLOSE_ALL = "InstagramMediator:CLOSE_ALL"
InstagramMediator.CLOSE_DETAIL = "InstagramMediator:CLOSE_DETAIL"
InstagramMediator.BACK_PRESSED = "InstagramMediator:BACK_PRESSED"

function InstagramMediator:register()
	self:bind(InstagramMediator.ON_READED, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.ACT_INSTAGRAM_OP, {
			arg2 = 0,
			cmd = ActivityConst.INSTAGRAM_OP_MARK_READ,
			arg1 = arg_2_1
		})

		return
	end)
	self:bind(InstagramMediator.ON_LIKE, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.ACT_INSTAGRAM_OP, {
			arg2 = 0,
			cmd = ActivityConst.INSTAGRAM_OP_LIKE,
			arg1 = arg_3_1
		})

		return
	end)
	self:bind(InstagramMediator.ON_SHARE, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.ACT_INSTAGRAM_OP, {
			arg2 = 0,
			cmd = ActivityConst.INSTAGRAM_OP_SHARE,
			arg1 = arg_4_1
		})

		return
	end)
	self:bind(InstagramMediator.ON_COMMENT, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		self:sendNotification(GAME.ACT_INSTAGRAM_OP, {
			cmd = ActivityConst.INSTAGRAM_OP_COMMENT,
			arg1 = arg_5_1,
			arg2 = arg_5_3,
			arg3 = arg_5_2
		})

		return
	end)
	self:bind(InstagramMediator.ON_REPLY_UPDATE, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.ACT_INSTAGRAM_OP, {
			arg2 = 0,
			cmd = ActivityConst.INSTAGRAM_OP_UPDATE,
			arg1 = arg_6_1,
			callback = function()
				self.viewComponent:UpdateCommentList()

				return
			end
		})

		return
	end)
	self:bind(InstagramMediator.ON_COMMENT_LIST_UPDATE, function(arg_8_0, arg_8_1, arg_8_2)
		self.viewComponent:UpdateInstagram(arg_8_2, false)

		if self.contextData.instagram then
			self.viewComponent:emit(InstagramMediator.ON_REPLY_UPDATE, arg_8_1, arg_8_2)
		end

		return
	end)
	self:bind(InstagramMediator.CLOSE_ALL, function(arg_9_0)
		self:sendNotification(InstagramMainMediator.CLOSE_ALL)

		return
	end)

	return
end

function InstagramMediator:listNotificationInterests()
	return {
		GAME.ACT_INSTAGRAM_OP_DONE,
		InstagramMediator.CLOSE_DETAIL,
		InstagramMediator.BACK_PRESSED,
		MusicPlayer.NO_PLAY_MUSIC_NOTIFICATION
	}
end

function InstagramMediator:handleNotification(arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1:getBody()

	local function var_11_2()
		self.viewComponent:SetProxy(getProxy(InstagramProxy))
		self.viewComponent:UpdateInstagram(var_11_1.id)
		self.viewComponent:UpdateSelectedInstagram(var_11_1.id)
		self:sendNotification(InstagramMainMediator.CHANGE_JUUS_TIP)

		return
	end

	if var_11_0 == GAME.ACT_INSTAGRAM_OP_DONE then
		self.viewComponent:SetProxy(getProxy(InstagramProxy))

		if var_11_1.cmd == ActivityConst.INSTAGRAM_OP_SHARE then
			pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeInstagram)
		elseif var_11_1.cmd == ActivityConst.INSTAGRAM_OP_LIKE then
			var_11_2()
			self.viewComponent:UpdateLikeBtn()
			pg.TipsMgr.GetInstance():ShowTips(i18n("ins_click_like_success"))
		elseif var_11_1.cmd == ActivityConst.INSTAGRAM_OP_COMMENT then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ins_push_comment_success"))
			var_11_2()
		elseif var_11_1.cmd == ActivityConst.INSTAGRAM_OP_ACTIVE or var_11_1.cmd == ActivityConst.INSTAGRAM_OP_UPDATE then
			self.viewComponent:InitList()
			var_11_2()
		elseif var_11_1.cmd == ActivityConst.INSTAGRAM_OP_MARK_READ then
			var_11_2()
		end
	elseif var_11_0 == InstagramMediator.CLOSE_DETAIL then
		self.viewComponent:CloseDetail()
	elseif var_11_0 == InstagramMediator.BACK_PRESSED then
		self.viewComponent:onBackPressed()
	elseif var_11_0 == MusicPlayer.NO_PLAY_MUSIC_NOTIFICATION then
		onNextTick(function()
			self.viewComponent:FlushMusicPlayer()

			return
		end)
	end

	return
end

return InstagramMediator
