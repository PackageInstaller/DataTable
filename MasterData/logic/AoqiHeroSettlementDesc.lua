-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/settlement/AoqiHeroSettlementDesc.lua

module("logic.extensions.battlesettlement.view.AoqiHeroSettlementDesc", package.seeall)

local AoqiHeroSettlementDesc = class("AoqiHeroSettlementDesc", BSAnimPlay)

function AoqiHeroSettlementDesc:buildUI(parent)
	AoqiHeroSettlementDesc.super.buildUI(self, parent)

	self._imgBgTarget = goutil.findChild(parent, "imgBgTarget"):GetComponent(goutil.Type_RectTransform)
	self._txtTitle = goutil.findChildTextComponent(parent, "imgBgTarget/Text")
	self._element = goutil.findChild(parent, "imgBgTarget/element")
	self._txtDesc = goutil.findChildTextComponent(parent, "imgBgTarget/element/txtDesc")

	goutil.setActive(self._parent, false)

	self._titleHeight = 50
end

function AoqiHeroSettlementDesc:onEnter(totalHeight, curPosY, delayTime, title, content)
	AoqiHeroSettlementDesc.super.onEnter(self, totalHeight, curPosY, delayTime)

	if self._isEntered then
		return self:_getDefault()
	end

	self._isEntered = true

	goutil.setActive(self._parent, true)

	self._txtDesc.text = content
	self._txtTitle.text = title

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._txtDesc.gameObject.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._element.transform)

	return self:getNextData(true)
end

function AoqiHeroSettlementDesc:onExit()
	self._isEntered = false

	goutil.setActive(self._parent, false)
end

function AoqiHeroSettlementDesc:_setHeight()
	self.height = self._element.transform.rect.height + self._titleHeight

	local sizeDelta = self._parentRectTrans.sizeDelta

	self._parentRectTrans.sizeDelta = Vector2.New(sizeDelta.x, self.height)

	Framework.TransformUtil.SetAnchoredPos(self._parentRectTrans, 0, self:_getCurPosY())
end

function AoqiHeroSettlementDesc:getMaxHeight()
	return self._parentRectTrans.rect.height
end

function AoqiHeroSettlementDesc:_setAnimCostTime()
	self.animCostTime = self._delayTime1 * 2
end

function AoqiHeroSettlementDesc:doTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 1500, 0)

	local curTime = self._time1
	local curDelay = self._delayTime1 + self:_getCurTimePoint()

	self._imgBgTarget:DOAnchorPosX(0, curTime):SetDelay(curDelay)
end

function AoqiHeroSettlementDesc:doKillTween()
	AoqiHeroSettlementDesc.super.doKillTween(self)
	self._imgBgTarget:DOKill(true)
end

function AoqiHeroSettlementDesc:doCompleteTween()
	self:doKillTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 0, 0)
end

return AoqiHeroSettlementDesc
