local var_0_0 = {}

manager.net:Bind(72201, function(arg_1_0)
	if not HeroClueData:IsInited(arg_1_0.activity_id) then
		var_0_0.InitRedConst(arg_1_0.activity_id)
	end

	HeroClueData:InitData(arg_1_0)
	var_0_0.UpdateDrawRedPoint(arg_1_0.activity_id)
	var_0_0.UpdateNewClueRedPoint(arg_1_0.activity_id)
end)

function var_0_0.UpdateTaskRedPoint(arg_2_0)
	local var_2_0 = HeroClueTools.GetPlayTaskActivityID(arg_2_0)
	local var_2_1 = TaskData2:GetActivityTaskSortList(var_2_0)
	local var_2_2 = 0

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		if iter_2_1.progress >= AssignmentCfg[iter_2_1.id].need and TaskData2:GetTaskComplete(iter_2_1.id) then
			var_2_2 = var_2_2 + 1
		end
	end

	if #var_2_1 <= var_2_2 then
		local var_2_3 = string.format("%s_%d", RedPointConst.ACTIVITY_TASK, (HeroClueTools.GetTaskActivityID(arg_2_0)))
		local var_2_4 = string.format("%s_%d", RedPointConst.HERO_CLUE_PLAY, arg_2_0)

		manager.redPoint:addGroup(var_2_4, {
			string.format("%s_%d", RedPointConst.ACTIVITY_TASK, var_2_0),
			(string.format("%s_%d", RedPointConst.HERO_CLUE_DRAW, arg_2_0))
		})
		manager.redPoint:addGroup(string.format("%s_%d", RedPointConst.HERO_CLUE, arg_2_0), {
			var_2_4
		}, true)
	end

	manager.notify:Invoke(ACTIVITY_UPDATE, arg_2_0)
end

function var_0_0.Draw(arg_3_0, arg_3_1, arg_3_2)
	manager.net:SendWithLoadingNew(72202, {
		clue_pool_id = arg_3_1,
		open_num = arg_3_2
	}, 72203, function(arg_4_0)
		if isSuccess(arg_4_0.result) then
			for iter_4_0, iter_4_1 in ipairs(arg_4_0.clue_list) do
				HeroClueData:SetUnlockClue(iter_4_1, 1)
			end

			var_0_0.UpdateDrawRedPoint(arg_3_0)
			var_0_0.UpdateNewClueRedPoint(arg_3_0)
			manager.notify:CallUpdateFunc(HERO_CLUE_DRAW, arg_4_0.clue_list)
		else
			ShowTips(arg_4_0.result)
		end
	end)
end

function var_0_0.InitRedConst(arg_5_0)
	local var_5_0 = string.format("%s_%d", RedPointConst.HERO_CLUE_PLAY, arg_5_0)

	manager.redPoint:addGroup(var_5_0, {
		string.format("%s_%d", RedPointConst.ACTIVITY_TASK, (HeroClueTools.GetPlayTaskActivityID(arg_5_0))),
		(string.format("%s_%d", RedPointConst.HERO_CLUE_DRAW, arg_5_0))
	})
	manager.redPoint:addGroup(string.format("%s_%d", RedPointConst.HERO_CLUE, arg_5_0), {
		string.format("%s_%d", RedPointConst.ACTIVITY_TASK, (HeroClueTools.GetTaskActivityID(arg_5_0))),
		var_5_0
	})
end

function var_0_0.UpdateDrawRedPoint(arg_6_0)
	local var_6_0 = 0
	local var_6_1 = HeroClueData:GetUnlockClueDataDic()

	if ItemTools.getItemNum(HeroCluePoolCfg[HeroCluePoolCfg.get_id_list_by_activity_id[arg_6_0][1]].item_id) >= 1 then
		for iter_6_0, iter_6_1 in ipairs(HeroClueCfg.get_id_list_by_clue_pool[HeroCluePoolCfg.get_id_list_by_activity_id[arg_6_0][1]]) do
			if var_6_1[iter_6_1] ~= nil then
				if #HeroClueCfg[iter_6_1].level > var_6_1[iter_6_1].level then
					var_6_0 = 1

					break
				end
			else
				var_6_0 = 1

				break
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.HERO_CLUE_DRAW, arg_6_0), var_6_0)
	var_0_0.UpdateTaskRedPoint(arg_6_0)
end

function var_0_0.UpdateNewClueRedPoint(arg_7_0)
	local var_7_0 = HeroClueData:GetNewClueDic()

	for iter_7_0, iter_7_1 in ipairs(HeroClueCfg.get_id_list_by_clue_pool[HeroCluePoolCfg.get_id_list_by_activity_id[arg_7_0][1]]) do
		manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.HERO_CLUE_NEW, arg_7_0, iter_7_1), var_7_0[iter_7_1] == true and (not (HeroClueData:GetSelectedClue(arg_7_0, iter_7_1) == true) and 1 or 0) or 0)
	end
end

return var_0_0
