-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/buffMo/AoQiHeroDisarmedBuffMo.lua

module("logic.extensions.aoqihero.model.buffMo.AoQiHeroDisarmedBuffMo", package.seeall)

local AoQiHeroDisarmedBuffMo = class("AoQiHeroDisarmedBuffMo", AoQiHeroBuffMo)

function AoQiHeroDisarmedBuffMo:ctor()
	AoQiHeroDisarmedBuffMo.super.ctor(self)

	self.buffType = AoQiHeroConst.BuffDisarmed
end

function AoQiHeroDisarmedBuffMo:initDataByCfg(cfg)
	AoQiHeroDisarmedBuffMo.super.initDataByCfg(self, cfg)
end

return AoQiHeroDisarmedBuffMo
