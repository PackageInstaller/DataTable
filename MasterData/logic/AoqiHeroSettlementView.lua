-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroSettlementView.lua

module("logic.extensions.aoqihero.view.AoqiHeroSettlementView", package.seeall)

local AoqiHeroSettlementView = class("AoqiHeroSettlementView", ViewComponent)

function AoqiHeroSettlementView:ctor()
	AoqiHeroSettlementView.super.ctor(self)
end

function AoqiHeroSettlementView:unbindEvents()
	AoqiHeroSettlementView.super.unbindEvents(self)
end

function AoqiHeroSettlementView:bindEvents()
	AoqiHeroSettlementView.super.bindEvents(self)
end

function AoqiHeroSettlementView:buildUI()
	AoqiHeroSettlementView.super.buildUI(self)
end

function AoqiHeroSettlementView:onExit()
	AoqiHeroSettlementView.super.onExit(self)
end

function AoqiHeroSettlementView:onEnter()
	AoqiHeroSettlementView.super.onEnter(self)
end

local StateEnum = {
	PageTwo = 2,
	PageOne = 1,
	Finish = 3,
	FirstPart = 0
}
local Type = {
	Endless = 2,
	Normal = 1
}

function AoqiHeroSettlementView:ctor()
	self._isSuccess = true
	self._settlementList = nil
	self._settlementQueue = nil
	self._settlementParam = nil
	self._curState = StateEnum.FirstPart
end

function AoqiHeroSettlementView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._part1 = self:getGo("part1")
	self._part2 = self:getGo("part2")
	self._imgBgPart1 = self:getGo("imgBgPart1")
	self._imgBgPart2 = self:getGo("imgBgPart2")
	self._txtContinue = self:getGo("txtContinue")
	self._rightRectTrans = self:getGo("part2/right"):GetComponent(goutil.Type_RectTransform)
	self._settlementQueue = Queue.New()
	self._settlementParam = Queue.New()
	self._settlementList = {}
	self._settlementFirstPart = AoqiHeroSettlementFirstPart.New()

	self._settlementFirstPart:buildUI(self:getGo("part1"))

	self._settlementTarget = AoqiHeroSettlementTarget.New()
	self._settlementTeam = AoqiHeroSettlementTeam.New()
	self._settlementReward = AoqiHeroSettlementReward.New()
	self._settlementDesc = AoqiHeroSettlementDesc.New()

	self._settlementTarget:buildUI(self:getGo("part2/right/target"))
	self._settlementTeam:buildUI(self:getGo("part2/right/team"))
	self._settlementReward:buildUI(self:getGo("part2/right/reward"))
	self._settlementDesc:buildUI(self:getGo("part2/right/desc"))
	table.insert(self._settlementList, self._settlementTarget)
	table.insert(self._settlementList, self._settlementTeam)
	table.insert(self._settlementList, self._settlementReward)
	table.insert(self._settlementList, self._settlementDesc)
end

function AoqiHeroSettlementView:_buildUIOfNew()
	return
end

function AoqiHeroSettlementView:destroyUI()
	self._settlementFirstPart:destroyUI()

	self._settlementFirstPart = nil

	for i, v in ipairs(self._settlementList) do
		v:destroyUI()
	end

	table.clear(self._settlementList)
	self._settlementQueue:clear()

	self._settlementQueue = nil

	self._settlementParam:clear()

	self._settlementParam = nil
	self._settlementTarget = nil
	self._settlementRank = nil
end

function AoqiHeroSettlementView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._settlementFirstPart:bindEvents()

	for i, v in ipairs(self._settlementList) do
		v:bindEvents()
	end
end

function AoqiHeroSettlementView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._settlementFirstPart:unbindEvents()

	for i, v in ipairs(self._settlementList) do
		v:unbindEvents()
	end
end

function AoqiHeroSettlementView:onEnter()
	local param = self:getOpenParam()

	self._activityId = param and checknumber(param[1]) or 450001
	self._isSuccess = param and param[2] or false

	if param then
		self._type = param[3] or Type.Normal
	end

	if param then
		self._param = param[4] or nil
	end

	self:_initRightChildsActive()
	ViewMgr.instance:close(ViewName.BulletScreen)
	ViewMgr.instance:close(ViewName.SendBullet)
	AudioBgmPlayer.instance:startPlayEffect(self:getAudioId())

	self._totalTimeForClickEnd = 0
	self._isClickEnd = false

	goutil.setActive(self._txtContinue, false)
	self:_openPart1()

	local delayTime = self._settlementFirstPart:getNeedTime()

	self._firstPartTween = TweenUtil.DoDelay(delayTime, function()
		self:_openPart2()
	end)
end

function AoqiHeroSettlementView:onExit()
	BattleSettlementModel.instance:onReset()
	self._settlementFirstPart:onExit()

	for i, v in ipairs(self._settlementList) do
		v:onExit()
	end
end

function AoqiHeroSettlementView:_onClickClose()
	if self._curState == StateEnum.FirstPart then
		self:_completeFirstPart()
		self:_startSecondPartPageOne()
		self:_completeSecondPartPageOne()
	elseif self._curState == StateEnum.PageOne then
		self:_completeSecondPartPageOne()
	elseif self._curState == StateEnum.PageTwo then
		self:_completeSecondPartPageTwo()
	elseif self._curState == StateEnum.Finish then
		self:_closeBattle()
	end
end

function AoqiHeroSettlementView:_closeBattle()
	AoQiHeroController.instance:endBattle()
	self:close()
end

function AoqiHeroSettlementView:getAudioId()
	return self._isSuccess and 30202 or 30201
end

function AoqiHeroSettlementView:_initRightChildsActive()
	local childCount = self._rightRectTrans.childCount

	for i = 1, childCount do
		local trans = self._rightRectTrans:GetChild(i - 1)

		if trans then
			goutil.setActive(trans.gameObject, false)
		end
	end
end

function AoqiHeroSettlementView:_setState(state)
	self._curState = state
end

function AoqiHeroSettlementView:_openPart1()
	self:_setState(StateEnum.FirstPart)
	self._part1:SetActive(true)
	self._part2:SetActive(false)
	goutil.setActive(self._imgBgPart1, true)
	goutil.setActive(self._imgBgPart2, false)
	self._settlementFirstPart:onEnter(self._isSuccess, self)

	self._totalTimeForClickEnd = self._settlementFirstPart:getNeedTime()
end

function AoqiHeroSettlementView:_openPart2()
	if self._isClickEnd then
		return
	end

	self:_setState(StateEnum.PageOne)
	self._part1:SetActive(true)
	self._part2:SetActive(true)
	goutil.setActive(self._imgBgPart1, true)
	goutil.setActive(self._imgBgPart2, true)

	self._nextPosY = 0
	self._delayTime = 0.2

	self:customSettlementInfo()
end

function AoqiHeroSettlementView:customSettlementInfo()
	if self._type == Type.Normal then
		local param = {}

		table.insert(param, self._isSuccess)
		self:enqueueQueue(self._settlementTarget, param)

		param = {
			self,
			self._activityId
		}

		self:enqueueQueue(self._settlementTeam, param)

		param = {}

		if self._param then
			table.insert(param, self._param)
		end

		self:enqueueQueue(self._settlementReward, param)
		self:_doOnEnter()

		self._totalTimeForClickEnd = self._delayTime + 1

		self:_delayOnBtnClose()
	elseif self._type == Type.Endless then
		local param = {}

		table.insert(param, self._param.title)
		table.insert(param, self._param.content)
		self:enqueueQueue(self._settlementDesc, param)

		param = {
			self,
			self._activityId
		}

		self:enqueueQueue(self._settlementTeam, param)

		param = {}

		self:enqueueQueue(self._settlementReward, param)
		self:_doOnEnter()

		self._totalTimeForClickEnd = self._delayTime + 1

		self:_delayOnBtnClose()
	end
end

function AoqiHeroSettlementView:enqueueQueue(target, param)
	self._settlementQueue:enqueue(target)
	self._settlementParam:enqueue(param)
end

function AoqiHeroSettlementView:dequeueQueue()
	local v, param

	if self._settlementQueue:count() > 0 then
		v = self._settlementQueue:dequeue()
		param = self._settlementParam:dequeue()
	end

	return v, param
end

function AoqiHeroSettlementView:_doOnEnter()
	self:_doPageOneTween()
end

function AoqiHeroSettlementView:_moveDown(pages, delayTimes)
	for i, delayTime in ipairs(delayTimes) do
		for j, bsAnimPlay in ipairs(pages[i]) do
			bsAnimPlay:moveDown(delayTime)
		end
	end
end

function AoqiHeroSettlementView:_isChangePage(totalHeight, curPos, maxHeight)
	return totalHeight < Mathf.Abs(curPos - maxHeight)
end

function AoqiHeroSettlementView:_completeFirstPart()
	self._settlementFirstPart:doKillTween()
end

function AoqiHeroSettlementView:_startSecondPartPageOne()
	if self._firstPartTween then
		self._firstPartTween:Kill(true)
	end
end

function AoqiHeroSettlementView:_doPageOneTween()
	local totalHeight = self._rightRectTrans.rect.height
	local pageOne = {}

	self._nextPosY = 0
	self._delayTime = 0.2

	while self._settlementQueue:count() > 0 do
		local temp = self._settlementQueue:peek()

		if self:_isChangePage(totalHeight, self._nextPosY, temp:getMaxHeight()) then
			break
		end

		local v = self._settlementQueue:dequeue()
		local param = self._settlementParam:dequeue()

		if param and #param > 0 then
			self._nextPosY, self._delayTime = v:onEnter(totalHeight, self._nextPosY, self._delayTime, unpack(param))
		else
			self._nextPosY, self._delayTime = v:onEnter(totalHeight, self._nextPosY, self._delayTime)
		end

		table.insert(pageOne, v)
	end

	self._pageOneList = pageOne

	local isExistPageTwo = self._settlementQueue:count() > 0

	self._pageOneTween = isExistPageTwo and TweenUtil.DoDelay(self._delayTime, function()
		self:_startSecondPartPageTwo()
	end) or TweenUtil.DoDelay(self._delayTime + 1, function()
		self:_onAnimEnd()
	end)
end

function AoqiHeroSettlementView:_completeSecondPartPageOne()
	if self._pageOneList then
		for i, v in ipairs(self._pageOneList) do
			v:doCompleteTween()
		end
	end

	if self._pageOneTween then
		self._pageOneTween:Kill(true)
	end
end

function AoqiHeroSettlementView:_startSecondPartPageTwo()
	self:_setState(StateEnum.PageTwo)

	local delayTime = 1
	local costTime = 1.5

	if self._pageOneList then
		for i, v in ipairs(self._pageOneList) do
			v:moveDown(delayTime, costTime)
		end
	end

	local totalHeight = self._rightRectTrans.rect.height
	local pageTwo = {}

	self._nextPosY = 0
	self._delayTime = delayTime + costTime - 0.5

	while self._settlementQueue:count() > 0 do
		local v = self._settlementQueue:dequeue()
		local param = self._settlementParam:dequeue()

		if param and #param > 0 then
			self._nextPosY, self._delayTime = v:onEnter(totalHeight, self._nextPosY, self._delayTime, unpack(param))
		else
			self._nextPosY, self._delayTime = v:onEnter(totalHeight, self._nextPosY, self._delayTime)
		end

		table.insert(pageTwo, v)
	end

	self._pageTwoList = pageTwo

	local isExistPageTwo = self._settlementQueue:count() > 0

	self._pageTwoTween = TweenUtil.DoDelay(self._delayTime + 1, function()
		self:_onAnimEnd()
	end)
end

function AoqiHeroSettlementView:_completeSecondPartPageTwo()
	if self._pageOneList then
		for i, v in ipairs(self._pageOneList) do
			v:completeMoveDown()
		end
	end

	if self._pageTwoList then
		for i, v in ipairs(self._pageTwoList) do
			v:doCompleteTween()
		end
	end

	if self._pageTwoTween then
		self._pageTwoTween:Kill(true)
	end
end

function AoqiHeroSettlementView:_delayOnBtnClose()
	return
end

function AoqiHeroSettlementView:_onAnimEnd()
	self:_popupExtraPassView()
	self:_setState(StateEnum.Finish)

	self._isClickEnd = true

	goutil.setActive(self._txtContinue, true)
end

function AoqiHeroSettlementView:_doKillTween()
	self._settlementFirstPart:doKillTween()

	for i, v in ipairs(self._settlementList) do
		v:doKillTween()
	end
end

function AoqiHeroSettlementView:_popupExtraPassView()
	return
end

return AoqiHeroSettlementView
