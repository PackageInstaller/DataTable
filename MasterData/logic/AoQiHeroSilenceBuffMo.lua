-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/buffMo/AoQiHeroSilenceBuffMo.lua

module("logic.extensions.aoqihero.model.buffMo.AoQiHeroSilenceBuffMo", package.seeall)

local AoQiHeroSilenceBuffMo = class("AoQiHeroSilenceBuffMo", AoQiHeroBuffMo)

function AoQiHeroSilenceBuffMo:ctor()
	AoQiHeroSilenceBuffMo.super.ctor(self)

	self.buffType = AoQiHeroConst.BuffSilence
end

function AoQiHeroSilenceBuffMo:initDataByCfg(cfg)
	AoQiHeroSilenceBuffMo.super.initDataByCfg(self, cfg)
end

return AoQiHeroSilenceBuffMo
