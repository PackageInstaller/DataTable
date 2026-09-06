-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmmgame/view/AixinmmGamePetPlayer.lua

module("logic.extensions.aixinmmgame.view.AixinmmGamePetPlayer", package.seeall)

local AixinmmGamePetPlayer = class("AixinmmGamePetPlayer", AixinmmGameUnitBase)

function AixinmmGamePetPlayer:ctor(go)
	AixinmmGamePetPlayer.super.ctor(self, go)
end

function AixinmmGamePetPlayer:buildUI()
	AixinmmGamePetPlayer.super.buildUI(self)

	self._playerGo = self:getGo("player")
	self._effectHitGo = self:getGo("player/imgHit")

	self:setTweenXOffset(-50)
end

function AixinmmGamePetPlayer:bindEvents()
	AixinmmGamePetPlayer.super.bindEvents(self)
end

function AixinmmGamePetPlayer:unbindEvents()
	AixinmmGamePetPlayer.super.unbindEvents(self)
end

function AixinmmGamePetPlayer:onEnter()
	AixinmmGamePetPlayer.super.onEnter(self)

	self._hp = AixinmmGameConfig.instance:getDefineValue("WY_INIT_POWER", true)

	self:_stopHitEffect()
	self:_setHpText()
end

function AixinmmGamePetPlayer:onExit()
	AixinmmGamePetPlayer.super.onExit(self)
end

function AixinmmGamePetPlayer:update(timeDelta)
	return
end

function AixinmmGamePetPlayer:_getImgNumPath()
	return "player/imgNum"
end

function AixinmmGamePetPlayer:_getHitEffectGo()
	return self._effectHitGo
end

return AixinmmGamePetPlayer
