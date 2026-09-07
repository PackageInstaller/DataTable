local BossRushChapterRemasterHelper = class("BossRushChapterRemasterHelper")
local var_0_1 = {
	SP = 2,
	SIA = 4,
	SEA = 3,
	EX = 1
}

function BossRushChapterRemasterHelper:GetExOrSp4Filter()
	if self == var_0_1.EX or self == var_0_1.SP then
		return self
	elseif self == var_0_1.SEA or self == var_0_1.SIA then
		return var_0_1.SP
	end

	return var_0_1.EX
end

function BossRushChapterRemasterHelper:IsRemasterByActivity()
	return pg.re_map_template[self].activity_type == var_0_1.SEA or pg.re_map_template[self].activity_type == var_0_1.SIA
end

function BossRushChapterRemasterHelper:GetRemasterByActivityId()
	if not self then
		return nil
	end

	for iter_3_0, iter_3_1 in ipairs(pg.re_map_template.all) do
		if pg.re_map_template[iter_3_1].activity_id == self then
			return pg.re_map_template[iter_3_1]
		end
	end

	return
end

function BossRushChapterRemasterHelper:GetActivityRemasterByFinalSeriesId(arg_4_1)
	local var_4_0 = BossRushChapterRemasterHelper.GetRemasterByActivityId(self)

	if not var_4_0 or not BossRushChapterRemasterHelper.IsRemasterByActivity(var_4_0.id) then
		return nil
	end

	local var_4_1 = var_4_0.config_data or {}

	if var_4_1[#var_4_1] == arg_4_1 then
		return var_4_0
	end

	return
end

function BossRushChapterRemasterHelper:GetMemoryGroupStoryIds()
	local var_5_0 = self and pg.memory_group[self]

	if not (self and pg.memory_group[self]) then
		return {}
	end

	local var_5_1 = pg.NewStoryMgr.GetInstance()
	local var_5_2 = {}
	local var_5_3 = {}

	local function var_5_4(arg_6_0)
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
	end

	for iter_5_0, iter_5_1 in ipairs(var_5_0.memories or {}) do
		if pg.memory_template[iter_5_1] then
			var_5_4(pg.memory_template[iter_5_1].story)

			if type(pg.memory_template[iter_5_1].unlock_pre) == "table" then
				for iter_5_2, iter_5_3 in ipairs(pg.memory_template[iter_5_1].unlock_pre) do
					var_5_4(iter_5_3)
				end
			else
				var_5_4(pg.memory_template[iter_5_1].unlock_pre)
			end
		end
	end

	return var_5_2
end

function BossRushChapterRemasterHelper:UnlockMemoryGroupStories(arg_7_1)
	arg_7_1 = arg_7_1 or {}

	local var_7_0 = BossRushChapterRemasterHelper.GetMemoryGroupStoryIds(self)

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

function BossRushChapterRemasterHelper:ShowUnlockMemoryMsgBox(arg_8_1, arg_8_2, arg_8_3)
	if not self or not arg_8_1 or #arg_8_1 <= 0 then
		if arg_8_3 then
			arg_8_3()
		end

		return
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		yesText = "text_go",
		content = i18n("levelScene_remaster_story_tip", pg.memory_group[self].title),
		onYes = arg_8_2,
		onNo = arg_8_3
	})

	return
end

function BossRushChapterRemasterHelper:MarkMemoryGroupNotification()
	if not self then
		return
	end

	PlayerPrefs.SetInt("MEMORY_GROUP_NOTIFICATION" .. getProxy(PlayerProxy):getRawData().id .. " " .. self, 1)
	PlayerPrefs.Save()

	return
end

function BossRushChapterRemasterHelper:IsAllStoriesPlayed()
	local var_10_0 = self and pg.memory_group[self]

	if not (self and pg.memory_group[self]) then
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

function BossRushChapterRemasterHelper:UnlockMemoryGroupStoriesAndShowMsgBox(arg_11_1)
	local var_11_0 = BossRushChapterRemasterHelper.UnlockMemoryGroupStories(self)

	if #var_11_0 <= 0 then
		return false
	end

	if BossRushChapterRemasterHelper.IsAllStoriesPlayed(self) then
		return false
	end

	BossRushChapterRemasterHelper.ShowUnlockMemoryMsgBox(self, var_11_0, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
			page = WorldMediaCollectionScene.PAGE_MEMORTY,
			memoryGroup = self
		})

		return
	end, function()
		BossRushChapterRemasterHelper.MarkMemoryGroupNotification(self)

		if arg_11_1 then
			arg_11_1(var_11_0)
		end

		return
	end)

	return true
end

function BossRushChapterRemasterHelper:GetPermanentActivityTicketCost(arg_14_1)
	if not self or not arg_14_1 or not pg.activity_task_permanent[self] then
		return 0
	end

	local var_14_0 = BossRushChapterRemasterHelper.GetRemasterByActivityId(self)

	if not var_14_0 then
		return 0
	end

	for iter_14_0, iter_14_1 in ipairs(var_14_0.config_data or {}) do
		if iter_14_1 == arg_14_1 then
			return var_14_0.tickets[iter_14_0] or 0
		end
	end

	return 0
end

function BossRushChapterRemasterHelper:GetChapterIds()
	if BossRushChapterRemasterHelper.IsRemasterByActivity(self) then
		return {}
	else
		return (pg.re_map_template[self] or nil) and (pg.re_map_template[self].config_data or {})
	end

	return
end

function BossRushChapterRemasterHelper.GetAllNonActivityIds()
	local var_16_0 = {}

	_.each(pg.re_map_template.all, function(arg_17_0)
		if not BossRushChapterRemasterHelper.IsRemasterByActivity(arg_17_0) then
			table.insert(var_16_0, arg_17_0)
		end

		return
	end)

	return var_16_0
end

function BossRushChapterRemasterHelper:GetProgress()
	if not self then
		return 0
	end

	if BossRushChapterRemasterHelper.IsRemasterByActivity(self) then
		local var_18_0 = pg.re_map_template[self] and getProxy(ActivityProxy):getActivityById(pg.re_map_template[self].activity_id)

		if not var_18_0 then
			return 0
		end

		local var_18_1 = 0

		for iter_18_0, iter_18_1 in ipairs(pg.re_map_template[self].config_data) do
			if var_18_0:HasPassSeries(iter_18_1) then
				var_18_1 = math.max(var_18_1, pg.re_map_template[self].chapter_progress[iter_18_0])
			end
		end

		return var_18_1
	else
		local var_18_2 = getProxy(ChapterProxy)
		local var_18_3 = 0

		for iter_18_2, iter_18_3 in ipairs(pg.re_map_template[self].config_data) do
			if var_18_2:getChapterById(iter_18_3):isClear() then
				var_18_3 = math.max(var_18_3, pg.re_map_template[self].chapter_progress[iter_18_2])
			end
		end

		return var_18_3
	end

	return
end

function BossRushChapterRemasterHelper:ChapterAwardInfo(arg_19_1)
	if not self then
		return nil
	end

	local var_19_0
	local var_19_1 = getProxy(ChapterProxy)

	arg_19_1 = arg_19_1 or pg.re_map_template[self].activity_id or 0

	if self and #pg.re_map_template[self].drop_gain > 0 then
		for iter_19_0, iter_19_1 in ipairs(pg.re_map_template[self].drop_gain) do
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

function BossRushChapterRemasterHelper:ExistCanGetAward(arg_20_1)
	if not self then
		return false
	end

	local var_20_0 = getProxy(ChapterProxy)

	arg_20_1 = arg_20_1 or pg.re_map_template[self].activity_id or 0

	for iter_20_0, iter_20_1 in ipairs(pg.re_map_template[self].drop_gain) do
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

function BossRushChapterRemasterHelper:GetAwardName(arg_21_1)
	if self and self > 0 then
		if pg.activity_series_enemy then
			local var_21_0 = pg.activity_series_enemy[arg_21_1] or pg.extraenemy_series_template and pg.extraenemy_series_template[arg_21_1]
			local var_21_1

			if var_21_0 then
				var_21_1 = var_21_0.name or var_21_0.chapter_name2 or var_21_0.chapter_name or ""
			end
		end

		return var_21_1
	end

	return pg.chapter_template[arg_21_1].chapter_name
end

return BossRushChapterRemasterHelper
