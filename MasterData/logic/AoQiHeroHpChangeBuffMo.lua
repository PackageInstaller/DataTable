-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/buffMo/AoQiHeroHpChangeBuffMo.lua

module("logic.extensions.aoqihero.model.buffMo.AoQiHeroHpChangeBuffMo", package.seeall)

local AoQiHeroHpChangeBuffMo = class("AoQiHeroHpChangeBuffMo", AoQiHeroBuffMo)

function AoQiHeroHpChangeBuffMo:ctor()
	AoQiHeroHpChangeBuffMo.super.ctor(self)

	self.buffType = AoQiHeroConst.BuffHpChange
	self.damage = 0
	self.isChangeHp = true
end

function AoQiHeroHpChangeBuffMo:initDataByCfg(cfg)
	AoQiHeroHpChangeBuffMo.super.initDataByCfg(self, cfg)

	self.damageRate = checknumber(cfg.buffParams)
end

function AoQiHeroHpChangeBuffMo:onActive(targetA, targetB, reportMos)
	if (self.buffCfg.isActiveSelf == true or nil) and self.targetId == targetA then
		local targetMo = AoQiHeroEntityMgr.instance:getPet(self.targetId)
		local beforeCurHp = targetMo.curHp
		local beforeMaxHp = targetMo:getMaxHp()

		targetMo:reduceHp(-self.damage)

		local reportMo = reportMos[self.targetId]

		if not reportMo then
			reportMo = AoQiHeroRoundMgr.instance:getNewReportMo()
			reportMo.petId = self.targetId
			reportMos[reportMo.petId] = reportMo
		end

		reportMo.isShow = true
		reportMo.isCritical = false
		reportMo.attackHps = self.damage + reportMo.attackHps
		reportMo.attackHps = reportMo.attackHps
		reportMo.totalHpChange = reportMo.totalHpChange + self.damage
		reportMo.afterRoundHp = targetMo.curHp

		local buffInfo = {
			buffId = self.configId,
			changeHp = targetMo.curHp - beforeCurHp,
			afterChangeHp = targetMo.curHp,
			changeMaxHp = targetMo:getMaxHp() - beforeMaxHp,
			afterChangeMaxHp = targetMo:getMaxHp()
		}

		table.insert(reportMo.effectHpBuffIds, buffInfo)

		self.tier = self.tier - 1
	end
end

return AoQiHeroHpChangeBuffMo
