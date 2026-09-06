-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulatecharge/view/AccumulateChargeView.lua

module("logic.extensions.accumulatecharge.view.AccumulateChargeView", package.seeall)

local AccumulateChargeView = class("AccumulateChargeView", TableViewComponent)
local MAXSINGLEPAGENUM = 8

function AccumulateChargeView:ctor()
	AccumulateChargeView.super.ctor(self)
end

function AccumulateChargeView:buildUI()
	AccumulateChargeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnChangePage = self:getBtn("btnChangePage")
	self._btnCharge = self:getBtn("btnCharge")
	self._btnDetail = self:getBtn("reward/btnDetail")

	goutil.setActive(self._btnDetail.gameObject, false)

	self._txtTime = self:getTxt("time/txtTime")
	self._txtPrice = self:getTxt("txtPrice")
	self._txtTip = self:getTxt("txtTip")
	self._txtRewardDesc = self:getTxt("txtDesc")
	self._txtChangePage = self:getTxt("btnChangePage/txtChangePage")
	self._txtCharge = self:getTxt("btnCharge/txtCharge")
	self._txtDesc = self:getTxt("reward/txtDesc")
	self._sliderBack = self:getImg("sliderBack")
	self._sliderFront = self:getImg("sliderFront")
	self._cell = self:getGo("cell")

	self._cell:SetActive(false)

	self._cellParent = self:getGo("cellParent")
	self._recordPos = self._cellParent:GetComponent(typeof(TestRecordPos))
	self._rewardItemList = {}

	for i = 1, MAXSINGLEPAGENUM do
		local go = goutil.cloneAndSetParent(self._cell, self._cellParent.transform)
		local item = GameUtil.AddLuaOnce(go, AccumulateChargeItem)

		table.insert(self._rewardItemList, item)
	end

	self._bgEffectGo = self:getGo("effect")
	self._btnEffectGo = self:getGo("btnCharge/effect")
	self._skinIconGo = self:getGo("reward/btnDetail/icon")
	self._rewardRectTrans = self:getGo("reward"):GetComponent(goutil.Type_RectTransform)
	self._extraGift = self:getGo("reward/extraGift")
	self._extraDesc = self:getGo("reward/extraDesc")
	self._btnLook = self:getBtn("reward/btnLook")
end

function AccumulateChargeView:_getBgEffectPath()
	return "20211126/nuoyashengrihuicangbaoge/fx_ui_nysrhcbg_fenwei.prefab"
end

function AccumulateChargeView:_getPath()
	return {
		cellPath = "reward/cell",
		viewPath = "reward/tableview"
	}
end

function AccumulateChargeView:bindEvents()
	AccumulateChargeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnChangePage:AddClickListener(self._onClickChangePage, self)
	self._btnCharge:AddClickListener(self._onClickCharge, self)
	self._btnDetail:AddClickListener(self._onClickDetail, self)
	self._btnLook:AddClickListener(self._onClickLook, self)
end

function AccumulateChargeView:unbindEvents()
	AccumulateChargeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnChangePage:RemoveClickListener()
	self._btnCharge:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	self._btnLook:RemoveClickListener()
end

function AccumulateChargeView:onEnter()
	AccumulateChargeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.CampaignConsumeGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CampaignConsumeGainPrizeRes, self._onGainPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.AccumulateChargeSelectReward, self._onSelectReward, self)
	self:_resetVariable()
	self:_closeMask()
	self:_loadEffect()

	self._activityId = checknumber(self:getFirstParam())

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.AccumulateCharge, self._activityId)

	if not isInTime then
		self:_showCloseTip()

		return
	end

	AccumulateChargeController.instance:sendPM_CampaignConsumeGetInfoReq(self._activityId)

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.AccumulateCharge, self._activityId)

	self._endTimestamp = endTime

	self:_onSecond()
	settimer(1, self._onSecond, self)
	self:_refreshBtnDetail()
	self:_playAnim(self._activityId)
end

function AccumulateChargeView:onExit()
	AccumulateChargeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CampaignConsumeGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CampaignConsumeGainPrizeRes, self._onGainPrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.AccumulateChargeSelectReward, self._onSelectReward, self)
	removetimer(self._onSecond, self)
	self:_killTweens()
	self:_removeEffect()
	self:_removeSkinIcon()
	self:_clearRewardShow()
end

function AccumulateChargeView:_playAnim(activityId)
	return
end

function AccumulateChargeView:_onSecond()
	self:_updateCountdown()
end

function AccumulateChargeView:_updateCountdown()
	if self._endTimestamp and self._endTimestamp > 0 then
		local leftTime = self._endTimestamp - ServerTime.now()

		leftTime = leftTime >= 0 and leftTime or 0
		self._txtTime.text = string.format("剩余：%s", GameUtil.FormatTimeSymbol(leftTime))
	end
end

function AccumulateChargeView:_onClickClose()
	self:close()
end

function AccumulateChargeView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "chargemoney_rule")
end

function AccumulateChargeView:_onClickChangePage()
	if self._curPageIndex and self._totalPageNum and self._totalPageNum > 1 then
		local newPageIndex = self._curPageIndex % self._totalPageNum + 1

		printInfo("test 从旧的一页 - > 新的一页", self._curPageIndex, newPageIndex)

		self._curPageIndex = newPageIndex

		local rewardCfgs = self:_getRewardCfgs()
		local selectCfg = self:_caculateTargetPageSelectCfg(newPageIndex, rewardCfgs)

		self:_refreshPage(self._curPageIndex, selectCfg, rewardCfgs, true)
	end
end

function AccumulateChargeView:_onClickCharge()
	if self._curSelectRewardCfg then
		local money = AccumulateChargeModel.instance:getMoney()

		if money < self._curSelectRewardCfg.consumeMoney then
			local cfg = AccumulategiftConfig.instance:getCampaignConsumeCfg(self._activityId)

			if cfg and not string.nilorempty(cfg.jumpTo) then
				GotoMgr.gotoByString(cfg.jumpTo)
			else
				PayShopController.instance:openView(GameEnum.PayShopEasyJump.Recharge)
			end
		elseif not AccumulateChargeModel.instance:isGetedReward(self._curSelectRewardCfg.id) then
			AccumulateChargeController.instance:sendPM_CampaignConsumeGainPrizeReq(self._activityId, self._curSelectRewardCfg.id)
		else
			FloatWordMgr.instance:show("奖励已领取")
		end
	end
end

function AccumulateChargeView:_onClickDetail()
	if self._activityId > 0 then
		local cfg = AccumulategiftConfig.instance:getCampaignConsumeCfg(self._activityId)

		if cfg and cfg.skinId then
			CommonTipsMgr.instance:openMaterialTips(nil, MatType.PET_SKIN, cfg.skinId)

			return
		end
	end

	FloatWordMgr.instance:show("skinId is not exist")
end

function AccumulateChargeView:_onClickLook()
	if self._curSelectRewardCfg then
		local exchangeCode = AccumulateChargeModel.instance:getExchangeCode(self._curSelectRewardCfg.id)

		if exchangeCode then
			local text = string.format("亲爱的小奥奇，您的专属兑换码为：\n%s\n可以前往《奥奇传说页游》兑换奖励！", exchangeCode)
			local btnText = lang("tip_know")

			TipsFacade.instance:openTipWindow("兑换码", text, nil, btnText)
		end
	end
end

function AccumulateChargeView:_onGetInfoRes()
	self:_refreshView(true)
end

function AccumulateChargeView:_onGainPrizeRes(id)
	self:_refreshView(false)
end

function AccumulateChargeView:_onSelectReward(selectCfgReward)
	for i, v in ipairs(self._rewardItemList) do
		if v:isActive() and not v:isSame(selectCfgReward) then
			v:setSelect(false)
		end
	end

	self._curSelectRewardCfg = selectCfgReward

	self:_refreshRewardShow(selectCfgReward)
	self:_refreshBtnCharge(selectCfgReward)
end

function AccumulateChargeView:_updateCell(view, cell, data)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.setCellByCfg(data, node)
end

function AccumulateChargeView:_clearTableview(cell)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.resetAll()
end

function AccumulateChargeView:_refreshView(isPlayAnim)
	local cfgRewards = self:_getRewardCfgs()

	if cfgRewards and #cfgRewards > 0 then
		local count = #cfgRewards

		self._totalPageNum = Mathf.Floor((count - 1) / MAXSINGLEPAGENUM) + 1
		self._totalPageNum = self._totalPageNum < 1 and 1 or self._totalPageNum
		self._curPageIndex, self._curSelectRewardCfg = self:_caculatePageIndex(self._totalPageNum, cfgRewards)

		self:_refreshPage(self._curPageIndex, self._curSelectRewardCfg, cfgRewards, isPlayAnim)
	end
end

function AccumulateChargeView:_resetVariable()
	self._totalPageNum = nil
	self._curPageIndex = 1
	self._curSelectRewardCfg = nil
end

function AccumulateChargeView:_getRewardCfgs()
	local planId = AccumulategiftConfig.instance:GetActivityPlanID(self._activityId)

	return (AccumulategiftConfig.instance:GetConsumeGiftCfg(planId))
end

function AccumulateChargeView:_caculatePageIndex(pageCount, cfgRewards)
	local money = AccumulateChargeModel.instance:getMoney()
	local targetIndex = -1
	local nextIndex = -1

	for i, v in ipairs(cfgRewards) do
		if money >= v.consumeMoney then
			if not AccumulateChargeModel.instance:isGetedReward(v.id) and targetIndex == -1 then
				targetIndex = i
			end
		elseif nextIndex == -1 then
			nextIndex = i
		end
	end

	if targetIndex > 0 then
		return Mathf.Floor((targetIndex - 1) / MAXSINGLEPAGENUM) + 1, cfgRewards[targetIndex]
	elseif nextIndex > 0 then
		return Mathf.Floor((nextIndex - 1) / MAXSINGLEPAGENUM) + 1, cfgRewards[nextIndex]
	else
		return pageCount, cfgRewards[#cfgRewards]
	end
end

function AccumulateChargeView:_getStartAndEndIndex(targetPageIndex, cfgRewards)
	local startIndex = (targetPageIndex - 1) * MAXSINGLEPAGENUM + 1
	local endIndex = 0

	if targetPageIndex == self._totalPageNum then
		if targetPageIndex == 1 then
			endIndex = (targetPageIndex - 1) * MAXSINGLEPAGENUM + MAXSINGLEPAGENUM
		else
			local num = #cfgRewards % MAXSINGLEPAGENUM

			endIndex = num == 0 and (targetPageIndex - 1) * MAXSINGLEPAGENUM + (#cfgRewards - 1) % MAXSINGLEPAGENUM + 1 or (targetPageIndex - 1) * MAXSINGLEPAGENUM + num
		end
	else
		endIndex = (targetPageIndex - 1) * MAXSINGLEPAGENUM + MAXSINGLEPAGENUM
	end

	return startIndex, endIndex
end

function AccumulateChargeView:_caculateTargetPageSelectCfg(targetPageIndex, cfgRewards)
	local money = AccumulateChargeModel.instance:getMoney()
	local startIndex, endIndex = self:_getStartAndEndIndex(targetPageIndex, cfgRewards)
	local targetIndex = -1
	local nextIndex = -1

	for i = startIndex, endIndex do
		if money >= cfgRewards[i].consumeMoney then
			if not AccumulateChargeModel.instance:isGetedReward(cfgRewards[i].id) and targetIndex == -1 then
				targetIndex = i
			end
		elseif nextIndex == -1 then
			nextIndex = i
		end
	end

	if targetIndex > 0 then
		return cfgRewards[targetIndex]
	elseif nextIndex > 0 then
		return cfgRewards[nextIndex]
	else
		return cfgRewards[endIndex]
	end
end

function AccumulateChargeView:_refreshPage(targetPageIndex, selectCfg, cfgRewards, isPlayAnim)
	local startIndex, endIndex = self:_getStartAndEndIndex(targetPageIndex, cfgRewards)
	local count = endIndex - startIndex + 1

	self._recordPos:LoadPlan(count - 1)

	for i = 1, MAXSINGLEPAGENUM do
		if i <= count then
			self._rewardItemList[i]:init(self, cfgRewards[startIndex - 1 + i], selectCfg)
			self._rewardItemList[i]:active()
		else
			self._rewardItemList[i]:disActive()
		end
	end

	self:_setSlider()
	self:_refreshBtnChangePage(self._totalPageNum, self._curPageIndex)

	if isPlayAnim then
		self:_playPageAnimation()
	end

	self:_refreshBtnLookState(selectCfg)
end

function AccumulateChargeView:_playPageAnimation()
	self:_openMask()

	local internalTime = 0.1
	local duration = 0.1
	local delayTime = 0

	for i, v in ipairs(self._rewardItemList) do
		if v:isActive() then
			v:playAnimation(delayTime, duration)

			delayTime = delayTime + internalTime
		end
	end

	self._tweenCloseMask = TweenUtil.DoDelay(delayTime + duration, function()
		self:_closeMask()
	end)
end

function AccumulateChargeView:_killTweens()
	if self._tweenCloseMask then
		self._tweenCloseMask:Kill()
	end
end

function AccumulateChargeView:_openMask()
	return
end

function AccumulateChargeView:_closeMask()
	return
end

function AccumulateChargeView:_refreshBtnCharge(cfgReward)
	local money = AccumulateChargeModel.instance:getMoney()

	if money < cfgReward.consumeMoney then
		self._txtCharge.text = "前往充值"

		GameUtil.SetGray(self._btnCharge, false)
		self._btnEffectGo:SetActive(false)
	elseif not AccumulateChargeModel.instance:isGetedReward(cfgReward.id) then
		self._txtCharge.text = "领取"

		GameUtil.SetGray(self._btnCharge, false)
		self._btnEffectGo:SetActive(true)
	else
		self._txtCharge.text = "已领取"

		GameUtil.SetGray(self._btnCharge, true)
		self._btnEffectGo:SetActive(false)
	end

	local colorStr = money >= cfgReward.consumeMoney and "ffc157" or "ffffff"

	self._txtPrice.text = string.format("累计：<color=#%s>%d</color>/%d元", colorStr, money, cfgReward.consumeMoney)
end

function AccumulateChargeView:_refreshRewardShow(cfgReward)
	local isExistExtraGift = not string.nilorempty(cfgReward.extraGift)
	local width = isExistExtraGift and 498 or 310

	goutil.setWidth(self._rewardRectTrans, width)
	goutil.setActive(self._extraDesc, isExistExtraGift)

	if not string.nilorempty(cfgReward.gift) then
		local list = MaterialMgr.changeItemStrArr(cfgReward.gift)

		self:updateListData(list)

		self._txtDesc.text = string.format("累计充值%d元可领取", cfgReward.consumeMoney)
	end

	MaterialMgr.resetAll(self._extraGift)

	if isExistExtraGift then
		local str = cfgReward.extraGift
		local proxy = MaterialMgr.setCellByCfg(str, self._extraGift)
		local matType, id, matNum = MaterialMgr.getMatParams(cfgStr)

		if proxy and not string.nilorempty(cfgReward.extraGiftIcon) then
			proxy.binder:setCustomIcon(GameUrl.getItemIconUrl(cfgReward.extraGiftIcon))
		end
	end

	self:_refreshBtnLookState(cfgReward)
end

function AccumulateChargeView:_refreshBtnLookState(cfgReward)
	local isExist = AccumulateChargeModel.instance:getExchangeCode(cfgReward.id)

	goutil.setActive(self._btnLook.gameObject, AccumulateChargeModel.instance:isGetedReward(cfgReward.id) and isExist)
end

function AccumulateChargeView:_clearRewardShow()
	MaterialMgr.resetAll(self._extraGift)
end

function AccumulateChargeView:_refreshBtnChangePage(totalPage, curPageIndex)
	if totalPage == 1 then
		self._btnChangePage.gameObject:SetActive(false)
	else
		self._btnChangePage.gameObject:SetActive(true)

		self._txtChangePage.text = curPageIndex == totalPage and "返回" or "更多奖励"
	end
end

function AccumulateChargeView:_showCloseTip()
	local title = lang("tip")
	local text = "未在活动时间"

	local function func()
		self:_onClickClose()
	end

	TipsFacade.instance:openTipWindowNoX(title, text, func, btnText)
end

function AccumulateChargeView:_setSlider()
	local money = AccumulateChargeModel.instance:getMoney()
	local cfgs = self:_getRewardCfgs()
	local finishTargetIndex = -1

	for i, v in ipairs(cfgs) do
		if money >= v.consumeMoney then
			finishTargetIndex = i
		end
	end

	if self._curPageIndex and self._totalPageNum then
		local startIndex, endIndex = self:_getStartAndEndIndex(self._curPageIndex, cfgs)
		local count = endIndex - startIndex

		self._sliderFront.fillAmount = self._curPageIndex == self._totalPageNum and (finishTargetIndex <= startIndex and 0 or startIndex < finishTargetIndex and finishTargetIndex < endIndex and (finishTargetIndex - startIndex) / count or 1) or finishTargetIndex <= startIndex and 0 or startIndex < finishTargetIndex and finishTargetIndex < endIndex and (finishTargetIndex - startIndex) / count or 1
	end
end

function AccumulateChargeView:_loadEffect()
	self:_removeEffect()

	local bgEffectPath = self:_getBgEffectPath()
	local bgUIEffect = UIEffectManager.instance:playEffect(self, bgEffectPath, self._bgEffectGo.transform, 0, 0, true, false)

	bgUIEffect:setParent(self._bgEffectGo.transform)
	bgUIEffect:setScale(1)
	bgUIEffect:setLocalPos(0, 0, 0)

	self._bgUIEffect = bgUIEffect

	local btnEffectPath = "fx_ui_xinxiyamianban/xinxiya_new/fx_ui_xinxiya_chongzhianniu.prefab"
	local btnUIEffect = UIEffectManager.instance:playEffect(self, btnEffectPath, self._btnEffectGo.transform, 0, 0, true, false)

	btnUIEffect:setParent(self._btnEffectGo.transform)
	btnUIEffect:setScale(1)
	btnUIEffect:setLocalPos(0, 0, 0)

	self._btnUIEffect = btnUIEffect
end

function AccumulateChargeView:_removeEffect()
	if self._bgUIEffect then
		UIEffectManager.instance:stopEffect(self._bgUIEffect)

		self._bgUIEffect = nil
	end

	if self._btnUIEffect then
		UIEffectManager.instance:stopEffect(self._btnUIEffect)

		self._btnUIEffect = nil
	end
end

function AccumulateChargeView:_refreshBtnDetail()
	if self._activityId > 0 then
		local cfg = AccumulategiftConfig.instance:getCampaignConsumeCfg(self._activityId)

		if cfg and cfg.skinId then
			goutil.setActive(self._btnDetail.gameObject, true)
			MaterialMgr.setIcon(self._skinIconGo, MatType.PET_SKIN, cfg.skinId)

			return
		end
	end

	goutil.setActive(self._btnDetail.gameObject, false)
end

function AccumulateChargeView:_removeSkinIcon()
	MaterialMgr.clearIcon(self._skinIconGo)
end

return AccumulateChargeView
