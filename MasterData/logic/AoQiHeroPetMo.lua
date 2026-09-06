-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/battleMo/AoQiHeroPetMo.lua

module("logic.extensions.aoqihero.model.battleMo.AoQiHeroPetMo", package.seeall)

local AoQiHeroPetMo = class("AoQiHeroPetMo", AoQiHeroEntityMo)

function AoQiHeroPetMo:ctor()
	AoQiHeroPetMo.super.ctor(self)

	self.towerMo = nil
	self.pos = 0
	self.normalSkillId = nil
	self.ultSkillId = nil
end

function AoQiHeroPetMo:initData(info)
	AoQiHeroPetMo.super.initData(self, info)

	local petCfg = AoQiHeroConfig.instance:getPetCfg(info.activityId, info.configId)
	local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, info.level)

	self.hp = propertyCfg.hp or 0
	self.curHp = self.hp
	self.attack = propertyCfg.Atk or 0
	self.speed = 0
	self.criticalRate = propertyCfg.criticalRate or 0
	self.criticaDamage = propertyCfg.criticalDamageRate or 0
	self.normalSkillId = propertyCfg.normalSkillId
	self.utlSkillId = propertyCfg.ultSkillId
	self.towerMo = info.towerMo
	self.pos = info.pos
end

function AoQiHeroPetMo:getMaxHp()
	if self.towerMo then
		return self.towerMo:getMaxHp()
	else
		return AoQiHeroPetMo.super.getMaxHp(self)
	end
end

function AoQiHeroPetMo:reduceHp(damage)
	if self.towerMo then
		self.towerMo:reduceHp(damage)
		AoQiHeroEntityMgr.instance:_refreshAttackTeamHp()
	else
		AoQiHeroPetMo.super.reduceHp(self, damage)
	end
end

function AoQiHeroPetMo:changeEnergy(num)
	AoQiHeroSkillMgr.instance:changeMyTeamEnergy(num)
end

function AoQiHeroPetMo:clearEnergy()
	AoQiHeroSkillMgr.instance:changeMyTeamEnergy(-AoQiHeroSkillMgr.instance:getMaxEnergy())
end

function AoQiHeroPetMo:getNormalSkill()
	return self.normalSkillId
end

function AoQiHeroPetMo:getUltSkill()
	return self.utlSkillId
end

return AoQiHeroPetMo
