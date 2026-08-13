class = var_0_10000

local var_0_0 = var_0_10000("BossRushChapterRemasterHelper")
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
	pg = var_1_10001

	return var_1_10001.re_map_template[arg_2_0].activity_type == var_0_1.SEA or var_2 == var_0_1.SIA
end

function var_0_0.GetRemasterByActivityId(arg_3_0)
	if not arg_3_0 then
		return nil
	end

	ipairs = var_1_10001
	pg = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10001(var_1_10003.re_map_template.all) do
		pg = var_1_10006

		if var_1_10006.re_map_template[iter_3_1].activity_id == arg_3_0 then
			return var_1_10006
		end
	end

	return
end

function var_0_0.GetActivityRemasterByFinalSeriesId(arg_4_0, arg_4_1)
	if not var_0_0.GetRemasterByActivityId(arg_4_0) or not var_0_0.IsRemasterByActivity(var_2.id) then
		return nil
	end

	local var_4_0

	if not var_2.config_data then
		var_4_0 = {}
	end

	if var_4_0[#var_4_0] == arg_4_1 then
		return var_2
	end

	return
end

function var_0_0.GetMemoryGroupStoryIds(arg_5_0)
	local var_5_0

	if arg_5_0 then
		::label_5_0::

		pg = var_5_0
		var_5_0 = var_5_0.memory_group[arg_5_0]
	end

	if not var_5_0 then
		return {}
	end

	pg = var_1_10002

	local var_5_1 = var_1_10002.NewStoryMgr.GetInstance()
	local var_5_2 = {}
	local var_5_3 = {}

	local function var_5_4(arg_6_0)
		if not arg_6_0 or arg_6_0 == "" then
			return
		end

		local var_6_0 = var_5_1
		local var_6_1, var_6_2 = var_1.StoryName2StoryId(var_6_0, arg_6_0)

		if var_6_1 and var_6_1 > 0 and not var_5_3[var_6_1] then
			local var_6_3 = var_5_1

			if not var_3.GetPlayedFlag(var_6_3, var_6_1) then
				local var_6_4 = var_5_3

				var_6_4[var_6_1] = true
				table = var_6_4

				var_6_4.insert(var_5_2, var_6_1)
			end
		end

		if var_6_2 and var_6_2 > 0 and not var_5_3[var_6_2] then
			local var_6_5 = var_5_1

			if not var_3.GetPlayedFlag(var_6_5, var_6_2) then
				local var_6_6 = var_5_3

				var_6_6[var_6_2] = true
				table = var_6_6

				var_6_6.insert(var_5_2, var_6_2)
			end
		end

		return
	end

	ipairs = var_1_10006

	local var_5_5

	if not var_5_0.memories then
		var_5_5 = {}
	end

	for iter_5_0, iter_5_1 in var_1_10006(var_5_5) do
		pg = var_1_10011

		if var_1_10011.memory_template[iter_5_1] then
			var_5_4(var_1_10011.story)

			type = var_12

			if var_12(var_1_10011.unlock_pre) == "table" then
				ipairs = var_12

				for iter_5_2, iter_5_3 in var_12(var_1_10011.unlock_pre) do
					var_5_4(iter_5_3)
				end
			else
				var_5_4(var_1_10011.unlock_pre)
			end
		end
	end

	return var_5_2
end

function var_0_0.UnlockMemoryGroupStories(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or {}

	if #var_0_0.GetMemoryGroupStoryIds(arg_7_0) <= 0 then
		if arg_7_1.callback then
			arg_7_1.callback()
		end

		return var_2
	end

	local var_7_1

	if arg_7_1.sync then
		pg = var_7_1

		local var_7_0 = var_7_1.m02

		var_7_1 = var_7_1.sendNotification
		GAME = var_1_10006

		var_7_1(var_7_0, var_1_10006.STORY_UPDATE_LIST, {
			storyIds = var_2,
			callback = arg_7_1.callback
		})
	else
		pg = var_7_1

		local var_7_2 = var_7_1.NewStoryMgr.GetInstance()

		var_3.SetPlayedFlagList(var_7_2, var_2)

		if arg_7_1.callback then
			arg_7_1.callback()
		end
	end

	return var_2
end

function var_0_0.ShowUnlockMemoryMsgBox(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_0 or not arg_8_1 or #arg_8_1 <= 0 then
		if arg_8_3 then
			arg_8_3()
		end

		return
	end

	pg = var_1_10004

	local var_8_0 = var_1_10004.MsgboxMgr.GetInstance()
	local var_8_1 = var_4.ShowMsgBox
	local var_8_2 = {
		yesText = "text_go"
	}

	i18n = var_1_10008

	local var_8_3 = "levelScene_remaster_story_tip"

	pg = var_1_10011
	var_8_2.content = var_1_10008(var_8_3, var_1_10011.memory_group[arg_8_0].title)
	var_8_2.onYes = arg_8_2
	var_8_2.onNo = arg_8_3

	var_8_1(var_8_0, var_8_2)

	return
end

function var_0_0.MarkMemoryGroupNotification(arg_9_0)
	if not arg_9_0 then
		return
	end

	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_9_0 = var_1_10001(var_1_10003)
	local var_9_1 = var_1.getRawData(var_9_0).id

	PlayerPrefs = var_1_10002

	var_1_10002.SetInt("MEMORY_GROUP_NOTIFICATION" .. var_9_1 .. " " .. arg_9_0, 1)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_0.IsAllStoriesPlayed(arg_10_0)
	local var_10_0

	if arg_10_0 then
		::label_10_0::

		pg = var_10_0
		var_10_0 = var_10_0.memory_group[arg_10_0]
	end

	if not var_10_0 then
		return false
	end

	if not var_10_0.memories then
		return true
	end

	pg = var_1_10003

	local var_10_1 = var_1_10003.NewStoryMgr.GetInstance()
	local var_10_2 = var_3.GetPlayedList(var_10_1)

	pg = var_1_10005

	local var_10_3 = var_1_10005.memory_template

	for iter_10_0 = 1, #var_2 do
		if var_10_3[var_2[iter_10_0]] and var_10.story and var_11 ~= "" then
			local var_10_4, var_10_5 = var_3:StoryName2StoryId(var_11)

			if var_10_4 and var_10_4 > 0 and not var_10_2[var_10_4] then
				return false
			end
		end
	end

	return true
end

function var_0_0.UnlockMemoryGroupStoriesAndShowMsgBox(arg_11_0, arg_11_1)
	local var_11_0 = var_0_0.IsAllStoriesPlayed(arg_11_0)

	if #var_0_0.UnlockMemoryGroupStories(arg_11_0) <= 0 then
		return false
	end

	if var_11_0 then
		return false
	end

	var_0_0.ShowUnlockMemoryMsgBox(arg_11_0, var_3, function()
		pg = var_2_10000

		local var_12_0 = var_2_10000.m02
		local var_12_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_12_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_12_3 = var_2_10004.WORLD_COLLECTION
		local var_12_4 = {}

		WorldMediaCollectionScene = var_2_10006
		var_12_4.page = var_2_10006.PAGE_MEMORTY
		var_12_4.memoryGroup = arg_11_0

		var_12_1(var_12_0, var_12_2, var_12_3, var_12_4)

		return
	end, function()
		var_0_0.MarkMemoryGroupNotification(arg_11_0)

		if arg_11_1 then
			arg_11_1(var_0)
		end

		return
	end)

	return true
end

function var_0_0.GetPermanentActivityTicketCost(arg_14_0, arg_14_1)
	if arg_14_0 and arg_14_1 then
		pg = var_1_10002

		if not var_1_10002.activity_task_permanent[arg_14_0] then
			return 0
		end

		if not var_0_0.GetRemasterByActivityId(arg_14_0) then
			return 0
		end

		ipairs = var_1_10003

		local var_14_0

		if not var_2.config_data then
			var_14_0 = {}
		end

		for iter_14_0, iter_14_1 in var_1_10003(var_14_0) do
			if iter_14_1 == arg_14_1 then
				local var_14_1

				if not var_2.tickets[iter_14_0] then
					var_14_1 = 0
				end

				return var_14_1
			end
		end

		return 0
	end
end

function var_0_0.GetChapterIds(arg_15_0)
	if var_0_0.IsRemasterByActivity(arg_15_0) then
		return {}
	else
		pg = var_1

		local var_15_0

		if not var_1.re_map_template[arg_15_0] or not var_1.config_data then
			var_15_0 = {}
		end

		return var_15_0
	end

	return
end

function var_0_0.GetAllNonActivityIds()
	local var_16_0 = {}

	_ = var_1_10001

	local var_16_1 = var_1_10001.each

	pg = var_1_10003

	var_16_1(var_1_10003.re_map_template.all, function(arg_17_0)
		if not var_0_0.IsRemasterByActivity(arg_17_0) then
			table = var_1

			var_1.insert(var_16_0, arg_17_0)
		end

		return
	end)

	return var_16_0
end

function var_0_0.GetProgress(arg_18_0)
	if not arg_18_0 then
		return 0
	end

	local var_18_0

	if var_0_0.IsRemasterByActivity(arg_18_0) then
		pg = var_1

		if var_1.re_map_template[arg_18_0] then
			::label_18_0::

			getProxy = var_1_10002
			ActivityProxy = var_1_10004
			var_1_10004 = var_1_10002(var_1_10004)
			var_1_10002 = var_1_10002.getActivityById(var_1_10004, var_1.activity_id)
		end

		if not var_1_10002 then
			return 0
		end

		var_18_0 = 0
		ipairs = var_1_10004

		for iter_18_0, iter_18_1 in var_1_10004(var_1.config_data) do
			if var_1_10002:HasPassSeries(iter_18_1) then
				math = var_9
				var_18_0 = var_9.max(var_18_0, var_1.chapter_progress[iter_18_0])
			end
		end

		return var_18_0
	else
		getProxy = var_1
		ChapterProxy = var_18_0

		local var_18_1 = var_1(var_18_0)

		pg = var_1_10002

		local var_18_2 = var_1_10002.re_map_template[arg_18_0]
		local var_18_3 = 0

		ipairs = var_1_10004

		for iter_18_2, iter_18_3 in var_1_10004(var_18_2.config_data) do
			local var_18_4 = var_18_1:getChapterById(iter_18_3)

			if var_9.isClear(var_18_4) then
				math = var_9
				var_18_3 = var_9.max(var_18_3, var_18_2.chapter_progress[iter_18_2])
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

	getProxy = var_1_10003
	ChapterProxy = var_1_10005

	local var_19_1 = var_1_10003(var_1_10005)

	pg = var_1_10004

	local var_19_2 = var_1_10004.re_map_template[arg_19_0]

	arg_19_1 = arg_19_1 or var_19_2.activity_id or 0

	if arg_19_0 and #var_19_2.drop_gain > 0 then
		ipairs = var_5

		for iter_19_0, iter_19_1 in var_5(var_19_2.drop_gain) do
			if #iter_19_1 > 0 and var_19_1:getRemasterInfo(arg_19_1, iter_19_1[1], iter_19_0) and var_10.receive == false then
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

	getProxy = var_1_10002
	ChapterProxy = var_1_10004

	local var_20_0 = var_1_10002(var_1_10004)

	pg = var_1_10003

	local var_20_1 = var_1_10003.re_map_template[arg_20_0]

	arg_20_1 = arg_20_1 or var_20_1.activity_id or 0
	ipairs = var_1_10004

	for iter_20_0, iter_20_1 in var_1_10004(var_20_1.drop_gain) do
		if #iter_20_1 > 0 then
			unpack = var_9

			local var_20_2, var_20_3, var_20_4, var_20_5 = var_9(iter_20_1)

			if var_20_0:getRemasterInfo(arg_20_1, var_20_2, iter_20_0) and not var_13.receive and var_20_5 <= var_13.count then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetAwardName(arg_21_0, arg_21_1)
	if arg_21_0 and 0 < arg_21_0 then
		pg = var_1_10002

		if var_1_10002.activity_series_enemy then
			pg = var_1_10002

			if not var_1_10002.activity_series_enemy[arg_21_1] then
				pg = var_1_10002

				if var_1_10002.extraenemy_series_template then
					pg = var_1_10002
					var_1_10002 = var_1_10002.extraenemy_series_template[arg_21_1]
				end
			end

			local var_21_0

			if not var_1_10002 or not var_1_10002.name and not var_1_10002.chapter_name2 and not var_1_10002.chapter_name then
				var_21_0 = ""
			end

			do return var_21_0 end

			pg = var_1_10002

			return var_1_10002.chapter_template[arg_21_1].chapter_name
		end
	end
end

return var_0_0
