local var_0_0 = {}
local var_0_1 = 40007701
local var_0_2 = 2004

function var_0_0.CheckPhotoUnlock(arg_1_0)
	local var_1_0 = QWorldQuestTool.GetQuestStatus(QuanzhouPhotoCfg[arg_1_0].task_id)

	return var_1_0 and var_1_0 == QWorldQuestConst.QUEST_STATUS.FINISH
end

function var_0_0.GetNdLevelIDList()
	return ActivityPointRewardCfg.get_id_list_by_system_key[var_0_1]
end

function var_0_0.GetNdLevelInfo()
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_system_key[var_0_1]) do
		if ItemTools.getItemNum(ActivityPointRewardCfg[iter_3_1].need_item_id) >= ActivityPointRewardCfg[iter_3_1].need then
			var_3_0 = var_3_0 + 1
		end
	end

	return var_3_0, #ActivityPointRewardCfg.get_id_list_by_system_key[var_0_1]
end

function var_0_0.GetBookletSystemName()
	if SandPlaySystemCfg[var_0_2] then
		return SandPlaySystemCfg[var_0_2].name
	end

	return ""
end

function var_0_0.UpdateLevelRewardRedPoint(arg_5_0)
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_system_key[var_0_1]) do
		local var_5_1 = ActivityPointRewardCfg[iter_5_1]

		if not ActivityPointData:IsCompleteID(iter_5_1) and (arg_5_0 and math.max(arg_5_0, ItemTools.getItemNum(var_5_1.need_item_id)) or ItemTools.getItemNum(var_5_1.need_item_id)) >= var_5_1.need then
			var_5_0 = 1

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.QWORLD_BOOKLET_LEVEL_REWARD, var_5_0)
end

return var_0_0
