-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenChapterThreeView.lua

module("logic.extensions.annualfuben.view.AnnualFubenChapterThreeView", package.seeall)

local AnnualFubenChapterThreeView = class("AnnualFubenChapterThreeView", ViewComponent)

function AnnualFubenChapterThreeView:ctor()
	AnnualFubenChapterThreeView.super.ctor(self)
end

function AnnualFubenChapterThreeView:unbindEvents()
	AnnualFubenChapterThreeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnPlayStory)
	GameUtil.rmClickHandler(self._btnTip)
end

function AnnualFubenChapterThreeView:bindEvents()
	AnnualFubenChapterThreeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnPlayStory, self._onClickPlayStory, self)
end

function AnnualFubenChapterThreeView:buildUI()
	AnnualFubenChapterThreeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnRank = self:getGo("btnRank")
	self._txtTime = self:getTxt("worldTime/txtTime")
	self._btnTip = self:getGo("btnTip")
	self._btnStart = self:getGo("btnStart")
	self._rewardtableviewGo = self:getGo("progressReward/tableview")
	self._rewardCellGo = self:getGo("progressReward/rewardCell")
	self._rewardScrollList = ScrollerList.create(self._rewardtableviewGo, self._rewardCellGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._progressBar = self:getSlider("progressReward/tableview/Viewport/Content/progressBar")
	self._txtCount = self:getTxt("progressReward/total/txt")
	self._txtBuff = self:getTxt("buff/txtBuff")
	self._txtTodayDamage = self:getTxt("txtTodayDamage")
	self._sliderStory_1 = self:getSlider("slider_1")
	self._sliderStory_2 = self:getSlider("slider_2")
	self._txtLackPrecent = self:getTxt("txtLackPrecent")
	self._txtCurPrecent = self:getTxt("txtCurPrecent")
	self._btnPlayStory = self:getGo("btnPlayStory")
end

function AnnualFubenChapterThreeView:onExit()
	AnnualFubenChapterThreeView.super.onExit(self)
	removetimer(self._onClock, self)

	if self._effectBtn then
		UIEffectManager.instance:stopEffect(self._effectBtn)

		self._effectBtn = nil
	end
end

function AnnualFubenChapterThreeView:onEnter()
	AnnualFubenChapterThreeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AnnualFubenInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._activityCfg = AnnualFubenConfig.instance:getActivityCfg(self._activityId)

	self:_refreshView()

	if not AnnualFubenModel.instance:getFirstEnterChapterThree(self._activityId) then
		AnnualFubenModel.instance:setFirstEnterChapterThree(self._activityId)
		GlobalDispatcher:dispatch(GlobalNotify.StartStory, self._activityCfg.chapterThreeStoryId)
	end
end

function AnnualFubenChapterThreeView:_refreshView()
	self:_initTimer()
	self:_setProgressReward()

	local curPassBrokenStageId = AnnualFubenModel.instance:getBrokenStageId(self._activityId)
	local brokenStageCfg = AnnualFubenConfig.instance:getBrokenStageCfg(self._activityId, curPassBrokenStageId)

	self._txtBuff.text = brokenStageCfg and langPara("规则化身-打破规则战胜敌阵数量：%d，在本挑战中获得增益：%s", curPassBrokenStageId, brokenStageCfg.buffDesc) or langPara("规则化身-打破规则战胜敌阵数量：%d，在本挑战中获得增益：无", curPassBrokenStageId)
	self._txtTodayDamage.text = langPara("今日最高伤害\n%d", AnnualFubenModel.instance:getTodayBossDamage(self._activityId))
end

function AnnualFubenChapterThreeView:_refreshClockInfo(curPrecent, curProgress, curShowTime)
	self._txtTime.text = GameUtil.FormatTimeSymbol(curShowTime)
	self._curPrecent = curPrecent
	self._txtLackPrecent.text = langPara("%d%% 原则", math.ceil((1 - curPrecent) * 100))
	self._txtCurPrecent.text = langPara("信念 %d%%", math.floor(curPrecent * 100))

	self._sliderStory_1:SetValue(self._curPrecent)
	self._sliderStory_2:SetValue(1 - self._curPrecent)

	if self._curPrecent >= 1 and not AnnualFubenModel.instance:getReadChapterThreeStory(self._activityId) and not self._effectBtn then
		local path = "fx_ui_yongzhezhita/fx_ui_yongzhezhita_xuanzhuan.prefab"

		local function loadHandler(target, eff)
			eff:setClipping(self.mainGO:GetComponent(goutil.Type_RectTransform))
		end

		self._effectBtn = UIEffectManager.instance:playEffect(self, path, self._btnPlayStory.transform, 0, 0, true, false, nil, loadHandler)

		self._effectBtn:setParent(self._btnPlayStory.transform)
		self._effectBtn:setScale(1)
		self._effectBtn:setLocalPos(0, 0, 0)
	elseif self._effectBtn then
		UIEffectManager.instance:stopEffect(self._effectBtn)

		self._effectBtn = nil
	end
end

function AnnualFubenChapterThreeView:_initTimer()
	self._curProgressId, self._precentStart, self._startProgressTime, self._nexProgressId, self._nextProgressTime, self._precentEnd = AnnualFubenController.instance:getWorldProgressCfgInfo(self._activityId)

	removetimer(self._onClock, self)

	local curTime = ServerTime.now()

	self:_onClock()

	if self._nextProgressTime and curTime < self._nextProgressTime then
		settimer(1, self._onClock, self, true)
	end
end

function AnnualFubenChapterThreeView:_onClock()
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

function AnnualFubenChapterThreeView:_setProgressReward()
	local prizeList = AnnualFubenConfig.instance:getBossPrizeCfgs(self._activityId)
	local damage = AnnualFubenModel.instance:getBossDamage(self._activityId)

	self._lotteryCount = damage

	local idx = -1
	local scoreArr = {}

	for i, v in ipairs(prizeList) do
		table.insert(scoreArr, checknumber(v.damage))

		local isCanGet = self._lotteryCount >= checknumber(v.damage)
		local isGainPrize = AnnualFubenModel.instance:isGainBossDamagePrize(self._activityId, v.prizeId)

		if isCanGet and not isGainPrize and idx == -1 then
			idx = i - 1
		end
	end

	self._rewardScrollList:reloadData(prizeList)
	self._rewardScrollList:updateUnderSlider(self._progressBar, self._lotteryCount, scoreArr)
	self._rewardScrollList:MoveCellToCenter(idx == -1 and 0 or idx)

	self._txtCount.text = langPara("%s", damage)
end

function AnnualFubenChapterThreeView:_updateRewardCell(view, cell, data, tag)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local received = goutil.findChild(go, "received")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local canGet = goutil.findChild(go, "canGet")
	local effect = goutil.findChild(go, "effect")

	MaterialMgr.resetAll(item)
	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = langPara("%s", MmUtil.formatNumber(checknumber(data.damage), MmUtil.Units_CN))

	local isCanGet = self._lotteryCount >= checknumber(data.damage)
	local isGainPrize = AnnualFubenModel.instance:isGainBossDamagePrize(self._activityId, data.prizeId)

	GameUtil.SetActive(canGet, isCanGet and not isGainPrize)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
end

function AnnualFubenChapterThreeView:_onClickGetPrize(data)
	local isCanGet = self._lotteryCount >= checknumber(data.damage)
	local isGainPrize = AnnualFubenModel.instance:isGainBossDamagePrize(self._activityId, data.prizeId)

	if isCanGet and not isGainPrize then
		AnnualFubenAgent.instance:sendPM_AnnualFubenGainBossPrizeReq(self._activityId, data.prizeId)
	end
end

function AnnualFubenChapterThreeView:_clearRewardCell(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local effect = goutil.findChild(go, "effect")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effect)
end

function AnnualFubenChapterThreeView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("progressReward/tableview/Viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function AnnualFubenChapterThreeView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function AnnualFubenChapterThreeView:_onClickRank()
	UIStateManager.instance:push(ViewName.AnnualFubenDamageRankView, self._activityId)
end

function AnnualFubenChapterThreeView:_onClickStart()
	AnnualFubenController.instance:openBossMissionView(self._activityId)
end

function AnnualFubenChapterThreeView:_onClickPlayStory()
	if self._curPrecent < 1 then
		FloatWordMgr.instance:show(lang("当前进度不足，无法说服，前往挑战黑创增加进度吧"))
	else
		if not AnnualFubenModel.instance:getReadChapterThreeStory(self._activityId) then
			AnnualFubenModel.instance:setReadChapterThreeStory(self._activityId)
		end

		GlobalDispatcher:dispatch(GlobalNotify.StartStory, self._activityCfg.chapterThreeEndStoryId)
	end
end

function AnnualFubenChapterThreeView:_onClickTip()
	TipsFacade.instance:openRulesView("annual_fuben_chapter_three_rule")
end

return AnnualFubenChapterThreeView
