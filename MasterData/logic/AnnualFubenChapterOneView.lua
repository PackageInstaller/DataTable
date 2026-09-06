-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenChapterOneView.lua

module("logic.extensions.annualfuben.view.AnnualFubenChapterOneView", package.seeall)

local AnnualFubenChapterOneView = class("AnnualFubenChapterOneView", ViewComponent)

function AnnualFubenChapterOneView:ctor()
	AnnualFubenChapterOneView.super.ctor(self)
end

function AnnualFubenChapterOneView:unbindEvents()
	AnnualFubenChapterOneView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSearch)
	GameUtil.rmClickHandler(self._btnCombine)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnTip)
end

function AnnualFubenChapterOneView:bindEvents()
	AnnualFubenChapterOneView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSearch, self._onClickSearch, self)
	GameUtil.addClickHandler(self._btnCombine, self._onClickCombine, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function AnnualFubenChapterOneView:buildUI()
	AnnualFubenChapterOneView.super.buildUI(self)

	self._btnSearch = self:getGo("btnSearch")
	self._btnCombine = self:getGo("btnCombine")
	self._btnPrize = self:getGo("btnPrize")
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._clueTablecell = self:getGo("clueTablecell")
	self._searchClueTableview = self:getGo("searchClueTableview")
	self._searchClueTableList = ScrollerList.create(self._searchClueTableview, self._clueTablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._timeClueTableview = self:getGo("timeClueTableview")
	self._timeClueTableList = ScrollerList.create(self._timeClueTableview, self._clueTablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTime = self:getTxt("worldTime/txtTime")
	self._txtSearchTime = self:getTxt("btnSearch/txtSearchTime")
	self._txtClueCount = self:getTxt("btnCombine/txtClueCount")
	self._redpointPrize = self:getGo("btnPrize/redpoint")
	self._redpointSearch = self:getGo("btnSearch/redpoint")
end

function AnnualFubenChapterOneView:onExit()
	AnnualFubenChapterOneView.super.onExit(self)
	removetimer(self._onClock, self)
	RedPointController.instance:unregRedPoint(self._redpointSearch)
end

function AnnualFubenChapterOneView:onEnter()
	AnnualFubenChapterOneView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AnnualFubenInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_FusionSoulCombineClueRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_AnnualFubenGainClueRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._activityCfg = AnnualFubenConfig.instance:getActivityCfg(self._activityId)

	self:_refreshView()

	if not AnnualFubenModel.instance:getFirstEnterChapterOne(self._activityId) then
		AnnualFubenModel.instance:setFirstEnterChapterOne(self._activityId)
		GlobalDispatcher:dispatch(GlobalNotify.StartStory, self._activityCfg.chapterOneStoryId)
	end

	RedPointController.instance:regRedPoint(self._redpointSearch, self._activityCfg.redPointId)
end

function AnnualFubenChapterOneView:_refreshView()
	self:_initTimer()

	local clueGainMap = AnnualFubenController.instance:getAllGainClueIds(self._activityId)
	local searchList = {}
	local timeList = {}
	local clueCfgs = AnnualFubenConfig.instance:getClueCfgs(self._activityId)

	for i, v in ipairs(clueCfgs) do
		if v.initClue == false then
			if checknumber(v.progressId) > 0 then
				table.insert(timeList, v)
			else
				table.insert(searchList, v)
			end
		else
			table.insert(searchList, v)
		end
	end

	table.sort(searchList, function(a, b)
		if clueGainMap[a.clueId] ~= clueGainMap[b.clueId] then
			return clueGainMap[a.clueId]
		else
			return a.clueId < b.clueId
		end
	end)
	table.sort(timeList, function(a, b)
		if clueGainMap[a.clueId] ~= clueGainMap[b.clueId] then
			return clueGainMap[a.clueId]
		else
			return a.clueId < b.clueId
		end
	end)
	self._searchClueTableList:reloadData(searchList)
	self._timeClueTableList:reloadData(timeList)

	local todayTimes = AnnualFubenModel.instance:getSearchClueTime(self._activityId)
	local actCfg = AnnualFubenConfig.instance:getActivityCfg(self._activityId)
	local curTimes = actCfg.dailyClue - todayTimes

	self._txtSearchTime.text = langPara("剩余次数:%d/%d", curTimes, actCfg.dailyClue)

	local totalCount = #searchList + #timeList

	self._txtClueCount.text = langPara("当前已解锁\n%d/%d条情报", table.nums(clueGainMap), totalCount)

	GameUtil.SetActive(self._redpointPrize, AnnualFubenController.instance:isCanGetCluePrize(self._activityId))
end

function AnnualFubenChapterOneView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local iconGo = goutil.findChild(go, "icon/con")
	local emptyGo = goutil.findChild(go, "imgEmpty")
	local txtDesc = goutil.findChildTextComponent(go, "desc/tableview/viewport/txt")
	local txtTableView = goutil.findChild(go, "desc/tableview")
	local txtEmpty = goutil.findChild(go, "desc/txtEmpty")
	local isGainClue = AnnualFubenModel.instance:isGainClue(self._activityId, data.clueId)

	GameUtil.SetActive(icon, isGainClue)
	GameUtil.SetActive(emptyGo, not isGainClue)
	uGuiUtil.clearImage(iconGo)
	GameUtil.SetActive(txtEmpty, false)
	GameUtil.SetActive(txtTableView, true)

	if isGainClue == true then
		uGuiUtil.setSpriteToImage(iconGo, nil, data.iconRes)

		txtDesc.text = data.desc
	elseif checknumber(data.progressId) > 0 then
		local progressCfg = AnnualFubenConfig.instance:getWorldCfg(self._activityCfg.wordProgressPlanId, data.progressId)

		txtDesc.text = langPara("全服收集\n%d/%d\n条龙族秘辛后解锁", self._curProgress, progressCfg.progress)
	else
		GameUtil.SetActive(txtEmpty, true)
		GameUtil.SetActive(txtTableView, false)

		txtDesc.text = "*********"
	end
end

function AnnualFubenChapterOneView:_clearCell(cell)
	local go = cell.gameObject
	local iconGo = goutil.findChild(go, "icon/con")

	uGuiUtil.clearImage(iconGo)
end

function AnnualFubenChapterOneView:_refreshClockInfo(curPrecent, curProgress, curShowTime)
	self._txtTime.text = GameUtil.FormatTimeSymbol(curShowTime)
end

function AnnualFubenChapterOneView:_initTimer()
	self._curProgressId, self._precentStart, self._startProgressTime, self._nexProgressId, self._nextProgressTime, self._precentEnd = AnnualFubenController.instance:getWorldProgressCfgInfo(self._activityId)

	removetimer(self._onClock, self)

	local curTime = ServerTime.now()

	self:_onClock()

	if self._nextProgressTime and curTime < self._nextProgressTime then
		settimer(1, self._onClock, self, true)
	end
end

function AnnualFubenChapterOneView:_onClock()
	local curTime = ServerTime.now()

	self._curPrecent, self._curProgress, self._curShowTime = AnnualFubenController.instance:getWorldProgressInfo(self._activityId, self._curProgressId, self._precentStart, self._startProgressTime, self._nexProgressId, self._nextProgressTime, self._precentEnd)

	if not self._nextProgressTime then
		self:_refreshClockInfo(self._curPrecent, self._curProgress, self._curShowTime)
	elseif curTime < self._nextProgressTime then
		self:_refreshClockInfo(self._curPrecent, self._curProgress, self._curShowTime)
	else
		removetimer(self._onClock, self)
		AnnualFubenAgent.instance:sendPM_AnnualFubenInfoReq(self._activityId)
	end
end

function AnnualFubenChapterOneView:_onClickSearch()
	UIStateManager.instance:push(ViewName.AnnualFubenSearchView, self._activityId)
end

function AnnualFubenChapterOneView:_onClickCombine()
	UIStateManager.instance:push(ViewName.AnnualFubenCombineView, self._activityId)
end

function AnnualFubenChapterOneView:_onClickPrize()
	UIStateManager.instance:push(ViewName.AnnualFubenCluePrizeView, self._activityId)
end

function AnnualFubenChapterOneView:_onClickTip()
	TipsFacade.instance:openRulesView("annual_fuben_chapter_one_rule")
end

return AnnualFubenChapterOneView
