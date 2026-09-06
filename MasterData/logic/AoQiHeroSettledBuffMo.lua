-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/buffMo/AoQiHeroSettledBuffMo.lua

module("logic.extensions.aoqihero.model.buffMo.AoQiHeroSettledBuffMo", package.seeall)

local AoQiHeroSettledBuffMo = class("AoQiHeroSettledBuffMo", AoQiHeroBuffMo)

function AoQiHeroSettledBuffMo:ctor()
	AoQiHeroSettledBuffMo.super.ctor(self)

	self.buffType = AoQiHeroConst.BuffSettled
end

function AoQiHeroSettledBuffMo:initDataByCfg(cfg)
	AoQiHeroSettledBuffMo.super.initDataByCfg(self, cfg)
end

return AoQiHeroSettledBuffMo
