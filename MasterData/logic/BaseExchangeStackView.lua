-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exchange/view/stack/BaseExchangeStackView.lua

module("logic.extensions.exchange.view.stack.BaseExchangeStackView", package.seeall)

local BaseExchangeStackView = class("BaseExchangeStackView", TableViewComponent)

function BaseExchangeStackView:_getPath()
	return {
		cellPath = "Cell",
		viewPath = "ScrollView"
	}
end

function BaseExchangeStackView:ctor()
	BaseExchangeStackView.super.ctor(self)
end

function BaseExchangeStackView:unbindEvents()
	GameUtil.rmClickHandler(self.btnRefresh)
	self._inputComp:RemoveOnValueChanged()
	self._fliter:RemoveClickListener()
	self._BtnClear:RemoveClickListener()
end

function BaseExchangeStackView:bindEvents()
	GameUtil.addClickHandler(self.btnRefresh, self.onClickRefresh, self)
	self._inputComp:AddOnValueChanged(self._inputValueChanged, self)
	self._fliter:AddClickListener(self._onClickfliter, self)
	self._BtnClear:AddClickListener(self._onClickBtnClear, self)
end

function BaseExchangeStackView:buildUI()
	BaseExchangeStackView.super.buildUI(self)

	self.btnRefresh = self:getGo("btnRefresh")
	self.itemRefresh = self:getGo("itemRefresh")
	self.itemIcon = self:getGo("itemRefresh/Img_Icon")
	self.itemTxt = self:getTxt("itemRefresh/Text")
	self._txtTips = self:getTxt("tip/Text")
	self._refreshCount = self:getTxt("txtRefreshCount")
	self._inputComp = self:getInput("searchpart/search")
	self._fliter = self:getBtn("searchpart/fliter")
	self._emptyGo = self:getGo("empty")
	self._BtnClear = self:getBtn("searchpart/search/BtnClear")
end

function BaseExchangeStackView:destroyUI()
	return
end

function BaseExchangeStackView:onEnter()
	BaseExchangeStackView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ExchangeRes, self.onReloadData, self)

	self.tabId = checknumber(self._viewPresentor._openParam[1])

	self._inputComp:SetText("")

	self.curSelectId = nil
	self.hasBuy = {}
	self._discountEndTimeStruct = {}
	self._curViewDatas = {}
	self._oriCurViewDatas = {}

	self._tableview:ReloadData()
	self._tableview:SetOffsetWithoutRefresh(0)
	self:_reloadData()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._reloadData, self, NotifyPriority.Low)
	settimer(0, self._updateDiscountTime, self, true)
	goutil.setActive(self._fliter.gameObject, self.tabId == 12)
end

function BaseExchangeStackView:_reloadData()
	local cfg = ExchangeConfig.instance:getTabById(self.tabId)

	if cfg then
		self._txtTips.text = cfg.tips or ""
	end

	ExchangeController.instance:sendGetTabInfo(self.tabId, GameUtil.handler(self.onReloadData, self))
end

function BaseExchangeStackView:onClickRefresh()
	local info = ExchangeModel.instance:getTabItems(self.tabId)

	if info ~= nil and info.refreshTimes then
		local cfg = ExchangeConfig.instance:getCostByTimes(self.tabId, checknumber(info.refreshTimes) + 1)

		if cfg then
			local matType, cfgId, num = self:getItemData(cfg.price, 1)
			local matId = cfgId
			local matNum = num
			local cfg = MaterialMgr.getMatCfg(matType, matId)
			local itemStr = MaterialMgr.createSerName(matType, matId)
			local matStr2 = TipsFacade.instance:getContentMatStr(itemStr, 50, -10, true)
			local content = string.format("是否花费<color=#d44c28>%s</color>%sx%s刷新当前的商品？", lang(cfg.name), matStr2, matNum)

			TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
				if MaterialFacade.instance:getMatNumber(matType, cfgId) >= num then
					ExchangeController.instance:sendRefreshTab(self.tabId, GameUtil.handler(self.onReloadData, self))
				else
					TipsFacade.instance:openCommonTips(lang(string.format("当前%s不足，无法刷新", lang(cfg.name))))
					MaterialMgr.openGetSourceByStr(matType, matId)
				end
			end)
		else
			TipsFacade.instance:openCommonTips(lang("刷新次数已经用完了，请等待次数重置吧"))
		end
	end
end

function BaseExchangeStackView:onReloadData()
	print(">>>>>>>>>>>>>>>>>>>>self._viewPresentor.viewName)", self._viewPresentor.viewName, self._viewPresentor:isOpen())

	if self._viewPresentor:isOpen() then
		local info = ExchangeModel.instance:getTabItems(self.tabId)

		if info ~= nil and info.refreshTimes then
			local cfg = ExchangeConfig.instance:getCostByTimes(self.tabId, info.refreshTimes + 1)

			GameUtil.SetActive(self.btnRefresh, false)
			GameUtil.SetActive(self._refreshCount, false)
			GameUtil.SetGray(self.btnRefresh, true)
			GameUtil.SetActive(self.itemRefresh, false)

			if cfg then
				local tabCfg = ExchangeConfig.instance:getTabById(self.tabId)

				if checknumber(tabCfg.openActivity) > 0 and checknumber(tabCfg.openActivityType) > 0 then
					if ActivityDefineController.instance:isInActivityTimeById(checknumber(tabCfg.openActivityType), checknumber(tabCfg.openActivity)) then
						GameUtil.SetActive(self.btnRefresh, true)
						GameUtil.SetGray(self.btnRefresh, false)
						GameUtil.SetActive(self.itemRefresh, true)
						GameUtil.SetActive(self._refreshCount, true)
					end
				elseif tabCfg.hideRefresh <= 0 then
					GameUtil.SetActive(self.btnRefresh, true)
					GameUtil.SetGray(self.btnRefresh, false)
					GameUtil.SetActive(self.itemRefresh, true)
					GameUtil.SetActive(self._refreshCount, true)
				end

				local resetTotalCount = ExchangeConfig.instance:getResetTotalCount(self.tabId)
				local count = resetTotalCount - info.refreshTimes

				self._refreshCount.text = string.format("今日剩余次数：%s次", count)

				local itemStr = cfg.price

				MaterialMgr.updateItemByStr(self.itemIcon, itemStr, self.itemTxt)
			end

			self._discountEndTimeStruct = {}

			local temp = info:getItems()

			self._oriCurViewDatas = {}

			for i, data in ipairs(temp) do
				if not string.nilorempty(data.cfg.buyTime) then
					local isInBuyTime = GameUtil.checkTimeStr(data.cfg.buyTime)

					if isInBuyTime then
						table.insert(self._oriCurViewDatas, data)
					end
				else
					table.insert(self._oriCurViewDatas, data)
				end
			end

			self:_onReloadData()
		end
	end
end

function BaseExchangeStackView:_refresh()
	self._tableview:Refresh()
end

function BaseExchangeStackView:onEnterFinished()
	return
end

function BaseExchangeStackView:onExit()
	BaseExchangeStackView.super.onExit(self)
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = nil
	self._discountEndTimeStruct = {}

	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._reloadData, self)
	removetimer(self._updateDiscountTime, self)
end

function BaseExchangeStackView:onExitFinished()
	return
end

function BaseExchangeStackView:_cellSize()
	return 304, 98
end

function BaseExchangeStackView:_updateCell(view, cell, data)
	local _icon = goutil.findChild(cell, "Icon")
	local _timeObj = goutil.findChild(cell, "ImgLimit")
	local _timeObjTxt = goutil.findChild(_timeObj, "Text"):GetComponent("Text")
	local _nameTxt = goutil.findChildTextComponent(cell, "TxtName")
	local _priceTxt = goutil.findChildTextComponent(cell, "ImgCnt/TxtPrice")
	local _priceTxt = goutil.findChildTextComponent(cell, "ImgCnt/TxtPrice")
	local _selectObj = goutil.findChild(cell, "ImgSelect")
	local _overObj = goutil.findChild(cell, "imgover")
	local _overTxtObj = goutil.findChild(cell, "imgover/img/Image")
	local txtPreview = goutil.findChildTextComponent(cell, "imgover/img/txtPreview")
	local txtDiscountTime = goutil.findChildTextComponent(cell, "txtDiscountTime")
	local txtLimit = goutil.findChildTextComponent(cell, "txtLimit")
	local txtBuyCount = goutil.findChildTextComponent(cell, "txtBuyCount")
	local _lockObj = goutil.findChild(cell, "lock")
	local markArtifact = goutil.findChild(cell, "markArtifact")

	self._textConGo = goutil.findChild(cell, "textCon")
	self._norText = goutil.findChildTextComponent(cell, "textCon/norText")
	self._norTextTr = self._norText.transform
	self._payIconChange = goutil.findChild(cell, "textCon/norText"):GetComponent(ComponentType.UIChangeGroup)
	self._payIconGo = goutil.findChild(cell, "textCon/norText/payIcon")
	self._disCountText = goutil.findChildTextComponent(cell, "textCon/disCountTxt")
	self._disCountCon = self._disCountText.gameObject
	self._disCountConTr = self._disCountCon.transform
	self._discountLineGo = goutil.findChild(cell, "textCon/norText/payIcon/discountLine")
	txtDiscountTime.text = ""

	goutil.setActive(txtLimit.gameObject, false)
	MaterialMgr.resetAll(_icon)

	local exchangeNum = checknumber(data.info.curBuyNum)
	local isHasExchange = false
	local remainBuyCount = data.cfg.num - checknumber(exchangeNum)

	txtPreview.text = ""

	if ExchangeController.instance:isBuyLimit(data.cfg.commodityProgramId) then
		local posLimitBuyNum = checknumber(data.info.posLimitBuyNum)
		local maxLimitBuyNum = ExchangeController.instance:getSellLimitCount(data.cfg.commodityProgramId)
		local limitLeftNum = maxLimitBuyNum - posLimitBuyNum
		local finalLeftNum = math.min(limitLeftNum, remainBuyCount)

		goutil.setActive(txtBuyCount.gameObject, finalLeftNum > 0)

		txtBuyCount.text = string.format("可购买次数：%s", finalLeftNum)
		isHasExchange = finalLeftNum <= 0
	else
		goutil.setActive(txtBuyCount.gameObject, remainBuyCount > 0)

		txtBuyCount.text = string.format("本轮可购买：%d", remainBuyCount)
		isHasExchange = exchangeNum >= data.cfg.num
	end

	_overObj:SetActive(isHasExchange)
	_overTxtObj:SetActive(isHasExchange)
	goutil.setActive(_lockObj, not data.info.unlock)

	local isOpenTime = true

	if not isHasExchange and not string.nilorempty(data.cfg.appearDate) then
		local timeStr = data.cfg.appearDate .. " 05:00:00"
		local openTime = GameUtil.string2time(timeStr)

		if openTime > ServerTime.now() then
			isOpenTime = false

			if not string.nilorempty(data.cfg.buyTime) then
				local result, startTime = GameUtil.checkTimeStr(data.cfg.buyTime, true)

				if not result then
					local date = GameUtil.time2date(startTime)

					_overObj:SetActive(true)
					_overTxtObj:SetActive(false)

					txtPreview.text = string.format("<color=#EDC374FF>%s月%s日%s时解锁</color>", date.month, date.day, date.hour)
				end
			else
				local date = GameUtil.time2date(openTime)

				_overObj:SetActive(true)
				_overTxtObj:SetActive(false)

				txtPreview.text = string.format("<color=#EDC374FF>%s月%s日%s时解锁</color>", date.month, date.day, date.hour)
			end
		end
	end

	GameUtil.asBtn(cell):RemoveClickListener()
	GameUtil.asBtn(cell):AddClickListener(GameUtil.handler(self.onBtnClick, self, data, isOpenTime))

	if not data.cfg then
		return
	end

	local str = MaterialMgr.changeItemStr(data.cfg.commodity)
	local proxy = MaterialMgr.setCellByCfg(str, _icon)
	local nameText = MaterialModel.instance:getMaterialsNameByStr(str)
	local arr = string.split(str, ":")

	_nameTxt.text = nameText

	GameUtil.SetActive(_timeObj, false)

	local discount = 1
	local isAbsoluteDisc = data.cfg.discountPlanType > 0

	if not isAbsoluteDisc then
		if GameUtil.checkTimeStr(data.cfg.discountTime) then
			discount = data.cfg.discountPercent / 100

			_timeObj:SetActive(data.cfg.discountPercent / 100 * 10 < 10)

			_timeObjTxt.text = tostring(discount * 10) .. "折"
		end
	elseif not string.nilorempty(data.cfg.discountTxt) and GameUtil.checkTimeStr(data.cfg.discountTime) then
		_timeObj:SetActive(true)

		_timeObjTxt.text = data.cfg.discountTxt
	end

	local endTime = self:_getDiscountEndTime(data.cfg.discountTime)

	self._discountEndTimeStruct[cell] = {
		endTime = endTime,
		txtDiscountTime = txtDiscountTime
	}

	self:_setPayBtnTextAndIcon(data.cfg.price)

	if isAbsoluteDisc then
		self:_setDiscountPayBtnTextAndIcon(data.cfg.absoluteDiscountPrice)
	elseif discount < 1 then
		local matType, cfgId, num = self:getItemData(data.cfg.price, discount)

		self:_setDiscountPayBtnTextAndIcon(string.format("%s:%s:%s", matType, cfgId, num))
	end

	goutil.setActive(markArtifact, false)

	local itemType, itemId, itemNum = MaterialMgr.getMatParams(str)

	if itemType == MatType.Equipment then
		local matCfg = MaterialMgr.getMatCfg(itemType, itemId)

		if matCfg.throneRelatedSkinId > 0 and matCfg.afterComposeGroup > 0 then
			local equipInfoList = PetEquipModel.instance:GetEquipInfos(matCfg.afterComposeGroup) or {}

			goutil.setActive(markArtifact, #equipInfoList > 0)
		end
	end

	return cell
end

function BaseExchangeStackView:getItemData(itemStr, discount)
	local info = string.split(itemStr, ":")
	local matType = checknumber(info[1])
	local cfgId = checknumber(info[2])
	local num = 0

	if #info > 2 then
		num = checknumber(info[#info])
	end

	num = math.ceil(num * discount)

	return matType, cfgId, num
end

function BaseExchangeStackView:onBtnClick(data, isOpenTime)
	if not isOpenTime then
		FloatWordMgr.instance:show("未到解锁时间")

		return
	end

	if not data.cfg then
		if data.info and data.info.commodityId then
			printError("t_exchange_commodity缺失配置 id,", data.info.commodityId)
		end

		return
	end

	if not string.nilorempty(data.cfg.buyTime) then
		local isInBuyTime = GameUtil.checkTimeStr(data.cfg.buyTime)

		if not isInBuyTime then
			FloatWordMgr.instance:show("不在购买时间内")

			return
		end
	end

	if not data.info.unlock then
		local conditionHandler = data.cfg.conditionHandler
		local conditionParams = data.cfg.conditionParams
		local showDesc = ""

		if conditionHandler == "Level" then
			showDesc = string.format("达到%s等级即可开启", conditionParams.level)
		elseif conditionHandler == "Time" then
			local timeArr = string.split(conditionParams.time, ",")

			showDesc = string.format("%s - %s开启", timeArr[1], timeArr[2])
		elseif conditionHandler == "Zdl" then
			showDesc = string.format("战斗力达到%s即可开启", conditionParams.zdl)
		end

		FloatWordMgr.instance:show(showDesc)

		return
	end

	self.curSelectId = data.info.posId

	self._tableview:Refresh()

	local discount = 1
	local priceStr = data.cfg.price

	if data.cfg.discountPlanType > 0 then
		priceStr = data.cfg.absoluteDiscountPrice
	elseif PayShopController.instance:checkTimeStr(data.cfg.discountTime) then
		discount = data.cfg.discountPercent / 100
	end

	local exchangeNum = checknumber(data.info.curBuyNum)
	local isHasExchange = false
	local isLimitBuy = false
	local posLimitBuyNum = checknumber(data.info.posLimitBuyNum)
	local maxLimitBuyNum = ExchangeController.instance:getSellLimitCount(data.cfg.commodityProgramId)
	local limitLeftNum = maxLimitBuyNum - posLimitBuyNum

	if ExchangeController.instance:isBuyLimit(data.cfg.commodityProgramId) then
		local finalLeftNum = math.min(limitLeftNum, data.cfg.num - exchangeNum)

		isHasExchange = finalLeftNum <= 0
		isLimitBuy = true
	else
		isHasExchange = exchangeNum >= data.cfg.num
	end

	if not isHasExchange then
		local matType, cfgId, num = self:getItemData(priceStr, discount)
		local matId = cfgId
		local matNum = num
		local targetMat = MaterialMgr.changeItemStr(data.cfg.commodity)
		local costMat = string.format("%s:%s:%s", matType, cfgId, num)
		local maxBuyNum = math.min(data.cfg.num, data.cfg.num - data.info.curBuyNum)

		if isLimitBuy then
			maxBuyNum = math.min(maxBuyNum, limitLeftNum)
		end

		local posId = data.info.posId
		local commodityId = data.info.commodityId

		TipsFacade.instance:openPopupCostManyView(targetMat, costMat, maxBuyNum, nil, nil, function(count)
			if MaterialFacade.instance:checkMatEnough(matType, matId, matNum) then
				ExchangeController.instance:sendExchangeItem(self.tabId, posId, commodityId, count)
			end
		end)
	end
end

function BaseExchangeStackView:_clearTableview(cell)
	local _icon = goutil.findChild(cell, "Icon")

	MaterialMgr.resetAll(_icon)

	local payIcon = goutil.findChild(cell, "textCon/norText/payIcon")

	MaterialMgr.resetAll(payIcon)
end

function BaseExchangeStackView:_getDiscountEndTime(str)
	if string.nilorempty(str) then
		return 0
	end

	if str ~= "全天" then
		local arr = string.split(str, "|")
		local type = arr[1]
		local timeStr = arr[2]

		if type == "时段" then
			local tem = string.split(timeStr, ",")

			return (GameUtil.string2time(tem[2]))
		end
	end

	return 0
end

function BaseExchangeStackView:_updateDiscountTime()
	if table.nums(self._discountEndTimeStruct) <= 0 then
		return
	end

	for k, v in pairs(self._discountEndTimeStruct) do
		local leftTime = v.endTime - ServerTime.nowServerLook()

		if leftTime > 0 then
			local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(leftTime)

			v.txtDiscountTime.text = day > 0 and string.format("折扣剩余:%s天%s时%s分", day, hour, min) or string.format("折扣剩余:%s时%s分%s秒", hour, min, sec)
		else
			v.txtDiscountTime.text = ""
		end
	end
end

function BaseExchangeStackView:_setPayBtnTextAndIcon(payGoodsId)
	goutil.setActive(self._discountLineGo, false)
	goutil.setActive(self._disCountCon, false)
	Framework.TransformUtil.SetAnchoredPos(self._norTextTr, 12, 0)
	goutil.setActive(self._payIconGo, true)

	local list = string.split(payGoodsId, ":")
	local matType = checknumber(list[1])
	local matId = checknumber(list[2])

	self._norText.text = list[#list]

	MaterialMgr.setIcon(self._payIconGo, matType, matId)
end

function BaseExchangeStackView:_setDiscountPayBtnTextAndIcon(payGoodsId)
	self:_setHasDiscPlanPos()
	goutil.setActive(self._discountLineGo, true)
	goutil.setActive(self._disCountCon, true)

	local list = string.split(payGoodsId, ":")
	local matType = checknumber(list[1])
	local matId = checknumber(list[2])

	self._disCountText.text = list[#list]
end

function BaseExchangeStackView:_setHasDiscPlanPos()
	Framework.TransformUtil.SetAnchoredPos(self._norTextTr, -28.5, 0)
	Framework.TransformUtil.SetAnchoredPos(self._disCountConTr, 55, 0)
end

function BaseExchangeStackView:_inputValueChanged(text)
	if text ~= self._searchInputStr then
		self._searchInputStr = text

		self:_onReloadData()
	end
end

function BaseExchangeStackView:_onClickfliter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._fliter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_EXCHANGE_SHOP, pos, sizeDelta, GameUtil.handler(self._updateFilterData, self))
end

function BaseExchangeStackView:_onClickBtnClear()
	self:_inputValueChanged("")
end

function BaseExchangeStackView:_updateFilterData(starList, jobList, rareList)
	self:_onReloadData()
end

function BaseExchangeStackView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function BaseExchangeStackView:_onReloadData()
	self._curViewDatas = self:_fliterWeightZero(self._curViewDatas)
	self._curViewDatas = self:_onFliter()
	self._curViewDatas = self:_sortViewDatas(self._curViewDatas)

	self._tableview:ReloadData()
	goutil.setActive(self._emptyGo, #self._curViewDatas <= 0)
end

function BaseExchangeStackView:_fliterWeightZero(datas)
	local list = {}

	for i, v in ipairs(datas) do
		if v.cfg.weight > 0 then
			table.insert(list, v)
		end
	end

	return list
end

function BaseExchangeStackView:_onFliter()
	local list = self:_fliterSearchByName(self._oriCurViewDatas)

	list = self:_fliterSearchByType(list)

	return list
end

function BaseExchangeStackView:_sortViewDatas(datas)
	local sortList = {}
	local notSortList = {}

	for i, v in ipairs(datas) do
		local cfg = ExchangeConfig.instance:getPlanCfgByCommodityProgram(v.cfg.commodityProgramId)

		if cfg.sort <= 0 then
			table.insert(notSortList, v)
		else
			table.insert(sortList, v)
		end
	end

	table.sort(sortList, function(a, b)
		local cfga = ExchangeConfig.instance:getPlanCfgByCommodityProgram(a.cfg.commodityProgramId)
		local cfgb = ExchangeConfig.instance:getPlanCfgByCommodityProgram(b.cfg.commodityProgramId)

		return cfga.sort > cfgb.sort
	end)
	table.insertto(sortList, notSortList)

	return sortList
end

function BaseExchangeStackView:_fliterSearchByType(items)
	if self.tabId ~= 12 then
		return items
	end

	local filterItems = {}

	for i, data in ipairs(items) do
		if data.cfg then
			local matType, id, matNum = MaterialMgr.getMatParams(data.cfg.commodity)

			if matType == MatType.Equipment then
				local matCfg = MaterialMgr.getMatCfg(matType, id)

				if matCfg.throneRelatedSkinId > 0 and self:_isMatch(matCfg.throneRelatedSkinId) then
					table.insert(filterItems, data)
				end
			else
				table.insert(filterItems, data)
			end
		end
	end

	return filterItems
end

function BaseExchangeStackView:_isMatch(skinId)
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
	local petCo = CharacterConfig.instance:getPetCo(skinCfg.raceId)

	return (PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_EXCHANGE_SHOP, petCo, petCo.rare, skinId))
end

function BaseExchangeStackView:_fliterSearchByName(items)
	local filterItems = {}

	if string.nilorempty(self._searchInputStr) then
		filterItems = items
	else
		for i, data in ipairs(items) do
			if data.cfg and string.find(data.cfg.searchKey, self._searchInputStr) then
				table.insert(filterItems, data)
			end
		end
	end

	return filterItems
end

return BaseExchangeStackView
