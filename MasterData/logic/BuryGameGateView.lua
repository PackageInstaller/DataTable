-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/BuryGameGateView.lua

module("logic.extensions.burygame.view.BuryGameGateView", package.seeall)

local BuryGameGateView = class("BuryGameGateView", ViewComponent)

function BuryGameGateView:unbindEvents()
	BuryGameGateView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnAddTimes:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function BuryGameGateView:bindEvents()
	BuryGameGateView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnAddTimes:AddClickListener(self._onClickAddTimes, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function BuryGameGateView:onExit()
	BuryGameGateView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.BuryGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.BuryBuyTimesRes, self._onBuyTimesRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.BuryGainPrizeRes, self._onGainPrizeRes, self)
	removetimer(self._onTicking, self)

	for _, eff in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	removetimer(self._randomBubble, self)

	self._effs = nil

	if self._canGainEffs then
		for _, v in ipairs(self._canGainEffs) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._canGainEffs = nil
end

function BuryGameGateView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "burygamegate1")
end

function BuryGameGateView:buildUI()
	BuryGameGateView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._slider = self:getGo("GameObject/ViewPort/Content/progressBar"):GetComponent(typeof(UnityEngine.UI.Slider))
	self._gridLayout = self:getGo("GameObject/ViewPort/Content/prizes"):GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._content = self:getGo("GameObject/ViewPort/Content"):GetComponent(typeof(UnityEngine.RectTransform))
	self._bar = DiscreteProgressBar.New(self._slider, self._gridLayout)
	self._txtCurScore = self:getTxt("score/Text")
	self._btnRank = self:getBtn("btnRank")
	self._btnStart = self:getBtn("btnStart")
	self._txtRemainingTime = self:getTxt("time/txtTime")
	self._btnAddTimes = self:getBtn("remaining/btnAdd")
	self._txtRemainingTimes = self:getTxt("remaining/txtCount")
	self._btnTip = self:getBtn("btnTip")
	self._txtBubble = self:getGo("bubble/Text"):GetComponent(typeof(TypewriterText))
	self._viewPort = self:getGo("GameObject/ViewPort"):GetComponent(typeof(UnityEngine.RectTransform))
end

function BuryGameGateView:onEnterFinished()
	BuryGameGateView.super.onEnterFinished(self)

	local key = "BURY_GAME_GATE_VIEW"
	local value = GameUtil.getUserData(key)

	if checknumber(value) <= 0 then
		GameUtil.saveUserData(key, 1)
		UIStateManager.instance:push(ViewName.BuryGameLetterView)
	end

	self:_randomBubble()
	settimer(2, self._randomBubble, self, true)
end

function BuryGameGateView:_randomBubble()
	local cfgs = BuryGameConfig.instance:getBubbleCfgs()
	local randomCfg = cfgs[math.random(1, #cfgs)]

	self._txtBubble:SetText(randomCfg.content)
end

function BuryGameGateView:onEnter()
	BuryGameGateView.super.onEnter(self)

	self._effs = {}

	local activityId = BuryGameModel.instance:getActivityId()

	self._gameCfg = BuryGameConfig.instance:getCfgById(activityId)

	self:_updateProgressBar()
	GlobalDispatcher:addListener(GlobalNotify.BuryGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.BuryBuyTimesRes, self._onBuyTimesRes, self)
	GlobalDispatcher:addListener(GlobalNotify.BuryGainPrizeRes, self._onGainPrizeRes, self)
	BuryGameController.instance:sendGetInfoReq()

	_, self._endTimeStamp = ActivityDefineController:getStartTimeAndEndTime(GameEnum.ActivityType.BuryGame, activityId)

	settimer(0.5, self._onTicking, self)

	local url = "fx_ui_yirenzhixia/fx_ui_yirenzhixia_zhujiemian.prefab"

	table.insert(self._effs, self:_playEffect(url, self.mainGO))
end

function BuryGameGateView:_onGetInfoRes()
	self:_updateProgressBar()
	self:_updateRemainingTimes()
end

function BuryGameGateView:_updateRemainingTimes()
	local freeTimes = BuryGameConfig.instance:getConstantValue("DAILY_FREE_GAME_TIMES")
	local todayGameTimes = BuryGameModel.instance:getUsedTimes()
	local buyTimes = BuryGameModel.instance:getBuyedTimes()
	local remainingTimes = freeTimes + buyTimes - todayGameTimes

	self._hasRemaingTimes = remainingTimes > 0
	self._txtRemainingTimes.text = string.format("今日剩余次数：%d/%d", remainingTimes, freeTimes)

	self._btnAddTimes.gameObject:SetActive(not self._hasRemaingTimes)
	uGuiUtil.setGoGrayState(self._btnStart.gameObject, false)

	if not self._hasRemaingTimes then
		local planCfg = BuryGameConfig.instance:getBuyPlanCfg(self._gameCfg.buyGameTimesPlan)
		local buyCfg

		if planCfg then
			buyCfg = planCfg[buyTimes + 1]
		end

		if buyCfg then
			_, _, self._costNum = unpack(string.splitToNumber(buyCfg.consume, ":"))
		else
			self._costNum = 0
		end

		local remainingBuyTimes = #planCfg - buyTimes

		self._hasRemaingBuyTimes = remainingBuyTimes > 0

		self._btnAddTimes.gameObject:SetActive(self._hasRemaingBuyTimes)

		self._tipsContent = string.format("今日没有免费次数了，确定花费%d钻购买游戏次数吗？\n每天最多可购买%d次，还能购买%d次", self._costNum, #planCfg, remainingBuyTimes)

		uGuiUtil.setGoGrayState(self._btnStart.gameObject, not self._hasRemaingBuyTimes)
	end
end

function BuryGameGateView:_onClickAddTimes(callback)
	TipsFacade:openPopupCostDiamondView(self._costNum, self._tipsContent, function()
		BuryGameController.instance:sendBuyTimesReq()
	end)
end

function BuryGameGateView:_updateProgressBar()
	local totalScore = BuryGameModel.instance:getTotalScore()
	local scores = {}
	local prizeCfgs = BuryGameConfig.instance:getPrizeCfgs(self._gameCfg.scorePrizePlan)

	for _, v in ipairs(prizeCfgs) do
		table.insert(scores, v.needScore)
	end

	local x = self._bar:setValue(scores, totalScore)

	self._content.sizeDelta = Vector2.New(x + 70, 100)
	self._txtCurScore.text = totalScore

	if self._canGainEffs then
		for _, v in ipairs(self._canGainEffs) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._canGainEffs = {}

	GameUtil.updateCellsWithCreate(self._gridLayout, prizeCfgs, self._updateOnePrize, self)
end

function BuryGameGateView:_updateOnePrize(go, cfg)
	local itemPoint = goutil.findChild(go, "item/itemcell")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local received = goutil.findChild(go, "item/received")

	MaterialMgr.setCellByCfg(cfg.prize, itemPoint)

	local btn = Framework.ButtonAdapter.GetFrom(go, "btn")

	txtNum.text = cfg.needScore

	local gained = BuryGameModel.instance:isGainedById(cfg.prizeId)

	received:SetActive(gained)

	local canGain = cfg.needScore <= BuryGameModel.instance:getTotalScore()

	if canGain and not gained then
		local url = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"
		local eff = self:_playEffect(url, go, 0.7, true)

		table.insert(self._canGainEffs, eff)
		btn.gameObject:SetActive(true)
		btn:AddClickListener(function()
			self:_onClickPrize(cfg.prizeId)
		end)
	end
end

function BuryGameGateView:_onClickPrize(prizeId)
	BuryGameController.instance:sendGainPrizeReq(prizeId)
end

function BuryGameGateView:_onGainPrizeRes()
	self:_updateProgressBar()
	FloatWordMgr.instance:show("领取成功")
end

function BuryGameGateView:_playEffect(url, parent, scale, needSetClip)
	return (UIEffectManager.instance:playEffect(self, url, parent, 0, 0, true, nil, nil, function(self2, uiEffect)
		if needSetClip then
			uiEffect:setClipping(self._viewPort)
		end

		uiEffect:setParent(parent.transform)
		uiEffect:setScale(scale or 1)

		local rectTrans = uiEffect.effGo:GetComponent(typeof(UnityEngine.RectTransform))

		Framework.TransformUtil.SetAnchoredPos(rectTrans, 0, 0)
	end))
end

function BuryGameGateView:_onTicking()
	local remainingTime = self._endTimeStamp - ServerTime.now()

	self._txtRemainingTime.text = string.format("活动剩余时间：%s", GameUtil.FormatTimeSymbol(remainingTime))
end

function BuryGameGateView:_onClickStart()
	if self._hasRemaingTimes then
		self:_enterMainView()
	elseif self._hasRemaingBuyTimes then
		self._onClickAddTimes(self, self._enterMainView, self)
	else
		FloatWordMgr.instance:show("今日次数用完，次日5点重置！")
	end
end

function BuryGameGateView:_enterMainView()
	UIStateManager.instance:push(ViewName.BuryGameMainView)
end

function BuryGameGateView:_onBuyTimesRes()
	self:_updateRemainingTimes()
	FloatWordMgr.instance:show("购买成功~")
end

function BuryGameGateView:_onClickRank()
	UIStateManager.instance:push(ViewName.BuryGameRankView)
end

return BuryGameGateView
