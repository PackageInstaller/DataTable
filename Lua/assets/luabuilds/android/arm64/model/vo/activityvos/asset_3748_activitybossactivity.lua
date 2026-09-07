local ActivityBossActivity = class("ActivityBossActivity", import("model.vo.Activity"))

function ActivityBossActivity:Ctor(arg_1_1)
	ActivityBossActivity.super.Ctor(self, arg_1_1)

	self.bossHP = 0
	self.milestones = {}
	self.bossConfig = ActivityBossConfig.New({
		configId = self:getConfig("config_id")
	})

	return
end

function ActivityBossActivity:GetBossConfig()
	return self.bossConfig
end

function ActivityBossActivity:UpdatePublicData(arg_3_1)
	self.bossHP = arg_3_1.boss_hp or 0
	self.milestones = arg_3_1.milestones or {}
	self.data2 = 1

	return
end

function ActivityBossActivity:AddStage(arg_4_1)
	if table.contains(self.data1_list, arg_4_1) then
		return
	end

	table.insert(self.data1_list, arg_4_1)

	return
end

function ActivityBossActivity:IsOilLimit(arg_5_1)
	assert(arg_5_1)

	return table.contains(self.data1_list, arg_5_1)
end

function ActivityBossActivity:GetBindPtActID()
	return (getProxy(ActivityProxy):GetActBossLinkPTActID(self.id))
end

function ActivityBossActivity:GetBossHP()
	return self.bossHP
end

function ActivityBossActivity:GetMileStones()
	return self.milestones
end

function ActivityBossActivity:readyToAchieve()
	return self.data2 ~= 1
end

function ActivityBossActivity:GetTickets()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(self.data1KeyValueList) do
		for iter_10_2, iter_10_3 in pairs(iter_10_1) do
			var_10_0[iter_10_2] = (var_10_0[iter_10_2] or 0) + iter_10_3
		end
	end

	return var_10_0
end

function ActivityBossActivity:GetStageBonus(arg_11_1)
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in pairs(self.data1KeyValueList) do
		for iter_11_2, iter_11_3 in pairs(iter_11_1) do
			if iter_11_2 == arg_11_1 then
				var_11_0 = var_11_0 + iter_11_3
			end
		end
	end

	return var_11_0
end

function ActivityBossActivity:checkBattleTimeInBossAct()
	assert(self:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

	if self:isEnd() then
		return false
	end

	return pg.TimeMgr.GetInstance():inTime((self.bossConfig:GetBattleTime()))
end

function ActivityBossActivity:GetHighestScore()
	return self.data1
end

function ActivityBossActivity:UpdateHighestScore(arg_14_1)
	if arg_14_1 <= self.data1 then
		return false
	end

	self.data1 = arg_14_1

	return true
end

function ActivityBossActivity:GetHistoryBuffs()
	return self.data2_list
end

function ActivityBossActivity:UpdateHistoryBuffs(arg_16_1)
	self.data2_list = arg_16_1

	return
end

return ActivityBossActivity
