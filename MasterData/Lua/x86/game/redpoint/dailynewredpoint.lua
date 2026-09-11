return {
	Init = function(self)
		self.NewTagList = {
			[204] = true
		}
		self.newStageIdList = {}

		self:AddResourceToggleList()

		self.chapterSystemId = {}

		for iter_1_0, iter_1_1 in pairs(self.NewTagList) do
			self.chapterSystemId[GetSystemIdByClientChapterId(iter_1_0)] = iter_1_0
		end

		self.NewTagPrefix = "DailyChapterNewTag_"
		self.OldNewTagKeyList = {}
	end,
	AddResourceToggleList = function(self)
		for iter_2_0 = 1, #ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.RESOURCE] do
			local var_2_0 = GetSystemIdByClientChapterId(ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.RESOURCE][iter_2_0])

			if var_2_0 and var_2_0 > 0 then
				self.NewTagList[ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.RESOURCE][iter_2_0]] = true

				for iter_2_1, iter_2_2 in ipairs(ChapterCfg[ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.RESOURCE][iter_2_0]].section_id_list or {}) do
					self.newStageIdList[iter_2_2] = true
				end
			end
		end
	end,
	CheckNeedNewTag = function(self, arg_3_1)
		if self.NewTagList[arg_3_1] then
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
	ClearOldNewTag = function(self)
		for iter_5_0, iter_5_1 in ipairs(self.OldNewTagKeyList) do
			manager.redPoint:setTip(iter_5_1, 0, RedPointStyle.SHOW_NEW_TAG)
		end

		self.OldNewTagKeyList = {}
	end,
	InitNewTagData = function(self)
		self:ClearOldNewTag()

		for iter_6_0, iter_6_1 in pairs(self.NewTagList) do
			self:InitChapter(iter_6_0)
		end
	end,
	InitChapter = function(self, arg_7_1)
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

		for iter_7_2, iter_7_3 in ipairs(var_7_0) do
			if BattleStageData:GetStageIsOpen(iter_7_3) then
				local var_7_4 = false

				if var_7_2[iter_7_3] then
					if self:AlreadyPlayOnce(iter_7_3) then
						var_7_1[var_7_2[iter_7_3]].needNew = false
						var_7_4 = false
					else
						var_7_4 = var_7_1[var_7_2[iter_7_3]].needNew
					end
				else
					local var_7_5 = {
						needNew = false,
						stageId = iter_7_3
					}

					if not self:AlreadyPlayOnce(iter_7_3) then
						var_7_5.needNew = true
						var_7_4 = true
					end

					table.insert(var_7_1, var_7_5)
				end

				if var_7_4 then
					self:AppendRedKey(iter_7_3)
					self:DispatchNewTag(iter_7_3)
					table.insert(self.OldNewTagKeyList, self:GetNewRedKey(iter_7_3))
				end
			end
		end

		saveData("chapterDailyNewTag", "newTag" .. arg_7_1, var_7_1)
	end,
	OnSystemUnlock = function(self, arg_8_1)
		for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
			if self.chapterSystemId[iter_8_1] then
				self:InitChapter(self.chapterSystemId[iter_8_1])
			end
		end
	end,
	GetNewRedKey = function(self, arg_9_1)
		return table.concat({
			self.NewTagPrefix,
			getChapterIDByStageID(arg_9_1),
			"_",
			arg_9_1
		})
	end,
	DispatchNewTag = function(self, arg_10_1)
		manager.redPoint:setTip(self:GetNewRedKey(arg_10_1), 1, RedPointStyle.SHOW_NEW_TAG)
	end,
	AppendRedKey = function(self, arg_11_1)
		manager.redPoint:appendGroup(ChapterTools.GetRedPoint((getChapterIDByStageID(arg_11_1))), self:GetNewRedKey(arg_11_1))
	end,
	CancelNewTag = function(self, arg_12_1)
		local var_12_0 = getChapterIDByStageID(arg_12_1)
		local var_12_1 = getData("chapterDailyNewTag", "newTag" .. var_12_0) or {}
		local var_12_2 = {}

		for iter_12_0, iter_12_1 in ipairs(var_12_1) do
			var_12_2[iter_12_1.stageId] = iter_12_0
		end

		if var_12_1 and var_12_2[arg_12_1] and var_12_1[var_12_2[arg_12_1]].needNew == true then
			var_12_1[var_12_2[arg_12_1]].needNew = false

			manager.redPoint:setTip(self:GetNewRedKey(arg_12_1), 0, RedPointStyle.SHOW_NEW_TAG)
			saveData("chapterDailyNewTag", "newTag" .. var_12_0, var_12_1)
		end
	end
}
