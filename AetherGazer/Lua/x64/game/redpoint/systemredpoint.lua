return {
	Init = function(arg_1_0)
		arg_1_0.NewSystemTagList = {}

		arg_1_0:AddToggleList()
		arg_1_0:AppendSystemUnlock()
	end,
	AddToggleList = function(arg_2_0)
		local var_2_0 = {
			BattleConst.TOGGLE.RESOURCE,
			BattleConst.TOGGLE.EQUIP,
			BattleConst.TOGGLE.CHALLENGE
		}

		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			local var_2_1 = ChapterClientCfg.get_id_list_by_toggle[iter_2_1]

			for iter_2_2 = 1, #var_2_1 do
				local var_2_2 = var_2_1[iter_2_2]

				if not ChapterTools.IsChapterSystemLock(var_2_2) then
					local var_2_3 = GetSystemIdByClientChapterId(var_2_2)

					if var_2_3 and var_2_3 > 0 then
						arg_2_0.NewSystemTagList[var_2_3] = true
					end
				end
			end
		end
	end,
	AppendSystemUnlock = function(arg_3_0)
		local var_3_0 = {
			BattleConst.TOGGLE.RESOURCE,
			BattleConst.TOGGLE.EQUIP,
			BattleConst.TOGGLE.CHALLENGE
		}

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			local var_3_1 = ChapterClientCfg.get_id_list_by_toggle[iter_3_1]

			for iter_3_2 = 1, #var_3_1 do
				local var_3_2 = var_3_1[iter_3_2]

				if not ChapterTools.IsChapterSystemLock(var_3_2) then
					local var_3_3 = GetSystemIdByClientChapterId(var_3_2)

					if var_3_3 and var_3_3 > 0 then
						local var_3_4 = ChapterTools.GetRedPoint(var_3_2)

						if var_3_4 ~= RedPointConst.COMBAT_UNLL then
							manager.redPoint:appendGroup(var_3_4, GetSystemNewRedKey(var_3_3))
						end
					end
				end
			end
		end
	end,
	InitSystemUnlockDispatch = function(arg_4_0)
		local var_4_0 = getData("systemUnlockNewTag", "newSystem") or {}
		local var_4_1 = false
		local var_4_2 = {}

		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			if not SystemData:GetSystemIsOpen(iter_4_1) then
				var_4_1 = true
			else
				arg_4_0:DispatchNewTag(iter_4_1)
				table.insert(var_4_2, iter_4_1)
			end
		end

		if var_4_1 then
			saveData("systemUnlockNewTag", "newSystem", var_4_2)
		end
	end,
	CheckIsSystemUnlock = function(arg_5_0, arg_5_1)
		local var_5_0 = getData("systemUnlockNewTag", "newSystem") or {}
		local var_5_1 = {}

		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			var_5_1[iter_5_1] = true
		end

		for iter_5_2, iter_5_3 in ipairs(arg_5_1) do
			if arg_5_0:CheckNeedNewTag(iter_5_3) and not var_5_1[iter_5_3] then
				table.insert(var_5_0, iter_5_3)
				arg_5_0:DispatchNewTag(iter_5_3)
			end
		end

		saveData("systemUnlockNewTag", "newSystem", var_5_0)
	end,
	DispatchNewTag = function(arg_6_0, arg_6_1)
		local var_6_0 = GetSystemNewRedKey(arg_6_1)

		manager.redPoint:setTip(var_6_0, 1, RedPointStyle.SHOW_NEW_TAG)
	end,
	CancelNewTagByChapterId = function(arg_7_0, arg_7_1)
		local var_7_0 = GetSystemIdByClientChapterId(arg_7_1)

		if var_7_0 then
			arg_7_0:CancelNewTag(var_7_0)
		end
	end,
	CancelNewTag = function(arg_8_0, arg_8_1)
		local var_8_0 = GetSystemNewRedKey(arg_8_1)
		local var_8_1 = getData("systemUnlockNewTag", "newSystem") or {}
		local var_8_2 = {}

		for iter_8_0, iter_8_1 in ipairs(var_8_1) do
			var_8_2[iter_8_1] = iter_8_0
		end

		if arg_8_0:CheckNeedNewTag(arg_8_1) and var_8_2[arg_8_1] then
			table.remove(var_8_1, var_8_2[arg_8_1])
		end

		manager.redPoint:setTip(GetSystemNewRedKey(arg_8_1), 0, RedPointStyle.SHOW_NEW_TAG)
		saveData("systemUnlockNewTag", "newSystem", var_8_1)
	end,
	CheckNeedNewTag = function(arg_9_0, arg_9_1)
		return arg_9_0.NewSystemTagList[arg_9_1] or false
	end
}
