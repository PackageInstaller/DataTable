return {
	Init = function(arg_1_0)
		arg_1_0.NewTagList = {
			[204] = true
		}
		arg_1_0.newStageIdList = {}

		arg_1_0:AddResourceToggleList()

		arg_1_0.chapterSystemId = {}

		for iter_1_0, iter_1_1 in pairs(arg_1_0.NewTagList) do
			arg_1_0.chapterSystemId[GetSystemIdByClientChapterId(iter_1_0)] = iter_1_0
		end

		arg_1_0.NewTagPrefix = "DailyChapterNewTag_"
		arg_1_0.OldNewTagKeyList = {}
	end,
	AddResourceToggleList = function(arg_2_0)
		local var_2_0 = ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.RESOURCE]

		for iter_2_0 = 1, #var_2_0 do
			local var_2_1 = var_2_0[iter_2_0]
			local var_2_2 = GetSystemIdByClientChapterId(var_2_1)

			if var_2_2 and var_2_2 > 0 then
				arg_2_0.NewTagList[var_2_1] = true

				local var_2_3 = ChapterCfg[var_2_1].section_id_list or {}

				for iter_2_1, iter_2_2 in ipairs(var_2_3) do
					arg_2_0.newStageIdList[iter_2_2] = true
				end
			end
		end
	end,
	CheckNeedNewTag = function(arg_3_0, arg_3_1)
		if arg_3_0.NewTagList[arg_3_1] then
			return true
		end

		return false
	end,
	AlreadyPlayOnce = function(arg_4_0, arg_4_1)
		if BattleStageData:GetStageClearTimes(arg_4_1) ~= 0 then
			return true
		end

		return false
	end,
	ClearOldNewTag = function(arg_5_0)
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.OldNewTagKeyList) do
			manager.redPoint:setTip(iter_5_1, 0, RedPointStyle.SHOW_NEW_TAG)
		end

		arg_5_0.OldNewTagKeyList = {}
	end,
	InitNewTagData = function(arg_6_0)
		arg_6_0:ClearOldNewTag()

		for iter_6_0, iter_6_1 in pairs(arg_6_0.NewTagList) do
			arg_6_0:InitChapter(iter_6_0)
		end
	end,
	InitChapter = function(arg_7_0, arg_7_1)
		if not ChapterCfg[arg_7_1] then
			return
		end

		if ChapterClientCfg[arg_7_1] and SystemData:ServerSystemIsLocked(GetSystemIdByClientChapterId(arg_7_1)) then
			return
		end

		local var_7_0 = ChapterCfg[arg_7_1].section_id_list
		local var_7_1 = getData("chapterDailyNewTag", "newTag" .. arg_7_1) or {}
		local var_7_2 = {}

		for iter_7_0, iter_7_1 in ipairs(var_7_1) do
			var_7_2[iter_7_1.stageId] = iter_7_0
		end

		local var_7_3 = {}

		for iter_7_2, iter_7_3 in ipairs(var_7_0) do
			if BattleStageData:GetStageIsOpen(iter_7_3) then
				local var_7_4 = var_7_2[iter_7_3]
				local var_7_5 = false

				if var_7_4 then
					if arg_7_0:AlreadyPlayOnce(iter_7_3) then
						var_7_1[var_7_4].needNew = false
						var_7_5 = false
					else
						var_7_5 = var_7_1[var_7_4].needNew
					end
				else
					local var_7_6 = {
						needNew = false,
						stageId = iter_7_3
					}

					if not arg_7_0:AlreadyPlayOnce(iter_7_3) then
						var_7_6.needNew = true
						var_7_5 = true
					end

					table.insert(var_7_1, var_7_6)
				end

				if var_7_5 then
					arg_7_0:AppendRedKey(iter_7_3)
					arg_7_0:DispatchNewTag(iter_7_3)
					table.insert(arg_7_0.OldNewTagKeyList, arg_7_0:GetNewRedKey(iter_7_3))
				end
			end
		end

		saveData("chapterDailyNewTag", "newTag" .. arg_7_1, var_7_1)
	end,
	OnSystemUnlock = function(arg_8_0, arg_8_1)
		for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
			if arg_8_0.chapterSystemId[iter_8_1] then
				arg_8_0:InitChapter(arg_8_0.chapterSystemId[iter_8_1])
			end
		end
	end,
	GetNewRedKey = function(arg_9_0, arg_9_1)
		local var_9_0 = getChapterIDByStageID(arg_9_1)

		return table.concat({
			arg_9_0.NewTagPrefix,
			var_9_0,
			"_",
			arg_9_1
		})
	end,
	DispatchNewTag = function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0:GetNewRedKey(arg_10_1)

		manager.redPoint:setTip(var_10_0, 1, RedPointStyle.SHOW_NEW_TAG)
	end,
	AppendRedKey = function(arg_11_0, arg_11_1)
		local var_11_0 = getChapterIDByStageID(arg_11_1)
		local var_11_1 = ChapterTools.GetRedPoint(var_11_0)

		manager.redPoint:appendGroup(var_11_1, arg_11_0:GetNewRedKey(arg_11_1))
	end,
	CancelNewTag = function(arg_12_0, arg_12_1)
		local var_12_0 = getChapterIDByStageID(arg_12_1)
		local var_12_1 = getData("chapterDailyNewTag", "newTag" .. var_12_0) or {}
		local var_12_2 = {}

		for iter_12_0, iter_12_1 in ipairs(var_12_1) do
			var_12_2[iter_12_1.stageId] = iter_12_0
		end

		if var_12_1 and var_12_2[arg_12_1] and var_12_1[var_12_2[arg_12_1]].needNew == true then
			var_12_1[var_12_2[arg_12_1]].needNew = false

			manager.redPoint:setTip(arg_12_0:GetNewRedKey(arg_12_1), 0, RedPointStyle.SHOW_NEW_TAG)
			saveData("chapterDailyNewTag", "newTag" .. var_12_0, var_12_1)
		end
	end
}
