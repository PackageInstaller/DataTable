-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/BattleSettlementBaseView.lua

module("logic.extensions.battlesettlement.view.BattleSettlementBaseView", package.seeall)

local BattleSettlementBaseView = class("BattleSettlementBaseView", ViewComponent)
local StateEnum = {
	PageTwo = 2,
	PageOne = 1,
	Finish = 3,
	FirstPart = 0
}

function BattleSettlementBaseView:ctor()
	self._isSuccess = nil
	self._settlementList = nil
	self._settlementQueue = nil
	self._settlementParam = nil
	self._curState = StateEnum.FirstPart
end

function BattleSettlementBaseView:buildUI()
	self:_buildUIOfNew()

	self._settlementTarget = SettlementTarget.New()
	self._settlementRank = SettlementRank.New()

	self._settlementTarget:buildUI(self:getGo("part2/right/target"))
	self._settlementRank:buildUI(self:getGo("part2/right/rank"))
	table.insert(self._settlementList, self._settlementTarget)
	table.insert(self._settlementList, self._settlementRank)
end

function BattleSettlementBaseView:_buildUIOfNew()
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
	self._settlementFirstPart = SettlementFirstPart.New()

	self._settlementFirstPart:buildUI(self:getGo("part1"))
end

function BattleSettlementBaseView:destroyUI()
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

function BattleSettlementBaseView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._settlementFirstPart:bindEvents()

	for i, v in ipairs(self._settlementList) do
		v:bindEvents()
	end
end

function BattleSettlementBaseView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._settlementFirstPart:unbindEvents()

	for i, v in ipairs(self._settlementList) do
		v:unbindEvents()
	end
end

function BattleSettlementBaseView:onEnter()
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

function BattleSettlementBaseView:onExit()
	BattleSettlementModel.instance:onReset()
	self._settlementFirstPart:onExit()

	for i, v in ipairs(self._settlementList) do
		v:onExit()
	end
end

function BattleSettlementBaseView:_onClickClose()
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

function BattleSettlementBaseView:_closeBattle()
	BattleController.instance:endBattle()
end

function BattleSettlementBaseView:getAudioId()
	return nil
end

function BattleSettlementBaseView:_initRightChildsActive()
	local childCount = self._rightRectTrans.childCount

	for i = 1, childCount do
		local trans = self._rightRectTrans:GetChild(i - 1)

		if trans then
			goutil.setActive(trans.gameObject, false)
		end
	end
end

function BattleSettlementBaseView:_setState(state)
	self._curState = state
end

function BattleSettlementBaseView:_openPart1()
	self:_setState(StateEnum.FirstPart)
	self._part1:SetActive(true)
	self._part2:SetActive(false)
	goutil.setActive(self._imgBgPart1, true)
	goutil.setActive(self._imgBgPart2, false)
	self._settlementFirstPart:onEnter(self._isSuccess, self)

	self._totalTimeForClickEnd = self._settlementFirstPart:getNeedTime()
end

function BattleSettlementBaseView:_openPart2()
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

function BattleSettlementBaseView:customSettlementInfo()
	local enumType = BattleSettlementModel.instance:getType()

	if enumType ~= BattleSettlementModel.Enum.Fengbaobao then
		local param = {}

		table.insert(param, self._isSuccess)
		self:enqueueQueue(self._settlementTarget, param)
	end

	if enumType == BattleSettlementModel.Enum.Arena then
		self:_onEnumTypeIsArena()
	elseif enumType == BattleSettlementModel.Enum.Endless then
		self:_onEnumTypeIsEndless()
	elseif enumType == BattleSettlementModel.Enum.Fengbaobao then
		self:_onEnumTypeIsFengbaobao()
	elseif enumType == BattleSettlementModel.Enum.GodDiShiTian then
		self:_onEnumGodDiShiTian()
	elseif enumType == BattleSettlementModel.Enum.VillaintrialPet then
		self:_onEnumVillaintrialPet()
	elseif enumType == BattleSettlementModel.Enum.LailisiChanllenge then
		self:_onEnumLailisi()
	elseif enumType == BattleSettlementModel.Enum.HonourTowerChallenge then
		self:_onEnumHonourTower()
	elseif enumType == BattleSettlementModel.Enum.TunTianChallenge then
		self:_onEnumTunTianChallenge()
	elseif enumType == BattleSettlementModel.Enum.SimplyDesc then
		self:_onEnumSimpleDesc()
	elseif enumType == BattleSettlementModel.Enum.NightFeastBoss then
		self:_onEnumNightFeastBoss()
	elseif enumType == BattleSettlementModel.Enum.HeartofJieshen then
		self:_onEnumSimpleDesc()
	elseif enumType == BattleSettlementModel.Enum.Chuangezhengli then
		self:_onEnumSimpleDesc()
	elseif enumType == BattleSettlementModel.Enum.KingArena then
		self:_onEnumTypeIsKingArena()
	else
		self:_onEnumTypeIsDefault()
	end
end

function BattleSettlementBaseView:enqueueQueue(target, param)
	self._settlementQueue:enqueue(target)
	self._settlementParam:enqueue(param)
end

function BattleSettlementBaseView:dequeueQueue()
	local v, param

	if self._settlementQueue:count() > 0 then
		v = self._settlementQueue:dequeue()
		param = self._settlementParam:dequeue()
	end

	return v, param
end

function BattleSettlementBaseView:_doOnEnter()
	self:_doPageOneTween()
end

function BattleSettlementBaseView:_moveDown(pages, delayTimes)
	for i, delayTime in ipairs(delayTimes) do
		for j, bsAnimPlay in ipairs(pages[i]) do
			bsAnimPlay:moveDown(delayTime)
		end
	end
end

function BattleSettlementBaseView:_isChangePage(totalHeight, curPos, maxHeight)
	print("===????----", totalHeight, curPos, maxHeight, type(totalHeight), type(curPos), type(maxHeight), totalHeight < Mathf.Abs(curPos - maxHeight))

	return totalHeight < Mathf.Abs(curPos - maxHeight)
end

function BattleSettlementBaseView:_completeFirstPart()
	self._settlementFirstPart:doKillTween()
end

function BattleSettlementBaseView:_startSecondPartPageOne()
	if self._firstPartTween then
		self._firstPartTween:Kill(true)
	end
end

function BattleSettlementBaseView:_doPageOneTween()
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

function BattleSettlementBaseView:_completeSecondPartPageOne()
	if self._pageOneList then
		for i, v in ipairs(self._pageOneList) do
			v:doCompleteTween()
		end
	end

	if self._pageOneTween then
		self._pageOneTween:Kill(true)
	end
end

function BattleSettlementBaseView:_startSecondPartPageTwo()
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

function BattleSettlementBaseView:_completeSecondPartPageTwo()
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

function BattleSettlementBaseView:_onEnumTypeIsDefault()
	return
end

function BattleSettlementBaseView:_onEnumTypeIsArena()
	return
end

function BattleSettlementBaseView:_onEnumTypeIsKingArena()
	return
end

function BattleSettlementBaseView:_onEnumTypeIsEndless()
	return
end

function BattleSettlementBaseView:_onEnumTypeIsFengbaobao()
	return
end

function BattleSettlementBaseView:_onEnumGodDiShiTian()
	return
end

function BattleSettlementBaseView:_onEnumVillaintrialPet()
	return
end

function BattleSettlementBaseView:_onEnumLailisi()
	return
end

function BattleSettlementBaseView:_onEnumHonourTower()
	return
end

function BattleSettlementBaseView:_onEnumTunTianChallenge()
	return
end

function BattleSettlementBaseView:_onEnumSimpleDesc()
	return
end

function BattleSettlementBaseView:_onEnumNightFeastBoss()
	return
end

function BattleSettlementBaseView:_delayOnBtnClose()
	return
end

function BattleSettlementBaseView:_onAnimEnd()
	self:_popupExtraPassView()
	self:_setState(StateEnum.Finish)

	self._isClickEnd = true

	goutil.setActive(self._txtContinue, true)
end

function BattleSettlementBaseView:_doKillTween()
	self._settlementFirstPart:doKillTween()

	for i, v in ipairs(self._settlementList) do
		v:doKillTween()
	end
end

function BattleSettlementBaseView:_isHavePerfectPass()
	local enumType = BattleSettlementModel.instance:getType()

	return enumType == BattleSettlementModel.Enum.PlotCopy or enumType == BattleSettlementModel.Enum.Scenariocopy
end

function BattleSettlementBaseView:_isPerfectPass()
	local enumType = BattleSettlementModel.instance:getType()

	return PlotCopyModel.instance:isPerfectPass(enumType)
end

function BattleSettlementBaseView:_isTongHavePopup()
	local enumType = BattleSettlementModel.instance:getType()

	if enumType ~= BattleSettlementModel.Enum.TongBattle then
		return false
	end

	if TongBattleModel.instance:isOpenDemonShowRound() then
		return true
	end

	if TongBattleModel.instance:isOpenTinderChooseRound() then
		return true
	end

	return false
end

function BattleSettlementBaseView:_popupExtraPassView()
	local flInfo = HolyChallModel.instance:GetChallengePopupData()

	if flInfo and checknumber(flInfo.energyPrize) > 0 then
		ViewMgr.instance:open(ViewName.HolyChallPopup)

		return
	end

	if self:_isTongHavePopup() then
		return
	end

	if self:_isHavePerfectPass() then
		local enumType = BattleSettlementModel.instance:getType()

		if enumType == BattleSettlementModel.Enum.PlotCopy then
			if self._isSuccess and self:_isPerfectPass() then
				local params = BattleSettlementModel.instance:getParams()

				if not params.isPerfectPassBefore then
					if self:_isShowPerfect(params.chapterId, params.stageId) then
						ViewMgr.instance:open(ViewName.PerfectPassView, params.chapterId, params.stageId)
					end

					return
				end
			end
		elseif enumType == BattleSettlementModel.Enum.Scenariocopy then
			local params = BattleSettlementModel.instance:getParams()
			local scPlotCfg = ScenariocopyConfig.instance:getStageCfg(params.chapterId, params.stageId)

			if scPlotCfg and checknumber(scPlotCfg.perfectWinId) > 0 and checkbool(params.isPerfectPassBefore) then
				ViewMgr.instance:open(ViewName.ScPerfectPassView, params.chapterId, params.stageId)
			end

			return
		end
	end
end

function BattleSettlementBaseView:_isShowPerfect(chapterId, stageId)
	local cfg = CopyConfig.instance:getStageById(chapterId, stageId)

	return cfg and not string.nilorempty(cfg.perfectPassMp)
end

return BattleSettlementBaseView
