-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/battleMo/AoQiHeroTowerMo.lua

module("logic.extensions.aoqihero.model.battleMo.AoQiHeroTowerMo", package.seeall)

local AoQiHeroTowerMo = class("AoQiHeroTowerMo", AoQiHeroEntityMo)

function AoQiHeroTowerMo:initData(info)
	AoQiHeroTowerMo.super.initData(self, info)

	self.level = info.level or 0
	self.hp = info.hp or 0
	self.curHp = self.hp
	self.attack = info.attack or 0
	self.speed = info.speed or 0
	self.criticalRate = info.criticalRate or 0
	self.criticaDamage = info.criticaDamage or 1.5
	self._energy = 0
end

return AoQiHeroTowerMo
