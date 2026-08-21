local var_0_0 = singletonClass("PlayerData")

var_0_0.INVALID_PLAYER = "0"

local var_0_1 = {
	originalLevel = 1,
	show_hero_flag = 1,
	userLevel = 10,
	userID = 1,
	show_sticker_flag = 1,
	is_changed_nick = 0,
	likes = 0,
	plot_progress = 0,
	hero_num = 0,
	poster_girl = 1084,
	register_timestamp = 0,
	icon_frame = 2001,
	ip = "",
	extra_chang_nick_time = 0,
	timestamp = 0,
	card_bg_id = 0,
	total_exp = 0,
	birthday_day = 0,
	remain_exp = 0,
	birthday_month = 0,
	nick = "",
	signUserId = "",
	portrait = 1084,
	sign = "",
	all_suit_rewarded = {},
	all_foreground_list = {},
	all_background_list = {},
	all_sticker_list = {},
	sticker_show_info = {},
	unlocked_portraits = {},
	icon_frame_list = {},
	heroes = {},
	storylist = {},
	levelUpInfos = {},
	likes_list = {},
	today_send_like = {},
	card_background_list = {},
	tag_info_list = {},
	used_tag_list = {},
	used_chat_buddle_id = GameSetting.profile_chat_bubble_default.value[1],
	chat_bubble_unlock_list = {}
}

function var_0_0.Init(arg_1_0)
	var_0_1.levelUpInfos = {}
	arg_1_0.cacheHeroSkinList_ = {}
	arg_1_0.cacheHeroSkin_ = {}
	arg_1_0.clearHeroFlag_ = false
	arg_1_0.selectSkinList_ = {}
	arg_1_0.heroAssistantVoice_ = nil
	arg_1_0.deskMode_ = false
	arg_1_0.deskRandomMode_ = false
end

local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {}
local var_0_6 = {}
local var_0_7 = {}
local var_0_8 = {}
local var_0_9 = {}
local var_0_10 = {}
local var_0_11 = {}
local var_0_12 = {}
local var_0_13 = {}
local var_0_14 = {}
local var_0_15 = {}
local var_0_16 = {}
local var_0_17 = {}
local var_0_18 = {}

function var_0_0.PlayInfoInit(arg_2_0, arg_2_1)
	var_0_1.total_exp = arg_2_1.total_exp
	var_0_1.userLevel, var_0_1.remain_exp = LvTools.CheckExp(1, var_0_1.total_exp, "user_level_exp")
	var_0_1.is_changed_nick = arg_2_1.is_changed_nick
	var_0_1.extra_chang_nick_time = arg_2_1.system_change_nick_times or 0

	if var_0_1.nick ~= "" and var_0_1.nick ~= arg_2_1.nick then
		manager.notify:CallUpdateFunc(CHANGE_NAME, arg_2_1)
	end

	var_0_1.nick = arg_2_1.nick
	var_0_1.hero_num = arg_2_1.hero_num
	var_0_1.plot_progress = arg_2_1.plot_progress

	manager.notify:Invoke(PLAYER_MODIFIED)

	if var_0_1.ip == "" then
		var_0_1.ip = GetTips("IP_UNKNOWN")
	end
end

function var_0_0.SetPlayerIP(arg_3_0, arg_3_1)
	var_0_1.ip = arg_3_1.ip_location or GetTips("IP_UNKNOWN")
end

function var_0_0.SetPlayerBirthday(arg_4_0, arg_4_1)
	var_0_1.birthday_month = arg_4_1.month
	var_0_1.birthday_day = arg_4_1.day

	manager.redPoint:setTip(RedPointConst.BRITHDAY, arg_4_1.month == 0 and 1 or 0)
end

function var_0_0.GetPlayerBrithday(arg_5_0)
	return var_0_1.birthday_month, var_0_1.birthday_day
end

function var_0_0.GetPlayerInfo(arg_6_0)
	var_0_1.icon_frame = arg_6_0:GetCurFrame()
	var_0_1.card_bg_id = arg_6_0:GetCurCardBg()

	return var_0_1
end

function var_0_0.GetStoryList(arg_7_0)
	return var_0_1.storylist
end

function var_0_0.GetlevelUpInfos(arg_8_0)
	return var_0_1.levelUpInfos and deepClone(var_0_1.levelUpInfos) or {}
end

function var_0_0.UserBaseInfoInit(arg_9_0, arg_9_1)
	var_0_1.userID = arg_9_1.userID
	var_0_1.register_timestamp = arg_9_1.register_timestamp
	var_0_1.signUserId = arg_9_1.uid_sign
end

function var_0_0.UserLoginTimestampInit(arg_10_0, arg_10_1)
	var_0_1.timestamp = arg_10_1.timestamp
end

function var_0_0.PlayerProtraitChange(arg_11_0, arg_11_1)
	var_0_1.portrait = arg_11_1.portrait
end

function var_0_0.PlayerNicknameChange(arg_12_0, arg_12_1)
	var_0_1.nick = arg_12_1
end

function var_0_0.GetExtraChangeNickTime(arg_13_0)
	return var_0_1.extra_chang_nick_time
end

function var_0_0.UpdateNameChangeInfo(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	var_0_1.extra_chang_nick_time = arg_14_1.system_change_nick_times or 0
	var_0_1.is_changed_nick = arg_14_1.is_changed_nick or 0
end

function var_0_0.GetIP(arg_15_0)
	return var_0_1.ip
end

function var_0_0.EXPChange(arg_16_0, arg_16_1)
	var_0_1.total_exp = arg_16_1

	local var_16_0 = var_0_1.userLevel

	var_0_1.userLevel, var_0_1.remain_exp = LvTools.CheckExp(1, var_0_1.total_exp, "user_level_exp")

	local var_16_1 = var_0_1.userLevel

	if var_16_0 ~= var_16_1 then
		manager.notify:Invoke(PLAYER_LEVEL_UP, var_16_0, var_16_1)
		ChapterResidentTools.SetNewTag()
		SDKTools.SetDefaultPublicAttribute()
		SendMessageManagerToSDK("role_level", {
			level = var_16_1
		})
	end
end

function var_0_0.PlayerCardInit(arg_17_0, arg_17_1)
	var_0_1.sign = arg_17_1.sign
	var_0_1.heroes = cleanProtoTable(arg_17_1.heroes)
	var_0_1.all_suit_rewarded = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1.admitted_suit_reaward_list) do
		var_0_1.all_suit_rewarded[iter_17_1] = true
	end

	var_0_1.all_foreground_list = cleanProtoTable(arg_17_1.all_foreground_list)
	var_0_1.all_background_list = cleanProtoTable(arg_17_1.all_background_list)
	var_0_1.show_sticker_flag = arg_17_1.sticker_background ~= 0 and arg_17_1.sticker_background or GameSetting.sticker_background_default.value[1]
	var_0_1.all_sticker_list = cleanProtoTable(arg_17_1.all_sticker_list)
	var_0_1.unlocked_portraits = cleanProtoTable(arg_17_1.icon_list, {
		"id",
		"lasted_time"
	})
	var_0_1.icon_frame_list = cleanProtoTable(arg_17_1.icon_frame_list, {
		"id",
		"lasted_time"
	})
	var_0_1.likes = arg_17_1.likes
	var_0_1.likes_list = cleanProtoTable(arg_17_1.info_list, {
		"id",
		"time"
	})
	var_0_1.today_send_like = cleanProtoTable(arg_17_1.today_send_like)
	var_0_1.card_background_list = cleanProtoTable(arg_17_1.information_background_list, {
		"id",
		"lasted_time"
	})
	var_0_1.tag_info_list = cleanProtoTable(arg_17_1.tag_info_list, {
		"id",
		"lasted_time",
		"obtain_time"
	})
	var_0_1.used_tag_list = cleanProtoTable(arg_17_1.used_tag_list or {})
	var_0_1.card_bg_id = arg_17_1.information_background_id
	var_0_1.used_chat_buddle_id = arg_17_1.chat_bubble or GameSetting.profile_chat_bubble_default.value[1]
	var_0_1.chat_bubble_unlock_list = cleanProtoTable(arg_17_1.chat_bubble_list, {
		"id",
		"lasted_time"
	})
	var_0_1.game_icon = cleanProtoTable(arg_17_1.game_icon, {
		"id",
		"lasted_time"
	})

	if arg_17_1.poster_girl and arg_17_1.poster_girl ~= 0 then
		var_0_1.poster_girl = arg_17_1.poster_girl
	else
		var_0_1.poster_girl = 1084
	end

	if arg_17_1.icon and arg_17_1.icon ~= 0 and arg_17_1.icon ~= 1 then
		var_0_1.portrait = arg_17_1.icon
	else
		var_0_1.portrait = GameSetting.profile_avatar_default.value[1]
	end

	if arg_17_1.icon_frame and arg_17_1.icon_frame ~= 0 and arg_17_1.icon_frame ~= 1 then
		var_0_1.icon_frame = arg_17_1.icon_frame
	else
		var_0_1.icon_frame = GameSetting.profile_avatar_frame_default.value[1]
	end

	var_0_0:InitStickerList()

	var_0_1.sticker_show_info = var_0_0:InitStickerShowList(arg_17_1.sticker_show_info or {})

	var_0_0:InitPortraitList()
	var_0_0:InitFrameList()
	var_0_0:InitChatBubbleList()
	var_0_0:InitCardBgList()
	var_0_0:InitTagInfoList()
	var_0_0:SetPureModeData(arg_17_1.table_setting)
	var_0_0:SetPureModeComponentData(arg_17_1.table_setting_module)
end

function var_0_0.InitStickerShowList(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		var_18_0[iter_18_1.page_id] = {
			foreground = iter_18_1.foreground or 0,
			sticker = {},
			hierarchy = {}
		}

		if iter_18_1.foreground and iter_18_1.foreground ~= 0 then
			var_0_3[iter_18_1.foreground].page = iter_18_1.page_id
		end

		for iter_18_2, iter_18_3 in ipairs(iter_18_1.sticker_display_info) do
			var_18_0[iter_18_1.page_id].sticker[iter_18_3.sticker_id] = {
				positionX = iter_18_3.location_x,
				positionY = iter_18_3.location_y,
				rotation = iter_18_3.rotate,
				scale = iter_18_3.scale
			}
			var_18_0[iter_18_1.page_id].hierarchy[iter_18_3.layer] = iter_18_3.sticker_id
			var_0_5[iter_18_3.sticker_id].page = iter_18_1.page_id
		end
	end

	if not arg_18_2 then
		for iter_18_4, iter_18_5 in ipairs(arg_18_0:GetStickerBgList()) do
			if not var_18_0[iter_18_5] then
				var_18_0[iter_18_5] = {
					foreground = 0,
					sticker = {},
					hierarchy = {}
				}
			end
		end
	end

	return var_18_0
end

function var_0_0.CheckOverdueRepeat(arg_19_0, arg_19_1, arg_19_2)
	for iter_19_0, iter_19_1 in ipairs(arg_19_2) do
		if iter_19_1.id == arg_19_1 then
			return true
		end
	end

	return false
end

function var_0_0.InitOverdueFrameList(arg_20_0, arg_20_1)
	if #arg_20_1 > 0 then
		for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
			if not arg_20_0:CheckOverdueRepeat(iter_20_1.id, var_0_8) then
				local var_20_0 = iter_20_1.id
				local var_20_1 = iter_20_1.num
				local var_20_2 = iter_20_1.time_valid

				table.insert(var_0_8, {
					id = var_20_0,
					num = var_20_1,
					timeValid = var_20_2
				})
			end
		end
	end
end

function var_0_0.InitOverduePortraitList(arg_21_0, arg_21_1)
	if #arg_21_1 > 0 then
		for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
			if not arg_21_0:CheckOverdueRepeat(iter_21_1.id, var_0_9) then
				local var_21_0 = iter_21_1.id
				local var_21_1 = iter_21_1.num
				local var_21_2 = iter_21_1.time_valid

				table.insert(var_0_9, {
					id = var_21_0,
					num = var_21_1,
					timeValid = var_21_2
				})
			end
		end
	end
end

function var_0_0.InitOverdueChatBubbleList(arg_22_0, arg_22_1)
	if #arg_22_1 > 0 then
		for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
			if not arg_22_0:CheckOverdueRepeat(iter_22_1.id, var_0_10) then
				local var_22_0 = iter_22_1.id
				local var_22_1 = iter_22_1.num
				local var_22_2 = iter_22_1.time_valid

				table.insert(var_0_10, {
					id = var_22_0,
					num = var_22_1,
					timeValid = var_22_2
				})
			end
		end
	end
end

function var_0_0.InitOverdueCardBgList(arg_23_0, arg_23_1)
	if #arg_23_1 > 0 then
		for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
			if not arg_23_0:CheckOverdueRepeat(iter_23_1.id, var_0_15) then
				local var_23_0 = {
					num = 1,
					id = iter_23_1.id,
					timeValid = iter_23_1.time_valid
				}

				table.insert(var_0_15, var_23_0)
			end
		end
	end
end

function var_0_0.InitOverdueTagList(arg_24_0, arg_24_1)
	if #arg_24_1 > 0 then
		for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
			if not arg_24_0:CheckOverdueRepeat(iter_24_1.id, var_0_17) then
				local var_24_0 = {
					num = 1,
					id = iter_24_1.id,
					time_valid = iter_24_1.time_valid
				}

				table.insert(var_0_17, var_24_0)
			end
		end
	end
end

function var_0_0.GetOverdueFrameList(arg_25_0)
	return var_0_8
end

function var_0_0.GetOverduePortraitList(arg_26_0)
	return var_0_9
end

function var_0_0.GetOverdueChatBubbleList(arg_27_0)
	return var_0_10
end

function var_0_0.GetOverdueCardBgList(arg_28_0)
	return var_0_15
end

function var_0_0.PlayerSignChange(arg_29_0, arg_29_1)
	var_0_1.sign = arg_29_1
end

function var_0_0.PlayerShowHeroChange(arg_30_0, arg_30_1)
	var_0_1.heroes = cleanProtoTable(arg_30_1)
end

function var_0_0.PlayerPosterGirlChange(arg_31_0, arg_31_1)
	var_0_1.poster_girl = arg_31_1
end

function var_0_0.StoryInit(arg_32_0, arg_32_1)
	var_0_1.storylist = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
		var_0_1.storylist[iter_32_1] = true
	end
end

function var_0_0.StoryModify(arg_33_0, arg_33_1)
	var_0_1.storylist[arg_33_1] = true
end

function var_0_0.PlayerOriginalLevel(arg_34_0, arg_34_1)
	var_0_1.originalLevel = arg_34_1.user_level
end

function var_0_0.ChangeLevel(arg_35_0, arg_35_1)
	if not var_0_1.levelUpInfos then
		var_0_1.levelUpInfos = {}
	end

	local var_35_0 = arg_35_1.fromLevel
	local var_35_1 = arg_35_1.toLevel

	if #var_0_1.levelUpInfos > 0 then
		var_35_0 = math.min(var_0_1.levelUpInfos[1].fromLevel, var_35_0)
		var_35_1 = math.max(var_0_1.levelUpInfos[1].toLevel, var_35_1)
	end

	var_0_1.levelUpInfos[1] = {
		fromLevel = var_35_0,
		toLevel = var_35_1
	}
end

function var_0_0.LevelUpFinish(arg_36_0, arg_36_1)
	if var_0_1.levelUpInfos then
		while table.getn(var_0_1.levelUpInfos) > 0 do
			table.remove(var_0_1.levelUpInfos, 1)
		end
	end
end

function var_0_0.InitModuleSwitchData(arg_37_0, arg_37_1)
	return
end

function var_0_0.GetModuleSwitchData(arg_38_0, arg_38_1)
	return var_0_2[arg_38_1]
end

function var_0_0.InitStickerList(arg_39_0)
	var_0_5 = {}
	var_0_3 = {}
	var_0_4 = {}

	for iter_39_0, iter_39_1 in ipairs(ProfileDecorateItemCfg.all) do
		local var_39_0 = ProfileDecorateItemCfg[iter_39_1]

		if var_39_0.item_type == 4 then
			var_0_4[iter_39_1] = {
				suit = 0,
				lock = true,
				page = iter_39_1
			}
		elseif var_39_0.item_type == 5 then
			var_0_5[iter_39_1] = {
				suit = 0,
				lock = true,
				page = 0
			}
		elseif var_39_0.item_type == 6 then
			var_0_3[iter_39_1] = {
				suit = 0,
				lock = true,
				page = 0
			}
		end
	end

	for iter_39_2, iter_39_3 in ipairs(var_0_1.all_sticker_list) do
		if var_0_5[iter_39_3] then
			var_0_5[iter_39_3].lock = false
		end
	end

	for iter_39_4, iter_39_5 in ipairs(var_0_1.all_foreground_list) do
		if var_0_3[iter_39_5] then
			var_0_3[iter_39_5].lock = false
		end
	end

	for iter_39_6, iter_39_7 in ipairs(var_0_1.all_background_list) do
		if var_0_4[iter_39_7] then
			var_0_4[iter_39_7].lock = false
		end
	end

	for iter_39_8, iter_39_9 in ipairs(StickerSuitCfg.all) do
		local var_39_1 = StickerSuitCfg[iter_39_9]

		for iter_39_10, iter_39_11 in ipairs(var_39_1.content) do
			local var_39_2 = ProfileDecorateItemCfg[iter_39_11]

			if var_39_2.item_type == 4 then
				var_0_4[iter_39_11].suit = iter_39_9
			elseif var_39_2.item_type == 5 then
				var_0_5[iter_39_11].suit = iter_39_9
			elseif var_39_2.item_type == 6 then
				var_0_3[iter_39_11].suit = iter_39_9
			end
		end
	end
end

local function var_0_19(arg_40_0)
	local var_40_0 = manager.time:GetServerTime()

	return arg_40_0.lasted_time == 0 or var_40_0 < arg_40_0.lasted_time
end

function var_0_0.InitPortraitList(arg_41_0)
	var_0_6 = {}
	var_0_6.get_portrait_id_list = {}

	local var_41_0 = ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.PORTRAIT]

	for iter_41_0, iter_41_1 in ipairs(var_41_0) do
		var_0_6[iter_41_1] = {
			lasted_time = 0,
			unlock = 0,
			id = iter_41_1
		}

		table.insert(var_0_6.get_portrait_id_list, iter_41_1)
	end

	for iter_41_2, iter_41_3 in ipairs(var_0_1.unlocked_portraits) do
		local var_41_1 = iter_41_3.id

		if var_0_19(iter_41_3) then
			var_0_6[var_41_1].unlock = 1
			var_0_6[var_41_1].lasted_time = iter_41_3.lasted_time
		end
	end
end

function var_0_0.InitChatBubbleList(arg_42_0)
	var_0_13 = {}
	var_0_13.get_chatBubble_id_list = {}

	local var_42_0 = ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.CHAT_BUBBLE]

	for iter_42_0, iter_42_1 in ipairs(var_42_0) do
		var_0_13[iter_42_1] = {
			lasted_time = 0,
			unlock = 0,
			id = iter_42_1
		}

		if iter_42_1 == GameSetting.profile_chat_bubble_default.value[1] then
			var_0_13[iter_42_1].unlock = 1
		end

		table.insert(var_0_13.get_chatBubble_id_list, iter_42_1)
	end

	for iter_42_2, iter_42_3 in ipairs(var_0_1.chat_bubble_unlock_list) do
		local var_42_1 = iter_42_3.id
		local var_42_2 = manager.time:GetServerTime()

		if var_0_19(iter_42_3) then
			var_0_13[var_42_1].unlock = 1
			var_0_13[var_42_1].lasted_time = iter_42_3.lasted_time
		end
	end
end

function var_0_0.InitFrameList(arg_43_0)
	var_0_7 = {}
	var_0_7.get_frame_id_list = {}

	local var_43_0 = ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.FRAME]

	for iter_43_0, iter_43_1 in ipairs(var_43_0) do
		var_0_7[iter_43_1] = {
			lasted_time = 0,
			unlock = 0,
			id = iter_43_1
		}

		table.insert(var_0_7.get_frame_id_list, iter_43_1)
	end

	local var_43_1

	for iter_43_2, iter_43_3 in ipairs(var_0_1.icon_frame_list) do
		local var_43_2 = iter_43_3.id

		if var_0_19(iter_43_3) then
			var_0_7[var_43_2].unlock = 1
			var_0_7[var_43_2].lasted_time = iter_43_3.lasted_time
		end
	end
end

function var_0_0.InitCardBgList(arg_44_0)
	var_0_14 = {}
	var_0_14.get_cardBg_id_list = {}

	local var_44_0 = ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.CARD_BG]

	for iter_44_0, iter_44_1 in ipairs(var_44_0) do
		var_0_14[iter_44_1] = {
			lasted_time = 0,
			unlock = 0,
			id = iter_44_1
		}

		table.insert(var_0_14.get_cardBg_id_list, iter_44_1)
	end

	for iter_44_2, iter_44_3 in ipairs(var_0_1.card_background_list) do
		local var_44_1 = iter_44_3.id

		if var_0_19(iter_44_3) then
			var_0_14[var_44_1].unlock = 1
			var_0_14[var_44_1].lasted_time = iter_44_3.lasted_time
		end
	end
end

function var_0_0.InitTagInfoList(arg_45_0)
	var_0_16 = {}
	var_0_16.get_tagList_id_list = {}

	local var_45_0 = ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.TAG]

	for iter_45_0, iter_45_1 in ipairs(var_45_0) do
		var_0_16[iter_45_1] = {
			obtain_time = 0,
			lasted_time = 0,
			unlock = 0,
			id = iter_45_1
		}

		table.insert(var_0_16.get_tagList_id_list, iter_45_1)
	end

	for iter_45_2, iter_45_3 in ipairs(var_0_1.tag_info_list) do
		local var_45_1 = iter_45_3.id

		if var_0_19(iter_45_3) then
			var_0_16[var_45_1].unlock = 1
			var_0_16[var_45_1].lasted_time = iter_45_3.lasted_time
			var_0_16[var_45_1].obtain_time = iter_45_3.obtain_time
		end
	end
end

function var_0_0.InItReceivedSkinGift(arg_46_0, arg_46_1)
	var_0_12 = {}
	var_0_12.all = {}

	for iter_46_0, iter_46_1 in ipairs(arg_46_1.list) do
		var_0_12[iter_46_1.skin_id] = iter_46_1.gift_acquire

		table.insert(var_0_12.all, iter_46_1.skin_id)
	end
end

function var_0_0.ReceiveSkinGift(arg_47_0, arg_47_1)
	var_0_12[arg_47_1] = true

	if not table.indexof(var_0_12.all, arg_47_1) then
		table.insert(var_0_12.all, arg_47_1)
	end
end

function var_0_0.IsNotReceived(arg_48_0, arg_48_1)
	if not var_0_12[arg_48_1] or var_0_12[arg_48_1] == false then
		return true
	end

	return false
end

function var_0_0.ChangeHeros(arg_49_0, arg_49_1)
	for iter_49_0 = 1, 3 do
		var_0_1.heroes[iter_49_0] = arg_49_1[iter_49_0]
	end
end

function var_0_0.ChangeHeroShow(arg_50_0, arg_50_1)
	var_0_1.show_hero_flag = arg_50_1
end

function var_0_0.ChangeStickerShow(arg_51_0, arg_51_1)
	var_0_1.show_sticker_flag = arg_51_1
end

function var_0_0.ChangePortrait(arg_52_0, arg_52_1)
	var_0_1.portrait = arg_52_1
end

function var_0_0.ChangeFrameIcon(arg_53_0, arg_53_1)
	var_0_1.icon_frame = arg_53_1
end

function var_0_0.GetHeroShowList(arg_54_0)
	return var_0_1.heroes
end

function var_0_0.GetCurPortrait(arg_55_0)
	return var_0_1.portrait
end

function var_0_0.GetCurFrame(arg_56_0)
	local var_56_0 = var_0_7[var_0_1.icon_frame]

	if var_56_0 and var_56_0.lasted_time > 0 and var_56_0.unlock == 1 and var_56_0.lasted_time < manager.time:GetServerTime() then
		arg_56_0:RefreshFrameList(function()
			return var_0_1.icon_frame
		end)
	end

	return var_0_1.icon_frame
end

function var_0_0.GetCurCardBg(arg_58_0)
	local var_58_0 = var_0_14[var_0_1.card_bg_id]

	if var_58_0 and var_58_0.unlock == 1 and var_58_0.lasted_time > 0 and var_58_0.lasted_time < manager.time:GetServerTime() then
		arg_58_0:LockCardBg(var_0_1.card_bg_id)

		local var_58_1 = GameSetting.profile_business_card_default.value[1]

		PlayerAction.ChangeCardBg(var_58_1)

		return var_0_1.card_bg_id
	end

	return var_0_1.card_bg_id
end

function var_0_0.CheckStickerSuitReward(arg_59_0, arg_59_1)
	if var_0_1.all_suit_rewarded[arg_59_1] then
		return true
	end

	return false
end

function var_0_0.AddStickerSuitReward(arg_60_0, arg_60_1)
	var_0_1.all_suit_rewarded[arg_60_1] = true

	manager.redPoint:setTip(RedPointConst.CUSTOM_STICKER_SUIT_REWARD .. "_" .. arg_60_1, 0)
end

function var_0_0.GetStickerEditData(arg_61_0)
	return var_0_1.sticker_show_info
end

function var_0_0.SetStickerEditData(arg_62_0, arg_62_1)
	var_0_1.sticker_show_info = arg_62_1
end

local var_0_20
local var_0_21

local function var_0_22(arg_63_0, arg_63_1)
	local var_63_0 = ItemCfg[arg_63_0]

	return var_63_0 and var_63_0.sub_type == arg_63_1
end

function var_0_0.GetStickerList(arg_64_0, arg_64_1, arg_64_2)
	local var_64_0 = {}

	for iter_64_0, iter_64_1 in pairs(var_0_5) do
		if not (var_0_22(iter_64_0, ItemConst.ITEM_SUB_TYPE.SPECIAL_STICKER) and iter_64_1.lock) then
			if arg_64_2 then
				if iter_64_1.lock then
					table.insert(var_64_0, iter_64_0)
				end
			elseif arg_64_1 or not iter_64_1.lock then
				table.insert(var_64_0, iter_64_0)
			end
		end
	end

	return var_64_0
end

function var_0_0.GetSticker(arg_65_0, arg_65_1)
	return var_0_5[arg_65_1]
end

function var_0_0.SetStickerPage(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = var_0_5[arg_66_1]

	if var_66_0 then
		var_66_0.page = arg_66_2
	end
end

function var_0_0.GetStickerBgList(arg_67_0, arg_67_1, arg_67_2)
	local var_67_0 = {}

	for iter_67_0, iter_67_1 in pairs(var_0_4) do
		if not (var_0_22(iter_67_0, var_0_20) and iter_67_1.lock) then
			if arg_67_2 then
				if iter_67_1.lock then
					table.insert(var_67_0, iter_67_0)
				end
			elseif arg_67_1 or not iter_67_1.lock then
				table.insert(var_67_0, iter_67_0)
			end
		end
	end

	return var_67_0
end

function var_0_0.GetStickerBg(arg_68_0, arg_68_1)
	return var_0_4[arg_68_1]
end

function var_0_0.GetStickerFgList(arg_69_0, arg_69_1, arg_69_2)
	local var_69_0 = {}

	for iter_69_0, iter_69_1 in pairs(var_0_3) do
		if not (var_0_22(iter_69_0, var_0_21) and iter_69_1.lock) then
			if arg_69_2 then
				if iter_69_1.lock then
					table.insert(var_69_0, iter_69_0)
				end
			elseif arg_69_1 or not iter_69_1.lock then
				table.insert(var_69_0, iter_69_0)
			end
		end
	end

	return var_69_0
end

function var_0_0.GetStickerFg(arg_70_0, arg_70_1)
	return var_0_3[arg_70_1]
end

function var_0_0.SetStickerFgPage(arg_71_0, arg_71_1, arg_71_2)
	local var_71_0 = var_0_3[arg_71_1]

	if var_71_0 then
		var_71_0.page = arg_71_2
	end
end

function var_0_0.ClearStickerCollectPageRedPoint(arg_72_0, arg_72_1)
	local var_72_0 = {}

	if arg_72_1 == 0 then
		for iter_72_0, iter_72_1 in ipairs(StickerSuitCfg.all) do
			table.insertto(var_72_0, StickerSuitCfg[iter_72_1].content)
		end
	elseif arg_72_1 == 1 then
		var_72_0 = arg_72_0:GetStickerList()
	elseif arg_72_1 == 2 then
		var_72_0 = arg_72_0:GetStickerBgList()
	elseif arg_72_1 == 3 then
		var_72_0 = arg_72_0:GetStickerFgList()
	end

	for iter_72_2, iter_72_3 in ipairs(var_72_0) do
		if not getData("PlayerCustomStickerTriggered", "StickerItem_" .. iter_72_3) and manager.redPoint:getTipValue(RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. iter_72_3) == 1 then
			saveData("PlayerCustomStickerTriggered", "StickerItem_" .. iter_72_3, 1)
			manager.redPoint:setTip(RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. iter_72_3, 0)
		end
	end
end

function var_0_0.GetPortraitList(arg_73_0)
	return var_0_6.get_portrait_id_list
end

function var_0_0.GetPortrait(arg_74_0, arg_74_1)
	return var_0_6[arg_74_1]
end

function var_0_0.GetFrameList(arg_75_0)
	return var_0_7.get_frame_id_list
end

function var_0_0.GetFrame(arg_76_0, arg_76_1)
	return var_0_7[arg_76_1]
end

function var_0_0.GetCardBgList(arg_77_0)
	return var_0_14.get_cardBg_id_list
end

function var_0_0.GetCardBg(arg_78_0, arg_78_1)
	return var_0_14[arg_78_1]
end

function var_0_0.GetStickerShowID(arg_79_0)
	return var_0_1.show_sticker_flag
end

function var_0_0.GetChatBubbleList(arg_80_0)
	return var_0_13.get_chatBubble_id_list
end

function var_0_0.GetChatBubble(arg_81_0, arg_81_1)
	return var_0_13[arg_81_1]
end

function var_0_0.UnlockSticker(arg_82_0, arg_82_1)
	if var_0_5[arg_82_1] then
		if not getData("PlayerCustomStickerTriggered", "StickerItem_" .. arg_82_1) then
			manager.redPoint:setTip(RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. arg_82_1, 1)
		end

		var_0_5[arg_82_1].lock = false

		table.insert(var_0_1.all_sticker_list, arg_82_1)

		if var_0_5[arg_82_1].suit ~= 0 then
			local var_82_0 = StickerSuitCfg[var_0_5[arg_82_1].suit]
			local var_82_1 = true

			for iter_82_0, iter_82_1 in ipairs(var_82_0.content) do
				local var_82_2 = ProfileDecorateItemCfg[iter_82_1]

				if var_82_2.item_type == 4 then
					var_82_1 = PlayerData:GetStickerBg(iter_82_1).lock
				elseif var_82_2.item_type == 5 then
					var_82_1 = PlayerData:GetSticker(iter_82_1).lock
				elseif var_82_2.item_type == 6 then
					var_82_1 = PlayerData:GetStickerFg(iter_82_1).lock
				end

				if var_82_1 then
					break
				end
			end

			if not var_82_1 then
				manager.redPoint:setTip(RedPointConst.CUSTOM_STICKER_SUIT_REWARD .. "_" .. var_0_5[arg_82_1].suit, 1)
			end
		end
	end
end

function var_0_0.UnlockStickerBg(arg_83_0, arg_83_1)
	if var_0_4[arg_83_1] and var_0_4[arg_83_1].lock then
		var_0_4[arg_83_1].lock = false

		if not getData("PlayerCustomStickerTriggered", "StickerItem_" .. arg_83_1) then
			manager.redPoint:setTip(RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. arg_83_1, 1)
		end

		table.insert(var_0_1.all_background_list, arg_83_1)

		var_0_1.sticker_show_info[arg_83_1] = {
			foreground = 0,
			sticker = {},
			hierarchy = {}
		}

		if var_0_4[arg_83_1].suit ~= 0 then
			local var_83_0 = StickerSuitCfg[var_0_4[arg_83_1].suit]
			local var_83_1 = true

			for iter_83_0, iter_83_1 in ipairs(var_83_0.content) do
				local var_83_2 = ProfileDecorateItemCfg[iter_83_1]

				if var_83_2.item_type == 4 then
					var_83_1 = PlayerData:GetStickerBg(iter_83_1).lock
				elseif var_83_2.item_type == 5 then
					var_83_1 = PlayerData:GetSticker(iter_83_1).lock
				elseif var_83_2.item_type == 6 then
					var_83_1 = PlayerData:GetStickerFg(iter_83_1).lock
				end

				if var_83_1 then
					break
				end
			end

			if not var_83_1 then
				manager.redPoint:setTip(RedPointConst.CUSTOM_STICKER_SUIT_REWARD .. "_" .. var_0_4[arg_83_1].suit, 1)
			end
		end
	end
end

function var_0_0.UnlockStickerFg(arg_84_0, arg_84_1)
	if var_0_3[arg_84_1] and var_0_3[arg_84_1].lock then
		var_0_3[arg_84_1].lock = false

		if not getData("PlayerCustomStickerTriggered", "StickerItem_" .. arg_84_1) then
			manager.redPoint:setTip(RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. arg_84_1, 1)
		end

		table.insert(var_0_1.all_foreground_list, arg_84_1)

		if var_0_3[arg_84_1].suit ~= 0 then
			local var_84_0 = StickerSuitCfg[var_0_3[arg_84_1].suit]
			local var_84_1 = true

			for iter_84_0, iter_84_1 in ipairs(var_84_0.content) do
				local var_84_2 = ProfileDecorateItemCfg[iter_84_1]

				if var_84_2.item_type == 4 then
					var_84_1 = PlayerData:GetStickerBg(iter_84_1).lock
				elseif var_84_2.item_type == 5 then
					var_84_1 = PlayerData:GetSticker(iter_84_1).lock
				elseif var_84_2.item_type == 6 then
					var_84_1 = PlayerData:GetStickerFg(iter_84_1).lock
				end

				if var_84_1 then
					break
				end
			end

			if not var_84_1 then
				manager.redPoint:setTip(RedPointConst.CUSTOM_STICKER_SUIT_REWARD .. "_" .. var_0_3[arg_84_1].suit, 1)
			end
		end
	end
end

function var_0_0.UnlockPortrait(arg_85_0, arg_85_1, arg_85_2)
	local var_85_0 = ItemCfg[arg_85_1]
	local var_85_1 = arg_85_1

	if var_0_6[var_85_1].unlock == 0 then
		manager.redPoint:setTip(RedPointConst.PORTRAIT .. "_" .. var_85_1, 1)
		saveData("limitRed", "portrait_" .. var_85_1, 1)
	end

	var_0_6[var_85_1].unlock = 1
	var_0_6[var_85_1].lasted_time = arg_85_2 or 0
end

function var_0_0.UnlockFrame(arg_86_0, arg_86_1)
	local var_86_0 = ItemCfg[arg_86_1]
	local var_86_1 = var_86_0.param[1]

	if var_0_7[var_86_1] then
		if var_86_0.sub_type == ItemConst.ITEM_SUB_TYPE.FRAME_LIMIT or var_86_0.sub_type == ItemConst.ITEM_SUB_TYPE.FRAME_LIMIT_COVER then
			local var_86_2 = var_86_0.param[2]

			if var_0_7[var_86_1].unlock == 0 then
				var_0_7[var_86_1].unlock = 1
				var_0_7[var_86_1].lasted_time = manager.time:GetServerTime() + var_86_2 * 86400

				table.insert(var_0_1.icon_frame_list, {
					id = var_86_1,
					lasted_time = var_0_7[var_86_1].lasted_time
				})
				manager.redPoint:setTip(RedPointConst.FRAME .. "_" .. var_86_1, 1)
				saveData("limitRed", "frame_" .. var_86_1, 1)
			elseif var_0_7[var_86_1].lasted_time == 0 then
				return
			else
				var_0_7[var_86_1].lasted_time = var_0_7[var_86_1].lasted_time + var_86_2 * 86400
			end
		else
			if var_0_7[var_86_1].unlock == 0 then
				manager.redPoint:setTip(RedPointConst.FRAME .. "_" .. var_86_1, 1)
				saveData("limitRed", "frame_" .. var_86_1, 1)
			end

			var_0_7[var_86_1].unlock = 1
			var_0_7[var_86_1].lasted_time = 0
		end
	end
end

function var_0_0.LockFrame(arg_87_0, arg_87_1)
	if var_0_7[arg_87_1] then
		var_0_7[arg_87_1].unlock = 0

		local var_87_0

		for iter_87_0, iter_87_1 in ipairs(var_0_1.icon_frame_list) do
			if iter_87_1.id == arg_87_1 then
				table.remove(var_0_1.icon_frame_list, iter_87_0)
			end
		end
	end
end

function var_0_0.UnlockTag(arg_88_0, arg_88_1)
	local var_88_0 = manager.time:GetServerTime()
	local var_88_1 = ItemCfg[arg_88_1]
	local var_88_2 = var_88_1.param[1]

	if var_0_16[var_88_2] then
		if var_88_1.sub_type == ItemConst.ITEM_SUB_TYPE.TAG_LIMIT then
			local var_88_3 = var_88_1.param[2] or 0

			if var_0_16[var_88_2].unlock == 0 then
				var_0_16[var_88_2].unlock = 1
				var_0_16[var_88_2].lasted_time = manager.time:GetServerTime() + var_88_3 * 86400

				table.insert(var_0_1.tag_info_list, {
					id = var_88_2,
					lasted_time = var_0_16[var_88_2].lasted_time,
					obtain_time = var_0_16[var_88_2].obtain_time
				})
				manager.redPoint:setTip(RedPointConst.TAG .. "_" .. var_88_2, 1)
				saveData("limitRed", "tag_" .. var_88_2, 1)
			elseif var_0_16[var_88_2].lasted_time == 0 then
				return
			else
				var_0_16[var_88_2].lasted_time = var_0_16[var_88_2].lasted_time + var_88_3 * 86400
			end
		else
			if var_0_16[var_88_2].unlock == 0 then
				var_0_16[var_88_2].obtain_time = var_88_0

				saveData("limitRed", "tag_" .. var_88_2, 1)
				manager.redPoint:setTip(RedPointConst.TAG .. "_" .. var_88_2, 1)
			end

			var_0_16[var_88_2].unlock = 1
			var_0_16[var_88_2].lasted_time = 0
		end
	end
end

function var_0_0.LockTag(arg_89_0, arg_89_1)
	if var_0_16[arg_89_1] then
		var_0_16[arg_89_1].unlock = 0

		for iter_89_0, iter_89_1 in ipairs(var_0_1.tag_info_list) do
			if iter_89_1.id == arg_89_1 then
				table.remove(var_0_1.tag_info_list, iter_89_0)
			end
		end
	end
end

function var_0_0.UnlockCardBg(arg_90_0, arg_90_1)
	local var_90_0 = ItemCfg[arg_90_1]
	local var_90_1 = var_90_0.param[1]

	if var_0_14[var_90_1] then
		if var_90_0.sub_type == ItemConst.ITEM_SUB_TYPE.CARD_BG_LIMIT then
			local var_90_2 = var_90_0.param[2] or 0

			if var_0_14[var_90_1].unlock == 0 then
				var_0_14[var_90_1].unlock = 1
				var_0_14[var_90_1].lasted_time = manager.time:GetServerTime() + var_90_2 * 86400

				table.insert(var_0_1.card_background_list, {
					id = var_90_1,
					lasted_time = var_0_14[var_90_1].lasted_time
				})
				manager.redPoint:setTip(RedPointConst.CARD_BG .. "_" .. var_90_1, 1)
				saveData("limitRed", "cardBg_" .. var_90_1, 1)
			elseif var_0_14[var_90_1].lasted_time == 0 then
				return
			else
				var_0_14[var_90_1].lasted_time = var_0_14[var_90_1].lasted_time + var_90_2 * 86400
			end
		else
			if var_0_14[var_90_1].unlock == 0 then
				saveData("limitRed", "cardBg_" .. var_90_1, 1)
				manager.redPoint:setTip(RedPointConst.CARD_BG .. "_" .. var_90_1, 1)
			end

			var_0_14[var_90_1].unlock = 1
			var_0_14[var_90_1].lasted_time = 0
		end
	end
end

function var_0_0.LockCardBg(arg_91_0, arg_91_1)
	if var_0_14[arg_91_1] then
		var_0_14[arg_91_1].unlock = 0

		for iter_91_0, iter_91_1 in ipairs(var_0_1.card_background_list) do
			if iter_91_1.id == arg_91_1 then
				table.remove(var_0_1.card_background_list, iter_91_0)
			end
		end
	end
end

function var_0_0.RefreshFrameList(arg_92_0, arg_92_1)
	local var_92_0
	local var_92_1 = false
	local var_92_2 = var_0_1.icon_frame
	local var_92_3 = manager.time:GetServerTime()

	for iter_92_0, iter_92_1 in ipairs(var_0_7.get_frame_id_list) do
		local var_92_4 = var_0_7[iter_92_1]

		if var_92_4.unlock == 1 and var_92_4.lasted_time > 0 and var_92_3 > var_92_4.lasted_time then
			arg_92_0:LockFrame(iter_92_1)

			if iter_92_1 == var_92_2 then
				var_92_1 = true
			end
		end
	end

	if var_92_1 then
		local var_92_5 = GameSetting.profile_avatar_frame_default.value[1]

		PlayerAction.ChangeFrameIcon(var_92_5)
	end

	if arg_92_1 then
		arg_92_1()
	end
end

function var_0_0.DealOverdueFrame(arg_93_0)
	if var_0_8 and #var_0_8 > 0 then
		PlayerAction.DealOverdueFrame()

		var_0_8 = {}
	end
end

function var_0_0.DealOverduePortrait(arg_94_0)
	if var_0_9 and #var_0_9 > 0 then
		PlayerAction.DealOverduePortrait()

		var_0_9 = {}
	end
end

function var_0_0.DealOverdueChatBubble(arg_95_0)
	if var_0_10 and #var_0_10 > 0 then
		PlayerAction.DealOverdueChatBubble()

		var_0_10 = {}
	end
end

function var_0_0.DealOverdueCardBgList(arg_96_0)
	if var_0_15 and #var_0_15 > 0 then
		PlayerAction.DealOverdueCardBgList()

		var_0_15 = {}
	end
end

function var_0_0.DealOverdueTagList(arg_97_0)
	if var_0_17 and #var_0_17 > 0 then
		JumpTools.OpenPageByJump("FrameExpired", {
			expiredList = var_0_17,
			type = ItemConst.ITEM_TYPE.TAG
		})
		PlayerAction.DealOverdueTagList()

		var_0_17 = {}
	end
end

function var_0_0.SetUnclaimedListFromServer(arg_98_0, arg_98_1)
	var_0_11 = {}

	for iter_98_0, iter_98_1 in ipairs(arg_98_1.reward) do
		var_0_11[iter_98_1.id] = iter_98_1.stage
	end
end

function var_0_0.GetUnclaimed(arg_99_0, arg_99_1)
	return var_0_11[arg_99_1] or nil
end

function var_0_0.ReadUnclaimed(arg_100_0, arg_100_1)
	var_0_11[arg_100_1] = nil
end

function var_0_0.SetUsingTagList(arg_101_0, arg_101_1)
	var_0_1.used_tag_list = arg_101_1
end

function var_0_0.GetUnlockTagListInfo(arg_102_0)
	local var_102_0 = {}
	local var_102_1 = manager.time:GetServerTime()

	for iter_102_0, iter_102_1 in ipairs(var_0_16.get_tagList_id_list) do
		local var_102_2 = var_0_16[iter_102_1]

		if var_102_2 and var_102_2.unlock == 1 then
			if var_102_2.lasted_time == 0 or var_102_1 < var_102_2.lasted_time then
				table.insert(var_102_0, var_102_2)
			else
				arg_102_0:LockTag(iter_102_1)
			end
		end
	end

	table.sort(var_102_0, function(arg_103_0, arg_103_1)
		local var_103_0 = ProfileLabelCfg[arg_103_0.id]
		local var_103_1 = ProfileLabelCfg[arg_103_1.id]

		if var_103_0.type ~= var_103_1.type then
			return var_103_0.type > var_103_1.type
		end

		if arg_103_0.obtain_time ~= arg_103_0.obtain_time then
			return arg_103_0.obtain_time < arg_103_0.obtain_time
		end

		return arg_103_0.id < arg_103_1.id
	end)

	return var_102_0
end

function var_0_0.GetUsingTagListInfo(arg_104_0)
	local var_104_0 = {}
	local var_104_1 = manager.time:GetServerTime()

	for iter_104_0, iter_104_1 in ipairs(var_0_1.used_tag_list) do
		local var_104_2 = var_0_16[iter_104_1]

		if var_104_2 and var_104_2.unlock == 1 and (var_104_2.lasted_time == 0 or var_104_1 < var_104_2.lasted_time) then
			table.insert(var_104_0, iter_104_1)
		end
	end

	table.sort(var_104_0, function(arg_105_0, arg_105_1)
		local var_105_0 = ProfileLabelCfg[arg_105_0]
		local var_105_1 = ProfileLabelCfg[arg_105_1]

		if var_105_0.type ~= var_105_1.type then
			return var_105_0.type > var_105_1.type
		end

		if var_0_16[arg_105_0].obtain_time ~= var_0_16[arg_105_1].obtain_time then
			return var_0_16[arg_105_0].obtain_time < var_0_16[arg_105_1].obtain_time
		end

		return arg_105_0 < arg_105_1
	end)

	return var_104_0
end

function var_0_0.GetTagInfo(arg_106_0, arg_106_1)
	return var_0_16[arg_106_1]
end

function var_0_0.ResetSendLikeList(arg_107_0)
	var_0_1.today_send_like = {}
end

function var_0_0.GetTodaySendLikeList(arg_108_0)
	return var_0_1.today_send_like
end

function var_0_0.SetCardBg(arg_109_0, arg_109_1)
	var_0_1.card_bg_id = arg_109_1
end

function var_0_0.OnSendLike(arg_110_0, arg_110_1)
	table.insert(var_0_1.today_send_like, arg_110_1)
end

function var_0_0.GetLikeInfo(arg_111_0)
	local var_111_0 = {}

	for iter_111_0 = 1, GameSetting.profile_like_record.value[1] do
		if var_0_1.likes_list[iter_111_0] then
			table.insert(var_111_0, var_0_1.likes_list[iter_111_0])
		else
			break
		end
	end

	return var_111_0
end

function var_0_0.AddLikeInfo(arg_112_0, arg_112_1)
	table.sort(arg_112_1, function(arg_113_0, arg_113_1)
		return arg_113_0.time > arg_113_1.time
	end)

	local var_112_0 = {}

	table.insertto(var_112_0, arg_112_1)
	table.insertto(var_112_0, var_0_1.likes_list)

	for iter_112_0 = #var_112_0, GameSetting.profile_like_record.value[1] + 1, -1 do
		table.remove(var_112_0, iter_112_0)
	end

	var_0_1.likes_list = var_112_0
	var_0_1.likes = var_0_1.likes + #arg_112_1

	manager.notify:CallUpdateFunc(GET_LIKE)
end

local var_0_23

function var_0_0.RefreshTagRed(arg_114_0)
	arg_114_0:StopTagRed()

	var_0_23 = Timer.New(function()
		local var_115_0 = 0
		local var_115_1 = manager.time:GetServerTime()

		for iter_115_0, iter_115_1 in ipairs(var_0_16.get_tagList_id_list) do
			local var_115_2 = var_0_16[iter_115_1]
			local var_115_3 = getData("limitRed", "tag_" .. iter_115_1) or 0

			if var_115_2.unlock == 1 and var_115_2.lasted_time > 0 and var_115_3 == 1 then
				var_115_0 = var_115_0 + 1

				if var_115_1 >= var_115_2.lasted_time then
					arg_114_0:LockTag(iter_115_1)
					saveData("limitRed", "tag_" .. iter_115_1, 0)
					manager.redPoint:setTip(RedPointConst.TAG .. "_" .. iter_115_1, 0)
				else
					manager.redPoint:setTip(RedPointConst.TAG .. "_" .. iter_115_1, 1)
				end
			end
		end

		if var_115_0 == 0 then
			arg_114_0:StopTagRed()
		end
	end, 1, -1)

	var_0_23:Start()
end

function var_0_0.ClearTagRed(arg_116_0)
	for iter_116_0, iter_116_1 in ipairs(var_0_16.get_tagList_id_list) do
		saveData("limitRed", "tag_" .. iter_116_1, 0)
		manager.redPoint:setTip(RedPointConst.TAG .. "_" .. iter_116_1, 0)
	end
end

function var_0_0.ClearTargetTagRed(arg_117_0, arg_117_1)
	saveData("limitRed", "tag_" .. arg_117_1, 0)
	manager.redPoint:setTip(RedPointConst.TAG .. "_" .. arg_117_1, 0)
end

function var_0_0.ClearPortraitRed(arg_118_0, arg_118_1)
	saveData("limitRed", "portrait_" .. arg_118_1, 0)
	manager.redPoint:setTip(RedPointConst.PORTRAIT .. "_" .. arg_118_1, 0)
end

function var_0_0.ClearFrameRed(arg_119_0, arg_119_1)
	saveData("limitRed", "frame_" .. arg_119_1, 0)
	manager.redPoint:setTip(RedPointConst.FRAME .. "_" .. arg_119_1, 0)
end

function var_0_0.ClearCardBgRedItem(arg_120_0, arg_120_1)
	saveData("limitRed", "cardBg_" .. arg_120_1, 0)
	manager.redPoint:setTip(RedPointConst.CARD_BG .. "_" .. arg_120_1, 0)
end

local var_0_24

function var_0_0.RefreshPortraitRed(arg_121_0)
	arg_121_0:StopPortraitRed()

	var_0_24 = Timer.New(function()
		local var_122_0 = 0
		local var_122_1 = manager.time:GetServerTime()

		for iter_122_0, iter_122_1 in ipairs(var_0_6.get_portrait_id_list) do
			local var_122_2 = var_0_6[iter_122_1]
			local var_122_3 = getData("limitRed", "portrait_" .. iter_122_1) or 0

			if var_122_2.unlock == 1 and var_122_2.lasted_time > 0 and var_122_3 == 1 then
				var_122_0 = var_122_0 + 1

				if var_122_1 >= var_122_2.lasted_time then
					saveData("limitRed", "portrait_" .. iter_122_1, 0)
					manager.redPoint:setTip(RedPointConst.PORTRAIT .. "_" .. iter_122_1, 0)
				else
					manager.redPoint:setTip(RedPointConst.PORTRAIT .. "_" .. iter_122_1, 1)
				end
			end
		end

		if var_122_0 == 0 then
			arg_121_0:StopPortraitRed()
		end
	end, 1, -1)

	var_0_24:Start()
end

function var_0_0.StopPortraitRed(arg_123_0)
	if var_0_24 then
		var_0_24:Stop()

		var_0_24 = nil
	end
end

local var_0_25

function var_0_0.RefreshFrameRed(arg_124_0)
	arg_124_0:StopFrameRed()

	var_0_25 = Timer.New(function()
		local var_125_0 = 0
		local var_125_1 = manager.time:GetServerTime()

		for iter_125_0, iter_125_1 in ipairs(var_0_7.get_frame_id_list) do
			local var_125_2 = var_0_7[iter_125_1]
			local var_125_3 = getData("limitRed", "frame_" .. iter_125_1) or 0

			if var_125_2.unlock == 1 and var_125_2.lasted_time > 0 and var_125_3 == 1 then
				var_125_0 = var_125_0 + 1

				if var_125_1 >= var_125_2.lasted_time then
					arg_124_0:LockFrame(iter_125_1)
					saveData("limitRed", "frame_" .. iter_125_1, 0)
					manager.redPoint:setTip(RedPointConst.FRAME .. "_" .. iter_125_1, 0)
				else
					manager.redPoint:setTip(RedPointConst.FRAME .. "_" .. iter_125_1, 1)
				end
			end
		end

		if var_125_0 == 0 then
			arg_124_0:StopFrameRed()
		end
	end, 1, -1)

	var_0_25:Start()
end

function var_0_0.StopFrameRed(arg_126_0)
	if var_0_25 then
		var_0_25:Stop()

		var_0_25 = nil
	end
end

function var_0_0.StopTagRed(arg_127_0)
	if var_0_23 then
		var_0_23:Stop()

		var_0_23 = nil
	end
end

local var_0_26

function var_0_0.RefreshCardBgRed(arg_128_0)
	arg_128_0:StopCardRed()

	var_0_26 = Timer.New(function()
		local var_129_0 = 0
		local var_129_1 = manager.time:GetServerTime()

		for iter_129_0, iter_129_1 in ipairs(var_0_14.get_cardBg_id_list) do
			local var_129_2 = var_0_14[iter_129_1]
			local var_129_3 = getData("limitRed", "cardBg_" .. iter_129_1) or 0

			if var_129_2.unlock == 1 and var_129_2.lasted_time > 0 and var_129_3 == 1 then
				var_129_0 = var_129_0 + 1

				if var_129_1 >= var_129_2.lasted_time then
					arg_128_0:LockCardBg(iter_129_1)
					saveData("limitRed", "cardBg_" .. iter_129_1, 0)
					manager.redPoint:setTip(RedPointConst.CARD_BG .. "_" .. iter_129_1, 0)
				else
					manager.redPoint:setTip(RedPointConst.CARD_BG .. "_" .. iter_129_1, 1)
				end
			end
		end

		if var_129_0 == 0 then
			arg_128_0:StopCardRed()
		end
	end, 1, -1)

	var_0_26:Start()
end

function var_0_0.ClearCardBgRed(arg_130_0)
	for iter_130_0, iter_130_1 in ipairs(var_0_14.get_cardBg_id_list) do
		saveData("limitRed", "cardBg_" .. iter_130_1, 0)
		manager.redPoint:setTip(RedPointConst.CARD_BG .. "_" .. iter_130_1, 0)
	end
end

function var_0_0.StopCardRed(arg_131_0)
	if var_0_26 then
		var_0_26:Stop()

		var_0_26 = nil
	end
end

function var_0_0.SetCurChatBubbleID(arg_132_0, arg_132_1)
	var_0_1.used_chat_buddle_id = arg_132_1
end

function var_0_0.GetCurChatBubbleID(arg_133_0)
	return var_0_1.used_chat_buddle_id
end

function var_0_0.UnlockChatBubble(arg_134_0, arg_134_1, arg_134_2)
	local var_134_0 = ItemCfg[arg_134_1]
	local var_134_1 = arg_134_1

	var_0_13[var_134_1].unlock = 1
	var_0_13[var_134_1].lasted_time = arg_134_2 or 0

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHAT_BUBBLE, var_134_1), 1)
end

function var_0_0.GetUnlockChatBubbleIDList(arg_135_0)
	local var_135_0 = {}

	for iter_135_0, iter_135_1 in pairs(var_0_13) do
		if iter_135_1.unlock == 1 then
			table.insert(var_135_0, iter_135_1.id)
		end
	end

	return var_135_0
end

function var_0_0.GetAllAppIconList(arg_136_0)
	local var_136_0 = {}

	for iter_136_0, iter_136_1 in ipairs(var_0_1.game_icon) do
		local var_136_1 = ItemCfg[iter_136_1.id]

		table.insert(var_136_0, {
			id = iter_136_1.id,
			name = var_136_1.name
		})
	end

	table.sort(var_136_0, function(arg_137_0, arg_137_1)
		local var_137_0 = ItemCfg[arg_137_0.id] and ItemCfg[arg_137_0.id].param and ItemCfg[arg_137_0.id].param[1] or 0
		local var_137_1 = ItemCfg[arg_137_1.id] and ItemCfg[arg_137_1.id].param and ItemCfg[arg_137_1.id].param[1] or 0

		if var_137_0 ~= var_137_1 then
			return var_137_1 < var_137_0
		end

		return arg_137_0.id > arg_137_1.id
	end)

	return var_136_0
end

function var_0_0.GetCurAppIcon(arg_138_0)
	local var_138_0 = PlayerPrefs.GetInt("app_icon_id")

	if not var_138_0 or var_138_0 == 0 then
		var_138_0 = arg_138_0:GetAllAppIconList()[1].id
	end

	return var_138_0
end

function var_0_0.SaveAppIcon(arg_139_0, arg_139_1)
	PlayerPrefs.SetInt("app_icon_id", arg_139_1)
end

function var_0_0.InitPlayerStoryTrigger(arg_140_0, arg_140_1)
	var_0_18 = {}

	for iter_140_0, iter_140_1 in ipairs(arg_140_1.info_list) do
		var_0_18[iter_140_1.trigger_group_id] = {}

		for iter_140_2, iter_140_3 in ipairs(iter_140_1.completed_trigger_list) do
			table.insert(var_0_18[iter_140_1.trigger_group_id], iter_140_3)
		end
	end
end

function var_0_0.AddPlayerStoryTrigger(arg_141_0, arg_141_1)
	local var_141_0 = StoryTriggerCfg[arg_141_1]

	if var_0_18[var_141_0.trigger_group] then
		if table.indexof(var_0_18[var_141_0.trigger_group], arg_141_1) == false then
			table.insert(var_0_18[var_141_0.trigger_group], arg_141_1)
		end
	else
		var_0_18[var_141_0.trigger_group] = {
			arg_141_1
		}
	end
end

function var_0_0.GetPlayerStoryTriggerGroupInfo(arg_142_0, arg_142_1)
	local var_142_0 = StoryTriggerCfg[arg_142_1]
	local var_142_1 = #StoryTriggerCfg.get_id_list_by_trigger_group[var_142_0.trigger_group]
	local var_142_2 = 0

	if var_0_18[var_142_0.trigger_group] then
		var_142_2 = #var_0_18[var_142_0.trigger_group]
	end

	return var_142_2, var_142_1
end

local var_0_27 = 2
local var_0_28 = {}
local var_0_29 = 2
local var_0_30 = false
local var_0_31 = false
local var_0_32

function var_0_0.GetRandomPosterGirlData(arg_143_0)
	return {
		random_type = 1,
		random_model = var_0_27,
		random_list = var_0_28,
		show_hero_dressing_scene = var_0_30,
		routine_hero_dressing_scene = var_0_31
	}
end

function var_0_0.GetRandomSceneData(arg_144_0)
	return {
		random_type = 2,
		random_model = HomeSceneSettingData:GetRandomModeRaw(),
		random_list = HomeSceneSettingData:GetRandomSceneList()
	}
end

function var_0_0.SetRandomHeroData(arg_145_0, arg_145_1)
	var_0_27 = arg_145_1.random_model
	var_0_28 = {}
	var_0_30 = arg_145_1.show_hero_dressing_scene ~= 0
	var_0_31 = arg_145_1.routine_hero_dressing_scene ~= 0

	table.insertto(var_0_28, arg_145_1.random_list)

	for iter_145_0 = #var_0_28, 1, -1 do
		local var_145_0 = var_0_28[iter_145_0]

		if table.keyof(var_0_28, var_145_0) ~= iter_145_0 then
			table.remove(var_0_28, iter_145_0)
		end
	end
end

function var_0_0.IsRandomHeroUseDlcScene(arg_146_0)
	return var_0_30
end

function var_0_0.SetIsRandomHeroUseDlcScene(arg_147_0, arg_147_1)
	var_0_30 = arg_147_1
end

function var_0_0.IsRandomHeroShowEachDebutAnim(arg_148_0)
	return var_0_31
end

function var_0_0.SetIsRandomHeroShowEachDebutAnim(arg_149_0, arg_149_1)
	var_0_31 = arg_149_1
end

function var_0_0.GetRandomHeroList(arg_150_0)
	return var_0_28
end

function var_0_0.SetRandomHeroList(arg_151_0, arg_151_1)
	var_0_28 = clone(arg_151_1)
end

function var_0_0.GetRandomHeroMode(arg_152_0)
	return PlayerTools.RandomModeDataGetMode(var_0_27)
end

function var_0_0.SetRandomHeroMode(arg_153_0, arg_153_1)
	var_0_27 = PlayerTools.MakeRandomModeData(arg_153_0:IsRandomHero(), arg_153_1)
end

function var_0_0.IsRandomHero(arg_154_0)
	return PlayerTools.RandomModeDataIsEnable(var_0_27)
end

function var_0_0.SetIsRandomHero(arg_155_0, arg_155_1)
	var_0_27 = PlayerTools.MakeRandomModeData(arg_155_1, arg_155_0:GetRandomHeroMode())
end

function var_0_0.GetRandomHero(arg_156_0)
	if var_0_29 == 0 then
		arg_156_0:CalcNextRandomHero()
	end

	return var_0_29
end

function var_0_0.SetRandomHero(arg_157_0, arg_157_1)
	var_0_29 = arg_157_1
end

function var_0_0.SetForceRandomHeroID(arg_158_0, arg_158_1)
	arg_158_0.forceRandomHeroID_ = arg_158_1
end

function var_0_0.GetForceRandomHeroID(arg_159_0)
	return arg_159_0.forceRandomHeroID_
end

function var_0_0.CalcNextRandomHero(arg_160_0)
	local var_160_0 = CustomCenterTools.GetRandomHeroList()
	local var_160_1 = #var_160_0

	if var_160_1 == 0 then
		var_0_29 = var_0_1.poster_girl
		arg_160_0.forceRandomHeroID_ = nil

		return var_0_29
	end

	if arg_160_0.forceRandomHeroID_ then
		var_0_29 = arg_160_0.forceRandomHeroID_
		arg_160_0.forceRandomHeroID_ = nil

		return
	end

	local var_160_2 = math.random(var_160_1)
	local var_160_3 = var_160_0[var_160_2]

	if var_160_3 == var_0_29 then
		if var_160_1 >= var_160_2 + 1 then
			var_160_3 = var_160_0[var_160_2 + 1]
		elseif var_160_2 - 1 >= 1 then
			var_160_3 = var_160_0[var_160_2 - 1]
		end
	end

	var_0_29 = var_160_3

	return var_0_29
end

function var_0_0.GetPosterGirlHeroSkinId(arg_161_0)
	if var_0_32 then
		return var_0_32
	elseif arg_161_0:IsRandomHero() then
		return arg_161_0:GetRandomHero()
	else
		return HeroTools.HeroUsingSkinInfo(var_0_1.poster_girl).id
	end
end

function var_0_0.GetCacheHeroSkinList(arg_162_0)
	return arg_162_0.cacheHeroSkinList_
end

function var_0_0.SetCacheHeroSkinList(arg_163_0, arg_163_1)
	arg_163_0.cacheHeroSkinList_ = arg_163_1
end

function var_0_0.UpdateCacheHeroSkinID(arg_164_0, arg_164_1)
	local var_164_0 = table.keyof(arg_164_0.cacheHeroSkinList_, arg_164_1)

	if var_164_0 then
		table.remove(arg_164_0.cacheHeroSkinList_, var_164_0)
	else
		table.insert(arg_164_0.cacheHeroSkinList_, arg_164_1)
	end
end

function var_0_0.GetCacheHeroSkinID(arg_165_0, arg_165_1)
	if not arg_165_0.cacheHeroSkin_[arg_165_1] then
		arg_165_0.cacheHeroSkin_[arg_165_1] = HeroTools.HeroUsingSkinInfo(arg_165_1).id
	end

	return arg_165_0.cacheHeroSkin_[arg_165_1]
end

function var_0_0.SetCacheHeroSkinID(arg_166_0, arg_166_1, arg_166_2)
	arg_166_0.cacheHeroSkin_[arg_166_1] = arg_166_2
end

function var_0_0.ClearCacheHeroSkinID(arg_167_0)
	arg_167_0.cacheHeroSkin_ = {}
end

function var_0_0.GetClearHeroFlag(arg_168_0)
	return arg_168_0.clearHeroFlag_
end

function var_0_0.SetClearHeroFlag(arg_169_0, arg_169_1)
	arg_169_0.clearHeroFlag_ = arg_169_1
end

function var_0_0.SetPosterGirlDebut(arg_170_0, arg_170_1)
	arg_170_0.posterGrilDebut_ = arg_170_1
end

function var_0_0.GetPosterGirlDebut(arg_171_0)
	return arg_171_0.posterGrilDebut_
end

function var_0_0.AddSelectSkinID(arg_172_0, arg_172_1)
	table.insert(arg_172_0.selectSkinList_, arg_172_1)
end

function var_0_0.GetSelectSkinList(arg_173_0)
	return arg_173_0.selectSkinList_
end

function var_0_0.ClearSelectSkinList(arg_174_0)
	arg_174_0.selectSkinList_ = {}
end

function var_0_0.SetPlayAssistantVoice(arg_175_0, arg_175_1, arg_175_2)
	arg_175_0.heroAssistantVoice_ = arg_175_1 and {
		arg_175_1,
		arg_175_2
	} or nil
end

function var_0_0.GetPlayAssistantVoice(arg_176_0)
	return arg_176_0.heroAssistantVoice_
end

function var_0_0.SetIsDeskMode(arg_177_0, arg_177_1)
	arg_177_0.deskMode_ = arg_177_1
end

function var_0_0.GetDeskMode(arg_178_0)
	return arg_178_0.deskMode_
end

function var_0_0.SetDeskModeHeroSkinID(arg_179_0, arg_179_1)
	var_0_32 = arg_179_1
end

function var_0_0.GetDeskModeHeroSkinID(arg_180_0)
	return var_0_32
end

function var_0_0.SetPureModeData(arg_181_0, arg_181_1)
	arg_181_0.pureModeData_ = {}

	if arg_181_1 then
		arg_181_0.pureModeData_.randomModeIndex = arg_181_1.pattern_id or 0
		arg_181_0.pureModeData_.randomModeRangeIndex = arg_181_1.pattern_scope ~= 0 and arg_181_1.pattern_scope or 1
		arg_181_0.pureModeData_.randomTimeIndex = arg_181_1.switch_frequency ~= 0 and arg_181_1.switch_frequency or 1
		arg_181_0.pureModeData_.pureModeTimeIndex = arg_181_1.entry_time ~= 0 and arg_181_1.entry_time or 1
	end
end

function var_0_0.GetPureModeData(arg_182_0)
	return arg_182_0.pureModeData_
end

function var_0_0.SetPureModeComponentData(arg_183_0, arg_183_1)
	arg_183_0.pureModeComponentData_ = {}

	for iter_183_0, iter_183_1 in ipairs(arg_183_1 or {}) do
		local var_183_0 = {
			id = iter_183_1.module_id,
			positionX = iter_183_1.module_location_x,
			positionY = iter_183_1.module_location_y,
			scale = iter_183_1.module_size
		}

		arg_183_0.pureModeComponentData_[iter_183_0] = var_183_0
	end
end

function var_0_0.GetPureModeComponentData(arg_184_0)
	return arg_184_0.pureModeComponentData_
end

return var_0_0
