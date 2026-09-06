-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulatecharge/view/AccumulateChargeProgressView.lua

module("logic.extensions.accumulatecharge.view.AccumulateChargeProgressView", package.seeall)

local AccumulateChargeProgressView = class("AccumulateChargeProgressView", ViewComponent)

function AccumulateChargeProgressView:buildUI()
	AccumulateChargeProgressView.super.buildUI(self)

	self._btnTip = self:getGo("btnTip")
	self._btnReCharge = self:getGo("btnRecharge")
	self._btnRank = self:getGo("btnRank")
	self._btnOneKey = self:getGo("btnOneKey")
	self._goCell = self:getGo("cell")
	self._goTableview = self:getGo("tableview")
	self._clipRect = goutil.findChild(self._goTableview, "Viewport"):GetComponent(goutil.Type_RectTransform)
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtProgress = self:getTxt("txtProgress")
	self._txtCharge = self:getTxt("txtCharge")
	self._txtChangeTip = self:getTxt("txtChargeTip")
	self._txtTime = self:getTxt("time/txtLeftTime")
	self._slider = self:getSlider("slider")
	self._showcell = self:getGo("showcell")
	self._showcellTxtNum = goutil.findChildTextComponent(self._showcell, "txtNum")
	self._showcellItemcon = goutil.findChild(self._showcell, "itemcon")
end

function AccumulateChargeProgressView:bindEvents()
	AccumulateChargeProgressView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnReCharge, self._onClickRecharge, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
end

function AccumulateChargeProgressView:unbindEvents()
	AccumulateChargeProgressView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReCharge)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnOneKey)
end

function AccumulateChargeProgressView:onEnter()
	AccumulateChargeProgressView.super.onEnter(self)

	self._actId = self:getActIdByCfg()

	if self._actId > 0 then
		self:refreshViewByCfg()
		AccumulateChargeController.instance:sendPM_CampaignConsumeGetInfoReq(self._actId)
		AccumulateChargeModel.instance:setActId(self._actId)
	else
		local text = "活动未开始"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
	end

	GlobalDispatcher:addListener(GlobalNotify.CampaignConsumeGetInfoRes, self.refreshViewByInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.CampaignConsumeGainPrizeRes, self.refreshViewByInfo, self)
	self:_createEff("20220401/choujiang/fx_ui_choujiangbg_dishitian.prefab", self.mainGO, "mainEff", true)
end

function AccumulateChargeProgressView:onExit()
	AccumulateChargeProgressView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CampaignConsumeGetInfoRes, self.refreshViewByInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.CampaignConsumeGainPrizeRes, self.refreshViewByInfo, self)
	removetimer(self._onCountdown, self)
	MaterialMgr.resetAll(self._showcellItemcon)
	self._tableview:dispose()
	self:_removeAllEffect()

	self._showId = nil
end

function AccumulateChargeProgressView:getActIdByCfg()
	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.AccumulateCharge)

	return (actCfg or nil) and (actCfg.activityId or 0)
end

function AccumulateChargeProgressView:_onClickGainPrize(data)
	AccumulateChargeController.instance:sendPM_CampaignConsumeGainPrizeReq(self._actId, data.id)
end

function AccumulateChargeProgressView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local proxyArr = MaterialMgr.setCellListByCfg(data.gift, cell.itemcon)

	cell.txtNum.text = data.consumeMoney

	GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickGainPrize, self, data))

	if self._curMoney >= data.consumeMoney and not AccumulateChargeModel.instance:isGetedReward(data.id) then
		goutil.setActive(cell.btn, true)
		goutil.setActive(cell.eff, true)

		for i = 1, #proxyArr do
			self:_createEff("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", cell.effcon, cell.go, true, self._clipRect, i)
		end
	else
		goutil.setActive(cell.mark, AccumulateChargeModel.instance:isGetedReward(data.id))
	end

	self:_refreshShowCell(self._tableview._tableview:GetCurrentIndex() + 1)
end

function AccumulateChargeProgressView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.itemcon = goutil.findChild(cell.go, "itemcon")
	cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
	cell.btn = goutil.findChild(cell.go, "btn")
	cell.eff = goutil.findChild(cell.go, "eff")
	cell.effcon = goutil.findChild(cell.go, "effcon")
	cell.mark = goutil.findChild(cell.go, "mark")

	GameUtil.rmClickHandler(cell.btn)
	goutil.setActive(cell.btn, false)
	goutil.setActive(cell.eff, false)
	goutil.setActive(cell.mark, false)
	MaterialMgr.resetAll(cell.itemcon)
	self:_removeEffect(cell.go)

	return cell
end

function AccumulateChargeProgressView:_refreshShowCell(dataId)
	if self._prizeCfgs[dataId] then
		if self._showId ~= self._prizeCfgs[dataId] then
			self._showId = self._prizeCfgs[dataId]

			local data = self._prizeCfgs[self._showId]

			if data then
				MaterialMgr.resetAll(self._showcellItemcon)
				MaterialMgr.setCellListByCfg(data.gift, self._showcellItemcon)

				self._showcellTxtNum.text = data.consumeMoney

				goutil.setActive(self._showcell, true)
			else
				goutil.setActive(self._showcell, false)
			end
		end
	end
end

function AccumulateChargeProgressView:refreshViewByCfg()
	self._actCfg = AccumulategiftConfig.instance:getCampaignConsumeCfg(self._actId)

	local planId = AccumulategiftConfig.instance:GetActivityPlanID(self._actId)

	self._prizeCfgs = AccumulategiftConfig.instance:GetConsumeGiftCfg(planId)

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.AccumulateCharge, self._actId)

	self._endTimestamp = endTime

	settimer(1, self._onCountdown, self)
	self:_onCountdown()
	self:refreshViewByInfo()
end

function AccumulateChargeProgressView:refreshViewByInfo()
	self:refreshProgressInfo()
	self._tableview:reloadData(self._prizeCfgs)
end

function AccumulateChargeProgressView:refreshProgressInfo()
	self._curMoney = AccumulateChargeModel.instance:getMoney()

	local nextCfg

	for _, v in ipairs(self._prizeCfgs) do
		if v.consumeMoney > self._curMoney then
			nextCfg = v

			break
		end
	end

	if nextCfg then
		self._txtChangeTip.text = langPara("距离下一档奖励还差：%s", nextCfg.consumeMoney - self._curMoney)
		self._txtProgress.text = langPara("%s/%s", self._curMoney, nextCfg.consumeMoney)

		self._slider:SetValue(checknumber(self._curMoney) / checknumber(nextCfg.consumeMoney))
	else
		self._txtChangeTip.text = ""
		self._txtProgress.text = langPara("%s/%s", self._curMoney, self._prizeCfgs[#self._prizeCfgs].consumeMoney)

		self._slider:SetValue(1)
	end

	self._txtCharge.text = langPara("当前充值\n<size=24><color=#7afb80>%s</color></size>", self._curMoney)
end

function AccumulateChargeProgressView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "chargemoney_rule")
end

function AccumulateChargeProgressView:_onClickRecharge()
	if self._actCfg and not string.nilorempty(self._actCfg.jumpTo) then
		GotoMgr.gotoByString(self._actCfg.jumpTo)
	else
		PayShopController.instance:openView(GameEnum.PayShopEasyJump.Recharge)
	end
end

function AccumulateChargeProgressView:_onCountdown()
	if self._endTimestamp and self._endTimestamp > 0 then
		local leftTime = self._endTimestamp - ServerTime.now()

		leftTime = leftTime >= 0 and leftTime or 0
		self._txtTime.text = string.format("剩余：%s", GameUtil.FormatTimeSymbol(leftTime))
	else
		removetimer(self._onCountdown, self)

		local text = "活动未开始"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
	end
end

function AccumulateChargeProgressView:_createEff(effPath, effParent, effKey, isLoop, clipRect, id)
	self._exictEffs = self._exictEffs or {}

	if not effParent then
		return
	end

	self:_removeEffect(key)

	local newEff = UIEffectManager.instance:playEffect(self, effPath, effParent.transform, 0, 0, isLoop, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(effParent.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)

		if clipRect then
			eff:setClipping(clipRect)
		end
	end)

	self._exictEffs[effKey] = self._exictEffs[effKey] or {}

	if id then
		self._exictEffs[effKey][id] = newEff
	else
		self._exictEffs[effKey][1] = newEff
	end
end

function AccumulateChargeProgressView:_removeAllEffect()
	if self._exictEffs then
		for k, eff in pairs(self._exictEffs) do
			self:_removeEffect(k)
		end

		self._exictEffs = nil
	end
end

function AccumulateChargeProgressView:_removeEffect(key)
	if self._exictEffs then
		if self._exictEffs then
			for _, eff in pairs(self._exictEffs) do
				UIEffectManager.instance:stopEffect(eff)
			end

			self._exictEffs[key] = nil
		end
	end
end

function AccumulateChargeProgressView:_onClickRank()
	UIStateManager.instance:push(ViewName.ChargeCostRankView, 0, self._actId)
end

function AccumulateChargeProgressView:_onClickOneKey()
	AccumulateChargeController.instance:sendOneKeyGainPrizeReq(self._actId)
end

return AccumulateChargeProgressView
