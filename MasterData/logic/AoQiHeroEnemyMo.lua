-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/battleMo/AoQiHeroEnemyMo.lua

module("logic.extensions.aoqihero.model.battleMo.AoQiHeroEnemyMo", package.seeall)

local AoQiHeroEnemyMo = class("AoQiHeroEnemyMo", AoQiHeroEntityMo)

function AoQiHeroEnemyMo:ctor()
	AoQiHeroEnemyMo.super.ctor(self)

	self.pos = 0
	self.sizeX = 1
	self.sizeY = 1
	self.isEnemy = true
	self.normalSkillId = nil
	self.ultSkillId = nil
	self._maxEnergy = 0
end

function AoQiHeroEnemyMo:initData(info)
	AoQiHeroEnemyMo.super.initData(self, info)

	self.pos = info.pos

	local petCfg = AoQiHeroConfig.instance:getPetCfg(info.activityId, info.configId)

	self.sizeX, self.sizeY = petCfg.size[1], petCfg.size[2]
	self.isEnemy = info.isEnemy
	self.normalSkillId = info.normalSkillId
	self.utlSkillId = info.utlSkillId
	self._maxEnergy = petCfg.maxEnergy
end

function AoQiHeroEnemyMo:getNormalSkill()
	return self.normalSkillId
end

function AoQiHeroEnemyMo:getUltSkill()
	return self.utlSkillId
end

function AoQiHeroEnemyMo:getMaxEnergy()
	return self._maxEnergy
end

function AoQiHeroEnemyMo:isCanUseSuper()
	return self._energy >= self._maxEnergy
end

return AoQiHeroEnemyMo
