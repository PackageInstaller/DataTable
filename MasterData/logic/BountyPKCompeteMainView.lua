-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountyPKCompeteMainView.lua

module("logic.extensions.bountypkcompete.view.BountyPKCompeteMainView", package.seeall)

local BountyPKCompeteMainView = class("BountyPKCompeteMainView", ViewComponent)

function BountyPKCompeteMainView:ctor()
	BountyPKCompeteMainView.super.ctor(self)
end

function BountyPKCompeteMainView:unbindEvents()
	BountyPKCompeteMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnExchange)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnRecord)
	GameUtil.rmClickHandler(self._btnDailyPrize)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnWish)
	self._tipsCustomInputComp:RemoveListener()
end

function BountyPKCompeteMainView:bindEvents()
	BountyPKCompeteMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnExchange, self._onClickExchange, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnRecord, self._onClickRecord, self)
	GameUtil.addClickHandler(self._btnDailyPrize, self._onClickDailyPrize, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnWish, self._onClickWish, self)
	self._tipsCustomInputComp:AddListener(self._tipsCustomInputChanged, self)
end

function BountyPKCompeteMainView:buildUI()
	BountyPKCompeteMainView.super.buildUI(self)

	self._btnClose = self:getBtn("left/btnClose")
	self._btnRule = self:getBtn("left/btnRule")
	self._btnTask = self:getBtn("left/btnTask")
	self._btnExchange = self:getBtn("left/btnExchange")
	self._btnRank = self:getBtn("left/btnRank")
	self._btnRecord = self:getBtn("left/btnRecord")
	self._btnDailyPrize = self:getBtn("left/btnDailyPrize")
	self._taskRedPoint = self:getGo("left/btnTask/redPoint")
	self._txtTitle = self:getTxt("left/txtTitle")
	self._myHeadCellGo = self:getGo("left/info/headcell")
	self._txtMyName = self:getTxt("left/info/txtName")
	self._txtMyScore = self:getTxt("left/info/txtScore")
	self._txtMyRank = self:getTxt("left/info/txtRank")
	self._bubbleItem = self:getGo("left/bubble/reward/item")
	self._txtBubbleDesc = self:getTxt("left/bubble/txtDesc")
	self._receiveGo = self:getGo("left/bubble/reward/receive")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtAd = self:getTxt("txtAd")
	self._btnWish = self:getBtn("down/btnWish")
	self._btnStart = self:getBtn("down/btnStart")
	self._tips = self:getGo("down/btnWish/tips")
	self._txtTips = self:getTxt("down/btnWish/tips/txt")
	self._goldBarCon = self:getGo("goldBarCon")
	self._con = self:getGo("left/petCon")
	self._mainEffectGo = self:getGo("effect")

	goutil.setActive(self._tips, false)

	self._tipsCustomInputComp = UICustomInput.Get(self._btnWish.gameObject)
end

function BountyPKCompeteMainView:onExit()
	BountyPKCompeteMainView.super.onExit(self)
	BountyPKCompeteController.instance:unregisterLocalNotify(BountyPKCompeteController.E_BountyPKGetInfoRes, self._updateAll, self)
	BountyPKCompeteController.instance:unregisterLocalNotify(BountyPKCompeteController.E_BountyPKDailyPrizeRes, self._updateAll, self)
	BountyPKCompeteController.instance:unregisterLocalNotify(BountyPKCompeteController.E_BountyPKDailyTaskPrizeRes, self._updateAll, self)
	HeadItemController.instance:resetHeadCell(self._myHeadCellGo)
	MaterialMgr.resetAll(self._bubbleItem)
	self:_removeMainEffect()
end

function BountyPKCompeteMainView:onEnter()
	BountyPKCompeteMainView.super.onEnter(self)
	BountyPKCompeteController.instance:registerLocalNotify(BountyPKCompeteController.E_BountyPKGetInfoRes, self._updateAll, self)
	BountyPKCompeteController.instance:registerLocalNotify(BountyPKCompeteController.E_BountyPKDailyPrizeRes, self._updateAll, self)
	BountyPKCompeteController.instance:registerLocalNotify(BountyPKCompeteController.E_BountyPKDailyTaskPrizeRes, self._updateAll, self)
	BountyPKCompeteAgent.instance:sendPM_BountyPKGetInfoReq()

	local seasonConfig = BountyPKCompeteConfig.instance:getSeasonConfig(BountyPKCompeteModel.instance:getActivityId())
	local buffConfigs = BountyPKCompeteConfig.instance:getBuffConfigs(seasonConfig.buffPlan)
	local descArray = {}

	for i, v in ipairs(buffConfigs) do
		table.insert(descArray, v.decs)
	end

	self._txtTips.text = table.concat(descArray, "\n")
	self._txtTime.text = BountyPKCompeteConfig.instance:getCommonValue("OPEN_TIME_TIPS")

	local btnList = {}
	local showGold = BountyPKCompeteConfig.instance:getCommonValue("SHOW_ITEM")
	local showGoldArray = string.split(showGold)

	for i = 1, #showGoldArray do
		table.insert(btnList, {
			showAdd = true,
			id = showGoldArray[i]
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)
end

function BountyPKCompeteMainView:onEnterFinished()
	BountyPKCompeteMainView.super.onEnterFinished(self)
	self:_initRole()
	self:_addMainEffect()
end

function BountyPKCompeteMainView:_removeMainEffect()
	if self._mainEffect then
		UIEffectManager.instance:stopEffect(self._mainEffect)

		self._mainEffect = nil
	end
end

function BountyPKCompeteMainView:_addMainEffect()
	self:_removeMainEffect()

	local effectPath = "20220930/shangjinsai/fx_ui_shangjinsai_fenw.prefab"
	local eff = UIEffectManager.instance:playEffect(self, effectPath, self._mainEffectGo.transform, 0, 0, true)

	eff:setParent(self._mainEffectGo.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._mainEffect = eff
end

function BountyPKCompeteMainView:_initRole()
	local skinId = BountyPKCompeteConfig.instance:getCommonValue("POST_RACEID", true)
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._con, scale, nil, true, modelCfg[1], y)
			end
		end
	end
end

function BountyPKCompeteMainView:_updateAll()
	self:_updateMyInfo()
	self:_updateDailyPrize()

	local model = BountyPKCompeteModel.instance

	self._txtAd.text = langPara("bountypk__12", StringUtil.numberToString(model.competitorNum), StringUtil.numberToString(model.totalScore))

	GameUtil.SetActive(self._taskRedPoint, model:isTaskRed())
end

function BountyPKCompeteMainView:_updateDailyPrize()
	self._txtBubbleDesc.text = BountyPKCompeteConfig.instance:getCommonValue("DAILY_LOGIN_PRIZE_DESC")

	local prizeNum = BountyPKCompeteConfig.instance:getCommonValue("DAILY_LOGIN_PRIZE")
	local prizeItemId = BountyPKCompeteConfig.instance:getCommonValue("BOUNTY_ITEM_ID", true)

	MaterialMgr.setCellByCfg(MaterialMgr.createSerName(MatType.Item_Fake, prizeItemId, prizeNum), self._bubbleItem)

	local model = BountyPKCompeteModel.instance

	goutil.setActive(self._receiveGo, model.dailyPrize)
	GameUtil.SetGray(self._btnDailyPrize, model.dailyPrize)
end

function BountyPKCompeteMainView:_updateMyInfo()
	HeadItemController.instance:setMyHeadCell(self._myHeadCellGo)

	self._txtMyName.text = RoleModel.instance:getUserName()

	local pkInfo = BountyPKCompeteModel.instance.pkInfo

	self._txtMyScore.text = langPara("bountypk__15", tostring(pkInfo.score or 0))

	if not BountyPKCompeteModel.instance.myRank then
		self._txtMyRank.text = BountyPKCompeteModel.instance.myRank > 0 and BountyPKCompeteModel.instance.myRank <= 100 and langPara("bountypk__17", BountyPKCompeteModel.instance.myRank) or lang("bountypk__3")
	end
end

function BountyPKCompeteMainView:_onClickWish()
	GameUtil.SetActive(self._tips, not GameUtil.GetActive(self._tips))
end

function BountyPKCompeteMainView:_tipsCustomInputChanged(isHover)
	if isHover == false then
		GameUtil.SetActive(self._tips, false)
	end
end

function BountyPKCompeteMainView:_onClickTips()
	TipsFacade.instance:openRulesView("bountypkcompete_rule")
end

function BountyPKCompeteMainView:_onClickTask()
	UIStateManager.instance:push(ViewName.BountyPKCompeteTaskView)
end

function BountyPKCompeteMainView:_onClickExchange()
	local activityType = BountyPKCompeteConfig.instance:getCommonValue("SHOP_ACTIVITYTYPE")
	local activityId = BountyPKCompeteConfig.instance:getCommonValue("SHOP_ACTIVITYID")

	if activityType and activityId then
		GotoMgr.gotoByString(string.format("func#191#%s#%s", activityType, activityId))
	end
end

function BountyPKCompeteMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.BountyPKCompeteRankView)
end

function BountyPKCompeteMainView:_onClickRecord()
	UIStateManager.instance:push(ViewName.BountyPKCompeteRecordView)
end

function BountyPKCompeteMainView:_onClickDailyPrize()
	if not BountyPKCompeteModel.instance.dailyPrize then
		BountyPKCompeteAgent.instance:sendPM_BountyPKDailyPrizeReq()
	end
end

function BountyPKCompeteMainView:_onClickStart()
	local bInMatchTime, strTips = BountyPKCompeteModel.instance:checkIsInMatchTime()

	if bInMatchTime then
		if BountyPKCompeteModel.instance:getRemainPlayTime() > 0 then
			UIStateManager.instance:push(ViewName.BountyPKCompeteLevelView)
		else
			FloatWordMgr.instance:show("次数不足")
		end
	else
		FloatWordMgr.instance:show(strTips)
	end
end

return BountyPKCompeteMainView
