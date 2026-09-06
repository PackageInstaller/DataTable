-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/buffMo/AoQiHeroEnergyChangeBuffMo.lua

module("logic.extensions.aoqihero.model.buffMo.AoQiHeroEnergyChangeBuffMo", package.seeall)

local AoQiHeroEnergyChangeBuffMo = class("AoQiHeroEnergyChangeBuffMo", AoQiHeroBuffMo)

function AoQiHeroEnergyChangeBuffMo:ctor()
	AoQiHeroEnergyChangeBuffMo.super.ctor(self)

	self.buffType = AoQiHeroConst.BuffEnergyChange
	self.energy = 0
end

function AoQiHeroEnergyChangeBuffMo:initDataByCfg(cfg)
	AoQiHeroDisarmedBuffMo.super.initDataByCfg(self, cfg)

	self.energy = checknumber(cfg.buffParams)
end

function AoQiHeroEnergyChangeBuffMo:onActive(targetA, targetB, reportMos)
	if (self.buffCfg.isActiveSelf == true or nil) and self.targetId == targetA then
		local targetMo = AoQiHeroEntityMgr.instance:getPet(self.targetId)

		targetMo:changeEnergy(self.energy)

		self.tier = self.tier - 1
	end
end

return AoQiHeroEnergyChangeBuffMo
