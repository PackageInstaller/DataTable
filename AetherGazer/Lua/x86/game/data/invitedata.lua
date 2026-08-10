local var_0_0 = singletonClass("InviteData")
local var_0_1 = {}

local function var_0_2(arg_1_0)
	local var_1_0 = 0

	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		var_1_0 = var_1_0 + 1
	end

	return var_1_0
end

function var_0_0.Init(arg_2_0)
	var_0_1:Init()
end

function var_0_0.InitInviteData(arg_3_0, arg_3_1)
	var_0_1:InitInviteData(arg_3_1)
end

function var_0_0.UpdateCompletePlotData(arg_4_0, arg_4_1)
	var_0_1:UpdateCompletePlotData(arg_4_1)
end

function var_0_0.GetDataByPara(arg_5_0, arg_5_1)
	return var_0_1[arg_5_1]
end

function var_0_1.Init(arg_6_0)
	arg_6_0.selectHeroIndex = nil
end

function var_0_1.InitInviteData(arg_7_0, arg_7_1)
	arg_7_0.activityId = arg_7_1.activity_id
	arg_7_0.inviteTimes = arg_7_1.invite_times
	arg_7_0.selectHeroId = nil
	arg_7_0.completePlotTable = {}
	arg_7_0.heroPlotTable = {}
	arg_7_0.heroPlotList = {}
	arg_7_0.drawItemId = 0

	for iter_7_0, iter_7_1 in pairs(ActivityInviteCfg.get_id_list_by_activity_id[arg_7_0.activityId]) do
		local var_7_0 = ActivityInviteCfg[iter_7_1]

		if #var_7_0.reward_list ~= 0 then
			local var_7_1 = var_7_0.reward_list[1][1]

			arg_7_0.drawItemId = ItemCfg[var_7_1].param[1]
		end

		if arg_7_0.heroPlotTable[var_7_0.hero_id] == nil then
			arg_7_0.heroPlotTable[var_7_0.hero_id] = {}
		end

		table.insert(arg_7_0.heroPlotTable[var_7_0.hero_id], var_7_0)
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_0.heroPlotTable) do
		table.sort(iter_7_3, function(arg_8_0, arg_8_1)
			return arg_8_0.stage < arg_8_1.stage
		end)
		table.insert(arg_7_0.heroPlotList, iter_7_3)
	end

	arg_7_0.poolID = DrawTools.GetActivityPoolIdByTicketId(arg_7_0.drawItemId)

	for iter_7_4, iter_7_5 in ipairs(arg_7_1.invite_list) do
		arg_7_0.completePlotTable[iter_7_5] = true
	end

	arg_7_0:UpdateData()
end

function var_0_1.UpdateData(arg_9_0)
	local var_9_0 = 0

	arg_9_0.completeHeroTable = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_0.completePlotTable) do
		var_9_0 = var_9_0 + 1

		local var_9_1 = ActivityInviteCfg[iter_9_0]

		if arg_9_0.completeHeroTable[var_9_1.hero_id] == nil then
			arg_9_0.completeHeroTable[var_9_1.hero_id] = {}
		end

		table.insert(arg_9_0.completeHeroTable[var_9_1.hero_id], iter_9_0)
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0.completeHeroTable) do
		if #iter_9_3 < var_0_2(arg_9_0.heroPlotTable[iter_9_2]) then
			arg_9_0.selectHeroId = iter_9_2
		end
	end

	if var_9_0 % 7 == 0 and (arg_9_0.inviteTimes == 0 or arg_9_0.inviteTimes >= GameSetting.activity_invite_daily_opportunities.value[1]) then
		arg_9_0.selectHeroId = nil
	end

	arg_9_0.allComplete = var_9_0 == #ActivityInviteCfg.get_id_list_by_activity_id[arg_9_0.activityId]

	arg_9_0:SelectIdToIndex()
end

function var_0_1.SelectIdToIndex(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.heroPlotList) do
		if iter_10_1[1].hero_id == arg_10_0.selectHeroId then
			arg_10_0.selectHeroIndex = iter_10_0
		end
	end
end

function var_0_1.UpdateCompletePlotData(arg_11_0, arg_11_1)
	if ActivityInviteCfg[arg_11_1.plot_id].stage ~= 0 then
		arg_11_0.inviteTimes = arg_11_0.inviteTimes - 1
	end

	arg_11_0.completePlotTable[arg_11_1.plot_id] = true

	arg_11_0:UpdateData()
	arg_11_0:UpdateReward(arg_11_1.plot_id)
end

function var_0_1.UpdateReward(arg_12_0, arg_12_1)
	local var_12_0 = 0
	local var_12_1
	local var_12_2 = ActivityInviteCfg[arg_12_1]

	for iter_12_0, iter_12_1 in pairs(arg_12_0.heroPlotTable[var_12_2.hero_id]) do
		if iter_12_1.stage == var_12_2.stage and arg_12_0.completePlotTable[iter_12_1.id] then
			var_12_0 = var_12_0 + 1

			if #iter_12_1.reward_list > 0 then
				var_12_1 = iter_12_1.reward_list
			end
		end
	end

	if var_12_0 == 3 then
		manager.notify:CallUpdateFunc(INVITE_PLOT_GET_REWARD, var_12_1)
	end
end

return var_0_0
