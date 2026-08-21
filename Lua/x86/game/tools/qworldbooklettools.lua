local var_0_0 = {}
local var_0_1 = 40007701
local var_0_2 = 2004

function var_0_0.CheckPhotoUnlock(arg_1_0)
	local var_1_0 = QuanzhouPhotoCfg[arg_1_0].task_id
	local var_1_1 = QWorldQuestTool.GetQuestStatus(var_1_0)

	return var_1_1 and var_1_1 == QWorldQuestConst.QUEST_STATUS.FINISH
end

function var_0_0.GetNdLevelIDList()
	return ActivityPointRewardCfg.get_id_list_by_system_key[var_0_1]
end

function var_0_0.GetNdLevelInfo()
	local var_3_0 = ActivityPointRewardCfg.get_id_list_by_system_key[var_0_1]
	local var_3_1 = 0

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_2 = ActivityPointRewardCfg[iter_3_1]

		if ItemTools.getItemNum(var_3_2.need_item_id) >= var_3_2.need then
			var_3_1 = var_3_1 + 1
		end
	end

	return var_3_1, #var_3_0
end

function var_0_0.GetBookletSystemName()
	local var_4_0 = SandPlaySystemCfg[var_0_2]

	if var_4_0 then
		return var_4_0.name
	end

	return ""
end

function var_0_0.UpdateLevelRewardRedPoint(arg_5_0)
	local var_5_0 = ActivityPointRewardCfg.get_id_list_by_system_key[var_0_1]
	local var_5_1 = 0

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_2 = ActivityPointRewardCfg[iter_5_1]
		local var_5_3 = arg_5_0 and math.max(arg_5_0, ItemTools.getItemNum(var_5_2.need_item_id)) or ItemTools.getItemNum(var_5_2.need_item_id)

		if not ActivityPointData:IsCompleteID(iter_5_1) and var_5_3 >= var_5_2.need then
			var_5_1 = 1

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.QWORLD_BOOKLET_LEVEL_REWARD, var_5_1)
end

return var_0_0
