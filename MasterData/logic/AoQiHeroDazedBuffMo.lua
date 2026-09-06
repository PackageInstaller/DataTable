-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/buffMo/AoQiHeroDazedBuffMo.lua

module("logic.extensions.aoqihero.model.buffMo.AoQiHeroDazedBuffMo", package.seeall)

local AoQiHeroDazedBuffMo = class("AoQiHeroDazedBuffMo", AoQiHeroBuffMo)

function AoQiHeroDazedBuffMo:ctor()
	AoQiHeroDazedBuffMo.super.ctor(self)

	self.buffType = AoQiHeroConst.BuffDazed
end

function AoQiHeroDazedBuffMo:initDataByCfg(cfg)
	AoQiHeroDazedBuffMo.super.initDataByCfg(self, cfg)
end

return AoQiHeroDazedBuffMo
