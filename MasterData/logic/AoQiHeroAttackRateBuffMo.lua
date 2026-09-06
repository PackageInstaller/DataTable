-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/buffMo/AoQiHeroAttackRateBuffMo.lua

module("logic.extensions.aoqihero.model.buffMo.AoQiHeroAttackRateBuffMo", package.seeall)

local AoQiHeroAttackRateBuffMo = class("AoQiHeroAttackRateBuffMo", AoQiHeroBuffMo)

function AoQiHeroAttackRateBuffMo:ctor()
	AoQiHeroAttackRateBuffMo.super.ctor(self)

	self.buffType = AoQiHeroConst.BuffAttackRate
	self.changeValue = 0
end

function AoQiHeroAttackRateBuffMo:initDataByCfg(cfg)
	AoQiHeroAttackRateBuffMo.super.initDataByCfg(self, cfg)

	self.changeValue = checknumber(cfg.buffParams)
end

function AoQiHeroAttackRateBuffMo:onAttackPowerChange(powerChange)
	return powerChange + self.changeValue
end

return AoQiHeroAttackRateBuffMo
