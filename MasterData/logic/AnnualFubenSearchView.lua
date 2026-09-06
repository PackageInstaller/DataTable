-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenSearchView.lua

module("logic.extensions.annualfuben.view.AnnualFubenSearchView", package.seeall)

local AnnualFubenSearchView = class("AnnualFubenSearchView", ViewComponent)

function AnnualFubenSearchView:ctor()
	AnnualFubenSearchView.super.ctor(self)
end

function AnnualFubenSearchView:unbindEvents()
	AnnualFubenSearchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLink)
	GameUtil.rmClickHandler(self._btnTip)
end

function AnnualFubenSearchView:bindEvents()
	AnnualFubenSearchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnLink, self._onClickLink, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function AnnualFubenSearchView:buildUI()
	AnnualFubenSearchView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._event = self:getGo("event")
	self._eventCon = self:getGo("event/eventCon")
	self._posRecord = self._event:GetComponent(ComponentType.TestRecordPos)
	self._btnLink = self:getGo("btnLink")
	self._txtWorldTime = self:getTxt("worldTime/txtWorldTime")
	self._btnTip = self:getGo("btnTip")
	self._txtSearchTime = self:getTxt("txtSearchTime")
end

function AnnualFubenSearchView:onExit()
	AnnualFubenSearchView.super.onExit(self)
	removetimer(self._onClock, self)
	GameUtil.clearCells(self._event, self._clearNpcCell, self, false)
end

function AnnualFubenSearchView:onEnter()
	AnnualFubenSearchView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AnnualFubenGainClueRes, self._handlePM_AnnualFubenGainClueRes, self)

	self._activityId = checknumber(self:getFirstParam())
	self._selectConList = {}

	self:_refreshView()
end

function AnnualFubenSearchView:_refreshView()
	self:_initTimer()

	local npcList = {}
	local cfgs = AnnualFubenConfig.instance:getClueCfgs(self._activityId)

	for i, v in ipairs(cfgs) do
		if v.initClue == true then
			table.insert(npcList, v)
		end
	end

	table.clear(self._selectConList)
	GameUtil.updateCellsList(self._event, self._eventCon, npcList, self._updateNpcCell, self)
	self._posRecord:LoadPlan(0)

	local todayTimes = AnnualFubenModel.instance:getSearchClueTime(self._activityId)
	local actCfg = AnnualFubenConfig.instance:getActivityCfg(self._activityId)
	local curTimes = actCfg.dailyClue - todayTimes

	self._txtSearchTime.text = langPara("剩余次数:%d/%d", curTimes, actCfg.dailyClue)
end

function AnnualFubenSearchView:_updateNpcCell(cell, data, index)
	local go = cell.gameObject
	local infoGo = goutil.findChild(go, "info")
	local iconGo = goutil.findChild(infoGo, "icon")
	local selectGo = goutil.findChild(infoGo, "select")
	local emptyGo = goutil.findChild(infoGo, "empty")
	local isGain = AnnualFubenModel.instance:isGainClue(self._activityId, data.clueId)
	local isGanUnlock = not isGain

	GameUtil.SetActive(selectGo, false)
	GameUtil.SetActive(emptyGo, isGanUnlock)
	GameUtil.SetActive(iconGo, isGain)
	uGuiUtil.clearImage(iconGo)

	if not isGain then
		self._selectConList[data.clueId] = selectGo
	end

	if isGain then
		uGuiUtil.setSpriteToImage(iconGo, nil, data.iconRes)
	end
end

function AnnualFubenSearchView:_clearNpcCell(cell, index)
	local go = cell.gameObject
	local infoGo = goutil.findChild(go, "info")
	local iconGo = goutil.findChild(infoGo, "icon")

	uGuiUtil.clearImage(iconGo)
end

function AnnualFubenSearchView:_refreshClockInfo(curPrecent, curProgress, curShowTime)
	self._txtWorldTime.text = GameUtil.FormatTimeSymbol(curShowTime)
end

function AnnualFubenSearchView:_initTimer()
	self._curProgressId, self._precentStart, self._startProgressTime, self._nexProgressId, self._nextProgressTime, self._precentEnd = AnnualFubenController.instance:getWorldProgressCfgInfo(self._activityId)

	removetimer(self._onClock, self)

	local curTime = ServerTime.now()

	self:_onClock()

	if self._nextProgressTime and curTime < self._nextProgressTime then
		settimer(1, self._onClock, self, true)
	end
end

function AnnualFubenSearchView:_onClock()
	local curTime = ServerTime.now()

	if not self._nextProgressTime then
		local curPrecent, curProgress, curShowTime = AnnualFubenController.instance:getWorldProgressInfo(self._activityId, self._curProgressId, self._precentStart, self._startProgressTime, self._nexProgressId, self._nextProgressTime, self._precentEnd)

		self:_refreshClockInfo(curPrecent, curProgress, curShowTime)
	elseif curTime < self._nextProgressTime then
		local curPrecent, curProgress, curShowTime = AnnualFubenController.instance:getWorldProgressInfo(self._activityId, self._curProgressId, self._precentStart, self._startProgressTime, self._nexProgressId, self._nextProgressTime, self._precentEnd)

		self:_refreshClockInfo(curPrecent, curProgress, curShowTime)
	else
		self:_initTimer()
	end
end

function AnnualFubenSearchView:_showSelectEffect()
	self._showStart = true

	local showKeys = table.keys(self._selectConList)

	if #showKeys > 1 then
		self._result = {}

		local preArray = {}
		local array = {}

		for i, v in ipairs(showKeys) do
			table.insert(array, v)
			table.insert(preArray, v)
		end

		local totalNum = 40
		local times = math.ceil(totalNum / #showKeys)

		for i = 1, times do
			GameUtil.permuteArray(array)

			if array[#array] == preArray[1] then
				array[#array] = array[1]
				array[1] = array[#array]
			end

			for i, v in ipairs(array) do
				table.insert(self._result, v)
			end

			preArray = array
			array = preArray
		end

		if self._result[#self._result] ~= self._playClueId then
			table.insert(self._result, self._playClueId)
		end

		self._showIndex = 1

		settimer(0.1, self._showNextEffext, self, true)
	else
		self:_showSelectEndEffect()
	end
end

function AnnualFubenSearchView:_showNextEffext()
	GameUtil.SetActive(self._selectConList[self._result[self._showIndex]], false)

	self._showIndex = self._showIndex + 1

	if self._result[self._showIndex] then
		GameUtil.SetActive(self._selectConList[self._result[self._showIndex]], true)
	else
		removetimer(self._showNextEffext, self)
		self:_showSelectEndEffect()
	end
end

function AnnualFubenSearchView:_showSelectEndEffect()
	GameUtil.SetActive(self._selectConList[self._playClueId], true)

	local tween1 = UnityTweens.UITweenFadeOut.Create(self._selectConList[self._playClueId], 0.1, UnityTweens.EaseType.linear, 0.5)
	local tween2 = UnityTweens.UITweenFadeIn.Create(self._selectConList[self._playClueId], 0.1, UnityTweens.EaseType.linear, 0.1)
	local tween3 = UnityTweens.UITweenFadeOut.Create(self._selectConList[self._playClueId], 0.1, UnityTweens.EaseType.linear, 0.5)
	local tween4 = UnityTweens.UITweenFadeIn.Create(self._selectConList[self._playClueId], 0.1, UnityTweens.EaseType.linear, 0.1)
	local tween5 = UnityTweens.TweenEmpty.Create(self._selectConList[self._playClueId], 0.5)
	local sequence = UnityTweens.TweenSequence.StartTween(self._selectConList[self._playClueId], tween1, tween2, tween3, tween4, tween5)

	sequence:AddListener(function()
		self:_onShowEffectEnd()
	end)
end

function AnnualFubenSearchView:_onClickLink()
	if self._showStart == true then
		return
	end

	local showCons = table.values(self._selectConList)
	local todayTimes = AnnualFubenModel.instance:getSearchClueTime(self._activityId)
	local actCfg = AnnualFubenConfig.instance:getActivityCfg(self._activityId)
	local curTimes = actCfg.dailyClue - todayTimes

	if curTimes <= 0 then
		FloatWordMgr.instance:show(lang("今日已无搜寻次数"))
	elseif #showCons > 0 then
		AnnualFubenAgent.instance:sendPM_AnnualFubenGainClueReq(self._activityId)
	else
		FloatWordMgr.instance:show(lang("无可链接角色"))
	end
end

function AnnualFubenSearchView:_onShowEffectEnd()
	GameUtil.SetActive(self._selectConList[self._playClueId], false)
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._endStory, self)

	local clueCfg = AnnualFubenConfig.instance:getClueCfg(self._activityId, self._playClueId)

	GlobalDispatcher:dispatch(GlobalNotify.StartStory, clueCfg.storyId)
end

function AnnualFubenSearchView:_endStory()
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._endStory, self)

	self._showStart = false
	self._playClueId = nil

	self:_refreshView()
end

function AnnualFubenSearchView:_onClickClose()
	if not self._showStart then
		self:close()
	end
end

function AnnualFubenSearchView:_onClickTip()
	if not self._showStart then
		TipsFacade.instance:openRulesView("annual_fuben_chapter_one_rule")
	end
end

function AnnualFubenSearchView:_handlePM_AnnualFubenGainClueRes(clueId)
	self._playClueId = clueId

	self:_showSelectEffect()
end

return AnnualFubenSearchView
