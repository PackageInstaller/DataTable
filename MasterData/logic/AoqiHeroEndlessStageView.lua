-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroEndlessStageView.lua

module("logic.extensions.aoqihero.view.AoqiHeroEndlessStageView", package.seeall)

local AoqiHeroEndlessStageView = class("AoqiHeroEndlessStageView", ViewComponent)

function AoqiHeroEndlessStageView:ctor()
	AoqiHeroEndlessStageView.super.ctor(self)
end

function AoqiHeroEndlessStageView:unbindEvents()
	AoqiHeroEndlessStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnStrengthen)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function AoqiHeroEndlessStageView:bindEvents()
	AoqiHeroEndlessStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnStrengthen, self._onClickStrengthen, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AoqiHeroEndlessStageView:buildUI()
	AoqiHeroEndlessStageView.super.buildUI(self)

	self._rewardtableviewGo = self:getGo("progressReward/tableview")
	self._rewardCellGo = self:getGo("progressReward/rewardCell")
	self._rewardScrollList = ScrollerList.create(self._rewardtableviewGo, self._rewardCellGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._progressBar = self:getSlider("progressReward/tableview/Viewport/Content/progressBar")
	self._txtCount = self:getTxt("progressReward/total/txt")
	self._btnStrengthen = self:getGo("btnStrengthen")
	self._btnRank = self:getGo("btnRank")
	self._btnStart = self:getGo("btnStart")
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
end

function AoqiHeroEndlessStageView:onExit()
	AoqiHeroEndlessStageView.super.onExit(self)
end

function AoqiHeroEndlessStageView:onEnter()
	AoqiHeroEndlessStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroEndlessGainPrizeRes, self._setProgressReward, self)
	self.addGEvent(self, GlobalNotify.PM_NotifyAoQiHeroEndlessChallengeEndRes, self._setProgressReward, self)

	self._activityId = checknumber(self:getFirstParam())

	self:_setProgressReward()
end

function AoqiHeroEndlessStageView:_setProgressReward()
	local prizeList = AoQiHeroConfig.instance:getEndlessPrizeCfg(self._activityId)
	local maxStageId, minCircleNum = AoQiHeroModel.instance:getEndlessStageInfo(self._activityId)

	self._lotteryCount = maxStageId

	local idx = -1
	local scoreArr = {}

	for i, v in ipairs(prizeList) do
		table.insert(scoreArr, v.stageId)

		local isCanGet = self._lotteryCount >= v.stageId
		local isGainPrize = AoQiHeroModel.instance:getEndlessGainPrize(self._activityId, v.prizeId)

		if isCanGet and not isGainPrize and idx == -1 then
			idx = i - 1
		end
	end

	self._rewardScrollList:reloadData(prizeList)
	self._rewardScrollList:updateUnderSlider(self._progressBar, self._lotteryCount, scoreArr)
	self._rewardScrollList:MoveCellToCenter(idx == -1 and 0 or idx)

	self._txtCount.text = langPara("%d关%d回合", maxStageId, minCircleNum)
end

function AoqiHeroEndlessStageView:_updateRewardCell(view, cell, data, tag)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local received = goutil.findChild(go, "received")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local canGet = goutil.findChild(go, "canGet")
	local effect = goutil.findChild(go, "effect")

	MaterialMgr.resetAll(item)
	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = langPara("%d关", data.stageId)

	local isCanGet = self._lotteryCount >= data.stageId
	local isGainPrize = AoQiHeroModel.instance:getEndlessGainPrize(self._activityId, data.prizeId)

	GameUtil.SetActive(canGet, isCanGet and not isGainPrize)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
end

function AoqiHeroEndlessStageView:_onClickGetPrize(data)
	local isCanGet = self._lotteryCount >= data.stageId
	local isGainPrize = AoQiHeroModel.instance:getEndlessGainPrize(self._activityId, data.prizeId)

	if isCanGet and not isGainPrize then
		AoQiHeroAgent.instance:sendPM_AoQiHeroEndlessGainPrizeReq(self._activityId, data.prizeId)
	end
end

function AoqiHeroEndlessStageView:_clearRewardCell(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local effect = goutil.findChild(go, "effect")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effect)
end

function AoqiHeroEndlessStageView:_playEffect(effGo)
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

function AoqiHeroEndlessStageView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function AoqiHeroEndlessStageView:_onClickStart()
	if not AoQiHeroController.instance:isPassAllStage(self._activityId) then
		FloatWordMgr.instance:show(lang("请先通关全部普通关卡"))

		return
	end

	UIStateManager.instance:push(ViewName.AoQiHeroEndlessFmtView, self._activityId)
end

function AoqiHeroEndlessStageView:_onClickStrengthen()
	UIStateManager.instance:push(ViewName.AoqiHeroStrengthenView, self._activityId)
end

function AoqiHeroEndlessStageView:_onClickRank()
	UIStateManager.instance:push(ViewName.AoqiHeroRankView, self._activityId, 2)
end

function AoqiHeroEndlessStageView:_onClickTips()
	TipsFacade.instance:openRulesView("aoqi_hero_rule_endless")
end

return AoqiHeroEndlessStageView
