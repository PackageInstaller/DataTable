local var_0_0 = class("IslandAchievementAgency", import(".IslandBaseAgency"))

var_0_0.NEW_CAN_GET = "IslandAchievementAgency.NEW_CAN_GET"

function var_0_0.OnInit(arg_1_0, arg_1_1)
	arg_1_0.gotList = arg_1_1.achievement_sys.finish_list or {}
	arg_1_0.recordDic = {}

	local var_1_0 = arg_1_1.achievement_sys.achieve_list or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0.recordDic[iter_1_1.event_type] = arg_1_0.recordDic[iter_1_1.event_type] or {}
		arg_1_0.recordDic[iter_1_1.event_type][iter_1_1.event_arg] = iter_1_1.value
	end

	return
end

function var_0_0.InitRuntimeRecords(arg_2_0)
	local var_2_0 = IslandAchievementType.GetRuntimeTypes()
	local var_2_1 = IslandAchievementType.GetClientTypes()

	for iter_2_0, iter_2_1 in ipairs(pg.island_achievement.all) do
		if table.contains(var_2_0, pg.island_achievement[iter_2_1].target_type) then
			arg_2_0.recordDic[pg.island_achievement[iter_2_1].target_type] = arg_2_0.recordDic[pg.island_achievement[iter_2_1].target_type] or {}
			arg_2_0.recordDic[pg.island_achievement[iter_2_1].target_type][pg.island_achievement[iter_2_1].target_value1] = arg_2_0.recordDic[pg.island_achievement[iter_2_1].target_type][pg.island_achievement[iter_2_1].target_value1] or IslandAchievementHelper.GetRuntimeData(pg.island_achievement[iter_2_1].target_type, pg.island_achievement[iter_2_1].target_value1)
		elseif table.contains(var_2_1, pg.island_achievement[iter_2_1].target_type) then
			arg_2_0.recordDic[pg.island_achievement[iter_2_1].target_type] = arg_2_0.recordDic[pg.island_achievement[iter_2_1].target_type] or {}
			arg_2_0.recordDic[pg.island_achievement[iter_2_1].target_type][pg.island_achievement[iter_2_1].target_value1] = arg_2_0.recordDic[pg.island_achievement[iter_2_1].target_type][pg.island_achievement[iter_2_1].target_value1] or 0
		end
	end

	arg_2_0:BuildDataDic()

	return
end

function var_0_0.BuildDataDic(arg_3_0)
	arg_3_0.groupDic = {}
	arg_3_0.achvDic = {}

	for iter_3_0, iter_3_1 in pairs(pg.island_achievement.get_id_list_by_group) do
		local var_3_0 = IslandAchievementGroup.New(iter_3_0, iter_3_1)

		for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
			local var_3_1 = var_3_0:GetAchvById(iter_3_3)
			local var_3_2 = var_3_1

			if table.contains(arg_3_0.gotList, iter_3_3) then
				var_3_1:SetStatus(IslandAchievement.STATUS.GOT)

				goto label_3_0
			end

			::label_3_0::

			if arg_3_0:IsCanGet(var_3_1) then
				do
					local var_3_4 = IslandAchievement.STATUS.GET or IslandAchievement.STATUS.NORMAL

					var_3_3(var_3_2, var_3_4)
				end

				local var_3_5 = var_3_1:GetType()
				local var_3_6 = var_3_1:GetParam()

				arg_3_0.achvDic[var_3_5] = arg_3_0.achvDic[var_3_5] or {}
				arg_3_0.achvDic[var_3_5][var_3_6] = arg_3_0.achvDic[var_3_5][var_3_6] or {}

				table.insert(arg_3_0.achvDic[var_3_5][var_3_6], var_3_1)
			end
		end

		arg_3_0.groupDic[iter_3_0] = var_3_0
	end

	return
end

function var_0_0.GetRecordsByType(arg_4_0, arg_4_1)
	return arg_4_0.recordDic[arg_4_1] or {}
end

function var_0_0.IsGot(arg_5_0, arg_5_1)
	return table.contains(arg_5_0.gotList, arg_5_1)
end

function var_0_0.GetGotList(arg_6_0)
	return arg_6_0.gotList
end

function var_0_0.GetGotGroupMaxStageList(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.gotList) do
		if not ({})[pg.island_achievement[iter_7_1].group] or pg.island_achievement[iter_7_1].stage > ({})[pg.island_achievement[iter_7_1].group] then
			({})[pg.island_achievement[iter_7_1].group] = pg.island_achievement[iter_7_1].stage
			;({})[pg.island_achievement[iter_7_1].group] = iter_7_1
		end
	end

	return underscore.values({})
end

function var_0_0.UpdataAchLv(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs((arg_8_0:GetGotGroupMaxStageList())) do
		({})[pg.island_achievement[iter_8_1].group] = iter_8_1
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_1) do
		table.insert({}, ({})[pg.island_achievement[iter_8_3].group])
	end

	return {}
end

function var_0_0.GetGroup(arg_9_0, arg_9_1)
	return arg_9_0.groupDic[arg_9_1]
end

function var_0_0.IsCanGet(arg_10_0, arg_10_1)
	if arg_10_1:GetStatus() == IslandAchievement.STATUS.GOT then
		return
	end

	local var_10_0 = arg_10_1:GetType()
	local var_10_1 = arg_10_1:GetParam()

	if not arg_10_0.recordDic[var_10_0] then
		return false
	end

	local var_10_2 = arg_10_0.recordDic[var_10_0][var_10_1]

	return arg_10_0.recordDic[var_10_0][var_10_1] and arg_10_1:GetNum() <= var_10_2
end

function var_0_0.GetCurProgress(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:GetType()
	local var_11_1 = arg_11_1:GetParam()
	local var_11_2 = arg_11_1:GetNum()

	if not arg_11_0.recordDic[var_11_0] then
		return 0
	end

	return arg_11_0.recordDic[var_11_0][var_11_1] or 0
end

function var_0_0.GetTotalCnt(arg_12_0)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in pairs(arg_12_0.groupDic) do
		var_12_0 = underscore.reduce(iter_12_1:GetSortAchvList(), var_12_0, function(arg_13_0, arg_13_1)
			return arg_13_0 + (arg_13_1:IsHideType() and (arg_12_0:IsCanGet(arg_13_1) and 1 or 0) or 1)
		end)
	end

	return var_12_0
end

function var_0_0.CheckRecordExist(arg_14_0, arg_14_1, arg_14_2)
	return arg_14_0.recordDic[arg_14_1] and arg_14_0.recordDic[arg_14_1][arg_14_2]
end

function var_0_0.UpdateRecord(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0.recordDic[arg_15_1] = arg_15_0.recordDic[arg_15_1] or {}

	if not arg_15_0.recordDic[arg_15_1][arg_15_2] then
		-- block empty
	end

	arg_15_0.recordDic[arg_15_1][arg_15_2] = arg_15_3

	arg_15_0:CheckAchvStatus(arg_15_1, arg_15_2)

	return
end

function var_0_0.UpdateRecordWithAdd(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0.recordDic[arg_16_1] = arg_16_0.recordDic[arg_16_1] or {}

	local var_16_0 = arg_16_0.recordDic[arg_16_1][arg_16_2] or 0

	arg_16_0.recordDic[arg_16_1][arg_16_2] = var_16_0 + arg_16_3

	arg_16_0:CheckAchvStatus(arg_16_1, arg_16_2)

	return
end

function var_0_0.CheckAchvStatus(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0.achvDic[arg_17_1] or not arg_17_0.achvDic[arg_17_1][arg_17_2] then
		return
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.achvDic[arg_17_1][arg_17_2]) do
		if iter_17_1:GetStatus() == IslandAchievement.STATUS.NORMAL and arg_17_0:IsCanGet(iter_17_1) then
			iter_17_1:SetStatus(IslandAchievement.STATUS.GET)
			arg_17_0:DispatchEvent(var_0_0.NEW_CAN_GET, iter_17_1)
		end
	end

	return
end

function var_0_0.AddGotIds(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		table.insert(arg_18_0.gotList, iter_18_1)
		arg_18_0.groupDic[pg.island_achievement[iter_18_1].group]:SetGotTagById(iter_18_1)
	end

	return
end

function var_0_0.IsTip(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.groupDic) do
		for iter_19_2, iter_19_3 in ipairs(iter_19_1:GetSortAchvList()) do
			if iter_19_3:GetStatus() == IslandAchievement.STATUS.GET then
				return true
			end
		end
	end

	return false
end

return var_0_0
