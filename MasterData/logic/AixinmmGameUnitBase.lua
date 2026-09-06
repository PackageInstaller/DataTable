-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmmgame/view/AixinmmGameUnitBase.lua

module("logic.extensions.aixinmmgame.view.AixinmmGameUnitBase", package.seeall)

local AixinmmGameUnitBase = class("AixinmmGameUnitBase", BaseLuaOnce)

function AixinmmGameUnitBase:ctor(go)
	AixinmmGameUnitBase.super.ctor(self, go)
end

function AixinmmGameUnitBase:buildUI()
	AixinmmGameUnitBase.super.buildUI(self)

	self._transform = self.mainGO.transform
	self._hp = 0
	self._tweenXOffset = 0
	self._tweenYOffset = 0
	self._radius = math.ceil(self._transform.sizeDelta.x / 2)
	self._imgNumCom = self:getGo(self:_getImgNumPath()):GetComponent(ComponentType.UIImgNumeralText)
end

function AixinmmGameUnitBase:bindEvents()
	AixinmmGameUnitBase.super.bindEvents(self)
end

function AixinmmGameUnitBase:unbindEvents()
	AixinmmGameUnitBase.super.unbindEvents(self)
end

function AixinmmGameUnitBase:onEnter()
	AixinmmGameUnitBase.super.onEnter(self)
end

function AixinmmGameUnitBase:onExit()
	AixinmmGameUnitBase.super.onExit(self)
	UnityTweens.TweenPosition.StopTween(self.mainGO)
	removetimer(self._updateHit, self)
end

function AixinmmGameUnitBase:getScreenPosX()
	return (Framework.TransformUtil.GetLocalPos(self._transform, 0, 0, 0))
end

function AixinmmGameUnitBase:getRadius()
	return self._radius
end

function AixinmmGameUnitBase:update(delta)
	return
end

function AixinmmGameUnitBase:getHP()
	return self._hp
end

function AixinmmGameUnitBase:addHP(hp)
	self._hp = self._hp + hp

	self:_setHpText()
end

function AixinmmGameUnitBase:reduceHP(hp)
	self._hp = self._hp - hp

	if self._hp <= 0 then
		self._hp = 0
	end

	self:playHitEffect()
	self:_setHpText()
end

function AixinmmGameUnitBase:setAnchoredPos(x, y)
	Framework.TransformUtil.SetAnchoredPos(self._transform, x, y)
end

function AixinmmGameUnitBase:createTween(duration, targetX, targetY)
	local from = self._transform.localPosition
	local toPosx = targetX or from.x + self:_getTweenXOffset()
	local toPosy = targetY or from.y + self:_getTweenYOffset()
	local to = Vector3.New(toPosx, toPosy, 0)
	local tween = self.mainGO:GetComponent(UnityTweensType.TweenPosition)

	if not tween then
		tween = UnityTweens.TweenPosition.Create(self.mainGO, from, to, duration)
	else
		tween.from = from
		tween.to = to
		tween.time = duration
	end

	return tween
end

function AixinmmGameUnitBase:_getTweenXOffset()
	return self._tweenXOffset
end

function AixinmmGameUnitBase:_getTweenYOffset()
	return self._tweenYOffset
end

function AixinmmGameUnitBase:setTweenXOffset(offset)
	self._tweenXOffset = offset
end

function AixinmmGameUnitBase:setTweenYOffset(offset)
	self._tweenYOffset = offset
end

function AixinmmGameUnitBase:_setHpText()
	goutil.setActive(self._imgNumCom.gameObject, self._hp > 0)
	self._imgNumCom:SetNum(self._hp)
end

function AixinmmGameUnitBase:_getImgNumPath()
	return ""
end

function AixinmmGameUnitBase:playHitEffect()
	if self:_getHitEffectGo() then
		self._updateHitTime = 0
		self._updateHitCount = 0

		settimer(0.01, self._updateHit, self, true)
		self:_updateHit()
	end
end

function AixinmmGameUnitBase:_updateHit()
	self._updateHitTime = self._updateHitTime + Time.deltaTime
	self._updateHitCount = self._updateHitCount + 1

	if self._updateHitTime >= 0.05 then
		self:_stopHitEffect()

		return
	end

	local go = self:_getHitEffectGo()

	goutil.setActive(go, self._updateHitCount % 2 == 1)
end

function AixinmmGameUnitBase:_stopHitEffect()
	local go = self:_getHitEffectGo()

	goutil.setActive(go, false)
	removetimer(self._updateHit, self)
end

function AixinmmGameUnitBase:_getHitEffectGo()
	return false
end

function AixinmmGameUnitBase:creatShakeTween(duration)
	local to = Vector3.New(10, 0, 0)
	local tween = self.mainGO:GetComponent(UnityTweensType.TweenShakePosition)

	if not tween then
		tween = UnityTweens.TweenShakePosition.Create(self.mainGO, to, duration)
	else
		tween.shakeRange = to
		tween.time = duration
	end

	tween:Begin()
end

return AixinmmGameUnitBase
