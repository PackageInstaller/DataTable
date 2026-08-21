local var_0_0 = singletonClass("ChatData")

function var_0_0.Init(arg_1_0)
	arg_1_0.worldChannelNum_ = 0
	arg_1_0.worldChannelData_ = {}
	arg_1_0.worldChannelTempData_ = {}
	arg_1_0.channelTimestamp_ = 0
	arg_1_0.sendTextTimestamp_ = {
		0
	}
	arg_1_0.stickerTimestamp_ = 0
	arg_1_0.levelTextTimeStamp_ = {}
	arg_1_0.mutedData_ = {
		mutedContent = "",
		mutedTimestamp = 0
	}
	arg_1_0.isShowMutedTips_ = false
	arg_1_0.reportCnt_ = 0
end

function var_0_0.UpdateMutedLevel(arg_2_0, arg_2_1)
	if arg_2_0.mutedData_.mutedTimestamp > arg_2_1.ban_timestamp then
		arg_2_0.isShowMutedTips_ = false
	end

	arg_2_0.mutedData_.mutedContent = arg_2_1.mute_reason
	arg_2_0.mutedData_.mutedTimestamp = arg_2_1.ban_timestamp
	arg_2_0.mutedData_.i18nInfo = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.i18n_info) do
		arg_2_0.mutedData_.i18nInfo[iter_2_1.language] = iter_2_1.string
	end
end

function var_0_0.GetMutedData(arg_3_0)
	return arg_3_0.mutedData_
end

function var_0_0.IsMuted(arg_4_0)
	return manager.time:GetServerTime() < arg_4_0.mutedData_.mutedTimestamp
end

function var_0_0.SetShowMutedTips(arg_5_0, arg_5_1)
	arg_5_0.isShowMutedTips_ = arg_5_1
end

function var_0_0.GetShowMutedTips(arg_6_0)
	return arg_6_0.isShowMutedTips_
end

function var_0_0.SetWorldChannelNum(arg_7_0, arg_7_1)
	arg_7_0.worldChannelNum_ = arg_7_1

	local var_7_0 = {
		timestamp = manager.time:GetServerTime(),
		contentType = ChatConst.CHAT_CONTENT_TYPE.CHANNEL,
		content = arg_7_1
	}

	table.insert(arg_7_0.worldChannelData_, var_7_0)
	table.insert(arg_7_0.worldChannelTempData_, var_7_0)
end

function var_0_0.GetWorldChannelNum(arg_8_0)
	return arg_8_0.worldChannelNum_
end

function var_0_0.GetWorldChatData(arg_9_0)
	return arg_9_0.worldChannelTempData_ or {}
end

function var_0_0.ResetWorldTempData(arg_10_0, arg_10_1)
	arg_10_0.worldChannelTempData_ = arg_10_1
end

function var_0_0.GetWorldOriginChatData(arg_11_0)
	return arg_11_0.worldChannelData_
end

function var_0_0.AddWorldChat(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.worldChannelData_ = arg_12_0.worldChannelData_ or {}

	local var_12_0 = #arg_12_0.worldChannelData_

	if var_12_0 <= 0 or var_12_0 > 0 and manager.time:GetServerTime() - arg_12_0.worldChannelData_[var_12_0].timestamp > ChatConst.MESSAGE_SPACE or arg_12_0.worldChannelData_[var_12_0].contentType == ChatConst.CHAT_CONTENT_TYPE.CHANNEL then
		local var_12_1 = {
			timestamp = arg_12_1.msg.timestamp,
			contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
		}

		table.insert(arg_12_0.worldChannelData_, var_12_1)
		table.insert(arg_12_0.worldChannelTempData_, var_12_1)
	end

	local var_12_2 = arg_12_0:ParseMsg(arg_12_1)

	table.insert(arg_12_0.worldChannelData_, var_12_2)

	if not arg_12_2 then
		table.insert(arg_12_0.worldChannelTempData_, var_12_2)
	end
end

function var_0_0.RemoveWorldChat(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.worldChannelData_) do
		if (iter_13_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT or iter_13_1.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER) and iter_13_1.msgID == arg_13_1 then
			if arg_13_0.worldChannelData_[iter_13_0 + 1] == nil and arg_13_0.worldChannelData_[iter_13_0 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
				table.remove(arg_13_0.worldChannelData_, iter_13_0)
				table.remove(arg_13_0.worldChannelData_, iter_13_0 - 1)

				break
			end

			table.remove(arg_13_0.worldChannelData_, iter_13_0)

			break
		end
	end

	for iter_13_2, iter_13_3 in ipairs(arg_13_0.worldChannelTempData_) do
		if (iter_13_3.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT or iter_13_3.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER) and iter_13_3.msgID == arg_13_1 then
			if arg_13_0.worldChannelTempData_[iter_13_2 + 1] == nil and arg_13_0.worldChannelTempData_[iter_13_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
				table.remove(arg_13_0.worldChannelTempData_, iter_13_2)
				table.remove(arg_13_0.worldChannelTempData_, iter_13_2 - 1)

				break
			end

			table.remove(arg_13_0.worldChannelTempData_, iter_13_2)

			break
		end
	end
end

function var_0_0.ParseMsg(arg_14_0, arg_14_1)
	return {
		id = arg_14_1.msg.id,
		msgID = arg_14_1.msg.msg_id,
		nick = arg_14_1.msg.user_profile_base.nick,
		icon = arg_14_1.msg.user_profile_base.icon,
		iconFrame = arg_14_1.msg.user_profile_base.icon_frame,
		timestamp = arg_14_1.msg.timestamp,
		contentType = arg_14_1.msg.type,
		content = arg_14_1.msg.content,
		roomID = arg_14_1.room_id,
		ip = (arg_14_1.msg.ip_location == nil or arg_14_1.msg.ip_location == "") and GetTips("IP_UNKNOWN") or arg_14_1.msg.ip_location,
		bubbleID = arg_14_1.msg.chat_bubble or GameSetting.profile_chat_bubble_default.value[1]
	}
end

function var_0_0.SetSendTextTimestamp(arg_15_0)
	if #arg_15_0.sendTextTimestamp_ >= 3 then
		table.remove(arg_15_0.sendTextTimestamp_, 1)
	end

	table.insert(arg_15_0.sendTextTimestamp_, manager.time:GetServerTime())
end

function var_0_0.GetSendTextTimestamp(arg_16_0)
	return arg_16_0.sendTextTimestamp_[1]
end

function var_0_0.SetLevelTextTimeStamp(arg_17_0, arg_17_1)
	arg_17_0.levelTextTimeStamp_[arg_17_1] = manager.time:GetServerTime()
end

function var_0_0.GetLevelTextTimeStamp(arg_18_0, arg_18_1)
	if PlayerData:GetPlayerInfo().userLevel > GameSetting.chat_speech_interval.value[2] then
		return 0
	end

	return arg_18_0.levelTextTimeStamp_[arg_18_1] or 0
end

function var_0_0.SetSendStickerTimestamp(arg_19_0)
	arg_19_0.stickerTimestamp_ = manager.time:GetServerTime()
end

function var_0_0.GetSendStickerTimestamp(arg_20_0)
	return arg_20_0.stickerTimestamp_
end

function var_0_0.SetChannelTimestamp(arg_21_0)
	arg_21_0.channelTimestamp_ = manager.time:GetServerTime()
end

function var_0_0.GetChannelTimestamp(arg_22_0)
	return arg_22_0.channelTimestamp_
end

function var_0_0.InitReportCnt(arg_23_0, arg_23_1)
	arg_23_0.reportCnt_ = arg_23_1
end

function var_0_0.AddReportCnt(arg_24_0)
	arg_24_0.reportCnt_ = arg_24_0.reportCnt_ + 1
end

function var_0_0.GetReportCnt(arg_25_0)
	return arg_25_0.reportCnt_
end

return var_0_0
