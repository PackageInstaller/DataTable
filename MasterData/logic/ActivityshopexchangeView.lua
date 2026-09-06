-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activityshop/view/ActivityshopexchangeView.lua

module("logic.extensions.activityshop.view.ActivityshopexchangeView", package.seeall)

local ActivityshopexchangeView = class("ActivityshopexchangeView", TableViewComponent)

ActivityshopexchangeView.ShortCellWidth = 200
ActivityshopexchangeView.LongCellWidth = 421
ActivityshopexchangeView.TabTagConst = {
	SHORT = 1,
	LONG = 2
}

function ActivityshopexchangeView:ctor()
	ActivityshopexchangeView.super.ctor(self)
end

function ActivityshopexchangeView:onExitFinished()
	return
end

function ActivityshopexchangeView:onEnterFinished()
	return
end

function ActivityshopexchangeView:buildUI()
	ActivityshopexchangeView.super.buildUI(self)

	self.viewBgGo = self:getGo("viewBgGo")

	local upInfoGo = self:getGo("upInfoTran")

	self.closeClickBtn = Framework.ButtonAdapter.GetFrom(upInfoGo, "closeClickBtn")
	self.supTimeTxt = goutil.findChildTextComponent(upInfoGo, "supTimeTxt")
	self._bgIma = goutil.findChild(upInfoGo, "bgIma")
	self.daibiMainGo = goutil.findChild(upInfoGo, "diabiItem")
	self.daibiIconGo = goutil.findChild(upInfoGo, "diabiItem/daibiIconIma")
	self.daibiCountTxt = goutil.findChild(upInfoGo, "diabiItem/daibiCountTxt"):GetComponent("Text")
	self.daibiAddBtn = Framework.ButtonAdapter.GetFrom(upInfoGo, "diabiItem/daibiAddBtn")
	self._goldBarCon = goutil.findChild(upInfoGo, "goldBarCon")
	self.supTimeTxt.text = ""
	self._roleCon = self:getGo("spriteInfoGo/roleCon")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "spriteInfoGo/bubble/txtTip")
	self._btn_add = self:getBtn("upInfoTran/diabiItem/btn_add")
	self._titleTxt = goutil.findChildTextComponent(self.mainGO, "upInfoTran/titleTxt")
	self._tabcellShortGo = self:getGo("tabcellShort")
	self._tabcellLongGo = self:getGo("tabcellLong")
	self._tabConGo = self:getGo("tabCon")
	self._bubbleGo = self:getGo("spriteInfoGo/bubble")
	self._dragGo = self:getGo("spriteInfoGo/drag")
	self._drag = Framework.UIDragTrigger.Get(self._dragGo)
	self._modelCam = goutil.findChild(self.mainGO, "modelCam")
	self._modelBG = goutil.findChild(self._modelCam, "rolebg")
	self._middleBG = goutil.findChild(self._modelCam, "middleBg")
	self._mainRoleConGo = self:getGo("modelCam/mainRoleCon/con")
	self._btnGoto = self:getBtn("btnGoto")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, nil, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	self._scrollerList:setTagCell(self._tabcellShortGo, ActivityshopexchangeView.TabTagConst.SHORT)
	self._scrollerList:setTagCell(self._tabcellLongGo, ActivityshopexchangeView.TabTagConst.LONG)
	self._scrollerList:regGetTagByIdx(function(data)
		return (self._useLongCell or nil) and (ActivityshopexchangeView.TabTagConst.LONG or ActivityshopexchangeView.TabTagConst.SHORT)
	end)
end

function ActivityshopexchangeView:bindEvents()
	ActivityshopexchangeView.super.bindEvents(self)
	self.closeClickBtn:AddClickListener(self.close, self)
	self._btn_add:AddClickListener(self._onClickbtn_add, self)
	self._btnGoto:AddClickListener(self._onClickGoTo, self)
end

function ActivityshopexchangeView:unbindEvents()
	ActivityshopexchangeView.super.unbindEvents(self)
	self.closeClickBtn:RemoveClickListener()
	self._btn_add:RemoveClickListener()
	self._btnGoto:RemoveClickListener()
end

function ActivityshopexchangeView:onExit()
	ActivityshopexchangeView.super.onExit(self)
	GlobalModel.instance:visibleSceneHUDs(true)
	self._modelCam.transform:SetParent(self.mainGO.transform)
	RoleObjectPool.instance:removeRole(self._roleObj)
	removetimer(self.CalculationSurplusTime, self)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil
	self.goodsInfo = nil
	self._currTabId = 0
	self._currRaceId = false

	GlobalDispatcher:removeListener(GlobalNotify.UpdateActiveShopInfo, self._updateView, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._setCostCoin, self)
	self._drag:RemoveDragListener()
	removetimer(self._onCountDown, self)

	self._discountTimerList = nil

	self._scrollerList:dispose()
end

function ActivityshopexchangeView:destroyUI()
	ActivityshopexchangeView.super.destroyUI(self)

	if self._avatar then
		AvatarsMgrNew.instance:removeAvatar(self._avatar)

		self._avatar = nil
	end
end

function ActivityshopexchangeView:onEnter()
	ActivityshopexchangeView.super.onEnter(self)
	GlobalModel.instance:visibleSceneHUDs(false)
	self._modelCam.transform:SetParent(nil)

	local params = self:getOpenParam()

	self._activityType = checknumber(params[1])
	self._activityId = checknumber(params[2])
	self._currTabId = checknumber(params[3])

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(self._activityType, self._activityId)

	if not isInTime then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(self._activityType)
	end

	if not self._activityId or self._activityId <= 0 then
		return
	end

	ActivityshopModel.instance:clearDailyRed(self._activityType, self._activityId)

	self._activeCfg = ActivityDefineConfig.instance:getCfgById(self._activityType, self._activityId)

	if not self._activeCfg then
		printError("无活动配置", self._activityType, self._activityId)
	end

	ActivityshopModel.instance:clearDailyRed(self._activityType, self._activityId)
	GlobalDispatcher:addListener(GlobalNotify.UpdateActiveShopInfo, self._updateView, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._setCostCoin, self)
	ActivityshopController.instance:getAllShopItemInfo(self._activityType, self._activityId)
	self:ShowSpriteInfo()
	self:_initPageTab()
	self:_setTitle()

	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.viewBgGo, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.viewBgGo.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
	self:showGlodBar()
	settimer(1, self._onCountDown, self)
	GameUtil.SetActive(self._btnGoto, self._activityId == 17043 and self._activityType == 17)
end

function ActivityshopexchangeView:showGlodBar()
	local iconCfg = ActivityshopConfig.instance:getCostIcon(self._activityType, self._activityId)

	if iconCfg then
		local accounts = string.split(iconCfg.icon, "#")
		local btn_list = {}

		for _, v in ipairs(accounts) do
			table.insert(btn_list, {
				showAdd = true,
				id = v
			})
		end

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list)
	end
end

function ActivityshopexchangeView:ShowSpriteInfo()
	if self._activeCfg.processType == 5 then
		GameUtil.SetActive(self._bgIma, false)

		self.supTimeTxt.text = ""
	else
		GameUtil.SetActive(self._bgIma, true)
		settimer(1, self.CalculationSurplusTime, self, true)
		self:CalculationSurplusTime()
	end
end

function ActivityshopexchangeView:CalculationSurplusTime()
	local time = GameUtil.string2time(self._activeCfg.endTime)

	self.supTimer = math.max(0, time - ServerTime.now())
	self.supTimer = self.supTimer - 1

	if self.supTimer < 0 then
		self.supTimeTxt.text = "当前活动结束"

		removetimer(self.CalculationSurplusTime, self)

		return
	end

	local days, hour, min, sec = GameUtil.getTimeDDHHMMSS(self.supTimer)

	self.supTimeTxt.text = self.supTimer > 86400 and string.format("活动剩余时间：%s天%s小时%s分", days, hour, min) or string.format("活动剩余时间：%s小时%s分%s秒", hour, min, sec)
end

function ActivityshopexchangeView:_updataExchangeBuyInfo(dataList, resetPos)
	self._dataList = dataList

	if dataList[1] then
		self.goodsInfo = {}

		local temp = string.split(dataList[1].sellPrice, ":")

		self.goodsInfo[1] = checknumber(temp[1])
		self.goodsInfo[2] = checknumber(temp[2])

		self:_setCostCoin()
	end

	local list1 = {}
	local list2 = {}
	local list3 = {}
	local sellOut = false

	for i, v in ipairs(dataList) do
		local isShow = v.showflag ~= 1

		if isShow then
			sellOut = false

			if v.sellPeriodLimit ~= "none" then
				local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, v.shopItemId)

				if buyTime >= v.sellLimitCount then
					sellOut = true
				end
			end

			if not sellOut and v.activityLimitCount > 0 then
				local buyTimeInActive = ActivityshopModel.instance:getActiveShopBuyTimesInActivity(self._activityType, self._activityId, v.shopItemId)

				sellOut = buyTimeInActive >= v.activityLimitCount
			end

			if not sellOut then
				if PayShopController.instance:checkTimeStr(v.sellTime) then
					table.insert(list1, v)
				else
					table.insert(list3, v)
				end
			else
				table.insert(list2, v)
			end
		end
	end

	table.insertto(list1, list2)
	table.insertto(list1, list3)

	self._curViewDatas = list1

	self._tableview:ReloadData()

	self._needResetPos = self._curViewDatas and #self._curViewDatas > 0 and resetPos
end

function ActivityshopexchangeView:_onReloadFinish()
	if self._needResetPos then
		self._needResetPos = false

		self:moveCellToCenter(1)
	end
end

function ActivityshopexchangeView:_getPath()
	return {
		cellPath = "buyItem",
		viewPath = "buyGoodsSR"
	}
end

function ActivityshopexchangeView:_cellSize()
	return 218, 274
end

function ActivityshopexchangeView:_clearTableview(cell)
	local goodsTranGo = goutil.findChild(cell, "goodsTranGo")

	MaterialMgr.resetAll(goodsTranGo)
	self:_removeDiscountTimer(cell)
end

function ActivityshopexchangeView:_updateCell(view, cell, data)
	local goodsNameTxt = goutil.findChildTextComponent(cell, "goodsNameTxt")
	local limitTxt = goutil.findChildTextComponent(cell, "limitBgIma/limitTxt")
	local goodsTranGo = goutil.findChild(cell, "goodsTranGo")
	local buyOutGo = goutil.findChild(cell, "buyOutGo")
	local buyLimit = goutil.findChild(cell, "buyLimit")
	local consumeImaGo = goutil.findChild(cell, "consumeGo/txtPrice/coin")
	local consumeTxt = goutil.findChildTextComponent(cell, "consumeGo/txtPrice")
	local txtDiscount = goutil.findChildTextComponent(cell, "consumeGo/txtDiscount")
	local goRate = goutil.findChild(cell, "rate")
	local txtRate = goutil.findChildTextComponent(cell, "rate/txtRate")
	local txtDiscountTime = goutil.findChildTextComponent(cell, "limitBgIma/limitTxt/txtDiscountTime")

	MaterialMgr.resetAll(goodsTranGo)

	local itemId = data.shopItemId
	local activityId = data.activityId
	local matSplitList = string.split(data.sellContent, ":")
	local goodsType = checknumber(matSplitList[1])
	local goodsId = checknumber(matSplitList[2])
	local cfg = MaterialMgr.getMatCfg(goodsType, goodsId)
	local colorStr = MaterialMgr.getGoodsColor(goodsType, goodsId)

	goodsNameTxt.text = string.format("<color=%s>%s</color>", colorStr, data.name)
	txtDiscountTime.text = ""

	local sellOut = false
	local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, itemId)
	local buyTimeInActive = ActivityshopModel.instance:getActiveShopBuyTimesInActivity(self._activityType, self._activityId, itemId)

	if data.sellPeriodLimit ~= "none" then
		sellOut = buyTime >= data.sellLimitCount
	end

	if not sellOut and data.activityLimitCount > 0 then
		sellOut = buyTimeInActive >= data.activityLimitCount
	end

	self:_setLimitTxt(itemId, limitTxt)
	self:_removeDiscountTimer(cell)

	local content = data.sellContent

	if string.find(data.sellContent, "^" .. MatType.Cloth .. ":") then
		local arr = string.split(data.sellContent, "#")

		content = arr[Mathf.Min(RoleModel.instance:getGender() + 1, #arr)]
	end

	local subLua = MaterialMgr.setCellByCfg(content, goodsTranGo)

	buyOutGo:SetActive(sellOut)
	buyLimit:SetActive(false)

	if not sellOut and (string.nilorempty(data.sellTime) or not PayShopController.instance:checkTimeStr(data.sellTime)) then
		buyLimit:SetActive(true)
	end

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
			self:_addDiscountTimer(endTime, cell, txtDiscountTime)
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
		GameUtil.asBtn(cell):AddClickListener(function()
			if isNo then
				FloatWordMgr.instance:show("兑换已达上限！")

				return
			end

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
		end, self)
	end
end

function ActivityshopexchangeView:_getLimitTypeStr(str)
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

function ActivityshopexchangeView:_setRole(page)
	local pageCfg = ActivityshopConfig.instance:getActivityShopPageCfg(self._activityType, self._activityId, page)
	local scale = pageCfg.scale
	local pos = pageCfg.pos

	goutil.setActive(self._bubbleGo, false)
	goutil.setActive(self._dragGo, pageCfg.isShowRole)
	goutil.setActive(self._mainRoleConGo, pageCfg.isShowRole)
	goutil.setActive(self._roleCon, not pageCfg.isShowRole)

	if not pageCfg.isShowRole then
		if pageCfg.raceId ~= self._currRaceId then
			self._currRaceId = pageCfg.raceId

			local function loadCallBack(go)
				RoleObjectPool.instance:playAnimation(go, "idle", true, nil, true)
			end

			self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, pageCfg.raceId, self._roleCon, scale, loadCallBack, true, pos[1], pos[2])
		end

		self._txtTip.text = pageCfg.content
	else
		self:_setMainRoleView(pos, scale, pageCfg.roleDressIds)
	end
end

function ActivityshopexchangeView:_initPageTab()
	self._tabDataList = ActivityshopConfig.instance:getActivityShopCfgWithPage(self._activityType, self._activityId) or {}

	local len = #self._tabDataList

	self._useLongCell = len <= 2
	self._scrollerList._tableview.gridWidth = self._useLongCell and ActivityshopexchangeView.LongCellWidth or ActivityshopexchangeView.ShortCellWidth

	self:_updatePageTab()

	if self._currTabId and self._currTabId > 0 then
		self:_switchTab(self._currTabId, true)
	end
end

function ActivityshopexchangeView:_updatePageTab()
	local list = ActivityshopConfig.instance:getActivityShopPageCfgs(self._activityType, self._activityId)

	self._scrollerList:reloadData(list)
end

function ActivityshopexchangeView:_switchTab(tabId, force)
	if self._currTabId == tabId and not force then
		return
	end

	if not ActivityshopModel.instance:isShopPageOpen(self._activityType, self._activityId, tabId) then
		local cfg = ActivityshopConfig.instance:getActivityShopPageCfg(self._activityType, self._activityId, tabId)
		local stime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
		local date = GameUtil.time2date(stime + 86400 * (cfg.optime - 1))

		FloatWordMgr.instance:show(string.format("%s将于%s月%s日%s时开启，敬请期待", cfg.name, date.month, date.day, date.hour))

		return
	end

	self:_setRole(tabId)

	self._currTabId = tabId

	self:_updataExchangeBuyInfo(self._tabDataList[tabId], true)
	self:_updatePageTab()
end

function ActivityshopexchangeView:_onClickbtn_add()
	if self.goodsInfo then
		MaterialMgr.openGetSource(self.goodsInfo[1], self.goodsInfo[2])
	end
end

function ActivityshopexchangeView:_onClickGoTo()
	GotoMgr.gotoByString("ui#preferentialview#3")
end

function ActivityshopexchangeView:_updateView()
	if self._dataList then
		self:_updataExchangeBuyInfo(self._dataList)
	end

	self:_setCostCoin()
end

function ActivityshopexchangeView:_setCostCoin()
	local iconCfg = ActivityshopConfig.instance:getCostIcon(self._activityType, self._activityId)

	if iconCfg == nil then
		goutil.setActive(self.daibiMainGo, true)
		goutil.setActive(self._goldBarCon, false)

		if self.goodsInfo then
			MaterialMgr.setIcon(self.daibiIconGo, self.goodsInfo[1], self.goodsInfo[2])

			local haveCount = MaterialModel.instance:getMaterialsNumber(self.goodsInfo[1], self.goodsInfo[2])

			self.daibiCountTxt.text = tostring(haveCount)
		end
	else
		goutil.setActive(self.daibiMainGo, false)
		goutil.setActive(self._goldBarCon, true)
	end

	self:_updatePageTab()
end

function ActivityshopexchangeView:_setTitle()
	self._titleTxt.text = ActivityshopConfig.instance:getActShopTitleName(self._activityType, self._activityId)
end

function ActivityshopexchangeView:_setMainRoleView(pos, scale, roleDressIds)
	self._drag:AddDragListener(self._onDrag, self)

	if not self._avatar then
		self._avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

		self._avatar:setParent(self._mainRoleConGo.transform)
		self._avatar:setLayer(SceneLayer.UI_Value)

		if RoleModel.instance:getGender() == GameEnum.Gender.Female then
			local avatarMo = DressModel.instance:getDefaultAvatarMo(DressModel.defaultFemaleSkelId or DressModel.defaultMaleSkelId)

			if roleDressIds then
				local temp1 = string.split(roleDressIds, "#")

				for i, v in ipairs(temp1) do
					local temp2 = string.split(v, ":")
					local gender = checknumber(temp2[1])

					if gender == RoleModel.instance:getGender() or gender == GameEnum.Gender.Neutral then
						local list = {}

						for _, drssId in ipairs(string.split(temp2[2], ",")) do
							table.insert(list, checknumber(drssId))
						end

						for i, v in ipairs(list) do
							local dressCfg = DressConfig.instance:getDressCfgById(v)
							local partId = dressCfg.partId
							local partType = AvatarConfig.instance:getPartCfgById(partId).partType
							local isOnDress = avatarMo:isExistDataByCfgId(partId)

							if not isOnDress then
								avatarMo:setDataByCfgId(partId)
							end
						end
					end
				end
			end

			avatarMo:setDefaultState()
			self._avatar:updateByMo(avatarMo)
			self._avatar:updateExtBgParent(self._modelBG, self._middleBG, self)
			self:_updateAvatarPosition(pos, scale)
		end
	end

	self._avatar:setVisible(true)
end

function ActivityshopexchangeView:_onDrag(eventData)
	self:_onRoleTrun(eventData.delta.x)
end

function ActivityshopexchangeView:_onRoleTrun(deltaX)
	local localRotation = Quaternion.Euler(0, -0.5 * deltaX * 1, 0) * self._mainRoleConGo.transform.localRotation
	local eulerAngles = localRotation.eulerAngles

	Framework.TransformUtil.SetLocalRotation(self._mainRoleConGo.transform, 0, eulerAngles.y, 0)
end

function ActivityshopexchangeView:_updateAvatarPosition(pos, scale)
	Framework.TransformUtil.SetLocalPos(self._mainRoleConGo.transform, pos[1], pos[2], 0)
	Framework.TransformUtil.SetLocalScale(self._mainRoleConGo.transform, scale[1], scale[2], 1)
end

function ActivityshopexchangeView:_setLimitTxt(itemId, limitTxt)
	local data = ActivityshopConfig.instance:getActivityShopCfgByItemId(self._activityType, self._activityId, itemId)

	if PayShopController.instance:checkTimeStr(data.sellTime) then
		local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, itemId)
		local limitStr = self:_getLimitTypeStr(data.sellPeriodLimit)
		local finalStr = ""

		if not string.nilorempty(limitStr) then
			finalStr = (data.sellPeriodLimit ~= "none" or nil) and buyTime >= data.sellLimitCount and finalStr .. "\n" .. string.format(limitStr, 0, data.sellLimitCount) or finalStr .. "\n" .. string.format(limitStr, data.sellLimitCount - buyTime, data.sellLimitCount)
		end

		if data.activityLimitCount > 0 then
			local buyTime = ActivityshopModel.instance:getActiveShopBuyTimesInActivity(self._activityType, self._activityId, itemId)

			finalStr = finalStr .. "\n" .. string.format("活动限兑：%s/%s", data.activityLimitCount - buyTime, data.activityLimitCount)
		end

		limitTxt.text = string.trim(finalStr)
	elseif data.sellTime == "全天" then
		limitTxt.text = ""
	else
		local arr = string.split(data.sellTime, "|")
		local type = arr[1]
		local timeStr = arr[2]

		if type == "时段" then
			local tem = string.split(timeStr, ",")
			local timeStart = GameUtil.string2time(tem[1])
			local time = timeStart - ServerTime.nowServerLook()

			limitTxt.text = time > 0 and string.format("%s天后开始售卖", math.ceil(time / 86400)) or "未开始售卖"
		else
			limitTxt.text = "未开始售卖"
		end
	end
end

function ActivityshopexchangeView:_addDiscountTimer(endTime, cell, txt)
	self._discountTimerList = self._discountTimerList or {}

	if endTime > 0 and txt then
		local temCell = {}

		temCell.endTime = endTime
		temCell.txt = txt
		self._discountTimerList[cell] = temCell
	end
end

function ActivityshopexchangeView:_removeDiscountTimer(cell)
	if self._discountTimerList then
		self._discountTimerList[cell] = nil
	end
end

function ActivityshopexchangeView:_onCountDown()
	if self._discountTimerList then
		local timeNow = ServerTime.now()

		for k, v in pairs(self._discountTimerList) do
			local leftTime = v.endTime - timeNow

			if leftTime > 0 then
				local hour, min, sec = GameUtil.getTimeHHMMSS(leftTime)

				v.txt.text = langPara("折扣:%s", hour >= 24 and string.format("%s天%02d:%02d:%02d", math.floor(hour / 24), hour % 24, min, sec) or string.format("%02d:%02d:%02d", hour, min, sec))
			else
				return self._tableview:ReloadData()
			end
		end
	end
end

function ActivityshopexchangeView:_updateTabCell(view, cell, data, tag)
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local lockGo = goutil.findChild(cell.gameObject, "lock")
	local dotGo = goutil.findChild(cell.gameObject, "dot")
	local btn = GameUtil.asBtn(cell.gameObject)
	local changeGrop = cell.gameObject:GetComponent(ComponentType.UIChangeGroup)
	local cfg = ActivityshopConfig.instance:getActivityShopPageCfg(self._activityType, self._activityId, data.page)
	local isOpen = ActivityshopModel.instance:isShopPageOpen(self._activityType, self._activityId, data.page)

	nameText.text = cfg.name

	goutil.setActive(lockGo, not isOpen)
	changeGrop:SetState(self._currTabId == data.page and 1 or 0)

	local dotState = false

	goutil.setActive(dotGo, dotState)
	btn:AddClickListener(function()
		self:_switchTab(data.page)
	end)

	if isOpen and self._currTabId <= 0 then
		self._currTabId = 1

		self:_switchTab(self._currTabId, true)
	end
end

function ActivityshopexchangeView:_clearTabCell(cell)
	return
end

return ActivityshopexchangeView
