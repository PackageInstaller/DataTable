local var_0_0 = {}

manager.net:Bind(72201, function(arg_1_0)
	local var_1_0 = arg_1_0.activity_id

	if not HeroClueData:IsInited(var_1_0) then
		var_0_0.InitRedConst(var_1_0)
	end

	HeroClueData:InitData(arg_1_0)
	var_0_0.UpdateDrawRedPoint(var_1_0)
	var_0_0.UpdateNewClueRedPoint(var_1_0)
end)

function var_0_0.UpdateTaskRedPoint(arg_2_0)
	local var_2_0 = HeroClueTools.GetTaskActivityID(arg_2_0)
	local var_2_1 = HeroClueTools.GetPlayTaskActivityID(arg_2_0)
	local var_2_2 = TaskData2:GetActivityTaskSortList(var_2_1)
	local var_2_3 = #var_2_2
	local var_2_4 = 0

	for iter_2_0, iter_2_1 in ipairs(var_2_2) do
		local var_2_5 = iter_2_1.id
		local var_2_6 = AssignmentCfg[var_2_5]

		if iter_2_1.progress >= var_2_6.need and TaskData2:GetTaskComplete(var_2_5) then
			var_2_4 = var_2_4 + 1
		end
	end

	if var_2_3 <= var_2_4 then
		local var_2_7 = string.format("%s_%d", RedPointConst.ACTIVITY_TASK, var_2_0)
		local var_2_8 = string.format("%s_%d", RedPointConst.ACTIVITY_TASK, var_2_1)
		local var_2_9 = string.format("%s_%d", RedPointConst.HERO_CLUE_DRAW, arg_2_0)
		local var_2_10 = string.format("%s_%d", RedPointConst.HERO_CLUE_PLAY, arg_2_0)

		manager.redPoint:addGroup(var_2_10, {
			var_2_8,
			var_2_9
		})
		manager.redPoint:addGroup(string.format("%s_%d", RedPointConst.HERO_CLUE, arg_2_0), {
			var_2_10
		}, true)
	end

	manager.notify:Invoke(ACTIVITY_UPDATE, arg_2_0)
end

function var_0_0.Draw(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {
		clue_pool_id = arg_3_1,
		open_num = arg_3_2
	}

	manager.net:SendWithLoadingNew(72202, var_3_0, 72203, function(arg_4_0)
		if isSuccess(arg_4_0.result) then
			local var_4_0 = arg_4_0.clue_list

			for iter_4_0, iter_4_1 in ipairs(var_4_0) do
				HeroClueData:SetUnlockClue(iter_4_1, 1)
			end

			var_0_0.UpdateDrawRedPoint(arg_3_0)
			var_0_0.UpdateNewClueRedPoint(arg_3_0)
			manager.notify:CallUpdateFunc(HERO_CLUE_DRAW, var_4_0)
		else
			ShowTips(arg_4_0.result)
		end
	end)
end

function var_0_0.InitRedConst(arg_5_0)
	local var_5_0 = HeroClueTools.GetTaskActivityID(arg_5_0)
	local var_5_1 = HeroClueTools.GetPlayTaskActivityID(arg_5_0)
	local var_5_2 = string.format("%s_%d", RedPointConst.ACTIVITY_TASK, var_5_0)
	local var_5_3 = string.format("%s_%d", RedPointConst.ACTIVITY_TASK, var_5_1)
	local var_5_4 = string.format("%s_%d", RedPointConst.HERO_CLUE_DRAW, arg_5_0)
	local var_5_5 = string.format("%s_%d", RedPointConst.HERO_CLUE_PLAY, arg_5_0)

	manager.redPoint:addGroup(var_5_5, {
		var_5_3,
		var_5_4
	})
	manager.redPoint:addGroup(string.format("%s_%d", RedPointConst.HERO_CLUE, arg_5_0), {
		var_5_2,
		var_5_5
	})
end

function var_0_0.UpdateDrawRedPoint(arg_6_0)
	local var_6_0 = 0
	local var_6_1 = HeroCluePoolCfg.get_id_list_by_activity_id[arg_6_0][1]
	local var_6_2 = HeroClueCfg.get_id_list_by_clue_pool[var_6_1]
	local var_6_3 = HeroClueData:GetUnlockClueDataDic()
	local var_6_4 = HeroCluePoolCfg[var_6_1].item_id

	if ItemTools.getItemNum(var_6_4) >= 1 then
		for iter_6_0, iter_6_1 in ipairs(var_6_2) do
			local var_6_5 = var_6_3[iter_6_1]

			if var_6_5 ~= nil then
				if #HeroClueCfg[iter_6_1].level > var_6_5.level then
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
	local var_7_0 = HeroCluePoolCfg.get_id_list_by_activity_id[arg_7_0][1]
	local var_7_1 = HeroClueCfg.get_id_list_by_clue_pool[var_7_0]
	local var_7_2 = HeroClueData:GetNewClueDic()

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_3 = var_7_2[iter_7_1] == true
		local var_7_4 = HeroClueData:GetSelectedClue(arg_7_0, iter_7_1) == true
		local var_7_5 = 0
		local var_7_6 = var_7_3 and (not var_7_4 and 1 or 0) or 0

		manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.HERO_CLUE_NEW, arg_7_0, iter_7_1), var_7_6)
	end
end

return var_0_0
