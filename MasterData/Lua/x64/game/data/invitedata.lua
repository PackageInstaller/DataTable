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

function var_0_1:InitInviteData(arg_7_1)
	self.activityId = arg_7_1.activity_id
	self.inviteTimes = arg_7_1.invite_times
	self.selectHeroId = nil
	self.completePlotTable = {}
	self.heroPlotTable = {}
	self.heroPlotList = {}
	self.drawItemId = 0

	for iter_7_0, iter_7_1 in pairs(ActivityInviteCfg.get_id_list_by_activity_id[self.activityId]) do
		if #ActivityInviteCfg[iter_7_1].reward_list ~= 0 then
			self.drawItemId = ItemCfg[ActivityInviteCfg[iter_7_1].reward_list[1][1]].param[1]
		end

		if self.heroPlotTable[ActivityInviteCfg[iter_7_1].hero_id] == nil then
			self.heroPlotTable[ActivityInviteCfg[iter_7_1].hero_id] = {}
		end

		table.insert(self.heroPlotTable[ActivityInviteCfg[iter_7_1].hero_id], ActivityInviteCfg[iter_7_1])
	end

	for iter_7_2, iter_7_3 in pairs(self.heroPlotTable) do
		table.sort(iter_7_3, function(arg_8_0, arg_8_1)
			return arg_8_0.stage < arg_8_1.stage
		end)
		table.insert(self.heroPlotList, iter_7_3)
	end

	self.poolID = DrawTools.GetActivityPoolIdByTicketId(self.drawItemId)

	for iter_7_4, iter_7_5 in ipairs(arg_7_1.invite_list) do
		self.completePlotTable[iter_7_5] = true
	end

	self:UpdateData()
end

function var_0_1:UpdateData()
	local var_9_0 = 0

	self.completeHeroTable = {}

	for iter_9_0, iter_9_1 in pairs(self.completePlotTable) do
		var_9_0 = var_9_0 + 1

		if self.completeHeroTable[ActivityInviteCfg[iter_9_0].hero_id] == nil then
			self.completeHeroTable[ActivityInviteCfg[iter_9_0].hero_id] = {}
		end

		table.insert(self.completeHeroTable[ActivityInviteCfg[iter_9_0].hero_id], iter_9_0)
	end

	for iter_9_2, iter_9_3 in pairs(self.completeHeroTable) do
		if #iter_9_3 < var_0_2(self.heroPlotTable[iter_9_2]) then
			self.selectHeroId = iter_9_2
		end
	end

	if var_9_0 % 7 == 0 and (self.inviteTimes == 0 or self.inviteTimes >= GameSetting.activity_invite_daily_opportunities.value[1]) then
		self.selectHeroId = nil
	end

	self.allComplete = var_9_0 == #ActivityInviteCfg.get_id_list_by_activity_id[self.activityId]

	self:SelectIdToIndex()
end

function var_0_1:SelectIdToIndex()
	for iter_10_0, iter_10_1 in ipairs(self.heroPlotList) do
		if iter_10_1[1].hero_id == self.selectHeroId then
			self.selectHeroIndex = iter_10_0
		end
	end
end

function var_0_1:UpdateCompletePlotData(arg_11_1)
	if ActivityInviteCfg[arg_11_1.plot_id].stage ~= 0 then
		self.inviteTimes = self.inviteTimes - 1
	end

	self.completePlotTable[arg_11_1.plot_id] = true

	self:UpdateData()
	self:UpdateReward(arg_11_1.plot_id)
end

function var_0_1:UpdateReward(arg_12_1)
	local var_12_0 = 0
	local var_12_1

	for iter_12_0, iter_12_1 in pairs(self.heroPlotTable[ActivityInviteCfg[arg_12_1].hero_id]) do
		if iter_12_1.stage == ActivityInviteCfg[arg_12_1].stage and self.completePlotTable[iter_12_1.id] then
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
