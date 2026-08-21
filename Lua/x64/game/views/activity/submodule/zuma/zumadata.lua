local var_0_0 = singletonClass("ZumaData")
local var_0_1 = 0
local var_0_2 = 0
local var_0_3 = 0
local var_0_4 = {}
local var_0_5 = 0
local var_0_6 = 0
local var_0_7 = {}
local var_0_8 = {}
local var_0_9 = {}
local var_0_10 = {}
local var_0_11 = {}
local var_0_12 = {}
local var_0_13 = false
local var_0_14 = 0
local var_0_15 = -1

function var_0_0.GetZumaRead(arg_1_0, arg_1_1)
	return table.indexof(var_0_10, arg_1_1)
end

function var_0_0.SetZumaRead(arg_2_0, arg_2_1)
	local var_2_0 = ActivityData:GetActivityData(arg_2_1)

	if not var_2_0 or not var_2_0:IsActivitying() then
		return
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ZUMA_OPEN, arg_2_1), 0)

	if not table.indexof(var_0_10, arg_2_1) then
		table.insert(var_0_10, arg_2_1)
	end
end

function var_0_0.GetZumaIdByActId(arg_3_0, arg_3_1)
	if not var_0_9[arg_3_1] then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0:GetZumaLevelIDList() or {}) do
			local var_3_0 = ActivityZumaLevelCfg[iter_3_1]

			if var_3_0 then
				var_0_9[var_3_0.activity_id] = iter_3_1
			end
		end
	end

	return var_0_9[arg_3_1]
end

var_0_0.ZUMA_DIFFICULT = {
	NIGHT = 3,
	ESAY = 1,
	HARD = 2
}

function var_0_0.Init(arg_4_0)
	var_0_1 = 0
	var_0_2 = 0
	var_0_3 = 0
	var_0_5 = 0
	var_0_6 = 0
	var_0_7 = {}
	var_0_8 = {}
	var_0_10 = {}
	var_0_11 = {}
	var_0_12 = {}
	var_0_13 = false
	var_0_14 = 0
	var_0_15 = -1
end

function var_0_0.InitZumaData(arg_5_0, arg_5_1)
	arg_5_0:SetZumaCoin(arg_5_1.value)

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.talent_list) do
		var_0_7[iter_5_1] = true
	end

	arg_5_0:OpenDefaultUnlockTalent()

	for iter_5_2, iter_5_3 in ipairs(arg_5_1.finish_mission or {}) do
		var_0_8[iter_5_3.id] = {
			id = iter_5_3.id,
			score = iter_5_3.score
		}
	end

	var_0_14 = arg_5_1.endless_all_score
end

function var_0_0.IsFinishOneZumaLevel(arg_6_0)
	local var_6_0 = arg_6_0:GetZumaLevelIDList()[1]

	return arg_6_0:GetZumaStageScore(var_6_0)
end

function var_0_0.GetZumaCoin(arg_7_0)
	return var_0_5
end

function var_0_0.UpdateZumaCoin(arg_8_0, arg_8_1)
	var_0_5 = var_0_5 + arg_8_1
end

function var_0_0.SetZumaCoin(arg_9_0, arg_9_1)
	var_0_5 = arg_9_1
end

function var_0_0.GetZumaTaskData(arg_10_0)
	return TaskData2:GetActivityTaskSortList(arg_10_0:GetZumaActivityID())
end

function var_0_0.GetZumaStageData(arg_11_0, arg_11_1)
	return var_0_8[arg_11_1]
end

function var_0_0.GetZumaStageScore(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:GetZumaStageData(arg_12_1)

	return var_12_0 and var_12_0.score or nil
end

function var_0_0.GetZumaFinishPointList(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {}
	local var_13_1 = 0

	for iter_13_0, iter_13_1 in pairs(arg_13_2) do
		local var_13_2 = ActivityPointRewardCfg[iter_13_1]

		if arg_13_1 >= var_13_2.need then
			table.insert(var_13_0, var_13_2)

			var_13_1 = var_13_1 + var_13_2.reward_item_list[1][2]
		end
	end

	return var_13_0, var_13_1
end

function var_0_0.UpdateZumaStageData(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.id
	local var_14_1 = ActivityZumaLevelCfg[var_14_0]

	if not var_0_8[var_14_0] then
		var_0_8[var_14_0] = {}
		var_0_8[var_14_0].id = var_14_0
		var_0_8[var_14_0].score = 0
	end

	if arg_14_1.score > var_0_8[var_14_0].score then
		var_0_8[var_14_0].score = arg_14_1.score
	end

	if var_14_1.difficult == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
		var_0_14 = var_0_14 + arg_14_1.score
	end
end

function var_0_0.GetZumaStageOpenTime(arg_15_0, arg_15_1)
	local var_15_0 = ActivityZumaLevelCfg[arg_15_1]
	local var_15_1 = ActivityData:GetActivityData(var_15_0.activity_id)

	if (var_15_1 and var_15_1.startTime or 0) >= manager.time:GetServerTime() then
		local var_15_2 = GetTips("OPEN_TIME")

		return string.format(var_15_2, manager.time:GetLostTimeStr(var_15_1.startTime, false, true))
	end

	return nil
end

function var_0_0.GetZumaBeforeIsFinish(arg_16_0, arg_16_1)
	local var_16_0 = ActivityZumaLevelCfg[arg_16_1].pre_id

	if var_16_0 == 0 or arg_16_0:GetZumaStageScore(var_16_0) then
		return true
	end

	return false
end

function var_0_0.InitZumaCfgData(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0:GetZumaLevelIDList() or {}) do
		local var_17_0 = ActivityZumaLevelCfg[iter_17_1]

		if var_17_0 then
			if not var_0_4[var_17_0.difficult] then
				var_0_4[var_17_0.difficult] = {}
			end

			table.insert(var_0_4[var_17_0.difficult], var_17_0)
		end
	end
end

function var_0_0.GetZumaLevelIDList(arg_18_0)
	return ActivityZumaLevelCfg.get_id_list_by_main_activity_id[arg_18_0:GetZumaActivityID()]
end

function var_0_0.GetZumaCfgData(arg_19_0)
	if #var_0_4 == 0 then
		arg_19_0:InitZumaCfgData()
	end

	return var_0_4
end

function var_0_0.OpenDefaultUnlockTalent(arg_20_0)
	if not var_0_7[2002] and arg_20_0:GetZumaActivityID() == ActivityConst.ACTIVITY_3_11_ZUMA then
		ZumaAction.OpenZumaTalent(2002, arg_20_0:GetZumaActivityID())
	end
end

function var_0_0.GetZumaTalentIDList(arg_21_0)
	local var_21_0 = {}
	local var_21_1 = ActivityZumaTalentCfg.get_id_list_by_activity_id[arg_21_0:GetZumaActivityID()]

	for iter_21_0, iter_21_1 in pairs(var_21_1 or {}) do
		if ActivityZumaTalentCfg[iter_21_1].type == 1 then
			table.insert(var_21_0, iter_21_1)
		end
	end

	return var_21_0
end

function var_0_0.GetZumaTalentIsOpen(arg_22_0, arg_22_1)
	return var_0_7[arg_22_1]
end

function var_0_0.SetUseZumaTalent(arg_23_0, arg_23_1)
	var_0_7[arg_23_1] = true
end

function var_0_0.ResetTalentList(arg_24_0)
	var_0_7 = {}
	var_0_11 = {}
	var_0_12 = {}

	arg_24_0:OpenDefaultUnlockTalent()
end

function var_0_0.GetTalentList(arg_25_0)
	return var_0_7
end

function var_0_0.GetTalentListBySort(arg_26_0)
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(var_0_7) do
		table.insert(var_26_0, iter_26_0)
	end

	table.sort(var_26_0)

	return var_26_0
end

function var_0_0.GetZumaTalentIsCanOpen(arg_27_0, arg_27_1)
	local var_27_0 = ActivityZumaTalentCfg[arg_27_1].pre_id_list

	for iter_27_0, iter_27_1 in pairs(var_27_0) do
		if iter_27_1 ~= 0 and not arg_27_0:GetZumaTalentIsOpen(iter_27_1) then
			return false
		end
	end

	return true
end

function var_0_0.GetTalentTreeCfg(arg_28_0)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in pairs(arg_28_0:GetZumaTalentIDList() or {}) do
		local var_28_1 = ActivityZumaTalentCfg[iter_28_1]

		if var_28_1 then
			local var_28_2 = var_28_1.pre_id_list

			for iter_28_2, iter_28_3 in pairs(var_28_2) do
				if not var_28_0[iter_28_3] then
					var_28_0[iter_28_3] = {}
				end

				table.insert(var_28_0[iter_28_3], var_28_1.id)
			end
		end
	end

	return var_28_0
end

function var_0_0.SetTalentRedList(arg_29_0, arg_29_1, arg_29_2)
	var_0_11[arg_29_1] = arg_29_2
end

function var_0_0.GetTalentRedList(arg_30_0, arg_30_1)
	return var_0_11[arg_30_1]
end

function var_0_0.SetTalentReadList(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(var_0_11) do
		if iter_31_1 then
			arg_31_0:SetZumaTalentRead(iter_31_0)
		end
	end

	local var_31_0 = ZumaData:GetZumaCoin()

	for iter_31_2 = #var_0_12, 1, -1 do
		local var_31_1 = var_0_12[iter_31_2]
		local var_31_2 = ActivityZumaTalentCfg[var_31_1]

		if var_31_2 and var_31_0 < var_31_2.need then
			table.remove(var_0_12, iter_31_2)
		end
	end

	manager.redPoint:setTip(RedPointConst.ZUMA_TALENT, 0)
end

function var_0_0.GetZumaTalentRead(arg_32_0, arg_32_1)
	return table.indexof(var_0_12, arg_32_1)
end

function var_0_0.SetZumaTalentRead(arg_33_0, arg_33_1)
	if not table.indexof(var_0_12, arg_33_1) then
		table.insert(var_0_12, arg_33_1)
	end
end

function var_0_0.GetSkillBaseTalentIDList(arg_34_0)
	local var_34_0 = {}
	local var_34_1 = ActivityZumaTalentCfg.get_id_list_by_activity_id[arg_34_0:GetZumaActivityID()]

	for iter_34_0, iter_34_1 in ipairs(var_34_1 or {}) do
		local var_34_2 = ActivityZumaTalentCfg[iter_34_1]

		if var_34_2 and var_34_2.type == 1 and var_34_2.pre_id_list[1] and var_34_2.pre_id_list[1] == 0 then
			table.insert(var_34_0, iter_34_1)
		end
	end

	return var_34_0
end

function var_0_0.GetSkillGroupList(arg_35_0, arg_35_1)
	local var_35_0 = {}

	table.insert(var_35_0, arg_35_1)

	local var_35_1 = ActivityZumaTalentCfg.get_id_list_by_activity_id[arg_35_0:GetZumaActivityID()]

	for iter_35_0, iter_35_1 in ipairs(var_35_1 or {}) do
		local var_35_2 = ActivityZumaTalentCfg[iter_35_1]

		if #var_35_2.pre_id_list == 1 and var_35_2.pre_id_list[1] and var_35_2.pre_id_list[1] == arg_35_1 then
			table.insert(var_35_0, iter_35_1)
		end
	end

	return var_35_0
end

function var_0_0.GetFinallyTalentID(arg_36_0)
	return ZumaConst.ZUMA_FINALLY_ID
end

function var_0_0.GetRandomTalentList(arg_37_0)
	local var_37_0 = {}
	local var_37_1 = ActivityZumaTalentCfg.get_id_list_by_activity_id[arg_37_0:GetZumaActivityID()]

	for iter_37_0, iter_37_1 in ipairs(var_37_1 or {}) do
		if ActivityZumaTalentCfg[iter_37_1].type == 3 then
			table.insert(var_37_0, iter_37_1)
		end
	end

	return var_37_0
end

function var_0_0.SetEndlessMapRandIndex(arg_38_0, arg_38_1)
	var_0_15 = arg_38_1
end

function var_0_0.GetEndlessMapRandIndex(arg_39_0)
	return var_0_15
end

function var_0_0.SetZumaEndless(arg_40_0, arg_40_1)
	var_0_13 = arg_40_1
end

function var_0_0.GetZumaIsUseEndless(arg_41_0)
	return var_0_13
end

function var_0_0.GetEndlessEffectList(arg_42_0)
	local var_42_0 = {}
	local var_42_1 = ActivityZumaTalentCfg.get_id_list_by_activity_id[arg_42_0:GetZumaActivityID()]

	for iter_42_0, iter_42_1 in pairs(var_42_1 or {}) do
		local var_42_2 = ActivityZumaTalentCfg[iter_42_1]

		if var_42_2.type == 2 and var_0_14 >= var_42_2.need then
			for iter_42_2, iter_42_3 in pairs(ActivityZumaTalentCfg[iter_42_1].effect_list) do
				table.insert(var_42_0, iter_42_3)
			end
		end
	end

	return var_42_0
end

function var_0_0.GetEndlessTalentList(arg_43_0)
	local var_43_0 = {}
	local var_43_1 = ActivityZumaTalentCfg.get_id_list_by_activity_id[arg_43_0:GetZumaActivityID()]

	for iter_43_0, iter_43_1 in ipairs(var_43_1 or {}) do
		if ActivityZumaTalentCfg[iter_43_1].type == 2 then
			table.insert(var_43_0, iter_43_1)
		end
	end

	table.sort(var_43_0, function(arg_44_0, arg_44_1)
		local var_44_0 = ActivityZumaTalentCfg[arg_44_0]
		local var_44_1 = ActivityZumaTalentCfg[arg_44_1]

		if var_44_0.need < var_44_1.need then
			return true
		else
			return false
		end
	end)

	return var_43_0
end

function var_0_0.GetEndlessScore(arg_45_0)
	return var_0_14
end

function var_0_0.SetZumaSkillID(arg_46_0, arg_46_1)
	var_0_2 = arg_46_1 or 0
end

function var_0_0.GetZumaSkillID(arg_47_0)
	return var_0_2
end

function var_0_0.GetZumaSkillTypeID(arg_48_0)
	if ZumaConst.ZUMA_TALENT_TO_SKILL[var_0_2] then
		return ZumaConst.ZUMA_TALENT_TO_SKILL[var_0_2]
	else
		return 0
	end
end

function var_0_0.SetZumaActivityID(arg_49_0, arg_49_1)
	arg_49_0.useActivityID = arg_49_1
end

function var_0_0.GetZumaActivityID(arg_50_0)
	return arg_50_0.useActivityID or ActivityConst.ACTIVITY_3_11_ZUMA
end

function var_0_0.SetZumaGameId(arg_51_0, arg_51_1)
	var_0_1 = arg_51_1
end

function var_0_0.GetZumaGameId(arg_52_0)
	return var_0_1
end

function var_0_0.ResetZumaGameData(arg_53_0)
	var_0_3 = 0
end

function var_0_0.SetZumaScore(arg_54_0, arg_54_1)
	var_0_3 = arg_54_1
end

function var_0_0.GetZumaScore(arg_55_0)
	return var_0_3
end

function var_0_0.SetZumaBallCount(arg_56_0, arg_56_1)
	var_0_6 = arg_56_1
end

function var_0_0.GetZumaBallCount(arg_57_0)
	return var_0_6
end

local var_0_16 = 0
local var_0_17 = {}

function var_0_0.InitGamePointData(arg_58_0)
	var_0_16 = 0
	var_0_17 = {}
end

function var_0_0.RecordEndlessPointMapNameToList(arg_59_0, arg_59_1)
	table.insert(var_0_17, {
		arg_59_1
	})
end

function var_0_0.RecordEndlessPointScoreToList(arg_60_0)
	local var_60_0 = var_0_3
	local var_60_1 = 0
	local var_60_2 = 0

	for iter_60_0, iter_60_1 in pairs(var_0_17) do
		local var_60_3 = iter_60_1[2]

		if not score then
			var_60_2 = iter_60_0

			break
		else
			var_60_1 = var_60_3
		end
	end

	table.insert(var_0_17[var_60_2], var_60_0 - var_60_1)
end

function var_0_0.RecordPointSkillUseTimes(arg_61_0, arg_61_1)
	var_0_16 = arg_61_1
end

function var_0_0.GetRecordPointData(arg_62_0)
	return var_0_17, var_0_16
end

return var_0_0
