local MallLevel = class("MallLevel", import("model.vo.BaseVO"))

MallLevel.CONDITION_TYPE = {
	ROUND = 1,
	ROUND_INCOME = 2,
	FLOOR_INCOME = 4,
	ORDER = 3
}

function MallLevel:Ctor(arg_1_1)
	self.level = arg_1_1

	self:InitLevelConfig()

	self.level = math.min(self.level, self.maxLevel)
	self.id = self.level2Id[self.level]
	self.configId = self.id

	return
end

function MallLevel:bindConfigTable()
	return pg.activity_mall_level
end

function MallLevel:InitLevelConfig()
	self.level2Id = {}
	self.maxLevel = 0

	for iter_3_0, iter_3_1 in ipairs(pg.activity_mall_level.all) do
		self.level2Id[pg.activity_mall_level[iter_3_1].lv] = iter_3_1
		self.maxLevel = math.max(self.maxLevel, pg.activity_mall_level[iter_3_1].lv)
	end

	return
end

function MallLevel:IsMaxLevel()
	return self.level == self.maxLevel
end

function MallLevel:OnUpgradeDone(arg_5_1)
	self.level = math.min(arg_5_1, self.maxLevel)
	self.id = self.level2Id[self.level]
	self.configId = self.id

	return
end

function MallLevel:GetReachLevelIds(arg_6_1)
	local var_6_0 = {}

	for iter_6_0 = 1, self.level do
		table.insert(var_6_0, self.level2Id[iter_6_0])
	end

	return var_6_0
end

function MallLevel:GetUnlockStoryIds()
	local var_7_0 = {}
	local var_7_1 = self:bindConfigTable()

	for iter_7_0, iter_7_1 in ipairs(self:GetReachLevelIds()) do
		var_7_0 = table.mergeArray(var_7_0, var_7_1[iter_7_1].unlock_param.story_id, true)
	end

	return var_7_0
end

function MallLevel:GetUnlockStoryIdsByType()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(self:GetUnlockStoryIds()) do
		if pg.activity_mall_story[iter_8_1] then
			var_8_0[pg.activity_mall_story[iter_8_1].type] = var_8_0[pg.activity_mall_story[iter_8_1].type] or {}

			table.insert(var_8_0[pg.activity_mall_story[iter_8_1].type], iter_8_1)
		end
	end

	for iter_8_2, iter_8_3 in pairs(var_8_0) do
		table.sort(iter_8_3, function(arg_9_0, arg_9_1)
			return arg_9_0 < arg_9_1
		end)
	end

	return var_8_0
end

function MallLevel:GetIdByLevel()
	return underscore.detect(pg.activity_mall_level.all, function(arg_11_0)
		return pg.activity_mall_level[arg_11_0].lv == self
	end)
end

function MallLevel:GetShowInfos()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(pg.activity_mall_level[self].round_show) do
		table.insert(var_12_0, iter_12_1[2])
	end

	local var_12_1 = pg.activity_mall_level[self].round_show[getRandomIdxByWeights(var_12_0)]

	return {
		skinId = var_12_1[1],
		wordList = var_12_1[3]
	}
end

return MallLevel
