-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulatelottery/view/AccumulateLotteryView.lua

module("logic.extensions.accumulatelottery.view.AccumulateLotteryView", package.seeall)

local AccumulateLotteryView = class("AccumulateLotteryView", ViewComponent)
local spineModelId = 1032401

function AccumulateLotteryView:buildUI()
	AccumulateLotteryView.super.buildUI(self)

	self._spineModel = self:getGo("con")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._goldBarCon = self:getGo("goldBarCon")
	self._itemGo = self:getGo("item")
	self._cell_0 = self:getGo("cell_0")
	self._cell_1 = self:getGo("cell_1")
	self._activityTime = self:getTxt("time/txtTime")
	self._itemGo = self:getGo("item")
	self._tableview = self:getGo("tableview"):GetComponent(typeof(UITableviewForLua))
	self._costNode = self:getGo("cost")
	self._costItem = self:getTxt("cost/txtCost")
	self._btnStart = self:getBtn("btnStart")
	self._drawingNode = self:getGo("drawing")
	self._goldBarCon = self:getGo("goldBarCon")
	self._textTips = self:getTxt("txtTips")
	self._discount = self:getGo("discount")
	self._effNode = self:getGo("effNode")
	self._showingRewardsNode = self:getGo("showingRewardsNode")

	self._cell_0:SetActive(false)
	self._cell_1:SetActive(false)
	self._itemGo:SetActive(false)
	self._drawingNode:SetActive(false)
	self._showingRewardsNode:SetActive(false)

	local discountTxt = self:getTxt("discount/txt")

	discountTxt.text = "前2次\n抽奖特惠"
end

function AccumulateLotteryView:bindEvents()
	AccumulateLotteryView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnStart:AddClickListener(self._onClickLottery, self)
	self._btnTip:AddClickListener(self._onClickTips, self)
	self._tableview:RegisterCallback(self._numCellsInTableview, self._cellSizeForIndex, self._tableCellAtIndex, self)
	self._tableview:RegisterReloadFinishCallback(self._onTableviewReloadFinished, self)
end

function AccumulateLotteryView:unbindEvents()
	AccumulateLotteryView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
end

function AccumulateLotteryView:onExit()
	AccumulateLotteryView.super.onExit(self)
	removetimer(self._updateCellsSiblingIndex, self)
	removetimer(self._startFinishCurrStorey, self)
	self:_resetShowRwardsAnim()
	self:_stopButtonEff()
	self:_stopScreenEff()
	RoleObjectPool.instance:removeRole(self._role)

	self._role = nil
	self._drwRuningCells = nil
	self._needMoveOnSetOffset = nil
	self._needShowRewardsAnim = nil

	removetimer(self._tickDrawAtions, self)
	ViewMgr.instance:close(ViewName.Popupwindow)
	self._tableview:Travel(self._clearTableview, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnAccumulateLotteryInfo, self._onAccumulateLotteryInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnAccumulateLotteryDraw, self._onAccumulateLotteryDraw, self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityInfoChange, self._checkActiveYear, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewClose, self._onViewClose, self)
end

function AccumulateLotteryView:onEnter()
	AccumulateLotteryView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnAccumulateLotteryDraw, self._onAccumulateLotteryDraw, self)
	GlobalDispatcher:addListener(GlobalNotify.OnAccumulateLotteryInfo, self._onAccumulateLotteryInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.AnnuityInfoChange, self._checkActiveYear, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClose, self)
	settimer(0, self._updateCellsSiblingIndex, self)

	self._needNeedShowRwardsAnimOnYearBack = false
	self._needShowRewardsAnim = AccumulateLotteryController.instance:needPlayRewardsAnim()

	self:_updateSpineModel()
	self:_refreshActivity()
	self:_openGoldBarCon()
	self:_playButtonEff()
	self:_playScreenEff()
end

function AccumulateLotteryView:_checkActiveYear()
	local annuityId = PayShopModel.instance:getCurAnnuityId()

	if annuityId == 0 then
		PayShopController.instance:getUserAnnuityInfo()

		return
	end

	local currMoney = AccumulateLotteryModel.instance:getMoney()
	local preMoney = AccumulateLotteryModel.instance:getPreMoney()
	local cfg = PayShopConfig.instance:getAnnuityCfgById(annuityId)
	local money = cfg.price
	local itemNum = math.floor(cfg.price * PayModel.RMB_UNIT)

	if money > currMoney + preMoney then
		if AccumulateLotteryController.instance:hasShowYearTips(false) then
			if self._needNeedShowRwardsAnimOnYearBack then
				self:_checkNeedShowRwardsAnim()
			end

			return
		end

		AccumulateLotteryController.instance:setShowYearTips(false)
		TipsFacade.instance:openTipWindow(lang("tip"), string.format("激活年费卡，可直接领取%s，全年年费累充活动均有效，免费领取奖励", self:_getGainAnnuityPrizeMatName() .. "*" .. itemNum), function()
			PayShopController.instance:openView(GameEnum.PayShopEasyJump.YearCard)
		end, "激活年费")

		return
	end

	if AccumulateLotteryController.instance:hasShowYearTips(true) then
		if self._needNeedShowRwardsAnimOnYearBack then
			self:_checkNeedShowRwardsAnim()
		end

		return
	end

	AccumulateLotteryController.instance:setShowYearTips(true)

	if preMoney == 0 or money <= preMoney then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), string.format("您已经成为年费，可直接领取%s，全年年费累充活动均有效，免费领取奖励！", self:_getGainAnnuityPrizeMatName() .. "*" .. itemNum), function()
			return
		end, "知道了")
	else
		TipsFacade.instance:openTipWindowNoX(lang("tip"), string.format("您当前已经激活年费至尊卡，现为您补发%d个%s，全年年费累充活动均有效，免费领取奖励！", math.floor(preMoney * PayModel.RMB_UNIT), self:_getGainAnnuityPrizeMatName()), function()
			return
		end, "知道了")
	end
end

function AccumulateLotteryView:_getGainAnnuityPrizeMatName()
	local activityId = AccumulateLotteryModel.instance:getActivityId()
	local acCo = AccumulateLotteryConfig.instance:getActivityCo(activityId)
	local arr = string.split(acCo.itemId, ":")

	return (MaterialMgr.getMaterialsName(checknumber(arr[1]), checknumber(arr[2])))
end

function AccumulateLotteryView:_updateExchangeUnit()
	local activityId = AccumulateLotteryModel.instance:getActivityId()

	if activityId == 0 then
		return
	end

	local acCo = AccumulateLotteryConfig.instance:getActivityCo(activityId)
	local matName = self:_getGainAnnuityPrizeMatName()

	self._textTips.text = string.format("充值1元=%d%s", acCo.getProps, matName)

	self._textTips.gameObject:SetActive(true)
end

function AccumulateLotteryView:_updateSpineModel()
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, spineModelId, self._spineModel)
end

function AccumulateLotteryView:_openGoldBarCon()
	local consumesCo = AccumulateLotteryConfig.instance:getActivities()
	local consumesMap = {}

	for i = 1, #consumesCo do
		local arr = string.split(consumesCo[i].itemId, ":")
		local gType = arr[1] .. ":" .. arr[2]

		consumesMap[gType] = true
	end

	local btnList = {}

	for k, v in pairs(consumesMap) do
		table.insert(btnList, {
			showAdd = true,
			id = k
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)
end

function AccumulateLotteryView:_refreshActivity()
	self:_resetShowRwardsAnim()
	self._drawingNode:SetActive(false)
	self._textTips.gameObject:SetActive(false)
	self._discount:SetActive(false)

	local activityInfo = AccumulateLotteryModel.instance:getActivityInfo()
	local activityId = AccumulateLotteryModel.instance:getActivityId()

	self._needMoveInSight = not self._currDrawStorey or self._currDrawStorey ~= AccumulateLotteryModel.instance:getCurStorey()
	self._currDrawStorey = AccumulateLotteryModel.instance:getCurStorey()

	if activityId == 0 or not activityInfo then
		self:_onNoActivityOpened()

		if not activityInfo then
			AccumulateLotteryController.instance:requestActivityInfo()
		end

		return
	end

	self._discount:SetActive(AccumulateLotteryModel.instance:getCurLotteryTimes() < 2)
	self._btnStart.gameObject:SetActive(true)
	self:_updateLotteryConsume(activityId)
	self:_updateActivityTime(activityId)
	self:_updateExchangeUnit()

	self._activitiesStoreyData = AccumulateLotteryConfig.instance:getActivitiesStorey(activityId)

	self:_checkActiveYear()
	self._tableview:ReloadData()
end

function AccumulateLotteryView:_resetShowRwardsAnim()
	if self._tableview.isReady then
		local contentNode = self._tableview:GetContent()

		UnityTweens.TweenBase.DestroyAll(contentNode)
	end

	self._showingRewardsNode:SetActive(false)
end

function AccumulateLotteryView:_checkNeedShowRwardsAnim()
	if not self._tableview.isReady then
		return
	end

	if self._needShowRewardsAnim then
		local topView = GlobalModel.instance:getTopView()

		if not topView or topView.viewName ~= self._viewPresentor.viewName then
			return
		end

		if PayShopModel.instance:getCurAnnuityId() == 0 then
			self._needNeedShowRwardsAnimOnYearBack = true

			return
		end

		self._needNeedShowRwardsAnimOnYearBack = false
		self._needShowRewardsAnim = false

		AccumulateLotteryController.instance:setPlayRewardsAnim()

		local offset = self._tableview:GetOffset()
		local maxOfs = self._tableview:GetMaxOffset()

		if maxOfs <= offset then
			return
		end

		self._showingRewardsNode:SetActive(true)

		local contentNode = self._tableview:GetContent()

		UnityTweens.TweenBase.DestroyAll(contentNode)

		local duration = math.abs(maxOfs - offset) / 200
		local startPos = Vector3.New(0, -offset, 0)
		local destPos = Vector3.New(0, -maxOfs, 0)
		local tweenShow = UnityTweens.TweenPosition.Create(contentNode, startPos, destPos, duration, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.Anchor)
		local tweenBack = UnityTweens.TweenPosition.Create(contentNode, destPos, startPos, duration, UnityTweens.EaseType.linear, 0.5, UnityTweens.CoordSpace.Anchor)
		local tweenSeq = UnityTweens.TweenSequence.StartTween(contentNode, tweenShow, tweenBack)

		tweenSeq:AddListener(function()
			self:_resetShowRwardsAnim()
		end)
	end
end

function AccumulateLotteryView:_onNoActivityOpened()
	self._activitiesStoreyData = nil
	self._activityTime.text = "活动未开启"

	self._costNode:SetActive(false)
	self._btnStart.gameObject:SetActive(false)
	self._drawingNode:SetActive(false)
	self._showingRewardsNode:SetActive(false)
	self._tableview:ReloadData()
end

function AccumulateLotteryView:_updateActivityTime(activityId)
	local activityCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.AccumulateLottery, activityId)
	local startTime = GameUtil.string2date(activityCfg.startTime)
	local endTime = GameUtil.string2date(activityCfg.endTime)

	self._activityTime.text = string.format("活动时间:%d月%d日%d:%02d-%d月%d日%d:%02d", startTime.month, startTime.day, startTime.hour, startTime.min, endTime.month, endTime.day, endTime.hour, endTime.min)
end

function AccumulateLotteryView:_updateLotteryConsume(activityId)
	local times = AccumulateLotteryModel.instance:getCurLotteryTimes() + 1
	local consume = AccumulateLotteryConfig.instance:getLotteryConsume(activityId, times)

	if string.nilorempty(consume) then
		self._costNode:SetActive(false)

		return
	end

	local arr = string.split(consume, ":")
	local matName = MaterialMgr.getMaterialsName(checknumber(arr[1]), checknumber(arr[2]))

	if string.nilorempty(matName) then
		self._costNode:SetActive(false)

		return
	end

	self._costNode:SetActive(true)

	self._costItem.text = string.format("消耗%s：%s张", matName, arr[3] or 0)
end

function AccumulateLotteryView:_playButtonEff()
	if self._btnLotteryEff then
		return
	end

	self._btnLotteryEff = UIEffectManager.instance:playEffectBrief(self, "fx_ui_leichong/fx_ui_leichong_anniu.prefab", self._btnStart.transform, true)

	self._btnLotteryEff:setParent(self._btnStart.transform)
	self._btnLotteryEff:setScale(1)
	self._btnLotteryEff:setLocalPos(0, 0, 0)
end

function AccumulateLotteryView:_stopButtonEff()
	if not self._btnLotteryEff then
		return
	end

	UIEffectManager.instance:stopEffect(self._btnLotteryEff)

	self._btnLotteryEff = nil
end

function AccumulateLotteryView:_playScreenEff()
	if self._screenEff then
		return
	end

	self._screenEff = UIEffectManager.instance:playEffectBrief(self, "fx_ui_leichong/fx_ui_leichong_choujiang.prefab", self._effNode.transform, true)

	self._screenEff:setParent(self._effNode.transform)
	self._screenEff:setScale(1)
	self._screenEff:setLocalPos(0, 0, 0)
end

function AccumulateLotteryView:_stopScreenEff()
	if not self._screenEff then
		return
	end

	UIEffectManager.instance:stopEffect(self._screenEff)

	self._screenEff = nil
end

function AccumulateLotteryView:_onTableviewReloadFinished()
	if self._needMoveInSight then
		self._needMoveInSight = false

		self:_moveCurrCellInView(self._needMoveOnSetOffset and not self._needShowRewardsAnim)
	end
end

function AccumulateLotteryView:_moveCurrCellInView(movable)
	local cellNum = self:_numCellsInTableview()

	if cellNum > 0 and cellNum >= self._currDrawStorey then
		local offset = self._tableview:GetOffsetByIndex(self._currDrawStorey - 1)
		local minOfs = self._tableview:GetMinOffset()
		local maxOfs = self._tableview:GetMaxOffset()

		self._tableview:SetOffset(math.min(math.max(offset, minOfs), maxOfs), movable or false)
		self:_checkNeedShowRwardsAnim()
	end
end

function AccumulateLotteryView:_numCellsInTableview()
	if not self._activitiesStoreyData then
		return 0
	end

	return #self._activitiesStoreyData
end

function AccumulateLotteryView:_cellSizeForIndex(view, idx)
	local datas = self._activitiesStoreyData[idx + 1]

	if #datas > 1 then
		if #self._activitiesStoreyData == idx + 1 then
			return 600, 118
		end

		return 600, 108
	end

	return 600, 185
end

function AccumulateLotteryView:_tableCellAtIndex(view, idx)
	local datas = self._activitiesStoreyData[idx + 1]
	local cell = self:_getCell(#datas)

	self:_fillCell(cell, datas, idx)

	return cell
end

function AccumulateLotteryView:_getCell(len)
	local tag = 0

	if len == 1 then
		tag = 1
	end

	local cell = self._tableview:DequeueCellByTag(tag)

	cell = cell or tag == 0 and self._tableview:AddChild(self._cell_0, 0) or self._tableview:AddChild(self._cell_1, 1)

	return cell
end

function AccumulateLotteryView:_fillCell(cell, datas, idx)
	self:_fillCellItems(cell, datas, idx)
	self:_adjustBgSize(cell.gameObject, #datas, idx)
	self:_updateOver(cell.gameObject, idx)
end

function AccumulateLotteryView:_fillCellItems(cell, datas, idx)
	local group = goutil.findChild(cell.gameObject, "group")
	local groupLayout = group:GetComponent(ComponentType.UILayoutSingleLine)
	local numItems = #datas
	local transform = group.transform
	local cnt = transform.childCount

	while cnt < numItems do
		UGUIToolHelper.AddChild(transform.gameObject, self._itemGo)

		cnt = cnt + 1
	end

	for i = 1, numItems do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(true)
		self:_fillItem(go, datas[i], idx)
	end

	for i = numItems + 1, cnt do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	if groupLayout then
		groupLayout:Layout()
	end
end

function AccumulateLotteryView:_adjustBgSize(go, numItems, idx)
	local groupBg = goutil.findChild(go, "groupBg")
	local nowBg = goutil.findChild(go, "nowBg")
	local over = goutil.findChild(go, "over")
	local signLeft = goutil.findChild(go, "signLeft")
	local signRight = goutil.findChild(go, "signRight")
	local curStorey = AccumulateLotteryModel.instance:getCurStorey()
	local width = numItems * 100 + 8

	if groupBg then
		local transGroup = groupBg.transform
		local sizeDelta = transGroup.sizeDelta

		sizeDelta.x = width
		transGroup.sizeDelta = sizeDelta

		groupBg:SetActive(idx + 1 ~= curStorey)
	end

	if nowBg then
		local transnowBg = nowBg.transform
		local sizeDelta = transnowBg.sizeDelta

		sizeDelta.x = width
		transnowBg.sizeDelta = sizeDelta

		nowBg:SetActive(idx + 1 == curStorey)
	end

	if numItems > 1 then
		local sizeDelta = over.transform.sizeDelta

		sizeDelta.x = width
		over.transform.sizeDelta = sizeDelta
	end

	if signLeft and signRight then
		local isActived = numItems >= 2 and numItems <= 4

		signLeft:SetActive(isActived)
		signRight:SetActive(isActived)

		if isActived then
			local posx, _, _ = Framework.TransformUtil.GetLocalPos(groupBg.transform, nil, nil, nil)
			local lx = posx - width * 0.5
			local rx = posx + width * 0.5

			Framework.TransformUtil.SetLocalPos(signLeft.transform, lx, 58, 0)
			Framework.TransformUtil.SetLocalPos(signRight.transform, rx, 58, 0)
		end
	end
end

function AccumulateLotteryView:_updateOver(go, idx)
	local curStorey = AccumulateLotteryModel.instance:getCurStorey()
	local overImg = goutil.findChild(go, "imgOver")
	local over = goutil.findChild(go, "over")

	UnityTweens.UITweenFade.StopTween(over.gameObject)
	UnityTweens.TweenScale.StopTween(overImg.gameObject)
	Framework.TransformUtil.SetLocalScale(overImg.transform, 1, 1, 1)
	UGUIToolHelper.SetGraphicAlpha(over:GetComponent(goutil.Type_UIImage), 0.5)
	over:SetActive(curStorey > idx + 1)
	overImg:SetActive(curStorey > idx + 1)
end

function AccumulateLotteryView:_fillItem(go, data, idx)
	local tag = goutil.findChild(go, "tag")
	local tagText = goutil.findChildTextComponent(go, "tag/txt")
	local gain = goutil.findChild(go, "gain")
	local sel = goutil.findChild(go, "select")
	local prizeCon = goutil.findChild(go, "con")
	local curStorey = AccumulateLotteryModel.instance:getCurStorey()

	tagText.text = data.rules

	tag:SetActive(not string.nilorempty(data.rules))
	sel:SetActive(false)
	gain:SetActive(AccumulateLotteryModel.instance:hasGainPrize(data.rewardId))

	local prize = MaterialMgr.changeItemStr(data.reward or "")

	MaterialMgr.resetAll(prizeCon)

	local proxy = MaterialMgr.setCellByCfg(prize, prizeCon)

	if proxy then
		proxy.binder:setEffStatus(curStorey <= idx + 1)
	end
end

function AccumulateLotteryView:_clearTableview(cell)
	local group = goutil.findChild(cell.gameObject, "group")
	local transform = group.transform
	local cnt = transform.childCount

	for i = 0, cnt - 1 do
		local go = transform:GetChild(i).gameObject
		local prizeCon = goutil.findChild(go, "con")

		MaterialMgr.resetAll(prizeCon)
	end
end

function AccumulateLotteryView:_onClickClose()
	self:close()
end

function AccumulateLotteryView:_onClickTips()
	TipsFacade.instance:openRulesView("goldendragonraffle")
end

function AccumulateLotteryView:_onClickLottery()
	local curStorey = AccumulateLotteryModel.instance:getCurStorey()

	if not self._activitiesStoreyData or curStorey > #self._activitiesStoreyData then
		FloatWordMgr.instance:show("奖励已经抽完啦")

		return
	end

	local activityId = AccumulateLotteryModel.instance:getActivityId()
	local times = AccumulateLotteryModel.instance:getCurLotteryTimes() + 1
	local consume = AccumulateLotteryConfig.instance:getLotteryConsume(activityId, times)

	if string.nilorempty(consume) then
		return
	end

	local arr = string.split(consume, ":")
	local matType = checknumber(arr[1])
	local matId = checknumber(arr[2])
	local itemNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
	local consumeNum = checknumber(arr[3])

	if itemNum < consumeNum then
		MaterialMgr.openGetSource(matType, matId)

		return
	end

	local index = self._currDrawStorey - 1
	local cell = self._tableview:GetCellAtIndex(index)

	if not cell then
		self:_moveCurrCellInView(false)
	end

	AccumulateLotteryAgent.instance:sendAnnuityAccumulateLotteryDrawReq(activityId)
end

function AccumulateLotteryView:_onAccumulateLotteryInfo()
	self:_refreshActivity()
end

function AccumulateLotteryView:_onAccumulateLotteryDraw()
	local drawPrizeId, drawChangeSet = AccumulateLotteryModel.instance:getLotteryResult()

	self._drawPrizeId = drawPrizeId
	self._drawChangeSet = drawChangeSet

	self:_startDrawPerform()
end

function AccumulateLotteryView:_startDrawPerform()
	self._drawingNode:SetActive(true)
	self:_buildDrawRunningCells()
	self:_runLotteryDrawActions()
end

function AccumulateLotteryView:_buildDrawRunningCells()
	local index = self._currDrawStorey - 1
	local cell = self._tableview:GetCellAtIndex(index)

	if not cell then
		self:_moveCurrCellInView(false)

		cell = self._tableview:GetCellAtIndex(index)
	end

	local datas = self._activitiesStoreyData[index + 1]
	local currPrizeCnt = 0
	local accModel = AccumulateLotteryModel.instance

	for i = 1, #datas do
		if datas[i].rewardId == self._drawPrizeId or not accModel:hasGainPrize(datas[i].rewardId) then
			currPrizeCnt = currPrizeCnt + 1
		end
	end

	if currPrizeCnt == 1 then
		return
	end

	local childCount = #datas

	self._drwRuningCells = self._drwRuningCells or {}

	table.clear(self._drwRuningCells)

	local group = goutil.findChild(cell.gameObject, "group")
	local start = 0
	local step = 1
	local endIdx = childCount - 1
	local round = math.random(5, 8)

	for i = 1, round do
		for j = start, endIdx, step do
			if datas[j + 1].rewardId == self._drawPrizeId or not accModel:hasGainPrize(datas[j + 1].rewardId) then
				local child = group.transform:GetChild(j).gameObject

				if self._drwRuningCells[#self._drwRuningCells] ~= child then
					table.insert(self._drwRuningCells, child)
				end
			end
		end

		if step > 0 then
			step = -1
			start = endIdx - 1
			endIdx = 0
		else
			step = 1
			start = 1
			endIdx = childCount - 1
		end
	end

	local prizeIndex

	for i = 1, #datas do
		if datas[i].rewardId == self._drawPrizeId then
			prizeIndex = i - 1

			break
		end
	end

	for i = start, prizeIndex, step do
		if datas[i + 1].rewardId == self._drawPrizeId or not accModel:hasGainPrize(datas[i + 1].rewardId) then
			local child = group.transform:GetChild(i).gameObject

			if self._drwRuningCells[#self._drwRuningCells] ~= child then
				table.insert(self._drwRuningCells, child)
			end
		end
	end
end

function AccumulateLotteryView:_runLotteryDrawActions()
	if not self._drwRuningCells or #self._drwRuningCells == 0 then
		self:_onLotteryDrawFinished()

		return
	end

	settimer(0, self._tickDrawAtions, self, true)

	self._startTimeStep = 0.3
	self._curTimeStep = self._startTimeStep
	self._timeStep = 0.1
	self._endTimeStep = 0.3
	self._timeCount = 0
	self._currShowCellIndex = 0
	self._phase = 0
	self._phaseChangeCount = 0
end

function AccumulateLotteryView:_tickDrawAtions()
	local deltaTime = UnityEngine.Time.deltaTime

	self._timeCount = self._timeCount + deltaTime

	if self._timeCount >= self._curTimeStep then
		self._timeCount = self._timeCount - self._curTimeStep

		local preCell = self._drwRuningCells[self._currShowCellIndex]

		self._currShowCellIndex = self._currShowCellIndex + 1

		local currCell = self._drwRuningCells[self._currShowCellIndex]

		if currCell then
			if preCell then
				local sel = goutil.findChild(preCell, "select")

				sel:SetActive(false)
			end

			local sel = goutil.findChild(currCell, "select")

			sel:SetActive(true)
		else
			self:_onLotteryDrawFinished()

			return
		end

		self:_updatePhase(deltaTime)
	end
end

function AccumulateLotteryView:_updatePhase(deltaTime)
	if self._phase == 0 then
		self._curTimeStep = self._curTimeStep - deltaTime

		if self._curTimeStep <= self._timeStep then
			self._curTimeStep = self._timeStep
			self._phaseChangeCount = self._currShowCellIndex
			self._phase = 1
		end
	elseif self._phase == 1 then
		if #self._drwRuningCells - self._currShowCellIndex <= self._phaseChangeCount then
			self._phase = 2
		end
	elseif self._phase == 2 then
		self._curTimeStep = self._curTimeStep + deltaTime

		if self._curTimeStep > self._endTimeStep then
			self._curTimeStep = self._endTimeStep
		end
	end
end

function AccumulateLotteryView:_onLotteryDrawFinished()
	removetimer(self._tickDrawAtions, self)

	if self._drwRuningCells then
		table.clear(self._drwRuningCells)
	end

	AccumulateLotteryModel.instance:resetLotteryResult()

	if self._drawChangeSet then
		MaterialController.instance:showChangeSetInTemp(self._drawChangeSet)
	else
		self:_finishOneLottery()
	end

	self._drawChangeSet = nil
	self._drawPrizeId = nil
end

function AccumulateLotteryView:_updateCellsSiblingIndex()
	if not self._tableview.isReady then
		return
	end

	local cnt = self._tableview:GetVisibleCount() - 1
	local minIdx = 99999

	for i = 0, cnt do
		local cell = self._tableview:GetCellByIndex(i)
		local index = cell.index

		if index < minIdx then
			minIdx = index
		end
	end

	for i = 0, cnt do
		local cell = self._tableview:GetCellByIndex(i)
		local index = cell.index

		cell.transform:SetSiblingIndex(index - minIdx)
	end
end

function AccumulateLotteryView:_finishOneLottery()
	removetimer(self._startFinishCurrStorey, self)

	local curStorey = AccumulateLotteryModel.instance:getCurStorey()

	if curStorey ~= self._currDrawStorey then
		local datas = self._activitiesStoreyData[self._currDrawStorey]
		local cell = self._tableview:GetCellAtIndex(self._currDrawStorey - 1)

		self:_fillCellItems(cell, datas, self._currDrawStorey - 1)
		settimer(0.5, self._startFinishCurrStorey, self, false)
	else
		self:_onFinishCurrStoreyFinished()
	end
end

function AccumulateLotteryView:_startFinishCurrStorey()
	removetimer(self._startFinishCurrStorey, self)

	local cell = self._tableview:GetCellAtIndex(self._currDrawStorey - 1)
	local over = goutil.findChild(cell.gameObject, "over")
	local overImg = goutil.findChild(cell.gameObject, "imgOver")

	UGUIToolHelper.SetGraphicAlpha(over:GetComponent(goutil.Type_UIImage), 0.5)
	UnityTweens.UITweenFade.StartTween(over.gameObject, 0, 0.5, 0.5, UnityTweens.EaseType.linear)
	UnityTweens.TweenScale.StartTween(overImg.gameObject, Vector3.New(10, 10, 10), Vector3.New(1, 1, 1), 0.5, UnityTweens.EaseType.easeOutBack):AddListener(self._onFinishCurrStoreyFinished, self)
	over:SetActive(true)
	overImg:SetActive(true)
end

function AccumulateLotteryView:_onFinishCurrStoreyFinished()
	self._needMoveOnSetOffset = true

	self._drawingNode:SetActive(false)
	self:_refreshActivity()
end

function AccumulateLotteryView:_onViewClose(view)
	if view.viewName == ViewName.ItemGet then
		self:_finishOneLottery()

		return
	end

	self:_checkNeedShowRwardsAnim()
end

return AccumulateLotteryView
