-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmmgame/view/AixinmmGamePlayer.lua

module("logic.extensions.aixinmmgame.view.AixinmmGamePlayer", package.seeall)

local AixinmmGamePlayer = class("AixinmmGamePlayer", AixinmmGameUnitBase)

function AixinmmGamePlayer:ctor(go)
	AixinmmGamePlayer.super.ctor(self, go)
end

function AixinmmGamePlayer:buildUI()
	AixinmmGamePlayer.super.buildUI(self)

	self._playerGo = self:getGo("player")
	self._txtScore = self:getText("player/txtScore")
	self._effectGo = self:getGo("effect")
	self._effectHitGo = self:getGo("player/imgHit")

	self:setTweenXOffset(-50)
end

function AixinmmGamePlayer:bindEvents()
	AixinmmGamePlayer.super.bindEvents(self)
end

function AixinmmGamePlayer:unbindEvents()
	AixinmmGamePlayer.super.unbindEvents(self)
end

function AixinmmGamePlayer:onEnter(viewRef)
	AixinmmGamePlayer.super.onEnter(self)

	self._hp = AixinmmGameConfig.instance:getDefineValue("FBB_INIT_POWER", true)

	self:_setEffect(viewRef)
	self:exitBattle()
	self:_stopHitEffect()
	self:_setHpText()
end

function AixinmmGamePlayer:onExit()
	AixinmmGamePlayer.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._effectHandler)
end

function AixinmmGamePlayer:_getImgNumPath()
	return "player/imgNum"
end

function AixinmmGamePlayer:_setEffect(viewRef)
	local effName = "20220701/xiaotian_youxi/fx_xiaotian_feng.prefab"

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)
	end

	self._effectHandler = UIEffectManager.instance:playEffect(viewRef, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(23)
end

function AixinmmGamePlayer:enterBattle()
	goutil.setActive(self._effectGo, false)
end

function AixinmmGamePlayer:exitBattle()
	goutil.setActive(self._effectGo, true)
end

function AixinmmGamePlayer:_getHitEffectGo()
	return self._effectHitGo
end

return AixinmmGamePlayer
