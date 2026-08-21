local var_0_0 = singletonClass("ForeignInfoData", BaseHeroViewData)
local var_0_1 = {}
local var_0_2

function var_0_0.SetForeignHeroInfo(arg_1_0, arg_1_1)
	var_0_1 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		local var_1_0 = iter_1_1.hero_base_info
		local var_1_1 = ForeignHeroDataTemplate.New(var_1_0.id)

		var_1_1:Init(iter_1_1)

		var_0_1[var_1_0.id] = var_1_1
	end
end

function var_0_0.SetForeignOathInfo(arg_2_0, arg_2_1)
	if arg_2_1 then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
			local var_2_0 = var_0_1[iter_2_1.hero_id]

			if var_2_0 then
				var_2_0:SetOathInfo(iter_2_1)
			end
		end
	end
end

function var_0_0.GetHeroList(arg_3_0)
	return var_0_1
end

function var_0_0.GetHeroNO(arg_4_0, arg_4_1)
	return table.indexof(arg_4_0:GetHeroIDList(), arg_4_1) or 0
end

function var_0_0.GetEquipDataList(arg_5_0, arg_5_1)
	return var_0_1[arg_5_1].equip_list
end

local function var_0_3(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2 = arg_6_2 or pairs

	local var_6_0 = {}

	if arg_6_0 then
		for iter_6_0, iter_6_1 in arg_6_2(arg_6_0) do
			var_6_0[iter_6_1[arg_6_1]] = iter_6_1
		end
	end

	return var_6_0
end

function var_0_0.SetCurForeignDetailInfo(arg_7_0, arg_7_1)
	var_0_2 = {
		user_id = arg_7_1.user_id,
		level = arg_7_1.level,
		nick = arg_7_1.base_info.nick,
		icon = arg_7_1.base_info.icon,
		icon_frame = arg_7_1.base_info.icon_frame,
		sign = arg_7_1.sign,
		sticker_show_info = PlayerData:InitStickerShowList({
			arg_7_1.sticker_show_info
		}, true),
		hero_list = arg_7_1.hero_list or {},
		is_online = arg_7_1.is_online,
		ip = (arg_7_1.ip_location == nil or arg_7_1.ip_location == "") and GetTips("IP_UNKNOWN") or arg_7_1.ip_location,
		guildID = arg_7_1.club_id,
		guildName = arg_7_1.club_name,
		guildIcon = arg_7_1.club_icon,
		postGril = arg_7_0:GetPostID(arg_7_1.poster_hero),
		birthdayMonth = arg_7_1.birthday.month,
		birthdayDay = arg_7_1.birthday.day,
		backhome_architecture_id = arg_7_1.backhome_architecture_id,
		hero_id_list = cleanProtoTable(arg_7_1.hero_id_list),
		likes = arg_7_1.likes,
		used_tag_list = cleanProtoTable(arg_7_1.used_tag_list),
		card_bg_id = arg_7_1.information_background_id,
		post_background_id = arg_7_1.post_background_id,
		achievement_static_info = arg_7_1.achievement_static_info,
		hero_static_info = arg_7_1.hero_static_info,
		weapon_servant_static_info = arg_7_1.weapon_servant_static_info,
		sticker_static_info = arg_7_1.sticker_static_info,
		sticker_background_static_info = arg_7_1.sticker_background_static_info,
		sticker_foreground_static_info = arg_7_1.sticker_foreground_static_info,
		hero_oath_display = var_0_3(arg_7_1.hero_oath_display, "hero_id", ipairs)
	}
end

function var_0_0.GetPostID(arg_8_0, arg_8_1)
	if arg_8_1.hero_id ~= 0 then
		if arg_8_1.using_skin ~= 0 then
			return arg_8_1.using_skin
		else
			return arg_8_1.hero_id
		end
	end

	return 1084
end

function var_0_0.GetCurForeignDetailInfo(arg_9_0)
	return var_0_2
end

function var_0_0.OnSendLike(arg_10_0)
	if var_0_2 and var_0_2.likes then
		var_0_2.likes = var_0_2.likes + 1
	end
end

function var_0_0.GetExFilterSorterFunc(arg_11_0)
	return function(arg_12_0, arg_12_1)
		local var_12_0 = ForeignInfoData:GetHeroNO(arg_12_0.id)
		local var_12_1 = ForeignInfoData:GetHeroNO(arg_12_1.id)

		return true, var_12_0 < var_12_1
	end
end

function var_0_0.GetHeroName(arg_13_0, arg_13_1)
	local var_13_0 = nullable(var_0_1, arg_13_1, "hero_oath_display", "nick")

	if var_13_0 == nil or var_13_0 == "" then
		return HeroCfg[arg_13_1].suffix
	end

	return var_13_0
end

function var_0_0.HasCustomNickName(arg_14_0, arg_14_1)
	local var_14_0 = nullable(var_0_1, arg_14_1, "hero_oath_display", "nick")

	if var_14_0 == nil or var_14_0 == "" then
		return false
	end

	return true
end

function var_0_0.IsHeroOath(arg_15_0, arg_15_1)
	return (nullable(var_0_1, arg_15_1, "hero_oath_display", "oath"))
end

return var_0_0
