-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/anheimm/AnheimmMainView.lua

module("logic.extensions.timelimitedchallenge.view.anheimm.AnheimmMainView", package.seeall)

local AnheimmMainView = class("AnheimmMainView", TimeLimitedMainView)

function AnheimmMainView:ctor()
	AnheimmMainView.super.ctor(self)
end

function AnheimmMainView:_setEffectUrls()
	self._effPaths = {
		{
			goPath = "point_fx_biaoti",
			path = "fx_ui_anheitiaozhan/prefabs/fx_ui_tiaozhan_anheimengmeng_02.prefab"
		},
		{
			goPath = "btnStart",
			path = "fx_ui_anheitiaozhan/prefabs/fx_ui_tiaozhan_anheimengmeng_01.prefab"
		}
	}
end

function AnheimmMainView:buildUI()
	AnheimmMainView.super.buildUI(self)

	self._challengeId = AnheimmConfig.instance:getChallengeId()
	self._btnReceive = self:getBtn("dailyPrize/btnReceive")
	self._imgIcon = self:getGo("dailyPrize/imgIcon")
	self._txtNum = self:getTxt("dailyPrize/txtNum")
	self._imgReceived = self:getGo("dailyPrize/imgReceived")
	self._btnAdd = self:getBtn("btnAdd")
	self._goAdd = self:getGo("btnAdd")
	self._btnEvolution = self:getBtn("btnEvolution")
	self._goEvolution = self:getGo("btnEvolution")
	self._imgEvolved = self:getGo("imgEvolved")
	self._dot = self:getGo("dailyPrize/btnReceive/dot")
	self.btnShop = self:getGo("btnShop")
	self.head = self:getGo("btnShop/head")
end

function AnheimmMainView:bindEvents()
	AnheimmMainView.super.bindEvents(self)
	self._btnReceive:AddClickListener(self._onClickReceive, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)
	self._btnEvolution:AddClickListener(self._onClickEvolution, self)
	GameUtil.addClickHandler(self.btnShop, self.onClickShop, self)
end

function AnheimmMainView:unbindEvents()
	AnheimmMainView.super.unbindEvents(self)
	self._btnReceive:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnEvolution:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnShop)
end

function AnheimmMainView:destroyUI()
	AnheimmMainView.super.destroyUI(self)
end

function AnheimmMainView:onEnter()
	AnheimmMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.EvolveSuccess, self._dailyReset, self)
	GlobalDispatcher:addListener(GlobalNotify.RefreshAnheiMMChallenge, self._dailyReset, self)
	GlobalDispatcher:addListener(GlobalNotify.RefreshAnheiMMRefreshTime, self._updateLeftTimes, self)
	self:_dailyReset()

	local matstr = AnheimmConfig.instance:getParamValueByKey("DAILY_PRIZE")
	local matType, matId, matNum = MaterialMgr.getMatParams(matstr)

	MaterialMgr.updateItemByStr(self._imgIcon, matstr)

	self._txtNum.text = "x" .. matNum

	local petRankThreshold = checknumber(AnheimmConfig.instance:getParamValueByKey("PET_RANK_LIMIT"))
	local petRankPrize = AnheimmConfig.instance:getParamValueByKey("PET_RANK_PRIZE")

	self._txtTipRank.text = string.format("前%s名\n可获得", petRankThreshold)

	MaterialMgr.setCellByCfg(petRankPrize, self._pointRankItem)

	local changeSetId = AnheimmModel.instance:getChangeSetId()

	print("showChangeSetInTemp = " .. tostring(AnheimmModel.instance:getChangeSetId()))

	if checknumber(changeSetId) > 0 then
		print("showChangeSetInTemp = " .. changeSetId)
		MaterialController.instance:showChangeSetInTemp(changeSetId)
		AnheimmModel.instance:setChangeSetId(nil)
	end

	MaterialMgr.resetAll(self._pointExchangeItem)

	local matStr = "4:6003:1"

	MaterialMgr.setCellByCfg(matStr, self._pointExchangeItem)

	self._txtTipExchange.text = string.format("可兑换\n进化石")

	RedPointController.instance:unregRedPoint(self._redPoint)
	self:updateGoShop()
	self:_activeTipTry(false)
end

function AnheimmMainView:updateGoShop()
	self._challengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	local raceId = self._challengeCfg.raceId

	MaterialMgr.setIcon(self.head, MatType.Pet, raceId)
end

function AnheimmMainView:onClickShop()
	local goodsId = AnheimmConfig.instance:getParamValueByKey("GOODS_ID")

	PayShopController.instance:buyShopItemWithTips(goodsId)
end

function AnheimmMainView:onEnterFinished()
	AnheimmMainView.super.onEnterFinished(self)
end

function AnheimmMainView:onExit()
	AnheimmMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.EvolveSuccess, self._dailyReset, self)
	GlobalDispatcher:removeListener(GlobalNotify.RefreshAnheiMMChallenge, self._dailyReset, self)
	GlobalDispatcher:removeListener(GlobalNotify.RefreshAnheiMMRefreshTime, self._updateLeftTimes, self)
	MaterialMgr.clearIcon(self._imgIcon)
	MaterialMgr.resetAll(self._pointRankItem)
	MaterialMgr.clearIcon(self.head)
end

function AnheimmMainView:onExitFinished()
	AnheimmMainView.super.onExitFinished(self)
end

function AnheimmMainView:_dailyReset()
	AnHeiMMChallengeAgent.instance:sendPM_AnHeiMMChallengeGetInfoReq(function(msg)
		AnheimmModel.instance:updateGetInfo(msg)
		self:_updateLeftTimes()
		self:_updateDailyPrize()
		self:_updateEvolution()
		self:_updateRankTip()

		if AnheimmController.instance:getNeedOpenRuleView() and TLChallengeController.instance:isInOpenTime(self._challengeId) then
			UIStateManager.instance:push(ViewName.AnheimmRuleView)
		end
	end)
end

function AnheimmMainView:_updateLeftTimes()
	self._leftTimes = AnheimmModel.instance:getCurChallengeTimes()
	self._totalTimes = AnheimmConfig.instance:getChallengeDailyTimes()
	self._txtLeftChallengeCount.text = string.format("今天剩余次数：<color=#FFFFFFFF>%d/%d</color>", self._leftTimes, self._totalTimes)

	goutil.setActive(self._goAdd, self._leftTimes == 0)
	goutil.setActive(self._redPoint, self._leftTimes ~= 0)
end

function AnheimmMainView:_updateDailyPrize()
	goutil.setActive(self._imgReceived, AnheimmModel.instance:getIsHasGainDaily())
	goutil.setActive(self._dot, not AnheimmModel.instance:getIsHasGainDaily())
end

function AnheimmMainView:_updateEvolution()
	goutil.setActive(self._imgEvolved, AnheimmModel.instance:getIsEverEvolve())
	goutil.setActive(self._goEvolution, not AnheimmModel.instance:getIsEverEvolve())
end

function AnheimmMainView:_updateRankTip()
	self._tipExchange.gameObject:SetActive(not AnheimmModel.instance:getIsEverEvolve())
end

function AnheimmMainView:_onClickReceive()
	if AnheimmModel.instance:getIsHasGainDaily() then
		FloatWordMgr.instance:show("今天已领取，明天再来吧")
	else
		AnHeiMMChallengeAgent.instance:sendPM_AnHeiMMChallengeGainDailyPrizeReq(function(msg)
			AnheimmModel.instance:updateGainDailyPrize(msg)
			self:_updateDailyPrize()
		end)
	end
end

function AnheimmMainView:_onClickAdd()
	if AnheimmModel.instance:getAbleToAddTimes() == 0 then
		FloatWordMgr.instance:show("今日购买已达上限，次日5点刷新购买次数")

		return
	end

	local curBuyTime = AnheimmModel.instance:getCurHasBuyTimes()
	local curcost = AnheimmConfig.instance:getCostByAddTimes(curBuyTime + 1)
	local curCostType, curCostId, curCostNum = MaterialMgr.getMatParams(curcost)
	local curIcon = MaterialMgr.getContentMatCfg(curCostType, curCostId, 30, -5, MaterialMgr.ICON_TYPE_ICON)
	local content = langPara("确定花费<color=#ebad32>%s</color>%s购买挑战次数吗？\n每天最多可购买：<color=#ebad32>%s次</color>，还能购买<color=#ebad32>%s次</color>", curCostNum, curIcon, AnheimmConfig.instance:getMaxAddTimes(), AnheimmModel.instance:getAbleToAddTimes())

	TipsFacade.instance:openPopupCostMatViewNew(curCostType, curCostId, curCostNum, content, function()
		AnHeiMMChallengeAgent.instance:sendPM_AnHeiMMChallengeBuyTimesReq(function(msg)
			AnheimmModel.instance:updateBuyTimes(msg)
			self:_updateLeftTimes()
		end)
	end)
end

function AnheimmMainView:_onClickStart()
	if self._leftTimes == 0 then
		if AnheimmModel.instance:getAbleToAddTimes() == 0 then
			FloatWordMgr.instance:show("今日挑战次数已耗尽！")
		else
			FloatWordMgr.instance:show("今日挑战次数已耗尽，可购买次数继续挑战！")
		end
	else
		local curRuleId = AnheimmModel.instance:getCurRuleId()

		if curRuleId == 0 or not curRuleId then
			UIStateManager.instance:push(ViewName.AnheimmDifficultyView)
		else
			UIStateManager.instance:push(ViewName.AnheimmRuleView)
		end
	end
end

function AnheimmMainView:_onClickEvolution()
	if AnheimmModel.instance:getIsEverEvolve() then
		FloatWordMgr.instance:show("已进化")
		self:_updateEvolution()
	else
		local exchangeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)
		local raceId = exchangeCfg.raceId
		local evolveMo = EvolveMo.New()

		evolveMo:setParamById(AnheimmConfig.instance:getEvolvePetRaceId(), raceId)
		UIStateManager.instance:push(ViewName.Evolve, evolveMo)
	end
end

return AnheimmMainView
