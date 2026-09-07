local IslandAchievementAgency = class("IslandAchievementAgency", import(".IslandBaseAgency"))

IslandAchievementAgency.NEW_CAN_GET = "IslandAchievementAgency.NEW_CAN_GET"

function IslandAchievementAgency:OnInit(arg_1_1)
	self.gotList = arg_1_1.achievement_sys.finish_list or {}
	self.recordDic = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.achievement_sys.achieve_list or {}) do
		self.recordDic[iter_1_1.event_type] = self.recordDic[iter_1_1.event_type] or {}
		self.recordDic[iter_1_1.event_type][iter_1_1.event_arg] = iter_1_1.value
	end

	return
end

function IslandAchievementAgency:InitRuntimeRecords()
	local var_2_0 = IslandAchievementType.GetRuntimeTypes()
	local var_2_1 = IslandAchievementType.GetClientTypes()

	for iter_2_0, iter_2_1 in ipairs(pg.island_achievement.all) do
		if table.contains(var_2_0, pg.island_achievement[iter_2_1].target_type) then
			self.recordDic[pg.island_achievement[iter_2_1].target_type] = self.recordDic[pg.island_achievement[iter_2_1].target_type] or {}
			self.recordDic[pg.island_achievement[iter_2_1].target_type][pg.island_achievement[iter_2_1].target_value1] = self.recordDic[pg.island_achievement[iter_2_1].target_type][pg.island_achievement[iter_2_1].target_value1] or IslandAchievementHelper.GetRuntimeData(pg.island_achievement[iter_2_1].target_type, pg.island_achievement[iter_2_1].target_value1)
		elseif table.contains(var_2_1, pg.island_achievement[iter_2_1].target_type) then
			self.recordDic[pg.island_achievement[iter_2_1].target_type] = self.recordDic[pg.island_achievement[iter_2_1].target_type] or {}
			self.recordDic[pg.island_achievement[iter_2_1].target_type][pg.island_achievement[iter_2_1].target_value1] = self.recordDic[pg.island_achievement[iter_2_1].target_type][pg.island_achievement[iter_2_1].target_value1] or 0
		end
	end

	self:BuildDataDic()

	return
end

function IslandAchievementAgency:BuildDataDic()
	self.groupDic = {}
	self.achvDic = {}

	for iter_3_0, iter_3_1 in pairs(pg.island_achievement.get_id_list_by_group) do
		local var_3_0 = IslandAchievementGroup.New(iter_3_0, iter_3_1)

		for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
			local var_3_1 = var_3_0:GetAchvById(iter_3_3)

			if table.contains(self.gotList, iter_3_3) then
				var_3_1:SetStatus(IslandAchievement.STATUS.GOT)
			else
				var_3_1:SetStatus((self:IsCanGet(var_3_1) or nil) and (IslandAchievement.STATUS.GET or IslandAchievement.STATUS.NORMAL))
			end

			local var_3_2 = var_3_1:GetType()
			local var_3_3 = var_3_1:GetParam()

			self.achvDic[var_3_2] = self.achvDic[var_3_2] or {}
			self.achvDic[var_3_2][var_3_3] = self.achvDic[var_3_2][var_3_3] or {}

			table.insert(self.achvDic[var_3_2][var_3_3], var_3_1)
		end

		self.groupDic[iter_3_0] = var_3_0
	end

	return
end

function IslandAchievementAgency:GetRecordsByType(arg_4_1)
	return self.recordDic[arg_4_1] or {}
end

function IslandAchievementAgency:IsGot(arg_5_1)
	return table.contains(self.gotList, arg_5_1)
end

function IslandAchievementAgency:GetGotList()
	return self.gotList
end

function IslandAchievementAgency:GetGotGroupMaxStageList()
	local var_7_0 = {}
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in ipairs(self.gotList) do
		if not var_7_0[pg.island_achievement[iter_7_1].group] or pg.island_achievement[iter_7_1].stage > var_7_0[pg.island_achievement[iter_7_1].group] then
			var_7_0[pg.island_achievement[iter_7_1].group] = pg.island_achievement[iter_7_1].stage
			var_7_1[pg.island_achievement[iter_7_1].group] = iter_7_1
		end
	end

	return underscore.values(var_7_1)
end

function IslandAchievementAgency:UpdataAchLv(arg_8_1)
	local var_8_0 = {}
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs((self:GetGotGroupMaxStageList())) do
		var_8_1[pg.island_achievement[iter_8_1].group] = iter_8_1
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_1) do
		table.insert(var_8_0, var_8_1[pg.island_achievement[iter_8_3].group])
	end

	return var_8_0
end

function IslandAchievementAgency:GetGroup(arg_9_1)
	return self.groupDic[arg_9_1]
end

function IslandAchievementAgency:IsCanGet(arg_10_1)
	if arg_10_1:GetStatus() == IslandAchievement.STATUS.GOT then
		return
	end

	local var_10_0 = arg_10_1:GetType()
	local var_10_1 = arg_10_1:GetParam()

	if not self.recordDic[var_10_0] then
		return false
	end

	return self.recordDic[var_10_0][var_10_1] and arg_10_1:GetNum() <= self.recordDic[var_10_0][var_10_1]
end

function IslandAchievementAgency:GetCurProgress(arg_11_1)
	local var_11_0 = arg_11_1:GetType()
	local var_11_1 = arg_11_1:GetParam()
	local var_11_2 = arg_11_1:GetNum()

	if not self.recordDic[var_11_0] then
		return 0
	end

	return self.recordDic[var_11_0][var_11_1] or 0
end

function IslandAchievementAgency:GetTotalCnt()
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in pairs(self.groupDic) do
		var_12_0 = underscore.reduce(iter_12_1:GetSortAchvList(), var_12_0, function(arg_13_0, arg_13_1)
			return arg_13_0 + (arg_13_1:IsHideType() and (self:IsCanGet(arg_13_1) and 1 or 0) or 1)
		end)
	end

	return var_12_0
end

function IslandAchievementAgency:CheckRecordExist(arg_14_1, arg_14_2)
	return self.recordDic[arg_14_1] and self.recordDic[arg_14_1][arg_14_2]
end

function IslandAchievementAgency:UpdateRecord(arg_15_1, arg_15_2, arg_15_3)
	self.recordDic[arg_15_1] = self.recordDic[arg_15_1] or {}

	if not self.recordDic[arg_15_1][arg_15_2] then
		-- block empty
	end

	self.recordDic[arg_15_1][arg_15_2] = arg_15_3

	self:CheckAchvStatus(arg_15_1, arg_15_2)

	return
end

function IslandAchievementAgency:UpdateRecordWithAdd(arg_16_1, arg_16_2, arg_16_3)
	self.recordDic[arg_16_1] = self.recordDic[arg_16_1] or {}
	self.recordDic[arg_16_1][arg_16_2] = (self.recordDic[arg_16_1][arg_16_2] or 0) + arg_16_3

	self:CheckAchvStatus(arg_16_1, arg_16_2)

	return
end

function IslandAchievementAgency:CheckAchvStatus(arg_17_1, arg_17_2)
	if not self.achvDic[arg_17_1] or not self.achvDic[arg_17_1][arg_17_2] then
		return
	end

	for iter_17_0, iter_17_1 in ipairs(self.achvDic[arg_17_1][arg_17_2]) do
		if iter_17_1:GetStatus() == IslandAchievement.STATUS.NORMAL and self:IsCanGet(iter_17_1) then
			iter_17_1:SetStatus(IslandAchievement.STATUS.GET)
			self:DispatchEvent(IslandAchievementAgency.NEW_CAN_GET, iter_17_1)
		end
	end

	return
end

function IslandAchievementAgency:AddGotIds(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		table.insert(self.gotList, iter_18_1)
		self.groupDic[pg.island_achievement[iter_18_1].group]:SetGotTagById(iter_18_1)
	end

	return
end

function IslandAchievementAgency:IsTip()
	for iter_19_0, iter_19_1 in pairs(self.groupDic) do
		for iter_19_2, iter_19_3 in ipairs(iter_19_1:GetSortAchvList()) do
			if iter_19_3:GetStatus() == IslandAchievement.STATUS.GET then
				return true
			end
		end
	end

	return false
end

return IslandAchievementAgency
