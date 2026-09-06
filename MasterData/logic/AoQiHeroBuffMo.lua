-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/battleMo/AoQiHeroBuffMo.lua

module("logic.extensions.aoqihero.model.battleMo.AoQiHeroBuffMo", package.seeall)

local AoQiHeroBuffMo = class("AoQiHeroBuffMo")

function AoQiHeroBuffMo:ctor()
	self.battleId = 0
	self.buffId = 0
	self.configId = 0
	self.targetId = 0
	self.tier = 0
	self.time = 0
	self.buffCfg = nil
	self.agent = 0
	self.isChangeHp = false
end

function AoQiHeroBuffMo:initDataByCfg(cfg)
	self.tier = cfg.tier
	self.time = cfg.effectTimes
	self.configId = cfg.id
	self.buffCfg = cfg
end

function AoQiHeroBuffMo:initDataOnAdd(targetId, agent, buffId)
	self.targetId = targetId
	self.agent = agent
	self.buffId = buffId
end

function AoQiHeroBuffMo:onAddBuffBefore()
	return
end

function AoQiHeroBuffMo:onAddBuff()
	return
end

function AoQiHeroBuffMo:onRemoveBefore()
	return
end

function AoQiHeroBuffMo:onRemoveBuffOnPet()
	AoQiHeroBuffMgr.instance:removeBuffOnPet(self.buffId, self.targetId)
end

function AoQiHeroBuffMo:onRemoveBuff()
	return
end

function AoQiHeroBuffMo:onDamage(totalDamage)
	return totalDamage
end

function AoQiHeroBuffMo:onAttackPowerChange(powerChange)
	return powerChange
end

function AoQiHeroBuffMo:onDefendPowerChange(powerChange)
	return powerChange
end

function AoQiHeroBuffMo:onActive(targetId)
	if self.buffCfg.isActiveSelf and self.targetId == targetId then
		self.tier = self.tier - 1
	elseif not self.buffCfg.isActiveSelf then
		self.tier = self.tier - 1
	end
end

function AoQiHeroBuffMo:onAddBuffTrigger(buffAddList)
	return buffAddList
end

return AoQiHeroBuffMo
