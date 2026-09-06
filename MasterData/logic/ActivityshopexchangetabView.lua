-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activityshop/view/ActivityshopexchangetabView.lua

module("logic.extensions.activityshop.view.ActivityshopexchangetabView", package.seeall)

local ActivityshopexchangetabView = class("ActivityshopexchangetabView", ViewComponent)

function ActivityshopexchangetabView:ctor()
	ActivityshopexchangetabView.super.ctor(self)
end

function ActivityshopexchangetabView:buildUI()
	ActivityshopexchangetabView.super.buildUI(self)

	local scrViewGo = self:getGo("itemCol/scrView")
	local scrCellGo = self:getGo("itemCol/scrCell")

	self._goldBarCon = self:getGo("goldBarCon")
	self._scrollerList = ScrollerList.create(scrViewGo, scrCellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ActivityshopexchangetabView:bindEvents()
	ActivityshopexchangetabView.super.bindEvents(self)
end

function ActivityshopexchangetabView:unbindEvents()
	ActivityshopexchangetabView.super.unbindEvents(self)
end

function ActivityshopexchangetabView:onEnter()
	ActivityshopexchangetabView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._activityType = ActivityDefineController.instance:getActTypeByActId(self._activityId)
	self._page = checknumber(params[2])

	ActivityshopModel.instance:clearDailyRed(self._activityType, self._activityId)
	GlobalDispatcher:addListener(GlobalNotify.UpdateActiveShopInfo, self._updateView, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._setCostCoin, self)
	ActivityshopController.instance:getAllShopItemInfo(self._activityType, self._activityId)
	self:_reloadPageData(true)
	self:_showGlodBar()
	settimer(1, self._onCountDown, self)
end

function ActivityshopexchangetabView:onExit()
	ActivityshopexchangetabView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateActiveShopInfo, self._updateView, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._setCostCoin, self)
	removetimer(self._onCountDown, self)

	self._discountTimerList = nil

	if self._scrollerList then
		self._scrollerList:dispose()
	end
end

function ActivityshopexchangetabView:_reloadPageData(resetPos)
	self._tabDataList = ActivityshopConfig.instance:getActivityShopCfgWithPage(self._activityType, self._activityId) or {}

	if self._page <= 0 and self._tabDataList[1] then
		self._page = 1
	end

	if not self._tabDataList[self._page] then
		local dataList = {}

		self:_updateExchangeBuyInfo(dataList, resetPos)
	end
end

function ActivityshopexchangetabView:_updateExchangeBuyInfo(dataList, resetPos)
	self._dataList = dataList or {}

	local listCanBuy = {}
	local listSellOut = {}
	local listLocked = {}

	for _, data in ipairs(self._dataList) do
		if data.showflag ~= 1 then
			local sellOut = self:_isSellOut(data)

			if sellOut then
				table.insert(listSellOut, data)
			elseif PayShopController.instance:checkTimeStr(data.sellTime) then
				table.insert(listCanBuy, data)
			else
				table.insert(listLocked, data)
			end
		end
	end

	table.insertto(listCanBuy, listSellOut)
	table.insertto(listCanBuy, listLocked)

	self._curViewDatas = listCanBuy

	self._scrollerList:reloadData(listCanBuy)

	if resetPos and #listCanBuy > 0 then
		self._scrollerList:MoveCellToBegin(0, false)
	end
end

function ActivityshopexchangetabView:_showGlodBar()
	local iconCfg = ActivityshopConfig.instance:getCostIcon(self._activityType, self._activityId)
	local showGoldBar = iconCfg and not string.nilorempty(iconCfg.icon)

	goutil.setActive(self._goldBarCon, showGoldBar)

	if not showGoldBar then
		return
	end

	local accounts = string.split(iconCfg.icon, "#")
	local btnList = {}

	for _, v in ipairs(accounts) do
		table.insert(btnList, {
			showAdd = true,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)
end

function ActivityshopexchangetabView:_setCostCoin()
	self:_showGlodBar()

	if self._dataList then
		self:_updateExchangeBuyInfo(self._dataList)
	end
end

function ActivityshopexchangetabView:_updateView(activityType, activityId)
	if activityType and activityId and (activityType ~= self._activityType or activityId ~= self._activityId) then
		return
	end

	self:_reloadPageData()
	self:_showGlodBar()
end

function ActivityshopexchangetabView:_updateCell(view, cell, data, tag)
	if not cell.gameObject then
		local mainGo = cell
		local goodsNameTxt = goutil.findChildTextComponent(mainGo, "goodsNameTxt")
		local limitTxt = goutil.findChildTextComponent(mainGo, "limitBgIma/limitTxt")
		local goodsTranGo = goutil.findChild(mainGo, "goodsTranGo")
		local buyOutGo = goutil.findChild(mainGo, "buyOutGo")
		local buyLimit = goutil.findChild(mainGo, "buyLimit")
		local consumeImaGo = goutil.findChild(mainGo, "consumeGo/txtPrice/coin")
		local consumeTxt = goutil.findChildTextComponent(mainGo, "consumeGo/txtPrice")
		local txtDiscount = goutil.findChildTextComponent(mainGo, "consumeGo/txtDiscount")
		local goRate = goutil.findChild(mainGo, "rate")
		local txtRate = goutil.findChildTextComponent(mainGo, "rate/txtRate")
		local txtDiscountTime = goutil.findChildTextComponent(mainGo, "limitBgIma/limitTxt/txtDiscountTime")

		MaterialMgr.resetAll(goodsTranGo)
		GameUtil.rmClickHandler(mainGo)
		self:_removeDiscountTimer(mainGo)

		local itemId = data.shopItemId
		local activityId = data.activityId
		local matSplitList = string.split(data.sellContent, ":")
		local goodsType = checknumber(matSplitList[1])
		local goodsId = checknumber(matSplitList[2])
		local colorStr = MaterialMgr.getGoodsColor(goodsType, goodsId)

		goodsNameTxt.text = string.format("<color=%s>%s</color>", colorStr, data.name)
		txtDiscountTime.text = ""

		local sellOut = self:_isSellOut(data)

		self:_setLimitTxt(data, limitTxt)

		local content = data.sellContent

		if string.find(data.sellContent, "^" .. MatType.Cloth .. ":") then
			local arr = string.split(data.sellContent, "#")

			content = arr[Mathf.Min(RoleModel.instance:getGender() + 1, #arr)]
		end

		MaterialMgr.setCellByCfg(content, goodsTranGo)
		buyOutGo:SetActive(sellOut)
		buyLimit:SetActive(not sellOut and not PayShopController.instance:checkTimeStr(data.sellTime))

		local sellPriceSplit = string.split(data.sellPrice, ":")
		local priceType = sellPriceSplit[1] and checknumber(sellPriceSplit[1]) or 104
		local priceId = sellPriceSplit[2] and checknumber(sellPriceSplit[2]) or 1

		if not sellPriceSplit[3] then
			local priceCount = 100
			local isDiscountTime = false

			if not string.nilorempty(data.discountTime) then
				isDiscountTime = GameUtil.checkTimeStr(data.discountTime)
			end

			local endTime = ActivityshopModel.instance:getDiscountEndTime(data.discountTime)

			if endTime and isDiscountTime then
				self:_addDiscountTimer(endTime, mainGo, txtDiscountTime)
			end

			consumeTxt.text = MaterialFacade.instance:getGoodCost(priceType, priceId, priceCount)

			local showDisc = isDiscountTime and not string.nilorempty(data.discountPrice)

			goutil.setActive(txtDiscount.gameObject, showDisc)

			if showDisc then
				priceCount = MaterialFacade.instance:getGoodCostByStr(data.discountPrice)
				txtDiscount.text = priceCount
			end

			local isDisc = showDisc and data.discountNum > 0 and isDiscountTime

			goutil.setActive(goRate, isDisc)

			if isDisc then
				txtRate.text = string.format("%s折", data.discountNum / 10)
			end

			MaterialMgr.setIcon(consumeImaGo, priceType, priceId)
			GameUtil.asBtn(mainGo):AddClickListener(function()
				self:_onClickCell(data, sellOut, priceType, priceId, priceCount, activityId, itemId)
			end, self)
		end
	end
end

function ActivityshopexchangetabView:_clearCell(cell)
	if not cell.gameObject then
		local mainGo = cell
		local goodsTranGo = goutil.findChild(mainGo, "goodsTranGo")
		local consumeImaGo = goutil.findChild(mainGo, "consumeGo/txtPrice/coin")

		GameUtil.rmClickHandler(mainGo)
		MaterialMgr.resetAll(goodsTranGo)
		MaterialMgr.clearIcon(consumeImaGo)
		self:_removeDiscountTimer(mainGo)
	end
end

function ActivityshopexchangetabView:_onClickCell(data, sellOut, priceType, priceId, priceCount, activityId, itemId)
	if sellOut then
		FloatWordMgr.instance:show("已售罄")

		return
	end

	if string.nilorempty(data.sellTime) or not PayShopController.instance:checkTimeStr(data.sellTime) then
		if not string.nilorempty(data.notSellTimeTips) then
			TipsFacade.instance:openCommonTips(data.notSellTimeTips)
		end

		return
	end

	local haveNum = MaterialModel.instance:getMaterialsNumber(priceType, priceId) or 0

	if priceType == MatType.Diamond_Consume then
		priceType = MatType.Diamond
		priceId = MatType.Diamond_Binding
	end

	if ((priceType == MatType.Diamond or nil) and RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()) < checknumber(priceCount) then
		local cfg = MaterialMgr.getMatCfg(priceType, priceId)

		if cfg then
			FloatWordMgr.instance:show(string.format("所需%s不足！", cfg.name))
		else
			FloatWordMgr.instance:show("所需货币不足！")
		end
	else
		UIStateManager.instance:push(ViewName.ActivityshopexchangebuyView, self._activityType, activityId, itemId)
	end
end

function ActivityshopexchangetabView:_isSellOut(data)
	local itemId = data.shopItemId
	local sellOut = false

	if data.sellPeriodLimit ~= "none" then
		local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, itemId)

		sellOut = buyTime >= data.sellLimitCount
	end

	if not sellOut and data.activityLimitCount > 0 then
		local buyTimeInActive = ActivityshopModel.instance:getActiveShopBuyTimesInActivity(self._activityType, self._activityId, itemId)

		sellOut = buyTimeInActive >= data.activityLimitCount
	end

	return sellOut
end

function ActivityshopexchangetabView:_setLimitTxt(data, limitTxt)
	if PayShopController.instance:checkTimeStr(data.sellTime) then
		local itemId = data.shopItemId
		local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, itemId)
		local limitStr = self:_getLimitTypeStr(data.sellPeriodLimit)
		local finalStr = ""

		if not string.nilorempty(limitStr) then
			finalStr = buyTime >= data.sellLimitCount and finalStr .. "\n" .. string.format(limitStr, 0, data.sellLimitCount) or finalStr .. "\n" .. string.format(limitStr, data.sellLimitCount - buyTime, data.sellLimitCount)
		end

		if data.activityLimitCount > 0 then
			local buyTimeInActive = ActivityshopModel.instance:getActiveShopBuyTimesInActivity(self._activityType, self._activityId, itemId)

			finalStr = finalStr .. "\n" .. string.format("活动限兑：%s/%s", data.activityLimitCount - buyTimeInActive, data.activityLimitCount)
		end

		limitTxt.text = string.trim(finalStr)
	elseif string.nilorempty(data.sellTime) then
		limitTxt.text = "未开始售卖"
	elseif data.sellTime == "全天" then
		limitTxt.text = ""
	else
		local arr = string.split(data.sellTime, "|")
		local type = arr[1]
		local timeStr = arr[2]

		if type == "时段" then
			local tem = string.split(timeStr, ",")
			local timeStart = GameUtil.string2time(tem[1])
			local leftTime = timeStart - ServerTime.nowServerLook()

			limitTxt.text = leftTime > 0 and string.format("%s天后开始售卖", math.ceil(leftTime / 86400)) or "未开始售卖"
		else
			limitTxt.text = "未开始售卖"
		end
	end
end

function ActivityshopexchangetabView:_getLimitTypeStr(str)
	if string.nilorempty(str) or str == "none" then
		return
	end

	if str == "daily" then
		return "每日限购 %s/%s"
	end

	if str == "allTime" then
		return "活动限购 %s/%s"
	end

	if str == "weekly" then
		return "每周限购 %s/%s"
	end
end

function ActivityshopexchangetabView:_addDiscountTimer(endTime, cell, txt)
	self._discountTimerList = self._discountTimerList or {}

	if endTime > 0 and txt then
		self._discountTimerList[cell] = {
			endTime = endTime,
			txt = txt
		}
	end
end

function ActivityshopexchangetabView:_removeDiscountTimer(cell)
	if self._discountTimerList then
		self._discountTimerList[cell] = nil
	end
end

function ActivityshopexchangetabView:_onCountDown()
	if not self._discountTimerList then
		return
	end

	local timeNow = ServerTime.now()

	for _, timerInfo in pairs(self._discountTimerList) do
		local leftTime = timerInfo.endTime - timeNow

		if leftTime > 0 then
			local hour, min, sec = GameUtil.getTimeHHMMSS(leftTime)
			local timerStr

			timerInfo.txt.text = langPara("折扣:%s", hour >= 24 and string.format("%s天%02d:%02d:%02d", math.floor(hour / 24), hour % 24, min, sec) or string.format("%02d:%02d:%02d", hour, min, sec))
		else
			self:_reloadPageData()

			return
		end
	end
end

return ActivityshopexchangetabView
