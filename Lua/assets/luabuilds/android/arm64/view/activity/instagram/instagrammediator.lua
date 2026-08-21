local var_0_0 = class("InstagramMediator", import("...base.ContextMediator"))

var_0_0.ON_LIKE = "InstagramMediator:ON_LIKE"
var_0_0.ON_SHARE = "InstagramMediator:ON_SHARE"
var_0_0.ON_COMMENT = "InstagramMediator:ON_COMMENT"
var_0_0.ON_REPLY_UPDATE = "InstagramMediator:ON_REPLY_UPDATE"
var_0_0.ON_READED = "InstagramMediator:ON_READED"
var_0_0.ON_COMMENT_LIST_UPDATE = "InstagramMediator:ON_COMMENT_LIST_UPDATE"
var_0_0.ON_REFRESH_TIP = "InstagramMediator:ON_REFRESH_TIP"
var_0_0.CLOSE_ALL = "InstagramMediator:CLOSE_ALL"
var_0_0.CLOSE_DETAIL = "InstagramMediator:CLOSE_DETAIL"
var_0_0.BACK_PRESSED = "InstagramMediator:BACK_PRESSED"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_READED, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.ACT_INSTAGRAM_OP, {
			arg2 = 0,
			cmd = ActivityConst.INSTAGRAM_OP_MARK_READ,
			arg1 = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_LIKE, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.ACT_INSTAGRAM_OP, {
			arg2 = 0,
			cmd = ActivityConst.INSTAGRAM_OP_LIKE,
			arg1 = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SHARE, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.ACT_INSTAGRAM_OP, {
			arg2 = 0,
			cmd = ActivityConst.INSTAGRAM_OP_SHARE,
			arg1 = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_COMMENT, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		arg_1_0:sendNotification(GAME.ACT_INSTAGRAM_OP, {
			cmd = ActivityConst.INSTAGRAM_OP_COMMENT,
			arg1 = arg_5_1,
			arg2 = arg_5_3,
			arg3 = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_REPLY_UPDATE, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.ACT_INSTAGRAM_OP, {
			arg2 = 0,
			cmd = ActivityConst.INSTAGRAM_OP_UPDATE,
			arg1 = arg_6_1,
			callback = function()
				arg_1_0.viewComponent:UpdateCommentList()

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_COMMENT_LIST_UPDATE, function(arg_8_0, arg_8_1, arg_8_2)
		arg_1_0.viewComponent:UpdateInstagram(arg_8_2, false)

		if arg_1_0.contextData.instagram then
			arg_1_0.viewComponent:emit(var_0_0.ON_REPLY_UPDATE, arg_8_1, arg_8_2)
		end

		return
	end)
	arg_1_0:bind(var_0_0.CLOSE_ALL, function(arg_9_0)
		arg_1_0:sendNotification(InstagramMainMediator.CLOSE_ALL)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_10_0)
	return {
		GAME.ACT_INSTAGRAM_OP_DONE,
		var_0_0.CLOSE_DETAIL,
		var_0_0.BACK_PRESSED,
		MusicPlayer.NO_PLAY_MUSIC_NOTIFICATION
	}
end

function var_0_0.handleNotification(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1:getBody()

	if var_11_0 == GAME.ACT_INSTAGRAM_OP_DONE then
		arg_11_0.viewComponent:SetProxy(getProxy(InstagramProxy))

		if var_11_1.cmd == ActivityConst.INSTAGRAM_OP_SHARE then
			pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeInstagram)
		elseif var_11_1.cmd == ActivityConst.INSTAGRAM_OP_LIKE then
			(function()
				arg_11_0.viewComponent:SetProxy(getProxy(InstagramProxy))
				arg_11_0.viewComponent:UpdateInstagram(var_11_1.id)
				arg_11_0.viewComponent:UpdateSelectedInstagram(var_11_1.id)
				arg_11_0:sendNotification(InstagramMainMediator.CHANGE_JUUS_TIP)

				return
			end)()
			arg_11_0.viewComponent:UpdateLikeBtn()
			pg.TipsMgr.GetInstance():ShowTips(i18n("ins_click_like_success"))
		elseif var_11_1.cmd == ActivityConst.INSTAGRAM_OP_COMMENT then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ins_push_comment_success"))
			;(function()
				arg_11_0.viewComponent:SetProxy(getProxy(InstagramProxy))
				arg_11_0.viewComponent:UpdateInstagram(var_11_1.id)
				arg_11_0.viewComponent:UpdateSelectedInstagram(var_11_1.id)
				arg_11_0:sendNotification(InstagramMainMediator.CHANGE_JUUS_TIP)

				return
			end)()
		elseif var_11_1.cmd == ActivityConst.INSTAGRAM_OP_ACTIVE or var_11_1.cmd == ActivityConst.INSTAGRAM_OP_UPDATE then
			arg_11_0.viewComponent:InitList()
			;(function()
				arg_11_0.viewComponent:SetProxy(getProxy(InstagramProxy))
				arg_11_0.viewComponent:UpdateInstagram(var_11_1.id)
				arg_11_0.viewComponent:UpdateSelectedInstagram(var_11_1.id)
				arg_11_0:sendNotification(InstagramMainMediator.CHANGE_JUUS_TIP)

				return
			end)()
		elseif var_11_1.cmd == ActivityConst.INSTAGRAM_OP_MARK_READ then
			(function()
				arg_11_0.viewComponent:SetProxy(getProxy(InstagramProxy))
				arg_11_0.viewComponent:UpdateInstagram(var_11_1.id)
				arg_11_0.viewComponent:UpdateSelectedInstagram(var_11_1.id)
				arg_11_0:sendNotification(InstagramMainMediator.CHANGE_JUUS_TIP)

				return
			end)()
		end
	elseif var_11_0 == var_0_0.CLOSE_DETAIL then
		arg_11_0.viewComponent:CloseDetail()
	elseif var_11_0 == var_0_0.BACK_PRESSED then
		arg_11_0.viewComponent:onBackPressed()
	elseif var_11_0 == MusicPlayer.NO_PLAY_MUSIC_NOTIFICATION then
		onNextTick(function()
			arg_11_0.viewComponent:FlushMusicPlayer()

			return
		end)
	end

	return
end

return var_0_0
