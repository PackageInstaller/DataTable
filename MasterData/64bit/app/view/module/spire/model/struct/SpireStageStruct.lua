local SpireStageStruct = class("SpireStageStruct")

function SpireStageStruct:ctor(arg_1_1, arg_1_2)
	self._passTime = 0
	self._spineId = 0
	self._isBoss = false
	self._cfg = nil
	self._awards = nil
	self._outputGoods = nil
	self._monsterRef = nil
	self._stageBuffList = {}

	self:_initShortInfo(arg_1_1, arg_1_2)
end

function SpireStageStruct:_initShortInfo(arg_2_1, arg_2_2)
	self._cfg = g.core.config.spire_stage_info.get(arg_2_1)
	self._stageBuffList = arg_2_2[self._cfg.buff_group] or {}
end

function SpireStageStruct:getCfg()
	return self._cfg
end

function SpireStageStruct:_initMonster()
	local var_4_0 = g.core.model.User.spireData:getMonsterPool():getMonster()

	var_4_0:updateMonsterInfoById(self._cfg.monster_team, self, self._isBoss)

	self._monsterRef = var_4_0
end

function SpireStageStruct:clearMonsterRef()
	self._monsterRef = nil
end

function SpireStageStruct:_initPassAwards()
	self._awards = {}

	local var_6_0 = 1
	local var_6_1 = {
		"reward_type"
	}

	var_6_1[2] = 1

	local var_6_2 = table.concat(var_6_1, "_")
	local var_6_3 = table.concat({
		"reward_value",
		var_6_0
	}, "_")
	local var_6_4 = table.concat({
		"reward_size",
		var_6_0
	}, "_")

	while g.core.config.spire_stage_info.hasKey(var_6_2) do
		if self._cfg[var_6_2] ~= 0 then
			self._awards[#self._awards + 1] = {
				type = self._cfg[var_6_2],
				value = self._cfg[var_6_3],
				size = self._cfg[var_6_4]
			}
		end

		var_6_0 = var_6_0 + 1
		var_6_2 = table.concat({
			"reward_type",
			var_6_0
		}, "_")
		var_6_3 = table.concat({
			"reward_value",
			var_6_0
		}, "_")
		var_6_4 = table.concat({
			"reward_size",
			var_6_0
		}, "_")
	end
end

function SpireStageStruct:getPassAwards()
	if not self._awards then
		self:_initPassAwards()
	end

	return self._awards
end

function SpireStageStruct:_initOutputGoods()
	self._outputGoods = {}

	local var_8_0 = 1
	local var_8_1 = {
		"output_type"
	}

	var_8_1[2] = 1

	local var_8_2 = table.concat(var_8_1, "_")
	local var_8_3 = table.concat({
		"output_value",
		var_8_0
	}, "_")
	local var_8_4 = table.concat({
		"output_size",
		var_8_0
	}, "_")

	while g.core.config.spire_stage_info.hasKey(var_8_2) do
		if self._cfg[var_8_2] ~= 0 then
			self._outputGoods[#self._outputGoods + 1] = {
				type = self._cfg[var_8_2],
				value = self._cfg[var_8_3],
				size = self._cfg[var_8_4]
			}
		end

		var_8_0 = var_8_0 + 1
		var_8_2 = table.concat({
			"output_type",
			var_8_0
		}, "_")
		var_8_3 = table.concat({
			"output_value",
			var_8_0
		}, "_")
		var_8_4 = table.concat({
			"output_size",
			var_8_0
		}, "_")
	end
end

function SpireStageStruct:getOutputGoods()
	if not self._outputGoods then
		self:_initOutputGoods()
	end

	return self._outputGoods
end

function SpireStageStruct:getShowSpineId()
	if not self._monsterRef then
		self:_initMonster()
	end

	return (self._monsterRef:getShowKnightId())
end

function SpireStageStruct:getShowName()
	if not self._monsterRef then
		self:_initMonster()
	end

	return self._monsterRef:getShowKnightName()
end

function SpireStageStruct:getShowSkillList()
	if not self._monsterRef then
		self:_initMonster()
	end

	return self._monsterRef:getShowSkillList()
end

function SpireStageStruct:getMonster()
	return self._monsterRef
end

function SpireStageStruct:isBossStage()
	return self._isBoss
end

function SpireStageStruct:getPassTime()
	return self._passTime
end

function SpireStageStruct:isPass()
	return self._passTime > 0
end

function SpireStageStruct:getBuffInfoList()
	return self._stageBuffList
end

function SpireStageStruct:updateStageBySvrInfo(arg_18_1)
	self._passTime = arg_18_1.pass_time or 0
end

function SpireStageStruct:onStageFinish(arg_19_1)
	self._passTime = arg_19_1.pass_time
end

return SpireStageStruct
