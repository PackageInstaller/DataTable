-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/buffMo/AoQiHeroDefendRateBuffMo.lua

module("logic.extensions.aoqihero.model.buffMo.AoQiHeroDefendRateBuffMo", package.seeall)

local AoQiHeroDefendRateBuffMo = class("AoQiHeroDefendRateBuffMo", AoQiHeroBuffMo)

function AoQiHeroDefendRateBuffMo:ctor()
	AoQiHeroDefendRateBuffMo.super.ctor(self)

	self.buffType = AoQiHeroConst.BuffDefendRate
	self.changeValue = 0
end

function AoQiHeroDefendRateBuffMo:initDataByCfg(cfg)
	AoQiHeroDefendRateBuffMo.super.initDataByCfg(self, cfg)

	self.changeValue = checknumber(cfg.buffParams)
end

function AoQiHeroDefendRateBuffMo:onDefendPowerChange(powerChange)
	return (powerChange < 0 or nil) and 0
end

return AoQiHeroDefendRateBuffMo
