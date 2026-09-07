local IslandSeason = class("IslandSeason", import("model.vo.BaseVO"))

IslandSeason.RESET_TIP_KEY = "IslandSeason.RESET_TIP_KEY"

function IslandSeason:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.pt = arg_1_1.pt or 0
	self.gotPtAwardList = arg_1_1.fetch_list or {}
	self.records = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.count_list or {}) do
		self.records[iter_1_1.key] = iter_1_1.value
	end

	self.endTime = pg.TimeMgr.GetInstance():parseTimeFromConfig(self:getConfig("time")[2])
	self.localTipKey = IslandSeason.RESET_TIP_KEY .. "_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. self.id

	return
end

function IslandSeason:IsEnd()
	return pg.TimeMgr.GetInstance():GetServerTime() >= self.endTime
end

function IslandSeason:bindConfigTable()
	return pg.island_season
end

function IslandSeason:GetTimeStr()
	local var_4_0 = self:getConfig("time")

	return string.format("%d.%d.%d - %d.%d.%d", var_4_0[1][1][1], var_4_0[1][1][2], var_4_0[1][1][3], var_4_0[2][1][1], var_4_0[2][1][2], var_4_0[2][1][3])
end

function IslandSeason:GetRemainTime()
	return self.endTime - pg.TimeMgr.GetInstance():GetServerTime()
end

function IslandSeason:NeedTip()
	local var_6_0 = self.endTime - pg.TimeMgr.GetInstance():GetServerTime()
	local var_6_1 = math.floor(var_6_0 / 0)

	if var_6_1 > 3 then
		return false
	end

	if PlayerPrefs.GetInt(self.localTipKey .. "_" .. self:GetTipStamp(var_6_1)) == 1 then
		return false
	end

	local var_6_4 = math.floor(var_6_0 / 16)
end

function IslandSeason:SetTipFlag(arg_7_1)
	PlayerPrefs.SetInt(self.localTipKey .. "_" .. self:GetTipStamp(arg_7_1), 1)

	return
end

function IslandSeason:GetTipStamp(arg_8_1)
	return arg_8_1 .. "_" .. self.endTime - arg_8_1 * 0
end

function IslandSeason:AddPt(arg_9_1)
	if self.pt == 0 then
		IslandAchievementHelper.UpdateRecordWithAdd(IslandAchievementType.SEASON_NUM, 0, 1)
	end

	self.pt = self.pt + arg_9_1

	return
end

function IslandSeason:GetPt()
	return self.pt
end

function IslandSeason:GetGotPtAwardList()
	return self.gotPtAwardList
end

function IslandSeason:AddGotPtAwardList(arg_12_1)
	if arg_12_1 == 0 then
		for iter_12_0, iter_12_1 in ipairs(self:getConfig("target")) do
			if iter_12_1 <= self.pt and not table.contains(self.gotPtAwardList, iter_12_1) then
				table.insert(self.gotPtAwardList, iter_12_1)
			end
		end
	else
		table.insert(self.gotPtAwardList, arg_12_1)
	end

	return
end

function IslandSeason:GanGetPtAward()
	return underscore.any(self:getConfig("target"), function(arg_14_0)
		return arg_14_0 <= self.pt and not table.contains(self.gotPtAwardList, arg_14_0)
	end)
end

function IslandSeason:GetTaskIds()
	return self:getConfig("task_list")
end

function IslandSeason:GetAwardsByRank(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(pg.island_season[self].rank) do
		if arg_16_1 >= iter_16_1[1] and arg_16_1 <= iter_16_1[2] then
			return underscore.map(pg.island_season[self].rankaward_display[iter_16_0], function(arg_17_0)
				return Drop.Create(arg_17_0)
			end)
		end
	end

	return {}
end

function IslandSeason:GetPtAwardInfos()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(pg.island_season[self].target) do
		table.insert(var_18_0, {
			target = iter_18_1,
			drop = Drop.Create(pg.island_season[self].ptaward_display[iter_18_0]),
			isImportant = table.contains(pg.island_season[self].ptaward_highvalue, iter_18_0)
		})
	end

	return var_18_0
end

return IslandSeason
