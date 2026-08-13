class = var_0_10000

local var_0_0 = "InstagramMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.ON_LIKE = "InstagramMediator:ON_LIKE"
var_0_1.ON_SHARE = "InstagramMediator:ON_SHARE"
var_0_1.ON_COMMENT = "InstagramMediator:ON_COMMENT"
var_0_1.ON_REPLY_UPDATE = "InstagramMediator:ON_REPLY_UPDATE"
var_0_1.ON_READED = "InstagramMediator:ON_READED"
var_0_1.ON_COMMENT_LIST_UPDATE = "InstagramMediator:ON_COMMENT_LIST_UPDATE"
var_0_1.ON_REFRESH_TIP = "InstagramMediator:ON_REFRESH_TIP"
var_0_1.CLOSE_ALL = "InstagramMediator:CLOSE_ALL"
var_0_1.CLOSE_DETAIL = "InstagramMediator:CLOSE_DETAIL"
var_0_1.BACK_PRESSED = "InstagramMediator:BACK_PRESSED"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_READED, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_2_2 = var_2_10004.ACT_INSTAGRAM_OP
		local var_2_3 = {
			arg2 = 0
		}

		ActivityConst = var_2_10006
		var_2_3.cmd = var_2_10006.INSTAGRAM_OP_MARK_READ
		var_2_3.arg1 = arg_2_1

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_LIKE, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_3_2 = var_2_10004.ACT_INSTAGRAM_OP
		local var_3_3 = {
			arg2 = 0
		}

		ActivityConst = var_2_10006
		var_3_3.cmd = var_2_10006.INSTAGRAM_OP_LIKE
		var_3_3.arg1 = arg_3_1

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SHARE, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_4_2 = var_2_10004.ACT_INSTAGRAM_OP
		local var_4_3 = {
			arg2 = 0
		}

		ActivityConst = var_2_10006
		var_4_3.cmd = var_2_10006.INSTAGRAM_OP_SHARE
		var_4_3.arg1 = arg_4_1

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_COMMENT, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		local var_5_0 = arg_1_0
		local var_5_1 = var_4.sendNotification

		GAME = var_2_10006

		local var_5_2 = var_2_10006.ACT_INSTAGRAM_OP
		local var_5_3 = {}

		ActivityConst = var_2_10008
		var_5_3.cmd = var_2_10008.INSTAGRAM_OP_COMMENT
		var_5_3.arg1 = arg_5_1
		var_5_3.arg2 = arg_5_3
		var_5_3.arg3 = arg_5_2

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_REPLY_UPDATE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_6_2 = var_2_10004.ACT_INSTAGRAM_OP
		local var_6_3 = {
			arg2 = 0
		}

		ActivityConst = var_2_10006
		var_6_3.cmd = var_2_10006.INSTAGRAM_OP_UPDATE
		var_6_3.arg1 = arg_6_1

		function var_6_3.callback()
			local var_7_0 = arg_1_0.viewComponent

			var_0.UpdateCommentList(var_7_0)

			return
		end

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_COMMENT_LIST_UPDATE, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_1_0.viewComponent

		var_3.UpdateInstagram(var_8_0, arg_8_2, false)

		if arg_1_0.contextData.instagram then
			local var_8_1 = arg_1_0.viewComponent

			var_3.emit(var_8_1, var_0_1.ON_REPLY_UPDATE, arg_8_1, arg_8_2)
		end

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_ALL, function(arg_9_0)
		local var_9_0 = arg_1_0
		local var_9_1 = var_1.sendNotification

		InstagramMainMediator = var_2_10003

		var_9_1(var_9_0, var_2_10003.CLOSE_ALL)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_10_0)
	local var_10_0 = {}

	GAME = var_1_10002
	var_10_0[1] = var_1_10002.ACT_INSTAGRAM_OP_DONE
	var_10_0[2] = var_0_1.CLOSE_DETAIL
	var_10_0[3] = var_0_1.BACK_PRESSED
	MusicPlayer = var_2
	var_10_0[4] = var_2.NO_PLAY_MUSIC_NOTIFICATION

	return var_10_0
end

function var_0_1.handleNotification(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1:getBody()

	local function var_11_2()
		local var_12_0 = arg_11_0.viewComponent
		local var_12_1 = var_0.SetProxy

		getProxy = var_2_10002
		InstagramProxy = var_2_10003

		var_12_1(var_12_0, var_2_10002(var_2_10003))

		local var_12_2 = arg_11_0.viewComponent

		var_0.UpdateInstagram(var_12_2, var_11_1.id)

		local var_12_3 = arg_11_0.viewComponent

		var_0.UpdateSelectedInstagram(var_12_3, var_11_1.id)

		local var_12_4 = arg_11_0
		local var_12_5 = var_0.sendNotification

		InstagramMainMediator = var_2

		var_12_5(var_12_4, var_2.CHANGE_JUUS_TIP)

		return
	end

	GAME = var_1_10005

	if var_11_0 == var_1_10005.ACT_INSTAGRAM_OP_DONE then
		local var_11_3 = arg_11_0.viewComponent
		local var_11_4 = var_5.SetProxy

		getProxy = var_1_10007
		InstagramProxy = var_1_10008

		var_11_4(var_11_3, var_1_10007(var_1_10008))

		local var_11_5 = var_11_1.cmd

		ActivityConst = var_11_3

		local var_11_6

		if var_11_5 == var_11_3.INSTAGRAM_OP_SHARE then
			pg = var_11_5
			var_11_6 = var_11_5.ShareMgr.GetInstance()

			local var_11_7 = var_5.Share

			pg = var_7

			var_11_7(var_11_6, var_7.ShareMgr.TypeInstagram)

			goto label_11_0
		end

		local var_11_8 = var_11_1.cmd

		ActivityConst = var_11_6

		local var_11_9

		if var_11_8 == var_11_6.INSTAGRAM_OP_LIKE then
			var_11_2()

			var_11_9 = arg_11_0.viewComponent

			var_5.UpdateLikeBtn(var_11_9)

			pg = var_5
			var_11_9 = var_5.TipsMgr.GetInstance()

			local var_11_10 = var_5.ShowTips

			i18n = var_7

			var_11_10(var_11_9, var_7("ins_click_like_success"))

			goto label_11_0
		end

		local var_11_11 = var_11_1.cmd

		ActivityConst = var_11_9

		local var_11_12

		if var_11_11 == var_11_9.INSTAGRAM_OP_COMMENT then
			pg = var_11_11
			var_11_12 = var_11_11.TipsMgr.GetInstance()

			local var_11_13 = var_5.ShowTips

			i18n = var_7

			var_11_13(var_11_12, var_7("ins_push_comment_success"))
			var_11_2()

			goto label_11_0
		end

		local var_11_14 = var_11_1.cmd

		ActivityConst = var_11_12

		if var_11_14 ~= var_11_12.INSTAGRAM_OP_ACTIVE then
			do
				local var_11_15 = var_11_1.cmd

				ActivityConst = var_11_16

				local var_11_16

				if var_11_15 == var_11_16.INSTAGRAM_OP_UPDATE then
					var_11_16 = arg_11_0.viewComponent

					var_5.InitList(var_11_16)
					var_11_2()
				else
					local var_11_17 = var_11_1.cmd

					ActivityConst = var_11_16

					if var_11_17 == var_11_16.INSTAGRAM_OP_MARK_READ then
						var_11_2()
					end
				end

				if false then
					if var_11_0 == var_0_1.CLOSE_DETAIL then
						local var_11_18 = arg_11_0.viewComponent

						var_5.CloseDetail(var_11_18)
					elseif var_11_0 == var_0_1.BACK_PRESSED then
						local var_11_19 = arg_11_0.viewComponent

						var_5.onBackPressed(var_11_19)
					else
						MusicPlayer = var_5

						if var_11_0 == var_5.NO_PLAY_MUSIC_NOTIFICATION then
							onNextTick = var_5

							var_5(function()
								local var_13_0 = arg_11_0.viewComponent

								var_0.FlushMusicPlayer(var_13_0)

								return
							end)
						end
					end
				end
			end

			::label_11_0::

			return
		end
	end
end

return var_0_1
