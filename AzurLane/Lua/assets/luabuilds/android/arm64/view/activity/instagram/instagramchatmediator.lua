class = var_0_10000

local var_0_0 = "InstagramChatMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.CHANGE_CARE = "InstagramChatMediator:CHANGE_CARE"
var_0_1.REPLY = "InstagramChatMediator:REPLY"
var_0_1.GET_REDPACKET = "InstagramChatMediator:GET_REDPACKET"
var_0_1.SET_CURRENT_TOPIC = "InstagramChatMediator:SET_CURRENT_TOPIC"
var_0_1.SET_CURRENT_BACKGROUND = "InstagramChatMediator:SET_CURRENT_BACKGROUND"
var_0_1.SET_READED = "InstagramChatMediator:SET_READED"
var_0_1.CLOSE_ALL = "InstagramChatMediator:CLOSE_ALL"
var_0_1.ON_OFFICIAL_ACCOUNTS_OPERATE = "InstagramChatMediator:ON_OFFICIAL_ACCOUNTS_OPERATE"
var_0_1.BACK_PRESSED = "InstagramChatMediator:BACK_PRESSED"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.CHANGE_CARE, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_2_2 = var_2_10006.ACT_INSTAGRAM_CHAT
		local var_2_3 = {}

		ActivityConst = var_2_10008
		var_2_3.operation = var_2_10008.INSTAGRAM_CHAT_SET_CARE
		var_2_3.characterId = arg_2_1
		var_2_3.care = arg_2_2

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.REPLY, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = arg_1_0
		local var_3_1 = var_4.sendNotification

		GAME = var_2_10007

		local var_3_2 = var_2_10007.ACT_INSTAGRAM_CHAT
		local var_3_3 = {
			isRedPacket = false
		}

		ActivityConst = var_2_10009
		var_3_3.operation = var_2_10009.INSTAGRAM_CHAT_REPLY
		var_3_3.topicId = arg_3_1
		var_3_3.wordId = arg_3_2
		var_3_3.replyId = arg_3_3

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)
	arg_1_0:bind(var_0_1.GET_REDPACKET, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		local var_4_0 = arg_1_0
		local var_4_1 = var_4.sendNotification

		GAME = var_2_10007

		local var_4_2 = var_2_10007.ACT_INSTAGRAM_CHAT
		local var_4_3 = {
			isRedPacket = true
		}

		ActivityConst = var_2_10009
		var_4_3.operation = var_2_10009.INSTAGRAM_CHAT_REPLY
		var_4_3.topicId = arg_4_1
		var_4_3.wordId = arg_4_2
		var_4_3.replyId = arg_4_3

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)
	arg_1_0:bind(var_0_1.SET_CURRENT_TOPIC, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_5_2 = var_2_10005.ACT_INSTAGRAM_CHAT
		local var_5_3 = {}

		ActivityConst = var_2_10007
		var_5_3.operation = var_2_10007.INSTAGRAM_CHAT_SET_TOPIC
		var_5_3.topicId = arg_5_1

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end)
	arg_1_0:bind(var_0_1.SET_CURRENT_BACKGROUND, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_1_0
		local var_6_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_6_2 = var_2_10006.ACT_INSTAGRAM_CHAT
		local var_6_3 = {}

		ActivityConst = var_2_10008
		var_6_3.operation = var_2_10008.INSTAGRAM_CHAT_SET_SKIN
		var_6_3.characterId = arg_6_1
		var_6_3.skinId = arg_6_2

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end)
	arg_1_0:bind(var_0_1.SET_READED, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_7_2 = var_2_10005.ACT_INSTAGRAM_CHAT
		local var_7_3 = {}

		ActivityConst = var_2_10007
		var_7_3.operation = var_2_10007.INSTAGRAM_CHAT_SET_READTIP
		var_7_3.topicIdList = arg_7_1

		var_7_1(var_7_0, var_7_2, var_7_3)

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_ALL, function(arg_8_0)
		local var_8_0 = arg_1_0
		local var_8_1 = var_1.sendNotification

		InstagramMainMediator = var_2_10004

		var_8_1(var_8_0, var_2_10004.CLOSE_ALL)

		return
	end)
	arg_1_0:bind(var_0_1.ON_OFFICIAL_ACCOUNTS_OPERATE, function(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
		local var_9_0 = arg_1_0
		local var_9_1 = var_5.sendNotification

		GAME = var_2_10008

		var_9_1(var_9_0, var_2_10008.ACT_INSTAGRAM_OP, {
			cmd = arg_9_1 or 0,
			arg1 = arg_9_2 or 0,
			arg2 = arg_9_3 or 0,
			arg3 = arg_9_4 or 0
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_10_0)
	local var_10_0 = {}

	GAME = var_1_10002
	var_10_0[1] = var_1_10002.ACT_INSTAGRAM_CHAT_DONE
	GAME = var_2
	var_10_0[2] = var_2.ACT_INSTAGRAM_OP_DONE
	var_10_0[3] = var_0_1.BACK_PRESSED

	return var_10_0
end

function var_0_1.handleNotification(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1
	local var_11_1 = arg_11_1.getName(var_11_0)
	local var_11_2 = arg_11_1
	local var_11_3 = arg_11_1.getBody(var_11_2)

	GAME = var_11_0

	local var_11_4

	if var_11_1 == var_11_0.ACT_INSTAGRAM_CHAT_DONE then
		getProxy = var_11_4
		InstagramChatProxy = var_1_10006
		var_11_4 = var_11_4(var_1_10006)
		var_11_2 = false

		local var_11_5 = false

		var_1_10007 = var_11_3.operation
		ActivityConst = var_1_10008

		if var_1_10007 == var_1_10008.INSTAGRAM_CHAT_REPLY then
			if var_11_3.awards ~= nil then
				local var_11_6 = arg_11_0.viewComponent

				var_1_10007.SetEndAniEvent(var_11_6, arg_11_0.viewComponent.redPacketGot, function()
					local var_12_0 = arg_11_0.viewComponent
					local var_12_1 = var_0.emit

					BaseUI = var_2_10003

					var_12_1(var_12_0, var_2_10003.ON_ACHIEVE, var_11_3.awards)

					return
				end)

				local var_11_7 = arg_11_0.viewComponent

				var_1_10007.UpdateRedPacketUI(var_11_7, var_11_3.redPacketId)
			end

			var_11_2 = true
		else
			var_1_10007 = var_11_3.operation
			ActivityConst = var_8

			if var_1_10007 == var_8.INSTAGRAM_CHAT_SET_SKIN then
				-- block empty
			else
				var_1_10007 = var_11_3.operation
				ActivityConst = var_8

				if var_1_10007 == var_8.INSTAGRAM_CHAT_SET_CARE then
					-- block empty
				else
					var_1_10007 = var_11_3.operation
					ActivityConst = var_8

					if var_1_10007 == var_8.INSTAGRAM_CHAT_SET_TOPIC then
						-- block empty
					else
						var_1_10007 = var_11_3.operation
						ActivityConst = var_8

						if var_1_10007 == var_8.INSTAGRAM_CHAT_SET_READTIP then
							local var_11_8 = arg_11_0

							var_1_10007 = arg_11_0.sendNotification
							InstagramMainMediator = var_1_10010

							var_1_10007(var_11_8, var_1_10010.CHANGE_CHAT_TIP)

							var_11_5 = true
						end
					end
				end
			end
		end

		var_1_10007 = var_11_3.operation
		ActivityConst = var_8

		if var_1_10007 == var_8.INSTAGRAM_CHAT_REPLY then
			if var_11_3.awards ~= nil then
				local var_11_9 = arg_11_0.viewComponent

				var_1_10007.ChangeFresh(var_11_9)
			else
				local var_11_10 = arg_11_0.viewComponent

				var_1_10007.SetEndAniEvent(var_11_10, arg_11_0.viewComponent.optionPanel, function()
					local var_13_0 = arg_11_0.viewComponent

					var_0.UpdateCharaList(var_13_0, var_11_2, var_11_5)

					return
				end)

				local var_11_11 = arg_11_0.viewComponent.optionPanel

				var_1_10007 = var_1_10007.GetComponent
				typeof = var_10
				Animation = var_1_10012

				local var_11_12 = var_1_10007(var_11_11, var_10(var_1_10012))

				var_1_10007.Play(var_11_12, "anim_newinstagram_option_out")
			end
		else
			local var_11_13 = arg_11_0.viewComponent

			var_1_10007.UpdateCharaList(var_11_13, var_11_2, var_11_5)
		end

		goto label_11_0
	end

	GAME = var_11_4

	if var_11_1 == var_11_4.ACT_INSTAGRAM_OP_DONE then
		local var_11_14 = var_11_3.cmd

		ActivityConst = var_11_2

		if var_11_14 == var_11_2.INSTAGRAM_OP_SHARE then
			pg = var_11_14

			local var_11_15 = var_11_14.ShareMgr.GetInstance()
			local var_11_16 = var_4.Share

			pg = var_1_10007

			var_11_16(var_11_15, var_1_10007.ShareMgr.TypeInstagram)

			goto label_11_0
		end

		local var_11_17 = var_11_3.cmd

		ActivityConst = var_5

		if var_11_17 == var_5.INSTAGRAM_OP_LIKE then
			local var_11_18 = arg_11_0.viewComponent

			var_4.UpdateLinkBtn(var_11_18, var_11_3.id)

			pg = var_4

			local var_11_19 = var_4.TipsMgr.GetInstance()
			local var_11_20 = var_4.ShowTips

			i18n = var_1_10007

			var_11_20(var_11_19, var_1_10007("ins_click_like_success"))

			goto label_11_0
		end

		local var_11_21 = var_11_3.cmd

		ActivityConst = var_5

		if var_11_21 == var_5.INSTAGRAM_OP_COMMENT then
			pg = var_11_21

			local var_11_22 = var_11_21.TipsMgr.GetInstance()
			local var_11_23 = var_4.ShowTips

			i18n = var_1_10007

			var_11_23(var_11_22, var_1_10007("ins_push_comment_success"))

			local var_11_24 = arg_11_0.viewComponent

			var_4.UpdateCommentList(var_11_24, var_11_3.id)

			local var_11_25 = arg_11_0.viewComponent

			var_4.AddOfficialAccountsTimer(var_11_25)

			local var_11_26 = arg_11_0.viewComponent

			var_4.ReadOfficialAccountComment(var_11_26)

			local var_11_27 = arg_11_0.viewComponent

			var_4.RefreshOfficialAccountTips(var_11_27)

			local var_11_28 = arg_11_0
			local var_11_29 = arg_11_0.sendNotification

			InstagramMainMediator = var_1_10007

			var_11_29(var_11_28, var_1_10007.CHANGE_CHAT_TIP)

			goto label_11_0
		end

		local var_11_30 = var_11_3.cmd

		ActivityConst = var_5

		if var_11_30 ~= var_5.INSTAGRAM_OP_ACTIVE then
			do
				local var_11_31 = var_11_3.cmd

				ActivityConst = var_5

				if var_11_31 == var_5.INSTAGRAM_OP_UPDATE then
					local var_11_32 = arg_11_0.viewComponent

					var_4.UpdateCommentList(var_11_32, var_11_3.id)

					local var_11_33 = arg_11_0.viewComponent

					var_4.AddOfficialAccountsTimer(var_11_33)

					local var_11_34 = arg_11_0.viewComponent

					var_4.ReadOfficialAccountComment(var_11_34)

					local var_11_35 = arg_11_0.viewComponent

					var_4.RefreshOfficialAccountTips(var_11_35)

					local var_11_36 = arg_11_0
					local var_11_37 = arg_11_0.sendNotification

					InstagramMainMediator = var_1_10007

					var_11_37(var_11_36, var_1_10007.CHANGE_CHAT_TIP)
				else
					local var_11_38 = var_11_3.cmd

					ActivityConst = var_5

					if var_11_38 == var_5.INSTAGRAM_OP_MARK_READ then
						local var_11_39 = arg_11_0.viewComponent

						var_4.RefreshOfficialAccountTips(var_11_39)

						local var_11_40 = arg_11_0
						local var_11_41 = arg_11_0.sendNotification

						InstagramMainMediator = var_1_10007

						var_11_41(var_11_40, var_1_10007.CHANGE_CHAT_TIP)
					end
				end

				if false then
					if var_11_1 == var_0_1.BACK_PRESSED then
						local var_11_42 = arg_11_0.viewComponent

						var_4.onBackPressed(var_11_42)
					end
				end
			end

			::label_11_0::

			return
		end
	end
end

return var_0_1
