local var_0_0 = {
	GetCharactorLitsByType = function(arg_1_0)
		local var_1_0 = {}
		local var_1_1 = MomoTalkData:GetData1(arg_1_0)

		for iter_1_0, iter_1_1 in pairs(var_1_1) do
			local var_1_2 = {
				sender_id = iter_1_0,
				chat_Data = iter_1_1
			}

			table.insert(var_1_0, var_1_2)
		end

		return var_1_0
	end
}

function var_0_0.ParseContentData(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0 or {}) do
		local var_2_2 = ChatMessageCfg[iter_2_1.id]

		var_2_0[iter_2_1.id] = var_0_0.GetListDataByMessAge(iter_2_1)
	end

	return var_2_0, nowIndex
end

function var_0_0.GetListDataByMessAge(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.save_list) do
		if iter_3_1.state ~= 0 then
			table.insert(var_3_1, iter_3_1.content_id)

			if ChatContentCfg[iter_3_1.state] then
				table.insert(var_3_1, iter_3_1.state)
			end
		end
	end

	local var_3_2 = ChatMessageCfg[arg_3_0.id]
	local var_3_3 = arg_3_0 and arg_3_0.is_view == 1 and "readed" or "unRead"
	local var_3_4 = {
		id = var_3_2.content,
		state = var_3_3,
		messageID = arg_3_0.id
	}

	table.insert(var_3_0, var_3_4)

	local var_3_5 = var_3_2.content
	local var_3_6 = ChatContentCfg[var_3_5]
	local var_3_7 = ChatContentCfg.get_id_list_by_belong_is_turn[var_3_2.content]
	local var_3_8 = var_3_7 and var_3_7[1] or {}
	local var_3_9 = true

	for iter_3_2, iter_3_3 in ipairs(var_3_8) do
		if not table.indexof(var_3_1, iter_3_3) then
			var_3_9 = false
		end
	end

	if arg_3_0 and arg_3_0.is_view == 0 and #var_3_8 == 0 then
		var_3_9 = false
	end

	if arg_3_0 and arg_3_0.is_view == 0 then
		local var_3_10 = 0

		var_3_6 = ChatContentCfg[var_3_10]
	end

	local var_3_11 = {}
	local var_3_12 = {
		[var_3_2.content] = true
	}
	local var_3_13 = {}

	while var_3_6 and (var_3_6.next_content_list ~= "" or var_3_6.options ~= "") do
		if var_3_13[var_3_6.id] then
			break
		end

		var_3_13[var_3_6.id] = true

		local var_3_14 = 0

		if var_3_6.next_content_list ~= "" and #var_3_6.next_content_list == 1 then
			var_3_14 = var_3_6.next_content_list[1]
		elseif not table.indexof(var_3_11, var_3_6.id) then
			table.insert(var_3_11, var_3_6.id)
		end

		if var_3_6.options ~= "" and #var_3_6.options > 0 then
			local var_3_15 = 0

			for iter_3_4, iter_3_5 in ipairs(var_3_6.options) do
				if table.indexof(var_3_1, iter_3_5) then
					var_3_15 = iter_3_5
				end
			end

			if var_3_15 ~= 0 then
				local var_3_16 = ChatContentCfg[var_3_15]

				if var_3_16 and not var_3_12[var_3_15] then
					local var_3_17 = {
						state = "readed",
						id = var_3_15,
						messageID = arg_3_0.id
					}

					table.insert(var_3_0, var_3_17)

					var_3_12[var_3_15] = true
				end

				if var_3_16 and var_3_16.next_content_list ~= "" and #var_3_16.next_content_list == 1 then
					var_3_14 = var_3_16.next_content_list[1]
				else
					var_3_14 = 0
				end
			else
				var_3_14 = var_3_15

				if var_3_14 ~= 0 and not var_3_12[var_3_14] then
					local var_3_18 = {
						state = "unRead",
						id = var_3_14,
						messageID = arg_3_0.id
					}

					table.insert(var_3_0, var_3_18)

					var_3_12[var_3_14] = true

					break
				end
			end
		elseif var_3_6.type == 5 then
			-- block empty
		end

		if var_3_14 == 0 or var_3_12[var_3_14] then
			break
		end

		local var_3_19 = {
			state = "readed",
			id = var_3_14,
			messageID = arg_3_0.id
		}

		table.insert(var_3_0, var_3_19)

		var_3_12[var_3_14] = true
		var_3_6 = ChatContentCfg[var_3_14]
	end

	for iter_3_6, iter_3_7 in ipairs(var_3_11) do
		if not var_3_12[iter_3_7] then
			local var_3_20 = {
				id = iter_3_7,
				state = var_3_9 and "readed" or "unRead",
				messageID = arg_3_0.id
			}

			table.insert(var_3_0, var_3_20)

			var_3_12[iter_3_7] = true
		end
	end

	return var_0_0.ApplyRecallDisplayRules(var_3_0)
end

function var_0_0.GetItemDisplayType(arg_4_0, arg_4_1)
	if arg_4_0 and arg_4_0.displayMsgType then
		return arg_4_0.displayMsgType
	end

	return arg_4_1 and arg_4_1.type or MomoTalkConst.MSG_TYPE.TEXT
end

function var_0_0.GetItemDisplayContent(arg_5_0, arg_5_1)
	local var_5_0 = var_0_0.GetItemDisplayType(arg_5_0, arg_5_1)

	if var_5_0 == MomoTalkConst.MSG_TYPE.STICKER then
		local var_5_1 = var_0_0.GetStickerCfg(arg_5_1)

		return var_5_1 and string.format("[%s]", GetI18NText(var_5_1.name or "")) or ""
	elseif var_5_0 == MomoTalkConst.MSG_TYPE.IMAGE then
		return GetTips("momotalk_message_picture")
	end

	local var_5_2

	if arg_5_0 and arg_5_0.displayContent ~= nil then
		var_5_2 = arg_5_0.displayContent
	else
		var_5_2 = arg_5_1 and GetI18NText(arg_5_1.content) or ""
	end

	return formatText(var_5_2 or "")
end

function var_0_0.GetShownCountBySessionProgress(arg_6_0, arg_6_1)
	if not arg_6_0 or #arg_6_0 == 0 then
		return 0
	end

	local var_6_0 = arg_6_1 and arg_6_1.current_content_id or 0

	if var_6_0 and var_6_0 > 0 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
			if iter_6_1.id == var_6_0 then
				return iter_6_0
			end
		end
	end

	local var_6_1 = 0

	for iter_6_2, iter_6_3 in ipairs(arg_6_0) do
		if iter_6_3.state == MomoTalkConst.MSG_STATE.READED or iter_6_3.state == "readed" then
			var_6_1 = iter_6_2
		else
			break
		end
	end

	if var_6_1 == 0 then
		var_6_1 = 1
	end

	return math.min(var_6_1, #arg_6_0)
end

function var_0_0.IsPendingChoiceItem(arg_7_0, arg_7_1)
	if not arg_7_0 then
		return false
	end

	local var_7_0 = ChatContentCfg[arg_7_0.id]

	if not var_7_0 or var_7_0.options == "" or not (#var_7_0.options > 0) then
		return false
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_1 and arg_7_1.save_list or {}) do
		if iter_7_1.content_id == arg_7_0.id then
			return iter_7_1.state == 0
		end
	end

	if arg_7_1 and arg_7_1.current_content_id == arg_7_0.id then
		return true
	end

	return arg_7_0.state ~= MomoTalkConst.MSG_STATE.READED and arg_7_0.state ~= "readed"
end

function var_0_0.HasSessionPendingContent(arg_8_0)
	if not arg_8_0 or not arg_8_0.id then
		return false
	end

	local var_8_0 = arg_8_0

	if not var_8_0.save_list then
		var_8_0 = clone(var_8_0)
		var_8_0.save_list = {}
	end

	local var_8_1 = var_0_0.GetListDataByMessAge(var_8_0) or {}

	if #var_8_1 == 0 then
		return false
	end

	local var_8_2 = var_0_0.GetShownCountBySessionProgress(var_8_1, var_8_0)

	if var_8_2 < #var_8_1 then
		return true
	end

	if var_0_0.IsPendingChoiceItem(var_8_1[var_8_2], var_8_0) then
		return true
	end

	return #(var_0_0.DONext(clone(var_8_1)) or var_8_1) > #var_8_1
end

function var_0_0.GetPendingSession(arg_9_0)
	local var_9_0
	local var_9_1

	for iter_9_0, iter_9_1 in pairs(arg_9_0 or {}) do
		local var_9_2 = iter_9_1 and iter_9_1.id or iter_9_0

		if iter_9_1 then
			if MomoTalkData:IsActiveUnreadSession(iter_9_1, iter_9_0) then
				if not var_9_0 or var_9_2 > (var_9_0.id or 0) then
					var_9_0 = iter_9_1
				end
			elseif MomoTalkData:IsNoRemindSession(iter_9_1, iter_9_0) and (not var_9_1 or var_9_2 > (var_9_1.id or 0)) then
				var_9_1 = iter_9_1
			end
		end
	end

	return var_9_0 or var_9_1
end

function var_0_0.GetDisplaySession(arg_10_0, arg_10_1)
	local var_10_0 = var_0_0.GetPendingSession(arg_10_0)

	if var_10_0 then
		return var_10_0
	end

	if not arg_10_1 then
		for iter_10_0, iter_10_1 in pairs(arg_10_0 or {}) do
			local var_10_1 = iter_10_1 and ChatMessageCfg[iter_10_1.id]

			if var_10_1 then
				arg_10_1 = var_10_1.sender

				break
			end
		end
	end

	local var_10_2 = arg_10_1 and MomoTalkData:GetLatestSessionID(MomoTalkConst.DATA_TYPE.CHAT, arg_10_1) or nil

	if var_10_2 and arg_10_0 and arg_10_0[var_10_2] then
		return arg_10_0[var_10_2]
	end

	local var_10_3

	for iter_10_2, iter_10_3 in pairs(arg_10_0 or {}) do
		local var_10_4 = iter_10_3 and iter_10_3.id or iter_10_2

		if iter_10_3 and (not var_10_3 or var_10_4 > (var_10_3.id or 0)) then
			var_10_3 = iter_10_3
		end
	end

	return var_10_3
end

function var_0_0.GetSessionPreviewContent(arg_11_0)
	if not arg_11_0 or not arg_11_0.id then
		return ""
	end

	local var_11_0 = arg_11_0

	if not var_11_0.save_list then
		var_11_0 = clone(var_11_0)
		var_11_0.save_list = {}
	end

	local var_11_1 = var_0_0.GetListDataByMessAge(var_11_0) or {}
	local var_11_2 = var_11_1[var_0_0.GetShownCountBySessionProgress(var_11_1, var_11_0)]
	local var_11_3 = var_11_2 and ChatContentCfg[var_11_2.id]

	return var_0_0.GetItemDisplayContent(var_11_2, var_11_3) or ""
end

function var_0_0.GetSessionFirstPreviewContent(arg_12_0)
	if not arg_12_0 or not arg_12_0.id then
		return ""
	end

	local var_12_0 = arg_12_0

	if not var_12_0.save_list then
		var_12_0 = clone(var_12_0)
		var_12_0.save_list = {}
	end

	local var_12_1 = (var_0_0.GetListDataByMessAge(var_12_0) or {})[1]
	local var_12_2 = var_12_1 and ChatContentCfg[var_12_1.id]

	return var_0_0.GetItemDisplayContent(var_12_1, var_12_2) or ""
end

function var_0_0.GetSessionDisplayName(arg_13_0, arg_13_1)
	local var_13_0 = ChatMessageCfg[arg_13_0 or 0]
	local var_13_1 = arg_13_1 or 0

	if var_13_0 and var_13_0.sender and var_13_0.sender > 0 then
		var_13_1 = var_13_0.sender
	end

	local var_13_2 = ChatHeroCfg[var_13_1]

	if not var_13_2 and arg_13_1 and arg_13_1 > 0 then
		var_13_2 = ChatHeroCfg[arg_13_1]
	end

	return var_13_2 and GetI18NText(var_13_2.name or "") or ""
end

function var_0_0.GetRecallTargetItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = tonumber(arg_14_3)

	if not var_14_0 and type(arg_14_3) == "table" then
		var_14_0 = tonumber(arg_14_3[1])
	end

	if var_14_0 then
		for iter_14_0 = arg_14_1 - 1, 1, -1 do
			local var_14_1 = arg_14_0[iter_14_0]
			local var_14_2 = ChatContentCfg[var_14_1 and var_14_1.id or 0]
			local var_14_3 = var_0_0.GetItemDisplayType(var_14_1, var_14_2)

			if var_14_2 and not var_14_1.isRecallReplaced and var_14_2.id == var_14_0 and var_14_3 ~= MomoTalkConst.MSG_TYPE.RECALL and var_14_3 ~= MomoTalkConst.MSG_TYPE.NARRATE and var_14_3 ~= MomoTalkConst.MSG_TYPE.STICKER then
				return var_14_1
			end
		end
	end

	for iter_14_1 = arg_14_1 - 1, 1, -1 do
		local var_14_4 = arg_14_0[iter_14_1]
		local var_14_5 = ChatContentCfg[var_14_4 and var_14_4.id or 0]
		local var_14_6 = var_0_0.GetItemDisplayType(var_14_4, var_14_5)

		if var_14_5 and not var_14_4.isRecallReplaced and var_14_5.spokesmen == arg_14_2 and var_14_6 ~= MomoTalkConst.MSG_TYPE.RECALL and var_14_6 ~= MomoTalkConst.MSG_TYPE.NARRATE and var_14_6 ~= MomoTalkConst.MSG_TYPE.STICKER then
			return var_14_4
		end
	end

	return nil
end

function var_0_0.ApplyRecallDisplayRules(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0 or {}) do
		iter_15_1.displayMsgType = nil
		iter_15_1.displayContent = nil
		iter_15_1.isRecallReplaced = nil
	end

	for iter_15_2, iter_15_3 in ipairs(arg_15_0 or {}) do
		local var_15_0 = ChatContentCfg[iter_15_3 and iter_15_3.id or 0]

		if var_15_0 and var_15_0.type == MomoTalkConst.MSG_TYPE.RECALL then
			iter_15_3.displayMsgType = MomoTalkConst.MSG_TYPE.RECALL
			iter_15_3.displayContent = var_15_0.content or ""

			local var_15_1 = var_0_0.GetRecallTargetItem(arg_15_0, iter_15_2, var_15_0.spokesmen, var_15_0.recall)

			if var_15_1 then
				var_15_1.displayMsgType = MomoTalkConst.MSG_TYPE.TEXT
				var_15_1.displayContent = GetTips("momotalk_recall")
				var_15_1.isRecallReplaced = true
			end
		end
	end

	return arg_15_0
end

function var_0_0.DONext(arg_16_0)
	local var_16_0 = arg_16_0[#arg_16_0]
	local var_16_1 = ChatContentCfg[var_16_0.id]

	if var_16_1 and var_16_1.next_content_list ~= "" and #var_16_1.next_content_list == 1 then
		table.insert(arg_16_0, {
			state = "readed",
			id = var_16_1.next_content_list[1],
			messageID = var_16_0.messageID
		})
	end

	return var_0_0.ApplyRecallDisplayRules(arg_16_0)
end

function var_0_0.CheckList(arg_17_0)
	local var_17_0 = arg_17_0[#arg_17_0]
	local var_17_1 = ChatContentCfg[var_17_0 and var_17_0.id or 0]
	local var_17_2 = "none"

	if var_17_1 and var_17_1.options ~= "" and #var_17_1.options > 0 then
		var_17_2 = "tab"
	end

	return var_17_2, var_17_0
end

function var_0_0.GetBgData()
	local var_18_0 = {}
	local var_18_1 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.MOMOTALK_CHATBG] or {}

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		local var_18_2 = MomoTalkData:GetBgData(iter_18_1)

		table.insert(var_18_0, {
			id = iter_18_1,
			state = var_18_2 and var_18_2.state or 0
		})
	end

	return var_18_0
end

function var_0_0.GetBubleData()
	local var_19_0 = {}
	local var_19_1 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_TYPE.CHAT_BUBBLE] or {}

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		table.insert(var_19_0, {
			state = 0,
			id = iter_19_1
		})
	end

	return var_19_0
end

function var_0_0.GetHeadData()
	local var_20_0 = {}
	local var_20_1 = ChatMonoAvatarCfg.all or {}

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		table.insert(var_20_0, {
			state = 1,
			id = iter_20_1,
			cfg = ChatMonoAvatarCfg[iter_20_1]
		})
	end

	return var_20_0
end

function var_0_0.GetMonoAvatarIcon(arg_21_0)
	local var_21_0 = ChatMonoAvatarCfg[arg_21_0] or ChatMonoAvatarCfg[ChatMonoAvatarCfg.all and ChatMonoAvatarCfg.all[1]]

	if not var_21_0 or not var_21_0.icon then
		return nil
	end

	local var_21_1 = var_21_0.icon
	local var_21_2 = string.gsub(var_21_1, "%.png$", "")

	if not string.find(var_21_2, "TextureConfig/", 1, true) then
		var_21_2 = "TextureConfig/Momotalk/" .. var_21_2
	end

	return pureGetSpriteWithoutAtlas(var_21_2)
end

function var_0_0.GetHeroIcon(arg_22_0)
	return pureGetSpriteWithoutAtlas(arg_22_0)
end

function var_0_0.GetStickerKey(arg_23_0)
	local var_23_0 = arg_23_0 and arg_23_0.url or ""

	if var_23_0 == "" then
		return nil
	end

	local var_23_1 = string.gsub(var_23_0, "%.png$", "")

	return string.match(var_23_1, "([^/]+)$") or var_23_1
end

function var_0_0.GetStickerCfg(arg_24_0)
	local var_24_0 = var_0_0.GetStickerKey(arg_24_0)

	if not var_24_0 then
		return nil
	end

	local var_24_1 = tonumber(var_24_0)

	if var_24_1 and ChatStickerCfg[var_24_1] then
		return ChatStickerCfg[var_24_1]
	end

	local var_24_2 = string.match(var_24_0, "^(%d+_%d+)_%d+$")

	for iter_24_0, iter_24_1 in ipairs(ChatStickerCfg.all or {}) do
		local var_24_3 = ChatStickerCfg[iter_24_1]
		local var_24_4 = var_24_3 and var_24_3.icon or ""
		local var_24_5 = string.match(var_24_4, "([^/]+)$") or var_24_4

		if var_24_4 == var_24_0 or var_24_5 == var_24_0 then
			return var_24_3
		end

		if var_24_2 and (var_24_4 == "DynamicSticker/" .. var_24_2 or var_24_5 == var_24_2) then
			return var_24_3
		end
	end

	return nil
end

function var_0_0.GetImageSpritePath(arg_25_0)
	local var_25_0 = arg_25_0 and arg_25_0.url or ""

	if var_25_0 == "" then
		return nil
	end

	local var_25_1 = string.gsub(var_25_0, "%.png$", "")

	var_25_1 = string.match(var_25_1, "([^/]+)$") or var_25_1

	if arg_25_0 and arg_25_0.type == MomoTalkConst.MSG_TYPE.STICKER then
		local var_25_2 = var_0_0.GetStickerCfg(arg_25_0)

		if var_25_2 and var_25_2.type == 1 then
			return "TextureConfig/Chat/ChatSticker/" .. var_25_2.icon
		end

		return nil
	end

	return "TextureConfig/Momotalk/" .. var_25_1
end

return var_0_0
