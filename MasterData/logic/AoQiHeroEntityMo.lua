-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/battleMo/AoQiHeroEntityMo.lua

module("logic.extensions.aoqihero.model.battleMo.AoQiHeroEntityMo", package.seeall)

local AoQiHeroEntityMo = class("AoQiHeroEntityMo")

function AoQiHeroEntityMo:ctor()
	self.battleId = 0
	self.id = 0
	self.activityId = 0
	self.configId = 0
	self.level = 0
	self.buffList = {}
	self.teamId = 0
	self.speed = 0
	self.hp = 0
	self.attack = 0
	self.criticalRate = 0
	self.curHp = 0
	self._energy = 0
	self.isActive = false
end

function AoQiHeroEntityMo:initData(info)
	self.id = info.id
	self.activityId = info.activityId
	self.configId = info.configId
	self.teamId = info.teamId
	self.level = info.level or 0
	self.hp = info.hp or 0
	self.curHp = self.hp
	self.attack = info.attack or 0
	self.speed = info.speed or 0
	self.criticalRate = info.criticalRate or 0
	self.criticaDamage = info.criticaDamage or 1.5
	self._energy = 0
end

function AoQiHeroEntityMo:checkMaxHp()
	local fixAddHp = 0
	local addRate = 0

	for i, v in ipairs(self.buffList) do
		local buffMo = AoQiHeroBuffMgr.instance:getBuff(v)

		if buffMo.buffType == AoQiHeroConst.BuffPropertyChange then
			if buffMo.proertyType == GameEnum.AttrType.HpRate then
				addRate = addRate + buffMo.changeValue
			elseif buffMo.proertyType == GameEnum.AttrType.Hp then
				fixAddHp = fixAddHp + buffMo.changeValue
			end
		end
	end

	local totalMaxHp = self.hp * (1 + addRate) + fixAddHp

	self.hp = math.floor(totalMaxHp)
end

function AoQiHeroEntityMo:getMaxHp()
	return self.hp
end

function AoQiHeroEntityMo:reduceHp(damage)
	self.curHp = math.max(self.curHp - damage, 0)
	self.curHp = math.min(self.curHp, self:getMaxHp())
end

function AoQiHeroEntityMo:removeBuff(buffId)
	for i, v in ipairs(self.buffList) do
		if v == buffId then
			table.remove(self.buffList, i)

			break
		end
	end
end

function AoQiHeroEntityMo:addBuff(buffId)
	table.insert(self.buffList, buffId)
end

function AoQiHeroEntityMo:getEnergy()
	return self._energy
end

function AoQiHeroEntityMo:changeEnergy(num)
	self._energy = self._energy + num
end

function AoQiHeroEntityMo:getCurAttack()
	local baseAttack = self.attack
	local totalAttack = baseAttack

	for i, v in ipairs(self.buffList) do
		local buffMo = AoQiHeroBuffMgr.instance:getBuff(v)

		if buffMo.buffType == AoQiHeroConst.BuffPropertyChange then
			if buffMo.proertyType == GameEnum.AttrType.AttackRate then
				totalAttack = totalAttack + baseAttack * buffMo.changeValue
			elseif buffMo.proertyType == GameEnum.AttrType.Attack then
				totalAttack = totalAttack + buffMo.changeValue
			end
		end
	end

	return totalAttack
end

function AoQiHeroEntityMo:getNormalSkill()
	local petCfg = AoQiHeroConfig.instance:getPetCfg(self.activityId, self.configId)

	return petCfg.normalSkillId
end

function AoQiHeroEntityMo:getUltSkill()
	local petCfg = AoQiHeroConfig.instance:getPetCfg(self.activityId, self.configId)

	return petCfg.ultSkillId
end

function AoQiHeroEntityMo:clearEnergy()
	self._energy = 0
end

return AoQiHeroEntityMo
