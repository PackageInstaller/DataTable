local var_0_0 = {
	GetCharactorLitsByType = function(arg_1_0)
		local var_1_0 = {}

		for iter_1_0, iter_1_1 in pairs((MomoTalkData:GetData1(arg_1_0))) do
			table.insert(var_1_0, {
				sender_id = iter_1_0,
				chat_Data = iter_1_1
			})
		end

		return var_1_0
	end
}

function var_0_0.ParseContentData(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0 or {}) do
		var_2_0[iter_2_1.id] = var_0_0.GetListDataByMessAge(iter_2_1)
	end

	return var_2_0, nowIndex
end

function var_0_0:GetListDataByMessAge()
	local var_3_0 = {}
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(self.save_list) do
		if iter_3_1.state ~= 0 then
			table.insert(var_3_1, iter_3_1.content_id)

			if ChatContentCfg[iter_3_1.state] then
				table.insert(var_3_1, iter_3_1.state)
			end
		end
	end

	local var_3_2 = ChatMessageCfg[self.id]

	table.insert(var_3_0, {
		id = ChatMessageCfg[self.id].content,
		state = self and self.is_view == 1 and "readed" or "unRead",
		messageID = self.id
	})

	local var_3_3 = ChatContentCfg[var_3_2.content]
	local var_3_4

	if ChatContentCfg.get_id_list_by_belong_is_turn[var_3_2.content] then
		var_3_4 = ChatContentCfg.get_id_list_by_belong_is_turn[var_3_2.content][1] or {}
	end

	local var_3_5 = true

	for iter_3_2, iter_3_3 in ipairs(var_3_4) do
		if not table.indexof(var_3_1, iter_3_3) then
			var_3_5 = false
		end
	end

	if self and self.is_view == 0 and #var_3_4 == 0 then
		var_3_5 = false
	end

	if self and self.is_view == 0 then
		var_3_3 = ChatContentCfg[0]
	end

	local var_3_6 = {}
	local var_3_7 = {
		[var_3_2.content] = true
	}
	local var_3_8 = {}

	while var_3_3 and (var_3_3.next_content_list ~= "" or var_3_3.options ~= "") do
		if var_3_8[var_3_3.id] then
			break
		end

		var_3_8[var_3_3.id] = true

		local var_3_9 = 0

		if var_3_3.next_content_list ~= "" and #var_3_3.next_content_list == 1 then
			var_3_9 = var_3_3.next_content_list[1]
		elseif not table.indexof(var_3_6, var_3_3.id) then
			table.insert(var_3_6, var_3_3.id)
		end

		if var_3_3.options ~= "" and #var_3_3.options > 0 then
			local var_3_10 = 0

			for iter_3_4, iter_3_5 in ipairs(var_3_3.options) do
				if table.indexof(var_3_1, iter_3_5) then
					var_3_10 = iter_3_5
				end
			end

			if var_3_10 ~= 0 then
				if ChatContentCfg[var_3_10] and not var_3_7[var_3_10] then
					table.insert(var_3_0, {
						state = "readed",
						id = var_3_10,
						messageID = self.id
					})

					var_3_7[var_3_10] = true
				end

				var_3_9 = ChatContentCfg[var_3_10] and ChatContentCfg[var_3_10].next_content_list ~= "" and #ChatContentCfg[var_3_10].next_content_list == 1 and ChatContentCfg[var_3_10].next_content_list[1] or 0
			else
				var_3_9 = var_3_10

				if var_3_10 ~= 0 and not var_3_7[var_3_9] then
					table.insert(var_3_0, {
						state = "unRead",
						id = var_3_9,
						messageID = self.id
					})

					var_3_7[var_3_9] = true

					break
				end
			end
		elseif var_3_3.type == 5 then
			-- block empty
		end

		if var_3_9 == 0 or var_3_7[var_3_9] then
			break
		end

		table.insert(var_3_0, {
			state = "readed",
			id = var_3_9,
			messageID = self.id
		})

		var_3_7[var_3_9] = true
		var_3_3 = ChatContentCfg[var_3_9]
	end

	for iter_3_6, iter_3_7 in ipairs(var_3_6) do
		if not var_3_7[iter_3_7] then
			table.insert(var_3_0, {
				id = iter_3_7,
				state = var_3_5 and "readed" or "unRead",
				messageID = self.id
			})

			var_3_7[iter_3_7] = true
		end
	end

	return var_0_0.ApplyRecallDisplayRules(var_3_0)
end

function var_0_0:GetItemDisplayType(arg_4_1)
	if self and self.displayMsgType then
		return self.displayMsgType
	end

	return (arg_4_1 or nil) and (arg_4_1.type or MomoTalkConst.MSG_TYPE.TEXT)
end

function var_0_0:GetItemDisplayContent(arg_5_1)
	local var_5_0 = var_0_0.GetItemDisplayType(self, arg_5_1)

	if var_5_0 == MomoTalkConst.MSG_TYPE.STICKER then
		local var_5_1 = var_0_0.GetStickerCfg(arg_5_1)

		return (var_5_1 or nil) and (string.format("[%s]", GetI18NText(var_5_1.name or "")) or "")
	elseif var_5_0 == MomoTalkConst.MSG_TYPE.IMAGE then
		return GetTips("momotalk_message_picture")
	end

	return formatText(self and self.displayContent ~= nil and self.displayContent or arg_5_1 and GetI18NText(arg_5_1.content) or "" or "")
end

function var_0_0.GetShownCountBySessionProgress(arg_6_0, arg_6_1)
	if not arg_6_0 or #arg_6_0 == 0 then
		return 0
	end

	if arg_6_1 then
		local var_6_0 = arg_6_1.current_content_id or 0

		if var_6_0 and var_6_0 > 0 then
			for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
				if iter_6_1.id == var_6_0 then
					return iter_6_0
				end
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

function var_0_0:IsPendingChoiceItem(arg_7_1)
	if not self then
		return false
	end

	local var_7_0 = ChatContentCfg[self.id]

	if not ChatContentCfg[self.id] or var_7_0.options == "" or #var_7_0.options <= 0 then
		return false
	end

	for iter_7_0, iter_7_1 in ipairs((arg_7_1 or nil) and (arg_7_1.save_list or {})) do
		if iter_7_1.content_id == self.id then
			return iter_7_1.state == 0
		end
	end

	if arg_7_1 and arg_7_1.current_content_id == self.id then
		return true
	end

	return self.state ~= MomoTalkConst.MSG_STATE.READED and self.state ~= "readed"
end

function var_0_0:HasSessionPendingContent()
	if not self or not self.id then
		return false
	end

	local var_8_0 = self

	if not self.save_list then
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
		if iter_9_1 then
			local var_9_2 = iter_9_1.id or iter_9_0

			if iter_9_1 then
				if MomoTalkData:IsActiveUnreadSession(iter_9_1, iter_9_0) then
					if var_9_0 then
						if (var_9_0.id or 0) < var_9_2 then
							var_9_0 = iter_9_1
						elseif MomoTalkData:IsNoRemindSession(iter_9_1, iter_9_0) then
							if var_9_1 then
								if (var_9_1.id or 0) < var_9_2 then
									var_9_1 = iter_9_1
								end
							end
						end
					end
				end
			end
		end
	end

	return var_9_0 or var_9_1
end

function var_0_0:GetDisplaySession(arg_10_1)
	local var_10_0 = var_0_0.GetPendingSession(self)

	if var_10_0 then
		return var_10_0
	end

	if not arg_10_1 then
		for iter_10_0, iter_10_1 in pairs(self or {}) do
			if iter_10_1 and ChatMessageCfg[iter_10_1.id] then
				arg_10_1 = (iter_10_1 and ChatMessageCfg[iter_10_1.id]).sender

				break
			end
		end
	end

	local var_10_1 = arg_10_1 and MomoTalkData:GetLatestSessionID(MomoTalkConst.DATA_TYPE.CHAT, arg_10_1) or nil

	if var_10_1 and self and self[var_10_1] then
		return self[var_10_1]
	end

	local var_10_2

	for iter_10_2, iter_10_3 in pairs(self or {}) do
		if iter_10_3 then
			if iter_10_3 then
				if var_10_2 then
					if (var_10_2.id or 0) < (iter_10_3.id or iter_10_2) then
						var_10_2 = iter_10_3
					end
				end
			end
		end
	end

	return var_10_2
end

function var_0_0:GetSessionPreviewContent()
	if not self or not self.id then
		return ""
	end

	local var_11_0 = self

	if not self.save_list then
		var_11_0 = clone(var_11_0)
		var_11_0.save_list = {}
	end

	local var_11_1 = var_0_0.GetListDataByMessAge(var_11_0) or {}

	return var_0_0.GetItemDisplayContent(var_11_1[var_0_0.GetShownCountBySessionProgress(var_11_1, var_11_0)], var_11_1[var_0_0.GetShownCountBySessionProgress(var_11_1, var_11_0)] and ChatContentCfg[var_11_1[var_0_0.GetShownCountBySessionProgress(var_11_1, var_11_0)].id]) or ""
end

function var_0_0:GetSessionFirstPreviewContent()
	if not self or not self.id then
		return ""
	end

	local var_12_0 = self

	if not self.save_list then
		var_12_0 = clone(var_12_0)
		var_12_0.save_list = {}
	end

	return var_0_0.GetItemDisplayContent((var_0_0.GetListDataByMessAge(var_12_0) or {})[1], (var_0_0.GetListDataByMessAge(var_12_0) or {})[1] and ChatContentCfg[(var_0_0.GetListDataByMessAge(var_12_0) or {})[1].id]) or ""
end

function var_0_0.GetSessionDisplayName(arg_13_0, arg_13_1)
	local var_13_1 = ChatHeroCfg[(ChatMessageCfg[arg_13_0 or 0] and ChatMessageCfg[arg_13_0 or 0].sender and ChatMessageCfg[arg_13_0 or 0].sender > 0 or nil) and ChatMessageCfg[arg_13_0 or 0].sender]

	if not ChatHeroCfg[(ChatMessageCfg[arg_13_0 or 0] and ChatMessageCfg[arg_13_0 or 0].sender and ChatMessageCfg[arg_13_0 or 0].sender > 0 or nil) and ChatMessageCfg[arg_13_0 or 0].sender] and arg_13_1 and arg_13_1 > 0 then
		var_13_1 = ChatHeroCfg[arg_13_1]
	end

	return (var_13_1 or nil) and (GetI18NText(var_13_1.name or "") or "")
end

function var_0_0:GetRecallTargetItem(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = tonumber(arg_14_3)

	if not var_14_0 and type(arg_14_3) == "table" then
		var_14_0 = tonumber(arg_14_3[1])
	end

	if var_14_0 then
		for iter_14_0 = arg_14_1 - 1, 1, -1 do
			local var_14_1 = self[iter_14_0]
			local var_14_2 = ChatContentCfg[(self[iter_14_0] or nil) and (var_14_1.id or 0)]
			local var_14_3 = var_0_0.GetItemDisplayType(var_14_1, ChatContentCfg[(self[iter_14_0] or nil) and (var_14_1.id or 0)])

			if ChatContentCfg[(self[iter_14_0] or nil) and (var_14_1.id or 0)] and not var_14_1.isRecallReplaced and var_14_2.id == var_14_0 and var_14_3 ~= MomoTalkConst.MSG_TYPE.RECALL and var_14_3 ~= MomoTalkConst.MSG_TYPE.NARRATE and var_14_3 ~= MomoTalkConst.MSG_TYPE.STICKER then
				return var_14_1
			end
		end
	end

	for iter_14_1 = arg_14_1 - 1, 1, -1 do
		local var_14_4 = self[iter_14_1]
		local var_14_5 = ChatContentCfg[(self[iter_14_1] or nil) and (var_14_4.id or 0)]
		local var_14_6 = var_0_0.GetItemDisplayType(var_14_4, ChatContentCfg[(self[iter_14_1] or nil) and (var_14_4.id or 0)])

		if ChatContentCfg[(self[iter_14_1] or nil) and (var_14_4.id or 0)] and not var_14_4.isRecallReplaced and var_14_5.spokesmen == arg_14_2 and var_14_6 ~= MomoTalkConst.MSG_TYPE.RECALL and var_14_6 ~= MomoTalkConst.MSG_TYPE.NARRATE and var_14_6 ~= MomoTalkConst.MSG_TYPE.STICKER then
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
		local var_15_1 = ChatContentCfg[(iter_15_3 or nil) and (iter_15_3.id or 0)]

		if ChatContentCfg[(iter_15_3 or nil) and (iter_15_3.id or 0)] and var_15_1.type == MomoTalkConst.MSG_TYPE.RECALL then
			iter_15_3.displayMsgType = MomoTalkConst.MSG_TYPE.RECALL
			iter_15_3.displayContent = var_15_1.content or ""

			local var_15_2 = var_0_0.GetRecallTargetItem(arg_15_0, iter_15_2, var_15_1.spokesmen, var_15_1.recall)

			if var_15_2 then
				var_15_2.displayMsgType = MomoTalkConst.MSG_TYPE.TEXT
				var_15_2.displayContent = GetTips("momotalk_recall")
				var_15_2.isRecallReplaced = true
			end
		end
	end

	return arg_15_0
end

function var_0_0:DONext()
	if ChatContentCfg[self[#self].id] and ChatContentCfg[self[#self].id].next_content_list ~= "" and #ChatContentCfg[self[#self].id].next_content_list == 1 then
		table.insert(self, {
			state = "readed",
			id = ChatContentCfg[self[#self].id].next_content_list[1],
			messageID = self[#self].messageID
		})
	end

	return var_0_0.ApplyRecallDisplayRules(self)
end

function var_0_0:CheckList()
	local var_17_0 = self[#self]
	local var_17_1 = ChatContentCfg[(self[#self] or nil) and (var_17_0.id or 0)]

	return (ChatContentCfg[(self[#self] or nil) and (var_17_0.id or 0)] and var_17_1.options ~= "" and #var_17_1.options > 0 or nil) and "tab", var_17_0
end

function var_0_0.GetBgData()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.MOMOTALK_CHATBG] or {}) do
		local var_18_1 = MomoTalkData:GetBgData(iter_18_1)
		local var_18_2 = {
			id = iter_18_1
		}

		if var_18_1 then
			var_18_2.state = var_18_1.state or 0
		end

		table.insert(var_18_0, var_18_2)
	end

	return var_18_0
end

function var_0_0.GetBubleData()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_TYPE.CHAT_BUBBLE] or {}) do
		table.insert(var_19_0, {
			state = 0,
			id = iter_19_1
		})
	end

	return var_19_0
end

function var_0_0.GetHeadData()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(ChatMonoAvatarCfg.all or {}) do
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

	local var_21_2 = string.gsub(var_21_0.icon, "%.png$", "")

	if not string.find(var_21_2, "TextureConfig/", 1, true) then
		var_21_2 = "TextureConfig/Momotalk/" .. var_21_2
	end

	return pureGetSpriteWithoutAtlas(var_21_2)
end

function var_0_0.GetHeroIcon(arg_22_0)
	return pureGetSpriteWithoutAtlas(arg_22_0)
end

function var_0_0:GetStickerKey()
	local var_23_0

	if self then
		var_23_0 = self.url or ""

		if var_23_0 == "" then
			return nil
		end
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
		local var_24_4

		if ChatStickerCfg[iter_24_1] then
			var_24_4 = var_24_3.icon or ""
		end

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

function var_0_0:GetImageSpritePath()
	local var_25_0

	if self then
		var_25_0 = self.url or ""

		if var_25_0 == "" then
			return nil
		end
	end

	local var_25_1 = string.gsub(var_25_0, "%.png$", "")

	var_25_1 = string.match(var_25_1, "([^/]+)$") or var_25_1

	if self and self.type == MomoTalkConst.MSG_TYPE.STICKER then
		local var_25_2 = var_0_0.GetStickerCfg(self)

		if var_25_2 and var_25_2.type == 1 then
			return "TextureConfig/Chat/ChatSticker/" .. var_25_2.icon
		end

		return nil
	end

	return "TextureConfig/Momotalk/" .. var_25_1
end

return var_0_0
