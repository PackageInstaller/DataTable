local SpireStageStruct = require("app.view.module.spire.model.struct.SpireStageStruct")
local SpireBossFloorStruct = class("SpireBossFloorStruct", SpireStageStruct)

function SpireBossFloorStruct:ctor(arg_1_1, arg_1_2)
	self._lastScore = 0
	self._maxScore = 0
	self._lastDamage = 0
	self._maxDamage = 0
	self._rank = 0
	self._curBuffIds = {}
	self._lastBuffRatio = 0
	self._buffRatio = 0
	self._buffList = nil
	self._buffIndexDic = {}
	self._maxRate = 0

	SpireBossFloorStruct.super.ctor(self, arg_1_1, arg_1_2)
end

function SpireBossFloorStruct:_initShortInfo(arg_2_1, arg_2_2)
	self._isBoss = true
	self._cfg = g.core.config.spire_boss_info.get(arg_2_1)
	self._stageBuffList = arg_2_2[self._cfg.buff_group] or {}
end

function SpireBossFloorStruct:_initPassAwards()
	self._awards = {}

	local var_3_0 = 1
	local var_3_1 = {
		"reward_type"
	}

	var_3_1[2] = 1

	local var_3_2 = table.concat(var_3_1, "_")
	local var_3_3 = table.concat({
		"reward_value",
		var_3_0
	}, "_")
	local var_3_4 = table.concat({
		"reward_size",
		var_3_0
	}, "_")

	while g.core.config.spire_boss_info.hasKey(var_3_2) do
		if self._cfg[var_3_2] ~= 0 then
			self._awards[#self._awards + 1] = {
				type = self._cfg[var_3_2],
				value = self._cfg[var_3_3],
				size = self._cfg[var_3_4]
			}
		end

		var_3_0 = var_3_0 + 1
		var_3_2 = table.concat({
			"reward_type",
			var_3_0
		}, "_")
		var_3_3 = table.concat({
			"reward_value",
			var_3_0
		}, "_")
		var_3_4 = table.concat({
			"reward_size",
			var_3_0
		}, "_")
	end
end

function SpireBossFloorStruct:getBossBuffList()
	if not self._buffList then
		self._buffList = {}
		self._buffIndexDic = {}

		for iter_4_0 = 1, g.core.config.spire_boss_buff_info.getLength() do
			local var_4_0 = g.core.config.spire_boss_buff_info.indexOf(iter_4_0)

			if var_4_0.boss_buff_group == self._cfg.boss_buff_group then
				local var_4_1 = {
					isSelect = false,
					cfg = var_4_0
				}

				self._buffList[#self._buffList + 1] = var_4_1
				self._buffIndexDic[var_4_0.id] = var_4_1
			end
		end
	end

	return self._buffList
end

function SpireBossFloorStruct:getCurBuffIds()
	return self._curBuffIds
end

function SpireBossFloorStruct:getCurBuffs()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(self._curBuffIds) do
		var_6_0[#var_6_0 + 1] = self._buffIndexDic[iter_6_1]
	end

	return var_6_0
end

function SpireBossFloorStruct:getLastBuffRatio()
	return self._lastBuffRatio
end

function SpireBossFloorStruct:getBuffRatio()
	return self._buffRatio
end

function SpireBossFloorStruct:getLastScore()
	return self._lastScore
end

function SpireBossFloorStruct:getMaxScore()
	return self._maxScore
end

function SpireStageStruct:getLastDamage()
	return self._lastDamage
end

function SpireStageStruct:getMaxDamage()
	return self._maxDamage
end

function SpireBossFloorStruct:getRank()
	return self._rank
end

function SpireStageStruct:getMaxRate()
	return self._maxRate
end

function SpireBossFloorStruct:updateStageBySvrInfo(arg_15_1)
	if not self._buffList then
		self:getBossBuffList()
	end

	self._maxDamage = arg_15_1.max_damage or 0
	self._lastDamage = self._maxDamage
	self._maxScore = arg_15_1.max_score or 0
	self._lastScore = self._maxScore
	self._rank = arg_15_1.rank or 0
	self._maxRate = arg_15_1.max_rate or 0
	self._buffRatio = 0

	for iter_15_0, iter_15_1 in ipairs(arg_15_1.buffs or {}) do
		self._buffIndexDic[iter_15_1].isSelect = true
		self._buffRatio = self._buffRatio + self._buffIndexDic[iter_15_1].cfg.point
	end

	self._lastBuffRatio = self._buffRatio
end

function SpireBossFloorStruct:updateBossBuff(arg_16_1, arg_16_2)
	self._lastBuffRatio = self._buffRatio
	self._buffIndexDic[arg_16_1].isSelect = arg_16_2

	local var_16_0 = 0

	if self._buffIndexDic[arg_16_1].isSelect ~= arg_16_2 then
		var_16_0 = self._buffIndexDic[arg_16_1].cfg.point

		if not arg_16_2 then
			var_16_0 = -var_16_0
		end
	end

	self._buffRatio = self._buffRatio + var_16_0
end

function SpireBossFloorStruct:onStageFinish(arg_17_1)
	if arg_17_1.damage and arg_17_1.damage > self._maxDamage then
		self._lastDamage = self._maxDamage
		self._maxDamage = arg_17_1.damage
	end

	if arg_17_1.score and arg_17_1.score > self._maxScore then
		self._lastScore = self._maxScore
		self._maxScore = arg_17_1.score
	end

	if arg_17_1.rate and arg_17_1.rate > self._maxRate then
		self._maxRate = arg_17_1.rate
	end
end

return SpireBossFloorStruct
