local var_0_0 = {}

local function var_0_1(arg_1_0)
	return arg_1_0.unlock == 1
end

local function var_0_2(arg_2_0)
	local var_2_0 = manager.time:GetServerTime()

	return arg_2_0.lasted_time == 0 or var_2_0 < arg_2_0.lasted_time
end

local function var_0_3(arg_3_0)
	return nullable(ItemCfg, arg_3_0, "sub_type")
end

function var_0_0.IsPortraitHide(arg_4_0)
	local var_4_0 = arg_4_0.id
	local var_4_1 = var_0_1(arg_4_0)
	local var_4_2 = var_0_2(arg_4_0)

	if HideInfoData:GetHeadIconHideList()[var_4_0] then
		return true
	end

	local var_4_3 = var_0_3(var_4_0)

	if var_4_3 == ItemConst.ITEM_SUB_TYPE.NORMAL_PORTRAIT then
		local var_4_4 = SkinCfg.get_id_list_by_portrait[var_4_0]

		if var_4_4 then
			for iter_4_0, iter_4_1 in ipairs(var_4_4) do
				if HeroTools.GetSkinIsHide(iter_4_1) then
					return true
				end
			end
		end
	elseif var_4_3 == ItemConst.ITEM_SUB_TYPE.SPECIAL_PORTRAIT then
		return not var_4_1 or not var_4_2
	end

	return false
end

function var_0_0.GetPortraitList()
	local var_5_0 = {}
	local var_5_1 = PlayerData:GetPortraitList()

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_2 = PlayerData:GetPortrait(iter_5_1)

		if not var_0_0.IsPortraitHide(var_5_2) then
			table.insert(var_5_0, var_5_2)
		end
	end

	return var_5_0
end

function var_0_0.IsFrameHide(arg_6_0)
	local var_6_0 = arg_6_0.id
	local var_6_1 = var_0_1(arg_6_0)
	local var_6_2 = var_0_2(arg_6_0)
	local var_6_3 = var_0_3(var_6_0)

	if var_6_3 == ItemConst.ITEM_SUB_TYPE.FRAME_LINK then
		return not var_6_1
	elseif var_6_3 == ItemConst.ITEM_SUB_TYPE.FRAME_LIMIT or var_6_3 == ItemConst.ITEM_SUB_TYPE.FRAME_LIMIT_COVER then
		return not var_6_1 or not var_6_2
	end

	return false
end

function var_0_0.GetFrameList()
	local var_7_0 = {}
	local var_7_1 = PlayerData:GetFrameList()

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_2 = PlayerData:GetFrame(iter_7_1)

		if not var_0_0.IsFrameHide(var_7_2) then
			table.insert(var_7_0, var_7_2)
		end
	end

	return var_7_0
end

function var_0_0.IsCardBgHide(arg_8_0)
	local var_8_0 = arg_8_0.id
	local var_8_1 = var_0_1(arg_8_0)
	local var_8_2 = var_0_2(arg_8_0)

	if var_0_3(var_8_0) == ItemConst.ITEM_SUB_TYPE.CARD_BG_LIMIT then
		return not var_8_1 or not var_8_2
	end

	return false
end

function var_0_0.GetCardBgList()
	local var_9_0 = {}
	local var_9_1 = PlayerData:GetCardBgList()

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_2 = PlayerData:GetCardBg(iter_9_1)

		if not var_0_0.IsCardBgHide(var_9_2) then
			table.insert(var_9_0, var_9_2)
		end
	end

	return var_9_0
end

function var_0_0.IsChatBubbleHide(arg_10_0)
	local var_10_0 = arg_10_0.id
	local var_10_1 = var_0_1(arg_10_0)
	local var_10_2 = var_0_2(arg_10_0)
	local var_10_3 = var_0_3(var_10_0)

	if var_10_3 == ItemConst.ITEM_SUB_TYPE.CHAT_BUBBLE_SPECIAL then
		return not var_10_1
	elseif var_10_3 == ItemConst.ITEM_SUB_TYPE.CHAT_BUBBLE_LIMIT then
		return not var_10_1 or not var_10_2
	end

	return false
end

function var_0_0.GetChatBubbleList()
	local var_11_0 = {}
	local var_11_1 = PlayerData:GetChatBubbleList()

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		local var_11_2 = PlayerData:GetChatBubble(iter_11_1)

		if not var_0_0.IsChatBubbleHide(var_11_2) then
			table.insert(var_11_0, var_11_2)
		end
	end

	return var_11_0
end

return var_0_0
