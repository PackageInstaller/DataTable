local var_0_0 = class("BossRushChapterRemasterHelper")
local var_0_1 = {
	SP = 2,
	SIA = 4,
	SEA = 3,
	EX = 1
}

function var_0_0.GetExOrSp4Filter(arg_1_0)
	if arg_1_0 == var_0_1.EX or arg_1_0 == var_0_1.SP then
		return arg_1_0
	elseif arg_1_0 == var_0_1.SEA or arg_1_0 == var_0_1.SIA then
		return var_0_1.SP
	end

	return var_0_1.EX
end

function var_0_0.IsRemasterByActivity(arg_2_0)
	local var_2_0 = pg.re_map_template[arg_2_0].activity_type

	return pg.re_map_template[arg_2_0].activity_type == var_0_1.SEA or var_2_0 == var_0_1.SIA
end

function var_0_0.GetRemasterByActivityId(arg_3_0)
	if not arg_3_0 then
		return nil
	end

	for iter_3_0, iter_3_1 in ipairs(pg.re_map_template.all) do
		if pg.re_map_template[iter_3_1].activity_id == arg_3_0 then
			return pg.re_map_template[iter_3_1]
		end
	end

	return
end

function var_0_0.GetActivityRemasterByFinalSeriesId(arg_4_0, arg_4_1)
	local var_4_0 = var_0_0.GetRemasterByActivityId(arg_4_0)

	if not var_4_0 or not var_0_0.IsRemasterByActivity(var_4_0.id) then
		return nil
	end

	local var_4_1 = var_4_0.config_data or {}

	if var_4_1[#var_4_1] == arg_4_1 then
		return var_4_0
	end

	return
end

function var_0_0.GetMemoryGroupStoryIds(arg_5_0)
	local var_5_0 = arg_5_0 and pg.memory_group[arg_5_0]

	if not (arg_5_0 and pg.memory_group[arg_5_0]) then
		return {}
	end

	local var_5_1 = pg.NewStoryMgr.GetInstance()
	local var_5_2 = {}
	local var_5_3 = {}
	local var_5_4 = var_5_0.memories or {}

	for iter_5_0, iter_5_1 in ipairs(var_5_4) do
		if pg.memory_template[iter_5_1] then
			(function(arg_6_0)
				if not arg_6_0 or arg_6_0 == "" then
					return
				end

				local var_6_0, var_6_1 = var_5_1:StoryName2StoryId(arg_6_0)

				if var_6_0 and var_6_0 > 0 and not var_5_3[var_6_0] and not var_5_1:GetPlayedFlag(var_6_0) then
					var_5_3[var_6_0] = true

					table.insert(var_5_2, var_6_0)
				end

				if var_6_1 and var_6_1 > 0 and not var_5_3[var_6_1] and not var_5_1:GetPlayedFlag(var_6_1) then
					var_5_3[var_6_1] = true

					table.insert(var_5_2, var_6_1)
				end

				return
			end)(pg.memory_template[iter_5_1].story)

			if type(pg.memory_template[iter_5_1].unlock_pre) == "table" then
				for iter_5_2, iter_5_3 in ipairs(pg.memory_template[iter_5_1].unlock_pre) do
					(function(arg_6_0)
						if not arg_6_0 or arg_6_0 == "" then
							return
						end

						local var_6_0, var_6_1 = var_5_1:StoryName2StoryId(arg_6_0)

						if var_6_0 and var_6_0 > 0 and not var_5_3[var_6_0] and not var_5_1:GetPlayedFlag(var_6_0) then
							var_5_3[var_6_0] = true

							table.insert(var_5_2, var_6_0)
						end

						if var_6_1 and var_6_1 > 0 and not var_5_3[var_6_1] and not var_5_1:GetPlayedFlag(var_6_1) then
							var_5_3[var_6_1] = true

							table.insert(var_5_2, var_6_1)
						end

						return
					end)(iter_5_3)
				end
			else
				(function(arg_6_0)
					if not arg_6_0 or arg_6_0 == "" then
						return
					end

					local var_6_0, var_6_1 = var_5_1:StoryName2StoryId(arg_6_0)

					if var_6_0 and var_6_0 > 0 and not var_5_3[var_6_0] and not var_5_1:GetPlayedFlag(var_6_0) then
						var_5_3[var_6_0] = true

						table.insert(var_5_2, var_6_0)
					end

					if var_6_1 and var_6_1 > 0 and not var_5_3[var_6_1] and not var_5_1:GetPlayedFlag(var_6_1) then
						var_5_3[var_6_1] = true

						table.insert(var_5_2, var_6_1)
					end

					return
				end)(pg.memory_template[iter_5_1].unlock_pre)
			end
		end
	end

	return {}
end

function var_0_0.UnlockMemoryGroupStories(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or {}

	local var_7_0 = var_0_0.GetMemoryGroupStoryIds(arg_7_0)

	if #var_7_0 <= 0 then
		if arg_7_1.callback then
			arg_7_1.callback()
		end

		return var_7_0
	end

	if arg_7_1.sync then
		pg.m02:sendNotification(GAME.STORY_UPDATE_LIST, {
			storyIds = var_7_0,
			callback = arg_7_1.callback
		})
	else
		pg.NewStoryMgr.GetInstance():SetPlayedFlagList(var_7_0)

		if arg_7_1.callback then
			arg_7_1.callback()
		end
	end

	return var_7_0
end

function var_0_0.ShowUnlockMemoryMsgBox(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_0 or not arg_8_1 or #arg_8_1 <= 0 then
		if arg_8_3 then
			arg_8_3()
		end

		return
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		yesText = "text_go",
		content = i18n("levelScene_remaster_story_tip", pg.memory_group[arg_8_0].title),
		onYes = arg_8_2,
		onNo = arg_8_3
	})

	return
end

function var_0_0.MarkMemoryGroupNotification(arg_9_0)
	if not arg_9_0 then
		return
	end

	local var_9_0 = getProxy(PlayerProxy)

	PlayerPrefs.SetInt("MEMORY_GROUP_NOTIFICATION" .. var_9_0:getRawData().id .. " " .. arg_9_0, 1)
	PlayerPrefs.Save()

	return
end

function var_0_0.IsAllStoriesPlayed(arg_10_0)
	local var_10_0 = arg_10_0 and pg.memory_group[arg_10_0]

	if not (arg_10_0 and pg.memory_group[arg_10_0]) then
		return false
	end

	local var_10_1 = var_10_0.memories

	if not var_10_0.memories then
		return true
	end

	local var_10_2 = pg.NewStoryMgr.GetInstance()
	local var_10_3 = var_10_2:GetPlayedList()

	for iter_10_0 = 1, #var_10_1 do
		local var_10_4 = pg.memory_template[var_10_1[iter_10_0]] and pg.memory_template[var_10_1[iter_10_0]].story

		if pg.memory_template[var_10_1[iter_10_0]] and pg.memory_template[var_10_1[iter_10_0]].story and var_10_4 ~= "" then
			local var_10_5, var_10_6 = var_10_2:StoryName2StoryId(var_10_4)

			if var_10_5 and var_10_5 > 0 and not var_10_3[var_10_5] then
				return false
			end
		end
	end

	return true
end

function var_0_0.UnlockMemoryGroupStoriesAndShowMsgBox(arg_11_0, arg_11_1)
	local var_11_0 = var_0_0.UnlockMemoryGroupStories(arg_11_0)

	if #var_11_0 <= 0 then
		return false
	end

	if var_0_0.IsAllStoriesPlayed(arg_11_0) then
		return false
	end

	var_0_0.ShowUnlockMemoryMsgBox(arg_11_0, var_11_0, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
			page = WorldMediaCollectionScene.PAGE_MEMORTY,
			memoryGroup = arg_11_0
		})

		return
	end, function()
		var_0_0.MarkMemoryGroupNotification(arg_11_0)

		if arg_11_1 then
			arg_11_1(var_11_0)
		end

		return
	end)

	return true
end

function var_0_0.GetPermanentActivityTicketCost(arg_14_0, arg_14_1)
	if not arg_14_0 or not arg_14_1 or not pg.activity_task_permanent[arg_14_0] then
		return 0
	end

	local var_14_0 = var_0_0.GetRemasterByActivityId(arg_14_0)

	if not var_14_0 then
		return 0
	end

	local var_14_2 = var_14_0.config_data or {}

	for iter_14_0, iter_14_1 in var_14_1(var_14_2) do
		if iter_14_1 == arg_14_1 then
			return var_14_0.tickets[iter_14_0] or 0
		end
	end

	return 0
end

function var_0_0.GetChapterIds(arg_15_0)
	local var_15_0 = pg.re_map_template[arg_15_0]

	if var_0_0.IsRemasterByActivity(arg_15_0) then
		do return {} end

		goto label_15_0
	end

	::label_15_0::

	if pg.re_map_template[arg_15_0] then
		do
			return var_15_0.config_data or {}
		end

		return
	end
end

function var_0_0.GetAllNonActivityIds()
	local var_16_0 = {}

	_.each(pg.re_map_template.all, function(arg_17_0)
		if not var_0_0.IsRemasterByActivity(arg_17_0) then
			table.insert(var_16_0, arg_17_0)
		end

		return
	end)

	return {}
end

function var_0_0.GetProgress(arg_18_0)
	if not arg_18_0 then
		return 0
	end

	if var_0_0.IsRemasterByActivity(arg_18_0) then
		local var_18_0 = pg.re_map_template[arg_18_0] and getProxy(ActivityProxy):getActivityById(pg.re_map_template[arg_18_0].activity_id)

		if not var_18_0 then
			return 0
		end

		local var_18_1 = 0

		for iter_18_0, iter_18_1 in ipairs(pg.re_map_template[arg_18_0].config_data) do
			if var_18_0:HasPassSeries(iter_18_1) then
				var_18_1 = math.max(var_18_1, pg.re_map_template[arg_18_0].chapter_progress[iter_18_0])
			end
		end

		return var_18_1
	else
		local var_18_2 = getProxy(ChapterProxy)
		local var_18_3 = 0

		for iter_18_2, iter_18_3 in ipairs(pg.re_map_template[arg_18_0].config_data) do
			local var_18_4 = var_18_2:getChapterById(iter_18_3)

			if var_18_4:isClear() then
				var_18_3 = math.max(var_18_3, pg.re_map_template[arg_18_0].chapter_progress[iter_18_2])
			end
		end

		return var_18_3
	end

	return
end

function var_0_0.ChapterAwardInfo(arg_19_0, arg_19_1)
	if not arg_19_0 then
		return nil
	end

	local var_19_0
	local var_19_1 = getProxy(ChapterProxy)

	arg_19_1 = arg_19_1 or pg.re_map_template[arg_19_0].activity_id or 0

	if arg_19_0 and #pg.re_map_template[arg_19_0].drop_gain > 0 then
		for iter_19_0, iter_19_1 in ipairs(pg.re_map_template[arg_19_0].drop_gain) do
			local var_19_2 = #iter_19_1 > 0 and var_19_1:getRemasterInfo(arg_19_1, iter_19_1[1], iter_19_0)

			if var_19_2 and var_19_2.receive == false then
				var_19_0 = {
					iter_19_0,
					iter_19_1,
					arg_19_1
				}

				break
			end
		end
	end

	return var_19_0
end

function var_0_0.ExistCanGetAward(arg_20_0, arg_20_1)
	if not arg_20_0 then
		return false
	end

	local var_20_0 = getProxy(ChapterProxy)

	arg_20_1 = arg_20_1 or pg.re_map_template[arg_20_0].activity_id or 0

	for iter_20_0, iter_20_1 in ipairs(pg.re_map_template[arg_20_0].drop_gain) do
		if #iter_20_1 > 0 then
			local var_20_1, var_20_2, var_20_3, var_20_4 = unpack(iter_20_1)
			local var_20_5 = var_20_0:getRemasterInfo(arg_20_1, var_20_1, iter_20_0)

			if var_20_5 and not var_20_5.receive and var_20_4 <= var_20_5.count then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetAwardName(arg_21_0, arg_21_1)
	if arg_21_0 and arg_21_0 > 0 then
		if pg.activity_series_enemy then
			local var_21_0 = pg.activity_series_enemy[arg_21_1] or pg.extraenemy_series_template and pg.extraenemy_series_template[arg_21_1]

			if var_21_0 then
				do return var_21_0.name or var_21_0.chapter_name2 or var_21_0.chapter_name or "" end
				return pg.chapter_template[arg_21_1].chapter_name
			end
		end
	end
end

return var_0_0
