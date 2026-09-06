-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/item/AQAFFloatItem.lua

module("logic.extensions.aoqiattackforce.view.item.AQAFFloatItem", package.seeall)

local AQAFFloatItem = class("AQAFFloatItem")

function AQAFFloatItem:ctor(container)
	self._go = container.gameObject
	self._contentText = nil
	self._bg = nil
	self._rt = nil
	self._originPos = Vector3.zero
	self._lastTween = nil
	self.gameObject = self._go
	self._lifeTime = 0
end

function AQAFFloatItem:Awake()
	self._rt = self._go.transform
	self._originPos = self._rt.localPosition
	self._cg = self._go:GetComponent("CanvasGroup")
end

function AQAFFloatItem:getContentText()
	self._contentText = self._contentText or goutil.findChild(self._go, "FloatText"):GetComponent(typeof(UIImgNumeralText))

	return self._contentText
end

function AQAFFloatItem:getBg()
	self._bg = self._bg or self._go:GetComponent(typeof(UnityEngine.UI.Image))

	return self._bg
end

function AQAFFloatItem:setContent(content)
	local contentText = self:getContentText()
	local num = checknumber(content)

	contentText:SetNum(num)
	GameUtil.SetActive(self._contentText.gameObject, num ~= 0)
end

function AQAFFloatItem:reset()
	if self._lastTween then
		self._lastTween:Kill()

		self._lastTween = nil
	end

	self._rt.localPosition = self._originPos

	if self._contentText then
		GameUtil.SetActive(self._contentText.gameObject, false)
	end

	if self._tweenAlpha then
		self._tweenAlpha:Kill(false)

		self._tweenAlpha = nil
	end

	if self._tweenScale then
		self._tweenScale:Kill(false)

		self._tweenScale = nil
	end

	self._lifeTime = 0
end

function AQAFFloatItem:_resetAlpha()
	local _dieAlphaTime = FloatWordMgr.instance:getDieAlphaTime()

	self._tweenAlpha = TweenUtil.ValueTo(1, 0, _dieAlphaTime, function(val)
		self._cg.alpha = val
	end, function()
		self._tweenAlpha = nil
	end, self, DG.Tweening.Ease.OutCubic)
end

function AQAFFloatItem:_bornScale()
	if not self._go then
		return
	end

	self._tweenScale = TweenUtil.ValueTo(1.3, 1, 0.3, function(val)
		GameUtil.setLocalScale(self._go, val, val, val)
	end, function()
		self._tweenScale = nil
	end, self, DG.Tweening.Ease.OutCubic)
end

function AQAFFloatItem:born()
	self._lifeTime = 1

	if Framework.OSDef.isEditor then
		local _dieAlphaTime = FloatWordMgr.instance:getDieAlphaTime()

		if _dieAlphaTime > self._lifeTime then
			error("self._lifeTime < _dieAlphaTime")
		end
	end

	self._cg.alpha = 1

	self:_bornScale()
end

function AQAFFloatItem:dying()
	if self._lifeTime <= 0 then
		return
	end

	local _dieAlphaTime = FloatWordMgr.instance:getDieAlphaTime()

	self._lifeTime = self._lifeTime - _dieAlphaTime

	if self._lifeTime == _dieAlphaTime then
		self:_resetAlpha()
	end
end

function AQAFFloatItem:isLiving()
	return self._lifeTime > 0
end

function AQAFFloatItem:flyTo(flyTargetHeight, flySpeed, stayTime, completeCallback, completeCallbackSelf)
	if self._lastTween then
		self._lastTween:Kill(false)

		self._lastTween = nil
	end

	local y = self._rt.anchoredPosition.y
	local flySequence = DG.Tweening.DOTween.Sequence()

	self._lastTween = flySequence

	local moveTween = self._rt:DOLocalMoveY(flyTargetHeight, (flyTargetHeight - y) / flySpeed, false)

	moveTween:SetEase(DG.Tweening.Ease.Linear)

	local fadeTween = self._cg:DOFade(0, 0.1)

	flySequence:Append(moveTween)

	if stayTime > 0 then
		flySequence:AppendInterval(stayTime)
	end

	flySequence:Append(fadeTween)

	if completeCallback then
		flySequence:AppendCallback(function()
			self._lastTween = nil

			if completeCallbackSelf then
				completeCallback(completeCallbackSelf, self)
			else
				completeCallback(self)
			end
		end)
	end
end

return AQAFFloatItem
