-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/settlement/AoqiHeroSettlementTarget.lua

module("logic.extensions.aoqihero.view.settlement.AoqiHeroSettlementTarget", package.seeall)

local AoqiHeroSettlementTarget = class("AoqiHeroSettlementTarget", BSAnimPlay)

AoqiHeroSettlementTarget.Colors = {
	Common = "FFFFFF",
	Sucess = "99FFB0",
	Fail = "EC6941"
}

function AoqiHeroSettlementTarget:buildUI(parent)
	AoqiHeroSettlementTarget.super.buildUI(self, parent)

	self._imgBgTarget = goutil.findChild(parent, "imgBgTarget"):GetComponent(goutil.Type_RectTransform)
	self._element = goutil.findChild(parent, "element")

	self._element:SetActive(false)

	self._scrollRectAdapter = Framework.ScrollRectAdapter.GetFrom(parent, "scrollList")
	self._scrollRect = goutil.findChild(parent, "scrollList"):GetComponent(goutil.Type_RectTransform)
	self._contentRect = goutil.findChild(parent, "scrollList/Viewport/Content"):GetComponent(goutil.Type_RectTransform)
	self._titleHeight = 50
	self._preHeight = 5
	self._postHeight = 10
	self._unitHeight = 30
end

function AoqiHeroSettlementTarget:destroyUI()
	self._parent = nil
	self._parentRectTrans = nil
end

function AoqiHeroSettlementTarget:bindEvents()
	return
end

function AoqiHeroSettlementTarget:unbindEvents()
	return
end

function AoqiHeroSettlementTarget:onEnter(totalHeight, curPosY, delayTime, isSuccess)
	AoqiHeroSettlementTarget.super.onEnter(self, totalHeight, curPosY, delayTime)

	if self._isEntered then
		return self:_getDefault()
	end

	self._isEntered = true
	self._isSuccess = isSuccess

	goutil.setActive(self._parent, true)

	self._curViewDatas = {}
	self._targetConditionItems = {}

	self:_setConditions()
	self:_loadList()

	return self:getNextData()
end

function AoqiHeroSettlementTarget:_setConditions()
	self._curTime = self._time1
	self._curDelay = self._delayTime1 + self:_getCurTimePoint()

	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 1500, 0)
	self._imgBgTarget:DOAnchorPosX(0, self._curTime):SetDelay(self._curDelay)
	self:_setDefaultConditions()
end

function AoqiHeroSettlementTarget:_loadList()
	print("real _loadList")
	self:_setContentHeight()
	self:_resetContentPos()
	print("len = " .. #self._curViewDatas)

	for i, v in ipairs(self._curViewDatas) do
		local go = goutil.cloneAndSetParent(self._element, self._contentRect.transform, "item" .. tostring(i))

		go:SetActive(true)

		local conditionItem = GameUtil.AddLuaOnce(go, TargetConditionItem)

		conditionItem:init(go, v)
		table.insert(self._targetConditionItems, conditionItem)
	end
end

function AoqiHeroSettlementTarget:_clearList()
	if self._targetConditionItems then
		for i, v in ipairs(self._targetConditionItems) do
			v:reset()
		end

		self._targetConditionItems = nil
	end

	self._curViewDatas = nil

	goutil.clearChildren(self._contentRect.gameObject)
end

function AoqiHeroSettlementTarget:_setDefaultConditions()
	local index = 1

	index = self:_setCommonCondition(index)
end

function AoqiHeroSettlementTarget:_setCommonCondition(index)
	local element1 = {}
	local enemyTeamMo = AoQiHeroEntityMgr.instance:getTeamMo(AoQiHeroConst.DefenceTeam)
	local enemys = 0
	local totalNum = 0

	for i, v in pairs(enemyTeamMo.pos) do
		local enemyMo = AoQiHeroEntityMgr.instance:getPet(v)

		if enemyMo.isEnemy == true then
			totalNum = totalNum + 1

			if not AoQiHeroEntityMgr.instance:isPetSurvival(v) then
				enemys = enemys + 1
			end
		end
	end

	local curNum = 0

	if self._isSuccess then
		curNum = enemys
		element1.txtDesc = string.format("击败敌阵全部精灵  <color=#%s>(%d/%d)</color>", AoqiHeroSettlementTarget.Colors.Sucess, enemys, totalNum)
		element1.isReach = true
	else
		element1.txtDesc = string.format("击败敌阵全部精灵  <color=#%s>(%d/%d)</color>", AoqiHeroSettlementTarget.Colors.Fail, enemys, totalNum)
		element1.isReach = false
	end

	element1.posY = self:_getPosY(index)
	element1.curTime = self._curTime

	self:_updateCurDelay()

	element1.curDelay = self._curDelay

	table.insert(self._curViewDatas, element1)

	index = index + 1

	return index
end

function AoqiHeroSettlementTarget:onExit()
	self._isEntered = false

	self:doKillTween()
	self:_clearList()
	goutil.setActive(self._parent, false)
end

function AoqiHeroSettlementTarget:doKillTween()
	AoqiHeroSettlementTarget.super.doKillTween(self)
	self._imgBgTarget:DOKill(true)

	if self._targetConditionItems then
		for i, v in ipairs(self._targetConditionItems) do
			v:doKillTween()
		end
	end
end

function AoqiHeroSettlementTarget:_getItemCount()
	if self._curViewDatas then
		return #self._curViewDatas
	end

	return 0
end

function AoqiHeroSettlementTarget:_setHeight()
	local count = self:_getItemCount()
	local height = self._titleHeight + self._preHeight + self._postHeight + count * self._unitHeight

	self.height = height

	Framework.TransformUtil.SetAnchoredPos(self._parentRectTrans, 0, self:_getCurPosY())

	local sizeDelta = self._parentRectTrans.sizeDelta

	self._parentRectTrans.sizeDelta = Vector2.New(sizeDelta.x, height)
end

function AoqiHeroSettlementTarget:getMaxHeight()
	local maxCount = 4

	return self._titleHeight + self._preHeight + self._postHeight + maxCount * self._unitHeight
end

function AoqiHeroSettlementTarget:_setAnimCostTime()
	self.animCostTime = self._delayTime1 * 2
end

function AoqiHeroSettlementTarget:doTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 1500, 0)

	local curTime = self._time1
	local curDelay = self._delayTime1 + self:_getCurTimePoint()

	self._imgBgTarget:DOAnchorPosX(0, curTime):SetDelay(curDelay)

	if self._targetConditionItems then
		for i, v in ipairs(self._targetConditionItems) do
			v:doTween()
		end
	end
end

function AoqiHeroSettlementTarget:doCompleteTween()
	self:doKillTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 0, 0)
end

function AoqiHeroSettlementTarget:_getPosY(index)
	local count = index >= 1 and index or 1

	return -1 * (self._preHeight + (count - 1) * self._unitHeight)
end

function AoqiHeroSettlementTarget:_getColorStr(bValue)
	return (bValue or nil) and (AoqiHeroSettlementTarget.Colors.Sucess or AoqiHeroSettlementTarget.Colors.Fail)
end

function AoqiHeroSettlementTarget:_updateCurDelay()
	self._curDelay = self._curDelay + self._delayTime1
end

function AoqiHeroSettlementTarget:_setContentHeight()
	local count = self:_getItemCount()
	local sizeDelta = self._contentRect.sizeDelta
	local height = self._preHeight + self._postHeight + count * self._unitHeight

	self._contentRect.sizeDelta = Vector2.New(sizeDelta.x, height)

	local scrollCount = count < 4 and count or 4
	local scrollHeight = self._preHeight + self._postHeight + scrollCount * self._unitHeight

	self._scrollRect.sizeDelta = Vector2.New(sizeDelta.x, scrollHeight)
end

function AoqiHeroSettlementTarget:_resetContentPos()
	self._scrollRectAdapter.scrollRect.verticalNormalizedPosition = 1
end

return AoqiHeroSettlementTarget
