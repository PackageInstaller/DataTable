-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anmoyangame/view/AnMoYanMainView.lua

module("logic.extensions.anmoyangame.view.AnMoYanMainView", package.seeall)

local AnMoYanMainView = class("AnMoYanMainView", ViewComponent)

function AnMoYanMainView:buildUI()
	AnMoYanMainView.super.buildUI(self)

	self._con = self:getGo("con")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtTime = self:getTxt("time/txt")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._rewardcell = self:getGo("scorollReward/rewardcell")
	self._tableview = self:getGo("scorollReward/tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._rewardcell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._txtProgress = self:getTxt("total/txtProgress")
	self._progressSlider = self:getSlider("scorollReward/tableview/viewport/content/progressSlider")
	self._txtPlayTimes = self:getTxt("playTimes/txt")
	self._redpoint = self:getGo("btnStart/redpoint")
	self._btnStart = self:getGo("btnStart")
	self._tipsRoot = self:getGo("tipsRoot")
end

function AnMoYanMainView:bindEvents()
	AnMoYanMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function AnMoYanMainView:unbindEvents()
	AnMoYanMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnTip)
end

function AnMoYanMainView:onEnter()
	AnMoYanMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DarkMoYanGameInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_DarkMoYanGameGainProgressPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_DarkMoYanGameSweepRes, self._handlePM_DarkMoYanGameSweepRes, self)
	self.addGEvent(self, GlobalNotify.PM_DarkMoYanGameStartGameRes, self._handleStartGame, self)

	self._activityType = AnMoYanController.instance:getActivityType()

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = AnMoYanController.instance:getActivityId()
	end

	self._actcfg = AnMoYanConfig.instance:getActCfg(self._activityId)
	self._isBelongSweep = AnnuityPrivilegeController.instance:isBelongSweep(self._activityId)
	self._info = AnMoYanModel.instance:getInfo(self._activityId)

	self:_onSetUI()
	AnMoYanController.instance:sendPM_DarkMoYanGameInfoReq(self._activityId)
end

function AnMoYanMainView:onExit()
	AnMoYanMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self._scrollList:dispose()
end

function AnMoYanMainView:_handlePM_DarkMoYanGameSweepRes()
	local addScore = checknumber(self._info.totalScore) - checknumber(self._oldSweepTotalScore)

	FloatWordMgr.instance:show(string.format("扫荡成功！获得积分：%s", addScore))
	self:_onUpdate()
end

function AnMoYanMainView:_onSetUI()
	if self._txtTime then
		self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end

	local skinId = self._actcfg.skinId

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	AnnuityPrivilegeController.instance:addAnnuityPrivilegeSweepTipsView(self._tipsRoot, self._viewPresentor, self._activityId)
end

function AnMoYanMainView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function AnMoYanMainView:_updateData()
	self._info = AnMoYanModel.instance:getInfo(self._activityId)
end

function AnMoYanMainView:_updateUI()
	if not self._info.gainPrizeIds then
		if not self._info.totalScore then
			local totalScore = 0
			local dailyGameTimes = self._actcfg.dailyGameTime
			local todayGameTimes = self._info.dailyTimes
			local leftGameTime = dailyGameTimes - todayGameTimes
			local list = AnMoYanConfig.instance:getProgressCfg(self._activityId)

			self._scrollList:reloadData(list)

			self._txtProgress.text = totalScore
			self._txtPlayTimes.text = "剩余游戏次数:" .. leftGameTime .. "/" .. dailyGameTimes

			GameUtil.SetActive(self._redpoint, todayGameTimes < dailyGameTimes)

			local scoreList = {}

			for i, v in ipairs(list) do
				table.insert(scoreList, v.progress)
			end

			self._scrollList:updateUnderSlider(self._progressSlider, self._info.totalScore, scoreList)
		end
	end
end

function AnMoYanMainView:_updateRewardCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effect = goutil.findChild(cell, "effect")
	local hasGet = false

	if not self._info.totalScore then
		local finishIds = {}
		local isCanGet = finishIds >= data.progress

		if not self._info.gainPrizeIds then
			local gainPrizeIds = {}

			hasGet = table.indexof(gainPrizeIds, data.id) ~= false
			txtScore.text = data.progress

			MaterialMgr.setCellByCfg(data.prize, item)
			GameUtil.SetActive(geted, hasGet)
			GameUtil.SetActive(btnGet, isCanGet and not hasGet)
			self:_clearCellEffect(effect)

			if isCanGet and not hasGet then
				self:_playCellEffect(effect)
			end

			GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
		end
	end
end

function AnMoYanMainView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")
	local btnGet = goutil.findChild(cell, "btnGet")

	MaterialMgr.resetAll(item)
	self:_clearCellEffect(effect)
	GameUtil.rmClickHandler(btnGet)
end

local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

function AnMoYanMainView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("scorollReward/tableview/viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function AnMoYanMainView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function AnMoYanMainView:_onClickBtnTip()
	local key = self._actcfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function AnMoYanMainView:_onClickGetPrize(data)
	if not self._info.gainPrizeIds then
		local gainPrizeIds = {}
		local hasGet = table.indexof(gainPrizeIds, data.id) ~= false

		if not hasGet then
			if not self._info.totalScore then
				local finishIds = {}
				local isCanGet = finishIds >= data.progress

				if isCanGet then
					AnMoYanController.instance:sendPM_DarkMoYanGameGainProgressPrizeReq(self._activityId, data.id)
				else
					TipsFacade.instance:openCommonTips("还没达到条件哦~")
				end
			end
		end
	end
end

function AnMoYanMainView:_onClickBtnStart()
	local maxScore = checknumber(self._info.maxScore)
	local isHasPassFirst = maxScore > 0

	if self._isBelongSweep and isHasPassFirst then
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
				self:_startGame()
			end

			local otherCallBack
			local maxCoinNum = checknumber(self._actcfg.dailyGameTime)

			local function updateCoinTxtCallBack(view)
				view:getTxtCoin().text = string.format("游戏次数：%s/%s", view:getCurCoinNum(), maxCoinNum)
			end

			local passGetScore = maxScore

			local function updateDescTxtCallBack(view)
				view:getTxtDesc().text = string.format("您已首通完毕，是否扫荡获得进度？\n当前可获得积分：<color=#0068b7>%s</color>", passGetScore * view:getCurTimes())
			end

			local left = self:_getLeftTimes()

			TipsFacade.instance:openPopupCommonCostPopView(left, 1, "开始游戏", "扫荡", "直接开始", descTxt, sureCallBack, cancelCallBack, otherCallBack, updateCoinTxtCallBack, updateDescTxtCallBack)
		else
			self:_startGame()
		end
	else
		self:_startGame()
	end
end

function AnMoYanMainView:_sweepGame(activityId, times)
	local result = self:getTrySweepGameResultAndTips(true, activityId, times)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	self._oldSweepTotalScore = checknumber(self._info.totalScore)

	AnMoYanController.instance:sendPM_DarkMoYanGameSweepReq(activityId, times)
end

function AnMoYanMainView:_startGame()
	if self:_getLeftTimes() <= 0 then
		FloatWordMgr.instance:show("今日剩余游戏次数为0")

		return
	end

	AnMoYanController.instance:sendPM_DarkMoYanGameStartGameReq(self._activityId)
end

function AnMoYanMainView:getTrySweepGameResultAndTips(isNeedTips, activityId, times)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		local isCanSweep = AnnuityPrivilegeController.instance:isCanSweep(activityId)

		if not isCanSweep then
			result = GameEnum.ResultCode.Error
		end
	end

	if result == GameEnum.ResultCode.Success then
		local leftTimes = self:_getLeftTimes()

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

function AnMoYanMainView:_handleStartGame()
	UIStateManager.instance:push(ViewName.AnMoYanGameView, self._activityId)
end

function AnMoYanMainView:_getLeftTimes()
	local dailyGameTimes = self._actcfg.dailyGameTime
	local todayGameTimes = checknumber(self._info.dailyTimes)

	return Mathf.Max(dailyGameTimes - todayGameTimes, 0)
end

return AnMoYanMainView
