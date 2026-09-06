-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/battleMo/AoQiHeroSkillMo.lua

module("logic.extensions.aoqihero.model.battleMo.AoQiHeroSkillMo", package.seeall)

local AoQiHeroSkillMo = class("AoQiHeroSkillMo")

function AoQiHeroSkillMo:ctor()
	self.battleId = 0
	self.configId = 0
	self.isSuperSkill = false
	self.targetA = 0
	self.targetB = {}
	self.skillCurBatterCount = 1
	self.isDone = false
	self.isSuper = false
	self.targetPos = 0
end

function AoQiHeroSkillMo:initData()
	self.skillCfg = AoQiHeroConfig.instance:getSkillCfg(self.configId)
end

function AoQiHeroSkillMo:onStart(reportMos)
	local buffCfgs = AoQiHeroConfig.instance:getAffixBySkillId(self.configId)

	if buffCfgs and #buffCfgs > 0 then
		for i, buffId in ipairs(buffCfgs) do
			local buffCfg = AoQiHeroConfig.instance:getSkillAffixCfg(buffId)
			local targetList = AoQiHeroBuffMgr.instance:getAddBuffTarget(self.targetA, self.targetB, buffCfg.buffType)

			for j, v in ipairs(targetList) do
				local buffMo = AoQiHeroBuffMgr.instance:createBuffMo(buffCfg)

				if buffMo.isChangeHp == true then
					local petMo = AoQiHeroEntityMgr.instance:getPet(v)
					local beforeCurHp = petMo.curHp
					local beforeMaxHp = petMo:getMaxHp()

					AoQiHeroBuffMgr.instance:addBuff(v, buffMo, self.targetA)

					local changeHp = petMo.curHp - beforeCurHp

					if changeHp ~= 0 then
						local reportMo = reportMos[v]

						if not reportMo then
							reportMo = AoQiHeroRoundMgr.instance:getNewReportMo()
							reportMo.petId = v
							reportMos[reportMo.petId] = reportMo
						end

						reportMo.isShow = true

						local buffInfo = {
							buffId = buffId,
							changeHp = petMo.curHp - beforeCurHp,
							afterChangeHp = petMo.curHp,
							changeMaxHp = petMo:getMaxHp() - beforeMaxHp,
							afterChangeMaxHp = petMo:getMaxHp()
						}

						table.insert(reportMo.effectHpBuffIds, buffInfo)
					end
				else
					AoQiHeroBuffMgr.instance:addBuff(v, buffMo, self.targetA)
				end
			end
		end
	end
end

function AoQiHeroSkillMo:hpChange(reportMos)
	local petMoA = AoQiHeroEntityMgr.instance:getPet(self.targetA)
	local totalAttack = 0
	local totalCriticalRate = 0

	if petMoA then
		totalAttack = petMoA:getCurAttack()
		totalAttack = totalAttack * self:getDamageRate()
		totalCriticalRate = petMoA.criticalRate

		for i, v in ipairs(petMoA.buffList) do
			local buffMo = AoQiHeroBuffMgr.instance:getBuff(v)

			if buffMo.buffType == AoQiHeroConst.BuffPropertyChange and buffMo.proertyType == GameEnum.AttrType.CriticalRate then
				totalCriticalRate = buffMo.rateType == true and totalCriticalRate + petMoA.criticalRate * buffMo.changeValue or totalCriticalRate + buffMo.changeValue
			end
		end
	end

	for i, v in ipairs(self.targetB) do
		local totalDamage = totalAttack
		local reportMo = reportMos[v]

		if not reportMo then
			reportMo = AoQiHeroRoundMgr.instance:getNewReportMo()
			reportMo.petId = v
			reportMos[reportMo.petId] = reportMo
		end

		reportMo.isShow = true

		local petMoB = AoQiHeroEntityMgr.instance:getPet(v)
		local random = math.random(1, 10000)
		local isCritical = random <= totalCriticalRate * 10000

		if isCritical then
			totalDamage = totalDamage * petMoA.criticaDamage
		end

		if self.skillCfg.functionType == GameEnum.SkillFuncType.Hurt then
			local powerChange = 1

			if petMoA then
				for j, buffId in ipairs(petMoA.buffList) do
					local buffMo = AoQiHeroBuffMgr.instance:getBuff(buffId)

					totalDamage = buffMo:onDamage(totalDamage)
					powerChange = buffMo:onAttackPowerChange(powerChange)
				end
			end

			for j, buffId in ipairs(petMoB.buffList) do
				local buffMo = AoQiHeroBuffMgr.instance:getBuff(buffId)

				powerChange = buffMo:onDefendPowerChange(powerChange)
			end

			totalDamage = totalDamage * math.max(0, powerChange)
		end

		totalDamage = math.floor(totalDamage)

		petMoB:reduceHp(totalDamage)

		reportMo.isCritical = isCritical
		reportMo.attackHps = -totalDamage
		reportMo.isSkill = true
		reportMo.totalHpChange = reportMo.totalHpChange + reportMo.attackHps
	end
end

function AoQiHeroSkillMo:onEnd(reportMos)
	for i, v in pairs(reportMos) do
		local petMo = AoQiHeroEntityMgr.instance:getPet(v.petId)

		v.afterRoundHp = petMo.curHp
	end
end

function AoQiHeroSkillMo:getDamageRate()
	return self.skillCfg.damageRate
end

function AoQiHeroSkillMo:isDone()
	return self.isDone
end

return AoQiHeroSkillMo
