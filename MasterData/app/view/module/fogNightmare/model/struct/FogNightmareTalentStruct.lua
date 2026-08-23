local FogNightmareTalentStruct = class("FogNightmareTalentStruct")
local var_0_1 = g.core.config.fog_talent_level_info
local var_0_2 = g.core.config.fog_talent_info

function FogNightmareTalentStruct:ctor(arg_1_1)
	self._id = arg_1_1
	self._cfg = var_0_2.get(self._id)

	if self._cfg.weekly_buff_id == 0 then
		self._initLevel = 0
		self.curLevel = self._initLevel
		self.nextLevel = self.curLevel + 1
		self._levelCfg = var_0_1.get(self._id, 0)
		self._nextLevelCfg = var_0_1.get(self._id, self.nextLevel)
	else
		self._initLevel = 1
		self.curLevel = self._initLevel
		self.nextLevel = self.curLevel + 1
		self._levelCfg = var_0_1.get(self._id, 1)
	end

	self.isUnLock = false
	self.isMax = false
	self.isUpgrade = false
	self._playLock = false
	self._extraRandNum = 0
	self._extraEffect = {}
	self._cfgInfos = {}

	for iter_1_0 = 1, var_0_1.getLength() do
		local var_1_0 = var_0_1.indexOf(iter_1_0)

		if var_1_0.talent_id == arg_1_1 then
			table.insert(self._cfgInfos, var_1_0)
		end
	end
end

function FogNightmareTalentStruct:getCfg()
	return self._cfg
end

function FogNightmareTalentStruct:updateInfo(arg_3_1)
	self.curLevel = arg_3_1
	self.isMax = false
	self._extraEffect = {}
	self._levelCfg = var_0_1.get(self._id, self.curLevel)

	if var_0_1.fetch(self._id, self.curLevel + 1) then
		self.nextLevel = self.curLevel + 1
		self._nextLevelCfg = var_0_1.get(self._id, self.nextLevel)
	else
		self.isMax = true
	end

	if self._levelCfg.type == 2 and self._levelCfg.value == 7 then
		self._extraRandNum = self._levelCfg.param_1
	end

	if arg_3_1 == 0 then
		self._extraRandNum = 0
	end

	local var_3_0 = 1

	while var_0_1.hasKey("param_" .. var_3_0) do
		self._extraEffect[self._levelCfg.type .. "_" .. self._levelCfg.value .. "_" .. var_3_0] = self._extraEffect[self._levelCfg.type .. "_" .. self._levelCfg.value .. "_" .. var_3_0] and self._extraEffect[self._levelCfg.type .. "_" .. self._levelCfg.value .. "_" .. var_3_0] + self._levelCfg["param_" .. var_3_0] or self._levelCfg["param_" .. var_3_0]
		var_3_0 = var_3_0 + 1
	end
end

function FogNightmareTalentStruct:setIsUnLock(arg_4_1, arg_4_2)
	self.isUnLock = arg_4_1

	if arg_4_1 == true and not arg_4_2 then
		self._playLock = true
	end
end

function FogNightmareTalentStruct:getIsUnlock()
	return self.isUnLock
end

function FogNightmareTalentStruct:getCurLevelCfg()
	return self._levelCfg
end

function FogNightmareTalentStruct:getNextLevelCfg()
	return self._nextLevelCfg
end

function FogNightmareTalentStruct:getLevelInfos()
	return self._cfgInfos
end

function FogNightmareTalentStruct:getInitLevel()
	return self._initLevel
end

function FogNightmareTalentStruct:setUpgrade(arg_10_1)
	self.isUpgrade = arg_10_1
end

function FogNightmareTalentStruct:getUpgrade()
	return self.isUpgrade
end

function FogNightmareTalentStruct:getExtraRandNum()
	return self._extraRandNum
end

function FogNightmareTalentStruct:getPlayLock()
	return self._playLock
end

function FogNightmareTalentStruct:setPlayLock(arg_14_1)
	self._playLock = arg_14_1
end

function FogNightmareTalentStruct:getEffectByTypeValueAndIndex(arg_15_1, arg_15_2, arg_15_3)
	return self._extraEffect[arg_15_1 .. "_" .. arg_15_2 .. "_" .. arg_15_3]
end

function FogNightmareTalentStruct:isSpecial()
	return self._cfg.weekly_buff_id ~= 0
end

return FogNightmareTalentStruct
