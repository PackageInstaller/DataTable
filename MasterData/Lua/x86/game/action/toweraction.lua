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
	local var_3_1 = false

	for iter_3_0, iter_3_1 in ipairs(ChapterClientCfg.get_id_list_by_toggle[401]) do
		if (ChapterCfg[iter_3_1].level or 0) <= var_3_0 then
			local var_3_3

			if RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_3_1) == nil then
				var_3_1 = true
				var_3_3 = TowerData:GetOverId(iter_3_1)
			end

			local var_3_4 = table.indexof(ChapterCfg[iter_3_1].section_id_list, var_3_3)

			var_3_4 = var_3_4 or 0

			if var_3_4 == 0 and RedPointData:GetIsRedPointOpen(RedPointConst.TOWER_NEW_LEVEL + iter_3_1) == nil then
				manager.redPoint:setTip(RedPointConst.TOWER_NEW_LEVEL + iter_3_1, 1, RedPointStyle.SHOW_NEW_TAG)
			else
				manager.redPoint:setTip(RedPointConst.TOWER_NEW_LEVEL + iter_3_1, 0, RedPointStyle.SHOW_NEW_TAG)
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.TOWER, var_3_1 and 1 or 0, RedPointStyle.SHOW_NEW_TAG)
end

function var_0_0.CancelTowerRedPoint()
	local var_4_0 = PlayerData:GetPlayerInfo().userLevel

	for iter_4_0, iter_4_1 in ipairs(ChapterClientCfg.get_id_list_by_toggle[401]) do
		if (ChapterCfg[iter_4_1].level or 0) <= var_4_0 and RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_4_1) == nil then
			RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_4_1)
		end
	end

	manager.redPoint:setTip(RedPointConst.TOWER, 0, RedPointStyle.SHOW_NEW_TAG)
end

return var_0_0
