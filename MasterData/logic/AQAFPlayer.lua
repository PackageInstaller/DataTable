-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/obj/AQAFPlayer.lua

module("logic.extensions.aoqiattackforce.minigame.obj.AQAFPlayer", package.seeall)

local AQAFPlayer = class("AQAFPlayer", AQAFUnit)

function AQAFPlayer:ctor()
	AQAFPlayer.super.ctor(self)

	self.modelCfg = nil
	self._isActive = true
end

function AQAFPlayer:getTag()
	return AQAFGameEnum.UnitTag.MainPlayer
end

function AQAFPlayer:initData()
	self:resetData()

	local curActCfg = AoQiAttackForceModel.instance:getCurActCfg()

	self.modelCfg = AoQiAttackForceConfig.instance:getModelCfg(curActCfg.playerModel)

	self:setRadius(self.modelCfg.radius)

	self._maxHp = AoQiAttackForceModel.instance:getCurHpMax()
	self._curHp = AoQiAttackForceModel.instance:getCurHp()
	self._CurShield = 0
end

function AQAFPlayer:beHit(unit)
	AQAFPlayer.super.beHit(self, unit)

	self.isTriHit = true
end

function AQAFPlayer:beDamage(unit, damage, damageType)
	AQAFPlayer.super.beDamage(self, unit, damage)

	self.isTriHit = true

	GlobalDispatcher:dispatch(GlobalNotify.AQAFPlayerGameInfoUpdate)
end

function AQAFPlayer:heal(addHp)
	AQAFPlayer.super.heal(self, addHp)
	GlobalDispatcher:dispatch(GlobalNotify.AQAFPlayerGameInfoUpdate)
end

function AQAFPlayer:addShield(addShield)
	AQAFPlayer.super.addShield(self, addShield)
	GlobalDispatcher:dispatch(GlobalNotify.AQAFPlayerGameInfoUpdate)
end

function AQAFPlayer:update()
	AQAFPlayer.super.update(self)

	if self._curHp <= 0 then
		self:die()
	end
end

function AQAFPlayer:resetTir()
	AQAFPlayer.super.resetTir(self)

	self.isTriHit = false
	self.isTriAtk = false
end

function AQAFPlayer:attack()
	self.isTriAtk = true
end

return AQAFPlayer
