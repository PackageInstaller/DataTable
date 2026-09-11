return {
	Init = function(self)
		self.NewSystemTagList = {}

		self:AddToggleList()
		self:AppendSystemUnlock()
	end,
	AddToggleList = function(self)
		for iter_2_0, iter_2_1 in ipairs({
			BattleConst.TOGGLE.RESOURCE,
			BattleConst.TOGGLE.EQUIP,
			BattleConst.TOGGLE.CHALLENGE
		}) do
			for iter_2_2 = 1, #ChapterClientCfg.get_id_list_by_toggle[iter_2_1] do
				if not ChapterTools.IsChapterSystemLock(ChapterClientCfg.get_id_list_by_toggle[iter_2_1][iter_2_2]) then
					local var_2_0 = GetSystemIdByClientChapterId(ChapterClientCfg.get_id_list_by_toggle[iter_2_1][iter_2_2])

					if var_2_0 and var_2_0 > 0 then
						self.NewSystemTagList[var_2_0] = true
					end
				end
			end
		end
	end,
	AppendSystemUnlock = function(arg_3_0)
		for iter_3_0, iter_3_1 in ipairs({
			BattleConst.TOGGLE.RESOURCE,
			BattleConst.TOGGLE.EQUIP,
			BattleConst.TOGGLE.CHALLENGE
		}) do
			for iter_3_2 = 1, #ChapterClientCfg.get_id_list_by_toggle[iter_3_1] do
				if not ChapterTools.IsChapterSystemLock(ChapterClientCfg.get_id_list_by_toggle[iter_3_1][iter_3_2]) then
					local var_3_0 = GetSystemIdByClientChapterId(ChapterClientCfg.get_id_list_by_toggle[iter_3_1][iter_3_2])

					if var_3_0 and var_3_0 > 0 then
						local var_3_1 = ChapterTools.GetRedPoint(ChapterClientCfg.get_id_list_by_toggle[iter_3_1][iter_3_2])

						if var_3_1 ~= RedPointConst.COMBAT_UNLL then
							manager.redPoint:appendGroup(var_3_1, GetSystemNewRedKey(var_3_0))
						end
					end
				end
			end
		end
	end,
	InitSystemUnlockDispatch = function(self)
		local var_4_0 = false
		local var_4_1 = {}

		for iter_4_0, iter_4_1 in ipairs(getData("systemUnlockNewTag", "newSystem") or {}) do
			if not SystemData:GetSystemIsOpen(iter_4_1) then
				var_4_0 = true
			else
				self:DispatchNewTag(iter_4_1)
				table.insert(var_4_1, iter_4_1)
			end
		end

		if var_4_0 then
			saveData("systemUnlockNewTag", "newSystem", var_4_1)
		end
	end,
	CheckIsSystemUnlock = function(self, arg_5_1)
		local var_5_0 = getData("systemUnlockNewTag", "newSystem") or {}
		local var_5_1 = {}

		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			var_5_1[iter_5_1] = true
		end

		for iter_5_2, iter_5_3 in ipairs(arg_5_1) do
			if self:CheckNeedNewTag(iter_5_3) and not var_5_1[iter_5_3] then
				table.insert(var_5_0, iter_5_3)
				self:DispatchNewTag(iter_5_3)
			end
		end

		saveData("systemUnlockNewTag", "newSystem", var_5_0)
	end,
	DispatchNewTag = function(arg_6_0, arg_6_1)
		manager.redPoint:setTip(GetSystemNewRedKey(arg_6_1), 1, RedPointStyle.SHOW_NEW_TAG)
	end,
	CancelNewTagByChapterId = function(self, arg_7_1)
		local var_7_0 = GetSystemIdByClientChapterId(arg_7_1)

		if var_7_0 then
			self:CancelNewTag(var_7_0)
		end
	end,
	CancelNewTag = function(self, arg_8_1)
		local var_8_0 = GetSystemNewRedKey(arg_8_1)
		local var_8_1 = getData("systemUnlockNewTag", "newSystem") or {}
		local var_8_2 = {}

		for iter_8_0, iter_8_1 in ipairs(var_8_1) do
			var_8_2[iter_8_1] = iter_8_0
		end

		if self:CheckNeedNewTag(arg_8_1) and var_8_2[arg_8_1] then
			table.remove(var_8_1, var_8_2[arg_8_1])
		end

		manager.redPoint:setTip(GetSystemNewRedKey(arg_8_1), 0, RedPointStyle.SHOW_NEW_TAG)
		saveData("systemUnlockNewTag", "newSystem", var_8_1)
	end,
	CheckNeedNewTag = function(self, arg_9_1)
		return self.NewSystemTagList[arg_9_1] or false
	end
}
