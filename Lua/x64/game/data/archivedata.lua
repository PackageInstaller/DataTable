require("game.data.ArchiveDataTemplate")

local var_0_0 = singletonClass("ArchiveData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
end

function var_0_0.InitArchive(arg_2_0, arg_2_1)
	var_0_1 = {}

	for iter_2_0, iter_2_1 in ipairs(cleanProtoTable(arg_2_1)) do
		var_0_1[iter_2_1.archive_id] = {
			archive_id = iter_2_1.archive_id,
			exp = iter_2_1.exp,
			lv = LvTools.LoveExpToLevel(iter_2_1.exp),
			gift_list = {},
			text_list = {},
			video_list = {},
			selected_picture = iter_2_1.selected_picture,
			hero_story_list = {},
			super_heart_link_list = {}
		}

		for iter_2_2, iter_2_3 in ipairs(cleanProtoTable(iter_2_1.gift_list)) do
			var_0_1[iter_2_1.archive_id].gift_list[iter_2_3.id] = iter_2_3.num
		end

		for iter_2_4, iter_2_5 in ipairs(cleanProtoTable(iter_2_1.text_list)) do
			var_0_1[iter_2_1.archive_id].text_list[iter_2_5] = true
		end

		for iter_2_6, iter_2_7 in ipairs(cleanProtoTable(iter_2_1.video_list)) do
			var_0_1[iter_2_1.archive_id].video_list[iter_2_7] = true
		end

		for iter_2_8, iter_2_9 in ipairs(cleanProtoTable(iter_2_1.hero_story_list)) do
			var_0_1[iter_2_1.archive_id].hero_story_list[iter_2_9.hero_id] = iter_2_9
		end

		for iter_2_10, iter_2_11 in ipairs(cleanProtoTable(iter_2_1.super_heart_link_list)) do
			var_0_1[iter_2_1.archive_id].super_heart_link_list[iter_2_10] = iter_2_11
		end
	end
end

function var_0_0.SortHeartArchiveList(arg_3_0, arg_3_1)
	table.sort(arg_3_1, function(arg_4_0, arg_4_1)
		arg_4_0.unlocked, arg_4_0.read_all_biography, arg_4_0.watched_all_heartchain, arg_4_0.trust, arg_4_0.has_super_heartchain = arg_3_0:GetSortAttribute(arg_4_0)
		arg_4_1.unlocked, arg_4_1.read_all_biography, arg_4_1.watched_all_heartchain, arg_4_1.trust, arg_4_1.has_super_heartchain = arg_3_0:GetSortAttribute(arg_4_1)

		if arg_4_0.unlocked and not arg_4_1.unlocked then
			return true
		elseif not arg_4_0.unlocked and arg_4_1.unlocked then
			return false
		end

		if not arg_4_0.read_all_biography and arg_4_1.read_all_biography then
			return true
		elseif arg_4_0.read_all_biography and not arg_4_1.read_all_biography then
			return false
		end

		if not arg_4_0.watched_all_heartchain and arg_4_1.watched_all_heartchain then
			return true
		elseif arg_4_0.watched_all_heartchain and not arg_4_1.watched_all_heartchain then
			return false
		end

		if arg_4_0.trust > arg_4_1.trust then
			return true
		elseif arg_4_0.trust < arg_4_1.trust then
			return false
		end

		if arg_4_0.lv > arg_4_1.lv then
			return true
		elseif arg_4_0.lv < arg_4_1.lv then
			return false
		end

		if arg_4_0.has_super_heartchain and not arg_4_1.has_super_heartchain then
			return true
		elseif not arg_4_0.has_super_heartchain and arg_4_1.has_super_heartchain then
			return false
		end

		return arg_4_0.archive_id < arg_4_1.archive_id
	end)
end

function var_0_0.GetSortAttribute(arg_5_0, arg_5_1)
	local var_5_0 = HeroRecordCfg[arg_5_1.archive_id]
	local var_5_1 = var_5_0.hero_id
	local var_5_2 = false
	local var_5_3 = false
	local var_5_4 = false
	local var_5_5 = 0
	local var_5_6 = false

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		if HeroData:GetHeroData(var_5_1[iter_5_0]).unlock == 1 then
			var_5_2 = true
		end
	end

	local var_5_7 = ArchiveData:GetAnedoteList(var_5_1)
	local var_5_8 = ArchiveData:GetIsViewedArhiveStoryList(arg_5_1.archive_id)
	local var_5_9 = #var_5_7 == #var_5_8
	local var_5_10 = 0

	for iter_5_2, iter_5_3 in pairs(arg_5_1.video_list) do
		var_5_10 = var_5_10 + 1
	end

	local var_5_11 = var_5_10 + #ArchiveData:GetHasViewedSuperHeartList(arg_5_1.archive_id) == #var_5_0.plot_id + #var_5_0.super_plot_id

	for iter_5_4, iter_5_5 in ipairs(var_5_1) do
		local var_5_12 = HeroData:GetHeroData(var_5_1[iter_5_4])

		if var_5_5 < arg_5_0:GetTrustLevel(var_5_12.id) then
			var_5_5 = arg_5_0:GetTrustLevel(var_5_12.id)
		end
	end

	local var_5_13 = #var_5_0.super_plot_id > 0

	return var_5_2, var_5_9, var_5_11, var_5_5, var_5_13
end

function var_0_0.GetContinuousHeartArchiveList(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(var_0_1) do
		if HeroRecordCfg[iter_6_1.archive_id] and not table.isEmpty(HeroRecordCfg[iter_6_1.archive_id].plot_id) then
			table.insert(var_6_0, iter_6_1)
		end
	end

	return var_6_0
end

function var_0_0.GetContinuousSuperHeartArchiveList(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(var_0_1) do
		if HeroRecordCfg[iter_7_1.archive_id] and not table.isEmpty(HeroRecordCfg[iter_7_1.archive_id].super_plot_id) then
			table.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function var_0_0.GetContinuousHeartArchiveListByType(arg_8_0, arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(var_0_1) do
		local var_8_1 = HeroRecordCfg[iter_8_1.archive_id]

		if var_8_1 then
			local var_8_2 = var_8_1.id

			if HeroCfg[var_8_2].race == arg_8_1 and not table.isEmpty(var_8_1.plot_id) then
				table.insert(var_8_0, iter_8_1)
			end
		end
	end

	return var_8_0
end

function var_0_0.GetContinuousSuperHeartArchiveListByType(arg_9_0, arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(var_0_1) do
		local var_9_1 = HeroRecordCfg[iter_9_1.archive_id].id

		if HeroCfg[var_9_1].race == arg_9_1 and not table.isEmpty(HeroRecordCfg[iter_9_1.archive_id].super_plot_id) then
			table.insert(var_9_0, iter_9_1)
		end
	end

	return var_9_0
end

function var_0_0.GetIsViewedArhiveStoryList(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(var_0_1[arg_10_1].hero_story_list) do
		if iter_10_1.is_viewed then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function var_0_0.GetSelectPicture(arg_11_0, arg_11_1)
	return arg_11_0:GetArchive(arg_11_1).selected_picture
end

function var_0_0.SetSelectPictrue(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	var_0_1[arg_12_1].selected_picture = {
		id = arg_12_2,
		type = arg_12_3
	}
end

function var_0_0.GetHasViewedSuperHeartList(arg_13_0, arg_13_1)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(var_0_1[arg_13_1].super_heart_link_list) do
		if iter_13_1.is_viewed then
			table.insert(var_13_0, iter_13_1)
		end
	end

	return var_13_0
end

function var_0_0.GetHasViewedHeartList(arg_14_0, arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(var_0_1[arg_14_1].video_list) do
		table.insert(var_14_0, iter_14_0)
	end

	return var_14_0
end

function var_0_0.GetAnedoteList(arg_15_0, arg_15_1)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		local var_15_1 = HeroAnedoteCfg[iter_15_1]

		if var_15_1 then
			table.insert(var_15_0, var_15_1)
		end
	end

	return var_15_0
end

function var_0_0.GetArchiveList(arg_16_0)
	return var_0_1
end

function var_0_0.IsHeartRead(arg_17_0, arg_17_1, arg_17_2)
	if var_0_1[arg_17_1] == nil then
		return true
	end

	return var_0_1[arg_17_1].text_list[arg_17_2]
end

function var_0_0.IsStoryRead(arg_18_0, arg_18_1, arg_18_2)
	return var_0_1[arg_18_1].video_list[arg_18_2]
end

function var_0_0.SetHeartRead(arg_19_0, arg_19_1, arg_19_2)
	var_0_1[arg_19_1].text_list[arg_19_2] = true
end

function var_0_0.SetStoryRead(arg_20_0, arg_20_1, arg_20_2)
	var_0_1[arg_20_1].video_list[arg_20_2] = true
end

function var_0_0.IsArchiveStoryRead(arg_21_0, arg_21_1, arg_21_2)
	for iter_21_0, iter_21_1 in pairs(var_0_1[arg_21_1].hero_story_list) do
		if iter_21_1.hero_id == arg_21_2 then
			return iter_21_1.is_viewed
		end
	end

	return false
end

function var_0_0.SetArchiveStoryRead(arg_22_0, arg_22_1, arg_22_2)
	var_0_1[arg_22_1].hero_story_list[arg_22_2] = {
		is_viewed = true,
		hero_id = arg_22_2
	}
end

function var_0_0.IsSuperHeartRead(arg_23_0, arg_23_1, arg_23_2)
	if not var_0_1[arg_23_1].super_heart_link_list[arg_23_2] then
		return false
	end

	return var_0_1[arg_23_1].super_heart_link_list[arg_23_2].is_viewed
end

function var_0_0.SetSuperHeartRead(arg_24_0, arg_24_1, arg_24_2)
	var_0_1[arg_24_1].super_heart_link_list[arg_24_2] = {
		is_viewed = true,
		index = arg_24_2
	}
end

function var_0_0.GetUnlockHeartListInfoLengthByHeroId(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[arg_25_1][1])
	local var_25_1 = HeroRecordCfg[var_25_0.archive_id].hero_id
	local var_25_2 = 0
	local var_25_3 = 0
	local var_25_4 = 0

	for iter_25_0 = 1, 4 do
		local var_25_5 = GameSetting.hero_plot_unlock_condition.value[iter_25_0]
		local var_25_6, var_25_7, var_25_8 = IsConditionAchieved(var_25_5, {
			heroId = var_25_0.archive_id
		})

		if var_25_6 then
			var_25_2 = var_25_2 + 1
		end
	end

	if #HeroRecordCfg[var_25_0.archive_id].super_plot_id > 0 then
		for iter_25_1, iter_25_2 in ipairs(var_25_1) do
			local var_25_9 = 0

			for iter_25_3 = 1, 2 do
				local var_25_10 = GameSetting.hero_super_plot_unlock_condition.value[iter_25_3]
				local var_25_11, var_25_12, var_25_13 = IsConditionAchieved(var_25_10, {
					heroId = iter_25_2
				})

				if var_25_11 then
					var_25_9 = var_25_9 + 1
				end
			end

			var_25_3 = math.max(var_25_3, var_25_9)
		end
	end

	for iter_25_4, iter_25_5 in ipairs(var_25_1) do
		if HeroAnedoteCfg[iter_25_5] then
			local var_25_14 = GameSetting.hero_anecdote_unlock_condition.value[1]
			local var_25_15, var_25_16, var_25_17 = IsConditionAchieved(var_25_14, {
				heroId = iter_25_5
			})

			if var_25_15 then
				var_25_4 = var_25_4 + 1
			end
		end
	end

	return var_25_2, var_25_3, var_25_4
end

function var_0_0.GetArchive(arg_26_0, arg_26_1)
	if arg_26_1 == 0 or arg_26_1 == nil then
		return {
			archive_id = 0,
			exp = 0,
			lv = 1,
			gift_list = {},
			text_list = {},
			video_list = {},
			selected_picture = {},
			hero_story_list = {},
			super_heart_link_list = {}
		}
	end

	if not var_0_1[arg_26_1] then
		var_0_1[arg_26_1] = {
			exp = 0,
			lv = 1,
			archive_id = arg_26_1,
			gift_list = {},
			text_list = {},
			video_list = {},
			selected_picture = {},
			hero_story_list = {},
			super_heart_link_list = {}
		}
	end

	return var_0_1[arg_26_1]
end

function var_0_0.AddExp(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0:GetArchive(arg_27_1).exp + arg_27_2
	local var_27_1, var_27_2 = LvTools.LoveExpToLevel(var_27_0)

	var_0_1[arg_27_1].exp = var_27_0
	var_0_1[arg_27_1].lv = var_27_1

	OathSupportData:UpdateOathCanCompleteNotice(arg_27_1)
end

function var_0_0.AddGift(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = var_0_1[arg_28_1].gift_list

	for iter_28_0, iter_28_1 in pairs(arg_28_2) do
		var_28_0[iter_28_1.id] = (var_28_0[iter_28_1.id] or 0) + iter_28_1.num
	end
end

function var_0_0.GetTrustLevel(arg_29_0, arg_29_1)
	local var_29_0 = HeroData:GetHeroData(arg_29_1)

	return var_29_0.trust.level, var_29_0.trust.exp, var_29_0.trust.mood
end

function var_0_0.InitRelationStory(arg_30_0, arg_30_1)
	var_0_2 = {}

	for iter_30_0, iter_30_1 in ipairs(arg_30_1.got_reward_id_list) do
		table.insert(var_0_2, iter_30_1)
	end
end

function var_0_0.UpdateRelationStory(arg_31_0, arg_31_1)
	if not table.indexof(var_0_2, arg_31_1) then
		table.insert(var_0_2, arg_31_1)
	end
end

function var_0_0.GetRelationStoryRead(arg_32_0, arg_32_1)
	return table.indexof(var_0_2, arg_32_1)
end

function var_0_0.InitTrustGiftDisplaceCount(arg_33_0, arg_33_1)
	var_0_3 = {}

	for iter_33_0, iter_33_1 in ipairs(arg_33_1.limit_list) do
		var_0_3[iter_33_1.item_id] = iter_33_1.use
	end
end

function var_0_0.ClearTrustGiftDisplaceCount(arg_34_0)
	var_0_3 = {}
end

function var_0_0.UpdateTrustGiftDisplaceCount(arg_35_0, arg_35_1, arg_35_2)
	if var_0_3[arg_35_1] then
		var_0_3[arg_35_1] = var_0_3[arg_35_1] + arg_35_2
	else
		var_0_3[arg_35_1] = arg_35_2
	end
end

function var_0_0.GetTrustGiftDisplaceCount(arg_36_0, arg_36_1)
	return var_0_3[arg_36_1] or 0
end

return var_0_0
