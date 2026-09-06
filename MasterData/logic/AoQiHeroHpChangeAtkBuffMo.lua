-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/buffMo/AoQiHeroHpChangeAtkBuffMo.lua

module("logic.extensions.aoqihero.model.buffMo.AoQiHeroHpChangeAtkBuffMo", package.seeall)

local AoQiHeroHpChangeAtkBuffMo = class("AoQiHeroHpChangeAtkBuffMo", AoQiHeroBuffMo)

function AoQiHeroHpChangeAtkBuffMo:ctor()
	AoQiHeroHpChangeAtkBuffMo.super.ctor(self)

	self.buffType = AoQiHeroConst.BuffHpChangeAtk
	self.damageRate = 0
	self.isChangeHp = true
end

function AoQiHeroHpChangeAtkBuffMo:initDataByCfg(cfg)
	AoQiHeroHpChangeAtkBuffMo.super.initDataByCfg(self, cfg)

	self.damageRate = checknumber(cfg.buffParams)
end

function AoQiHeroHpChangeAtkBuffMo:onActive(targetA, targetB, reportMos)
	if (self.buffCfg.isActiveSelf == true or nil) and self.targetId == targetA then
		if self.agent then
			local targetMo = AoQiHeroEntityMgr.instance:getPet(self.targetId)
			local agentMo = AoQiHeroEntityMgr.instance:getPet(self.agent)
			local damage = math.floor(agentMo:getCurAttack() * self.damageRate)

			if damage == 0 then
				self.tier = self.tier - 1

				return
			end

			local beforeCurHp = targetMo.curHp
			local beforeMaxHp = targetMo:getMaxHp()

			targetMo:reduceHp(-damage)

			local reportMo = reportMos[self.targetId]

			if not reportMo then
				reportMo = AoQiHeroRoundMgr.instance:getNewReportMo()
				reportMo.petId = self.targetId
				reportMos[reportMo.petId] = reportMo
			end

			reportMo.isShow = true
			reportMo.isCritical = false
			reportMo.attackHps = reportMo.attackHps
			reportMo.totalHpChange = reportMo.totalHpChange + damage
			reportMo.afterRoundHp = targetMo.curHp

			local buffInfo = {
				buffId = self.configId,
				changeHp = targetMo.curHp - beforeCurHp,
				afterChangeHp = targetMo.curHp,
				changeMaxHp = targetMo:getMaxHp() - beforeMaxHp,
				afterChangeMaxHp = targetMo:getMaxHp()
			}

			table.insert(reportMo.effectHpBuffIds, buffInfo)
		end

		self.tier = self.tier - 1
	end
end

return AoQiHeroHpChangeAtkBuffMo
