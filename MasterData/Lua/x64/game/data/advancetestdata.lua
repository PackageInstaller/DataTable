local var_0_0 = singletonClass("AdvanceTestData", BaseHeroViewData)

function var_0_0.Init(arg_1_0)
	arg_1_0.cacheActivityID = 0
	arg_1_0.lastSelectIndex = {}
	arg_1_0.battleResultScore = 0
	arg_1_0.activityIDList = {}
	arg_1_0.scoreList = {}
	arg_1_0.affixList_ = {}
	arg_1_0.recordSelectBuffList = {}
end

function var_0_0:GetActivityList()
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(self.activityIDList) do
		table.insert(var_2_0, iter_2_1)
	end

	return var_2_0
end

function var_0_0:GetCacheActivityID()
	return self.cacheActivityID
end

function var_0_0.SetCacheActivityID(arg_4_0, arg_4_1)
	arg_4_0.cacheActivityID = arg_4_1
end

function var_0_0:GetLastSelectIndex(arg_5_1)
	if self.lastSelectIndex[arg_5_1] and AdvanceTestCfg[self.lastSelectIndex[arg_5_1]] then
		return self.lastSelectIndex[arg_5_1]
	else
		return AdvanceTestCfg.get_id_list_by_activity_id[arg_5_1] and AdvanceTestCfg.get_id_list_by_activity_id[arg_5_1][1]
	end
end

function var_0_0:SetLastSelectIndex(arg_6_1, arg_6_2)
	self.lastSelectIndex[arg_6_2] = arg_6_1
end

function var_0_0:InitDefalutHeroList()
	self.heroList = clone(HeroData:GetHeroList())

	for iter_7_0, iter_7_1 in pairs(self.heroList) do
		iter_7_1.servantInfo = clone(iter_7_1:GetServantInfo())

		function iter_7_1.GetServantInfo()
			return iter_7_1.servantInfo
		end
	end
end

function var_0_0:GetHeroList()
	return self.heroList
end

function var_0_0:GetSortedHeroList()
	return (HeroTools.Sort(self:GetHeroList()))
end

function var_0_0:GetAdvanceHeroData(arg_11_1)
	return self.heroList[arg_11_1]
end

function var_0_0.GetCurCfgByIndex(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0

	for iter_12_0, iter_12_1 in pairs(AdvanceTestCfg.get_id_list_by_activity_id[arg_12_2]) do
		if AdvanceTestCfg[iter_12_1].stage_type == arg_12_1 then
			var_12_0 = AdvanceTestCfg[iter_12_1]

			break
		end
	end

	return var_12_0
end

function var_0_0:SetHeroListByDifficult(arg_13_1, arg_13_2)
	local var_13_0 = self:GetCurCfgByIndex(arg_13_1, arg_13_2)
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(var_13_0.limit_hero) do
		if iter_13_1[1] == 8 then
			table.insert(var_13_1, iter_13_1[2][1], iter_13_1[2][2])
		end
	end

	for iter_13_2, iter_13_3 in pairs(self.heroList) do
		iter_13_3.star = var_13_0.character

		if iter_13_3.servant_uid ~= 0 and iter_13_3.unlock == 1 then
			iter_13_3.servantInfo.stage = var_13_0.weapon
		end

		if var_13_1[iter_13_3.id] then
			iter_13_3.using_astrolabe = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[HeroCfg[iter_13_3.id].astrolabe[var_13_1[iter_13_3.id]]]
		end
	end
end

function var_0_0:GetIsActivityOpen()
	for iter_14_0, iter_14_1 in pairs(self.activityIDList) do
		if ActivityData:GetActivityIsOpen(iter_14_1) then
			return true
		end
	end

	return false
end

function var_0_0:OnReceviedAdvanceTestData(arg_15_1)
	if arg_15_1 == nil then
		return
	else
		self.scoreList[arg_15_1.activity_id] = self.scoreList[arg_15_1.activity_id] or {}
		self.activityIDList[arg_15_1.activity_id] = self.activityIDList[arg_15_1.activity_id] or arg_15_1.activity_id
		self.subActivityList = AdvanceTestCfg.get_id_list_by_activity_id[arg_15_1.activity_id]

		for iter_15_0, iter_15_1 in ipairs(arg_15_1.stage_list) do
			self.scoreList[arg_15_1.activity_id][AdvanceTestCfg[self.subActivityList[iter_15_0]].stage_type] = iter_15_1.history_max_score
		end
	end
end

function var_0_0:OnReceviedBattleResult(arg_16_1)
	self.battleResultScore = arg_16_1.score
	self.scoreList[arg_16_1.activity_id] = self.scoreList[arg_16_1.activity_id] or {}
	self.scoreList[arg_16_1.activity_id][AdvanceTestCfg[arg_16_1.id].stage_type] = arg_16_1.history_max_score
end

function var_0_0:GetBattleResultScore()
	return self.battleResultScore
end

function var_0_0:GetHistortyMaxScoreByIndex(arg_18_1, arg_18_2)
	if not self.scoreList or not self.scoreList[arg_18_2] or not self.scoreList[arg_18_2][arg_18_1] then
		return -1
	end

	return self.scoreList[arg_18_2][arg_18_1]
end

function var_0_0.SetAffixList(arg_19_0, arg_19_1)
	arg_19_0.affixList_ = arg_19_1
end

function var_0_0:GetAffixList()
	return self.affixList_ or {}
end

local var_0_2 = {
	ALL = 1,
	GUILD = 2
}
local var_0_3 = var_0_2.ALL

function var_0_0:GetCurActivityID()
	for iter_21_0, iter_21_1 in pairs(ActivityCfg[self.cacheActivityID].sub_activity_list) do
		local var_21_0 = ActivityData:GetActivityData(iter_21_1)

		if manager.time:GetServerTime() >= var_21_0.startTime and manager.time:GetServerTime() < var_21_0.stopTime then
			return iter_21_1
		end
	end

	return 0
end

function var_0_0.GetRankTypeConst(arg_22_0)
	return var_0_2
end

function var_0_0.GetCurRankType(arg_23_0)
	return var_0_3
end

function var_0_0.SetCurRankType(arg_24_0, arg_24_1)
	var_0_3 = arg_24_1
end

function var_0_0:RecordSelectAffix(arg_25_1, arg_25_2, arg_25_3)
	self.recordSelectBuffList[arg_25_1] = {
		select_gen_list = arg_25_2,
		buff_id_list = arg_25_3
	}
end

function var_0_0:GetSelectBuffList(arg_26_1)
	return (self.recordSelectBuffList[arg_26_1] or nil) and (self.recordSelectBuffList[arg_26_1].buff_id_list or {})
end

function var_0_0:GetSelectGen(arg_27_1)
	return (self.recordSelectBuffList[arg_27_1] or nil) and (self.recordSelectBuffList[arg_27_1].select_gen_list or {})
end

return var_0_0
