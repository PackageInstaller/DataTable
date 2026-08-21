local var_0_0 = {}

manager.net:Bind(41001, function(arg_1_0)
	TowerData:InitTowerData(arg_1_0.info_list)
	var_0_0.UpdateTowerRedPoint()
end)
manager.notify:RegistListener(PLAYER_LEVEL_UP, function()
	var_0_0.UpdateTowerRedPoint()
end)

function var_0_0.UpdateTowerRedPoint()
	if JumpTools.GetSystemLockedText(ChapterClientCfg[401].jump_system) then
		return
	end

	local var_3_0 = PlayerData:GetPlayerInfo().userLevel
	local var_3_1 = ChapterClientCfg.get_id_list_by_toggle[401]
	local var_3_2 = false

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		local var_3_3 = ChapterCfg[iter_3_1]

		if var_3_0 >= (var_3_3.level or 0) then
			if RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_3_1) == nil then
				var_3_2 = true
			end

			local var_3_4 = var_3_3.section_id_list
			local var_3_5 = TowerData:GetOverId(iter_3_1)

			if (table.indexof(var_3_4, var_3_5) or 0) == 0 and RedPointData:GetIsRedPointOpen(RedPointConst.TOWER_NEW_LEVEL + iter_3_1) == nil then
				manager.redPoint:setTip(RedPointConst.TOWER_NEW_LEVEL + iter_3_1, 1, RedPointStyle.SHOW_NEW_TAG)
			else
				manager.redPoint:setTip(RedPointConst.TOWER_NEW_LEVEL + iter_3_1, 0, RedPointStyle.SHOW_NEW_TAG)
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.TOWER, var_3_2 and 1 or 0, RedPointStyle.SHOW_NEW_TAG)
end

function var_0_0.CancelTowerRedPoint()
	local var_4_0 = PlayerData:GetPlayerInfo().userLevel
	local var_4_1 = ChapterClientCfg.get_id_list_by_toggle[401]

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		if var_4_0 >= (ChapterCfg[iter_4_1].level or 0) and RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_4_1) == nil then
			RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_4_1)
		end
	end

	manager.redPoint:setTip(RedPointConst.TOWER, 0, RedPointStyle.SHOW_NEW_TAG)
end

return var_0_0
