-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bricksxgame/view/BricksxgamemainView.lua

module("logic.extensions.bricksxgame.view.BricksxgamemainView", package.seeall)

local BricksxgamemainView = class("BricksxgamemainView", ViewComponent)

function BricksxgamemainView:ctor()
	BricksxgamemainView.super.ctor(self)
end

function BricksxgamemainView:unbindEvents()
	BricksxgamemainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnRank)
end

function BricksxgamemainView:bindEvents()
	BricksxgamemainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
end

function BricksxgamemainView:buildUI()
	BricksxgamemainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnRule = self:getGo("btnRule")
	self._btnChallenge = self:getGo("btnChallenge")
	self._btnRank = self:getGo("btnRank")
	self._txtLeaves = self:getTxt("txtLeaves")
	self._txtTime = self:getTxt("time/txt")
	self._txtTotal = self:getTxt("playerRoot/txtTotal")
	self._tipsRoot = self:getGo("tipsRoot")
	self._progressBar = self:getSlider("playerRoot/tableview/Viewport/Content/progressBar")
	self._tableview = self:getGo("playerRoot/tableview")
	self._rewardCell = self:getGo("playerRoot/rewardCell")
	self._rewardScrollList = ScrollerList.create(self._tableview, self._rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
end

function BricksxgamemainView:onExit()
	BricksxgamemainView.super.onExit(self)
end

function BricksxgamemainView:onEnter()
	BricksxgamemainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_XiaoXiaoLeGameSweepRes, self._handleSweepRes, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = BricksxgameController.instance:getDeafultActId()
	end

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._isBelongSweep = AnnuityPrivilegeController.instance:isBelongSweep(self._activityId)

	self.addGEvent(self, GlobalNotify.BRICKSXGAME_INFO_UPDATE, self._refreshUI, self)
	BricksxgameController.instance:sendGetInfo(self._activityId)
	AnnuityPrivilegeController.instance:addAnnuityPrivilegeSweepTipsView(self._tipsRoot, self._viewPresentor, self._activityId)
	self:_refreshUI()
end

function BricksxgamemainView:_refreshUI()
	local info = BricksxgameModel.instance:getInfo(self._activityId) or {}

	self._curScore = checknumber(info.score)
	self._maxScore = checknumber(info.maxScore)
	self._dailyTimes = checknumber(info.dailyTimes)
	self._gainPrizeIds = info.gainPrizeIds or {}

	local cfg = BricksxgameConfig.instance:getActivityCfgById(self._activityId) or {}
	local total = checknumber(cfg.dailyTimes)

	self._left = total - self._dailyTimes

	local prizeList = BricksxgameConfig.instance:getPorgressListById(self._activityId) or {}
	local idx = -1
	local scoreArr = {}

	for i, v in ipairs(prizeList) do
		table.insert(scoreArr, v.score)

		local isCanGet = self._curScore >= v.score
		local isGainPrize = table.indexof(self._gainPrizeIds, v.prizeId) ~= false

		if isCanGet and not isGainPrize and idx == -1 then
			idx = i - 1
		end
	end

	self._rewardScrollList:reloadData(prizeList)
	self._rewardScrollList:updateUnderSlider(self._progressBar, self._curScore, scoreArr)
	self._rewardScrollList:MoveCellToCenter(idx == -1 and 0 or idx)

	self._txtTotal.text = self._curScore
	self._txtLeaves.text = langPara("今日剩余次数：%s/%s", self._left, total)
end

function BricksxgamemainView:_onClickRule()
	TipsFacade.instance:openRulesView("bricksxgamemainview_rule")
end

function BricksxgamemainView:_onClickStart()
	if self._left <= 0 then
		TipsFacade.instance:openCommonTips("今日次数已经用完，下次再来吧")
	else
		local info = BricksxgameModel.instance:getInfo(self._activityId) or {}
		local isHasPassFirst = checknumber(info.dailyTimes) > 0

		if self._isBelongSweep and isHasPassFirst and self._maxScore > 0 then
			local isInitInfo = YearCardModel.instance:isInitInfo()

			if not isInitInfo then
				FloatWordMgr.instance:show("正在读取年费特权信息，请稍后再试")

				return
			end

			local sweepResult = self:getTrySweepGameResultAndTips(false, self._activityId, 1)

			if sweepResult == GameEnum.ResultCode.Success then
				local descTxt

				local function sureCallBack(view)
					self:_sweepGame(self._activityId, view:getCurTimes())
				end

				local function cancelCallBack(view)
					BricksxgameController.instance:sendStartGame(self._activityId)
				end

				local otherCallBack
				local cfg = BricksxgameConfig.instance:getActivityCfgById(self._activityId) or {}
				local maxCoinNum = checknumber(cfg.dailyTimes)

				local function updateCoinTxtCallBack(view)
					view:getTxtCoin().text = string.format("游戏次数：%s/%s", view:getCurCoinNum(), maxCoinNum)
				end

				local passGetScore = self._maxScore

				local function updateDescTxtCallBack(view)
					view:getTxtDesc().text = string.format("您已首通完毕，是否扫荡获得进度？\n当前可获得积分：<color=#0068b7>%s</color>", passGetScore * view:getCurTimes())
				end

				local left = self._left

				TipsFacade.instance:openPopupCommonCostPopView(left, 1, "开始游戏", "扫荡", "直接开始", descTxt, sureCallBack, cancelCallBack, otherCallBack, updateCoinTxtCallBack, updateDescTxtCallBack)
			else
				BricksxgameController.instance:sendStartGame(self._activityId)
			end
		else
			BricksxgameController.instance:sendStartGame(self._activityId)
		end
	end
end

function BricksxgamemainView:getTrySweepGameResultAndTips(isNeedTips, activityId, times)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		local isCanSweep = AnnuityPrivilegeController.instance:isCanSweep(activityId)

		if not isCanSweep then
			result = GameEnum.ResultCode.Error
		end
	end

	if result == GameEnum.ResultCode.Success then
		local leftTimes = self._left

		if leftTimes <= 0 or leftTimes < times then
			result = GameEnum.ResultCode.Error
			tips = "次数不足"
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function BricksxgamemainView:_sweepGame(activityId, times)
	local result = self:getTrySweepGameResultAndTips(true, activityId, times)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	BricksxgameController.instance:sendPM_XiaoXiaoLeGameSweepReq(activityId, self._maxScore, times)
end

function BricksxgamemainView:_onClickRank()
	UIStateManager.instance:push(ViewName.BricksxgamerankView, self._activityId)
end

function BricksxgamemainView:_onClickGetPrize()
	local isCanGetPrize = BricksxgameController.instance:hasCanGetPrize(self._activityId)

	if not isCanGetPrize then
		TipsFacade.instance:openCommonTips("没有可以领取的奖励")

		return
	end

	BricksxgameController.instance:sendGetPrize(self._activityId)
end

function BricksxgamemainView:_updateRewardCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.score

	local isCanGet = self._curScore >= data.score
	local isGainPrize = table.indexof(self._gainPrizeIds, data.prizeId) ~= false

	GameUtil.SetActive(canGet, isCanGet and not isGainPrize)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
end

function BricksxgamemainView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effect)
end

local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

function BricksxgamemainView:_playEffect(effGo)
	self:playViewEffectUniGo(effPath, effGo, self:getGo("playerRoot/tableview/Viewport").transform)
end

function BricksxgamemainView:_clearEffect(effGo)
	self:stopViewEffectUniGo(effGo)
end

function BricksxgamemainView:_handleSweepRes()
	FloatWordMgr.instance:show("扫荡成功!")
	self:_refreshUI()
end

return BricksxgamemainView
