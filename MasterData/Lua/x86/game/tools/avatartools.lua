local var_0_0 = {}

local function var_0_1(arg_1_0)
	return arg_1_0.unlock == 1
end

local function var_0_2(arg_2_0)
	return arg_2_0.lasted_time == 0 or manager.time:GetServerTime() < arg_2_0.lasted_time
end

local function var_0_3(arg_3_0)
	return nullable(ItemCfg, arg_3_0, "sub_type")
end

function var_0_0:IsPortraitHide()
	local var_4_0 = var_0_1(self)
	local var_4_1 = var_0_2(self)

	if HideInfoData:GetHeadIconHideList()[self.id] then
		return true
	end

	local var_4_2 = var_0_3(self.id)

	if var_4_2 == ItemConst.ITEM_SUB_TYPE.NORMAL_PORTRAIT then
		if SkinCfg.get_id_list_by_portrait[self.id] then
			for iter_4_0, iter_4_1 in ipairs(SkinCfg.get_id_list_by_portrait[self.id]) do
				if HeroTools.GetSkinIsHide(iter_4_1) then
					return true
				end
			end
		end
	elseif var_4_2 == ItemConst.ITEM_SUB_TYPE.SPECIAL_PORTRAIT then
		return not var_4_0 or not var_4_1
	end

	return false
end

function var_0_0.GetPortraitList()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs((PlayerData:GetPortraitList())) do
		local var_5_1 = PlayerData:GetPortrait(iter_5_1)

		if not var_0_0.IsPortraitHide(var_5_1) then
			table.insert(var_5_0, var_5_1)
		end
	end

	return var_5_0
end

function var_0_0:IsFrameHide()
	local var_6_0 = var_0_1(self)
	local var_6_1 = var_0_2(self)
	local var_6_2 = var_0_3(self.id)

	if var_6_2 == ItemConst.ITEM_SUB_TYPE.FRAME_LINK then
		return not var_6_0
	elseif var_6_2 == ItemConst.ITEM_SUB_TYPE.FRAME_LIMIT or var_6_2 == ItemConst.ITEM_SUB_TYPE.FRAME_LIMIT_COVER then
		return not var_6_0 or not var_6_1
	end

	return false
end

function var_0_0.GetFrameList()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs((PlayerData:GetFrameList())) do
		local var_7_1 = PlayerData:GetFrame(iter_7_1)

		if not var_0_0.IsFrameHide(var_7_1) then
			table.insert(var_7_0, var_7_1)
		end
	end

	return var_7_0
end

function var_0_0:IsCardBgHide()
	if var_0_3(self.id) == ItemConst.ITEM_SUB_TYPE.CARD_BG_LIMIT then
		return not var_0_1(self) or not var_0_2(self)
	end

	return false
end

function var_0_0.GetCardBgList()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs((PlayerData:GetCardBgList())) do
		local var_9_1 = PlayerData:GetCardBg(iter_9_1)

		if not var_0_0.IsCardBgHide(var_9_1) then
			table.insert(var_9_0, var_9_1)
		end
	end

	return var_9_0
end

function var_0_0:IsChatBubbleHide()
	local var_10_0 = var_0_1(self)
	local var_10_1 = var_0_2(self)
	local var_10_2 = var_0_3(self.id)

	if var_10_2 == ItemConst.ITEM_SUB_TYPE.CHAT_BUBBLE_SPECIAL then
		return not var_10_0
	elseif var_10_2 == ItemConst.ITEM_SUB_TYPE.CHAT_BUBBLE_LIMIT then
		return not var_10_0 or not var_10_1
	end

	return false
end

function var_0_0.GetChatBubbleList()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs((PlayerData:GetChatBubbleList())) do
		local var_11_1 = PlayerData:GetChatBubble(iter_11_1)

		if not var_0_0.IsChatBubbleHide(var_11_1) then
			table.insert(var_11_0, var_11_1)
		end
	end

	return var_11_0
end

return var_0_0
