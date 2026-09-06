-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/BSAnimPlay.lua

module("logic.extensions.battlesettlement.view.BSAnimPlay", package.seeall)

local BSAnimPlay = class("BSAnimPlay")

function BSAnimPlay:ctor()
	self._posY = 0
	self.height = 0
	self._totalHeight = 0
	self._curTimePoint = 0
	self.animCostTime = 0
	self._extraCostTime = 0
	self._time1 = 0.4
	self._delayTime1 = 0.2
	self._parentRectTrans = nil
end

function BSAnimPlay:_resetHeight()
	self.height = 0
end

function BSAnimPlay:_setHeight()
	return
end

function BSAnimPlay:_getCurPosY()
	return self._posY
end

function BSAnimPlay:_setAnimCostTime()
	self.animCostTime = 0
end

function BSAnimPlay:_getCurTimePoint()
	return self._curTimePoint + self._extraCostTime
end

function BSAnimPlay:getMaxHeight()
	return
end

function BSAnimPlay:setCurPosY(y)
	self._posY = y
end

function BSAnimPlay:getNextPosY()
	return self._posY + self.height * -1
end

function BSAnimPlay:setCurTimePoint(curTimePoint)
	self._curTimePoint = curTimePoint
end

function BSAnimPlay:getNextTimePoint()
	return self._curTimePoint + self.animCostTime + self._extraCostTime
end

function BSAnimPlay:bindEvents()
	return
end

function BSAnimPlay:unbindEvents()
	return
end

function BSAnimPlay:_getDefault()
	return 0, 0
end

function BSAnimPlay:buildUI(parent)
	self._parent = parent
	self._parentRectTrans = parent:GetComponent(goutil.Type_RectTransform)
end

function BSAnimPlay:destroyUI()
	return
end

function BSAnimPlay:onEnter(totalHeight, curPosY, delayTime)
	self._totalHeight = totalHeight
	self._extraCostTime = 0

	self:setCurPosY(curPosY)
	self:setCurTimePoint(delayTime)
end

function BSAnimPlay:getNextData(isShow)
	isShow = isShow == nil and true or isShow

	self:_resetHeight()
	self:_setHeight()

	if isShow then
		self:_setHeight()
		self:_setAnimCostTime()
		self:doTween()
	end

	return self:getNextPosY(), self:getNextTimePoint()
end

function BSAnimPlay:onExit()
	return
end

function BSAnimPlay:doTween()
	return
end

function BSAnimPlay:doKillTween()
	return
end

function BSAnimPlay:doCompleteTween()
	return
end

function BSAnimPlay:moveDown(delayTime, animTime)
	delayTime = delayTime or 0
	animTime = animTime or 1.5

	self._parentRectTrans:DOAnchorPosY(-1200, animTime):SetDelay(delayTime)
end

function BSAnimPlay:completeMoveDown()
	self._parentRectTrans:DOKill(true)
	Framework.TransformUtil.SetAnchoredPos(self._parentRectTrans, 0, -1200)
end

return BSAnimPlay
