-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breakformation/view/BreakFormationView.lua

module("logic.extensions.breakformation.view.BreakFormationView", package.seeall)

local BreakFormationView = class("BreakFormationView", TableViewComponent)

function BreakFormationView:ctor()
	BreakFormationView.super.ctor(self)
end

function BreakFormationView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "ScrollView"
	}
end

function BreakFormationView:_cellSize()
	return 206, 552
end

function BreakFormationView:_RefreshList()
	self._curViewDatas = BreakFormationModel.instance:getFormationCards()

	self._tableview:ReloadData()
end

function BreakFormationView:_RefreshHellList()
	self._curViewDatas = BreakFormationModel.instance:getHellFormationCards()

	self._tableview:ReloadData()
end

function BreakFormationView:_onReloadFinish()
	local tem = #self._curViewDatas

	for i = 1, #self._curViewDatas do
		if self._curViewDatas[i].score < 0 then
			tem = i

			break
		end
	end

	local idx = BreakFormationModel.instance:getAndResetLastIdx()

	if idx == nil then
		idx = tem
	elseif idx + 1 == tem then
		idx = tem
	end

	self.isFirstIn = true

	self._tableview:MoveCellToCebter(idx - 1)

	local cnt = self._tableview:GetVisibleCount() - 1

	for i = 0, cnt do
		local cell = self._tableview:GetCellByIndex(i)
		local comp = FormationItem.AddOnce(cell)

		comp:playFirstShow(i, 0)
	end

	self:showItemEff()
end

function BreakFormationView:showItemEff()
	if self.isAlertClose and self.isFirstIn then
		local cnt = self._tableview:GetVisibleCount() - 1

		for i = 0, cnt do
			local cell = self._tableview:GetCellByIndex(i)
			local comp = FormationItem.AddOnce(cell)

			comp:playGetNew()
		end
	end
end

function BreakFormationView:_updateCell(view, cell, data)
	local comp = FormationItem.AddOnce(cell)
	local preMo = self._curViewDatas[cell.index]
	local isOpen = preMo == nil or preMo.score >= 0 or data.isHell

	comp:onSetMo(data, isOpen, self, self._viewResLoader)
end

function BreakFormationView:_clearTableview(cell)
	local comp = FormationItem.AddOnce(cell)

	comp:dispose()
end

function BreakFormationView:_showDetailCard(id)
	local comp = BuffCard.AddOnce(self._detailCard)

	comp:setId(id)
	comp:setClickCallBack(function()
		self._detailCard:SetActive(false)
	end)
	self._detailCard:SetActive(true)
end

function BreakFormationView:bindEvents()
	BreakFormationView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnRankReward:AddClickListener(self._onClickRankReward, self)
	self.btnHelp:AddClickListener(self._onClickHelp, self)
	self.btnRule:AddClickListener(self._onClickRule, self)
	GameUtil.addClickHandler(self.btnMode, self._onModeClick, self)
	self._btnSweep:AddClickListener(self._onClickSweep, self)
end

function BreakFormationView:unbindEvents()
	BreakFormationView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnRankReward:RemoveClickListener()
	self._btnRankReward:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnMode)
	self._btnSweep:RemoveClickListener()
end

function BreakFormationView:buildUI()
	BreakFormationView.super.buildUI(self)

	self._closeButton = self:getBtn("Close")
	self.btnHelp = self:getBtn("btnHelp")
	self.btnRule = self:getBtn("bottom/btnRule")
	self.bgHell = self:getGo("canvas/bgHell")

	GameUtil.setHeight(self.bgHell, 0)

	self.bgHellBTM = self:getGo("bottom/bgHell")
	self.hell = self:getGo("hell")
	self.btnMode = self:getGo("btnMode")
	self.btnModeImg = self:getGo("btnMode/img")
	self._btnRank = self:getBtn("bottom/btnRank")
	self._btnRankReward = self:getBtn("bottom/btnRankReward")
	self.bottom = self:getGo("bottom"):GetComponent(goutil.Type_RectTransform)
	self._txtBestScore = goutil.findChildTextComponent(self.mainGO, "bottom/txtRecord")

	local goLeftDesc = goutil.findChild(self.mainGO, "bottom/leftDesc")

	self._txtBuffDesc = goutil.findChildTextComponent(goLeftDesc, "txtBuffDesc")
	self._txtConditionDesc = goutil.findChildTextComponent(goLeftDesc, "txtBuffDesc/txtConditionDesc")
	self._txtUpdateDesc = goutil.findChildTextComponent(goLeftDesc, "txtBuffDesc/txtConditionDesc/txtUpdateDesc")
	self.txtProgressRate = self:getTxt("bottom/txtProgressRate")
	self.txtTime = self:getTxt("resetTime/txtTime")
	self.txtCount = self:getTxt("buyTimeGo/txtCount")
	self.ScrollView = self:getGo("ScrollView")
	self._redPoint = goutil.findChild(self._btnRankReward.gameObject, "redPoint")
	self._btnSweep = self:getBtn("btnSweep")
	self._sweepRedPoint = goutil.findChild(self._btnSweep.gameObject, "redPoint")
end

function BreakFormationView:destroyUI()
	BreakFormationView.super.destroyUI(self)
end

function BreakFormationView:onEnter()
	BreakFormationView.super.onEnter(self)

	local time = 0.4

	GameUtil.setAnchoredPos(self.bottom, 1200, -300)
	self.bottom:DOAnchorPosX(0, time):SetEase(DG.Tweening.Ease.OutBack)

	local isDataInit = self:getFirstParam()

	self._viewResLoader = ViewResLoadMgr.get(self._viewPresentor)

	BreakFormationController.instance:registerLocalNotify("onDataLoaded", self._updateFirst, self)

	self.isAlertClose = false
	self.isFirstIn = false

	if isDataInit ~= true then
		self:sendUpdate()
	else
		self:_updateFirst()
	end

	BreakFormationController.instance:OpenPozhenTipsView(GameUtil.handler(self.onAlertClose, self))
	self:_updateRedPoint()
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateRedPoint, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdatePozhenMainView, self._updatePozhenMainView, self)
end

function BreakFormationView:_updatePozhenMainView()
	self:_updateFirst()
end

function BreakFormationView:sendUpdate()
	BreachFormationAgent.instance:sendPM_BreachFormationGetUserInfoReq(function(msg)
		BreakFormationModel.instance:handlePM_BreachFormationGetUserInfoRes(msg)
		BreakFormationController.instance:localNotify("onDataLoaded")
	end)
end

function BreakFormationView:onAlertClose()
	self.isAlertClose = true

	self:showItemEff()
end

function BreakFormationView:_updateFirst()
	local periodId = BreakFormationModel.instance.periodId
	local descTxt = ""
	local rule = ""

	if periodId > 1 then
		local pcfg = BreakFormationConfig.instance:getTeamCfg(periodId)
		local desc = BreakFormationModel.instance:getConditionDesc(periodId)

		printInfo("ddddddddddddddddddddddddddddddddddddd")
		printInfo(periodId)

		local nextCfg = BreakFormationConfig.instance:getTeamCfg(periodId + 1)

		if nextCfg then
			local nextTime = GameUtil.formatTimeString(lang("%m月%d日%H时"), nextCfg.startDateTime)

			rule = langPara("1.击败所有敌方精灵即可通关，获得通关奖励。\n2.%s。", desc)
			descTxt = langPara("1.赛季已更新，上赛季排名奖励已通过邮件发放，请注意查收。\n2.%s。", desc)
		else
			rule = langPara("1.击败所有敌方精灵即可通关，获得通关奖励。\n2.%s。", desc)
			descTxt = langPara("1.赛季已更新，上赛季排名奖励已通过邮件发放，请注意查收。\n2.%s。", desc)
		end

		local timeStr = GameUtil.getUserData("BreakFormationPeriod")

		if string.nilorempty(timeStr) or timeStr ~= pcfg.startDateTime then
			GameUtil.saveUserData("BreakFormationPeriod", pcfg.startDateTime)
			BreakFormationModel.instance:setCurMode(BreakFormationModel.MODE_NORMAL)
			TipsFacade.instance:openTipWindowNoX(lang("赛季更新"), descTxt, GameUtil.handler(self.popupTips, self))
		else
			self:popupTips()
		end
	else
		self:popupTips()
	end

	self:updateMode()

	self._txtBestScore.text = BreakFormationModel.instance:getTotalScore()
	self._txtBuffDesc.text = rule

	local count = VipModel.instance:getFreeGetTimesOfBreakFormation()
	local totalCount = count + BreakFormationModel.instance:getHasBuyFirstPassTimes()

	self.txtCount.text = math.max(0, totalCount - BreakFormationModel.instance:getHasFirstPassTimes()) .. "/" .. count

	local list = BreakFormationModel.instance:getFormationCards()
	local idx = #list

	for i = 1, #list do
		if list[i].score < 0 then
			idx = i - 1

			break
		end
	end

	self.txtProgressRate.text = "关卡进度：" .. idx .. "/" .. #list
	self.txtTime.text = ""

	self:onTimer()
	settimer(1, self.onTimer, self)
end

function BreakFormationView:updateMode()
	local mode = BreakFormationModel.instance:getCurMode() or BreakFormationModel.MODE_NORMAL

	if mode == BreakFormationModel.MODE_NORMAL then
		GameUtil.SetActive(self._btnSweep, true)
		GameUtil.SetActive(self.hell, false)
		GameUtil.SetActive(self.bgHellBTM, false)
		GameUtil.setHeight(self.bgHell, 0)
		GameUtil.setUIImageSpriteIdx(self.btnModeImg, 0)
		self:_RefreshList()
		GameUtil.SetGray(self.btnMode, false)
	else
		GameUtil.SetActive(self._btnSweep, false)
		GameUtil.SetActive(self.hell, true)
		GameUtil.SetActive(self.bgHellBTM, true)
		GameUtil.setUIImageSpriteIdx(self.btnModeImg, 1)
		self:_RefreshHellList()

		local height = GameUtil.getHeight(self.bgHell)

		if self.tween then
			self.tween:Kill(false)

			self.tween = nil
		end

		self.tween = TweenUtil.ValueTo(height, 720, 0.3, function(val)
			GameUtil.setHeight(self.bgHell, val)
		end, function()
			GameUtil.SetGray(self.btnMode, false)

			self.tween = nil
		end, self)
	end
end

function BreakFormationView:popupTips()
	LocalUserDataController.instance:doCallbackWhenDayFirst("isDayFirstEnterBreakFormation2", function()
		local key = "pozhentianxia2"
		local ruleCo = RulesConfig.instance:getRuleCo(key)

		if ruleCo then
			local title = tostring((not ruleCo.title or nil) and 0)

			if not title or title == "0" or #title == 0 then
				title = lang("tip")
			end

			TipsFacade.instance:openTipWindowNoX(title, ruleCo.rules)
		end
	end)
end

function BreakFormationView:onTimer()
	local endtime = BreakFormationModel.instance.endTime
	local now = ServerTime.now()
	local left = endtime - now

	if left >= 0 then
		self.txtTime.text = GameUtil.FormatTimeWords(left)
	else
		self.txtTime.text = ""

		self:sendUpdate()
	end
end

function BreakFormationView:onEnterFinished()
	BreakFormationView.super.onEnterFinished(self)
end

function BreakFormationView:_updateRedPoint()
	goutil.setActive(self._redPoint, RedPointModel.instance:isActive(27))
	print(" 115 isActive = " .. tostring(RedPointModel.instance:isActive(115)))
	goutil.setActive(self._sweepRedPoint, RedPointModel.instance:isActive(115))
end

function BreakFormationView:onExit()
	BreakFormationView.super.onExit(self)
	BreakFormationController.instance:unregisterLocalNotify("onDataLoaded", self._updateFirst, self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._updateRedPoint, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdatePozhenMainView, self._updatePozhenMainView, self)
	removetimer(self.onTimer, self)

	if self.tween then
		self.tween:Kill(false)

		self.tween = nil
	end

	GameUtil.SetGray(self.btnMode, false)
	self._viewResLoader:clear()
end

function BreakFormationView:onExitFinished()
	BreakFormationView.super.onExitFinished(self)
end

function BreakFormationView:_onClickClose()
	BreakFormationModel.instance:setCurMode(BreakFormationModel.MODE_NORMAL)
	self:close()
end

function BreakFormationView:_onClickRank()
	UIStateManager.instance:push(ViewName.Rank, GameEnum.RankType.BreakFormation, 0)
end

function BreakFormationView:_onClickRankReward()
	UIStateManager.instance:open(ViewName.PozhenReward)
end

function BreakFormationView:_onClickHelp()
	local cfgKey = "pozhentianxia"

	UIStateManager.instance:open(ViewName.RulesView, cfgKey)
end

function BreakFormationView:_onClickRule()
	UIStateManager.instance:push(ViewName.PozhendescView)
end

function BreakFormationView:_onModeClick()
	local now = ServerTime.now()

	if self.lastClickTime == nil or now - self.lastClickTime >= 0.6 then
		self.lastClickTime = now

		GameUtil.SetGray(self.btnMode, true)
	else
		return
	end

	local mode = BreakFormationModel.instance:getCurMode() or BreakFormationModel.MODE_NORMAL

	if mode == BreakFormationModel.MODE_NORMAL then
		local score = BreakFormationModel.instance:getTotalScore()
		local limitScore = BreakFormationConfig.instance:getHellScoreLimit()

		if limitScore <= score then
			BreakFormationModel.instance:setCurMode(BreakFormationModel.MODE_HELL)
			self:updateMode()
		else
			TipsFacade.instance:openCommonTips(langPara("本期总评分达到%s分后，解锁地狱模式", limitScore))
		end
	else
		BreakFormationModel.instance:setCurMode(BreakFormationModel.MODE_NORMAL)
		self:updateMode()
	end
end

function BreakFormationView:_onClickHome()
	BreakFormationModel.instance:setCurMode(BreakFormationModel.MODE_NORMAL)
	UIStateManager.instance:clear(true)
end

function BreakFormationView:_onClickSweep()
	BreakFormationModel.instance:saveQuickOpenTime()
	UIStateManager.instance:push(ViewName.PozhenSweepView)
end

return BreakFormationView
