-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/dragonspirit/ActivityDragonSpiritView.lua

module("logic.extensions.operationsummary.view.dragonspirit.ActivityDragonSpiritView", package.seeall)

local ActivityDragonSpiritView = class("ActivityDragonSpiritView", ViewComponent)

function ActivityDragonSpiritView:ctor()
	ActivityDragonSpiritView.super.ctor(self)
end

function ActivityDragonSpiritView:buildUI()
	ActivityDragonSpiritView.super.buildUI(self)

	self._leftTop = goutil.findChild(self.mainGO, "leftTop")
	self._btnTips = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._rightCol = goutil.findChild(self.mainGO, "rightCol")
	self._goldBarCon = goutil.findChild(self.mainGO, "rightCol/goldBarCon")
	self._goldItemCon = goutil.findChild(self.mainGO, "rightCol/goldBarCon/item")
	self._txtGoldNum = goutil.findChildTextComponent(self.mainGO, "rightCol/goldBarCon/txtNum")
	self._btnLotteryBox = goutil.findChild(self.mainGO, "lotteryBox/btnLotteryBox")
	self._txtBoxCount = goutil.findChildTextComponent(self.mainGO, "lotteryBox/btnLotteryBox/txtCount")
	self._txtTipCost = MaterialMgr.findGraphicText(self.mainGO, "lotteryBox/btnLotteryBox/cost/txtTip")
	self._boxEffGo = goutil.findChild(self.mainGO, "lotteryBox/effect")
	self._boxEff = nil
	self._scrollerview = goutil.findChild(self.mainGO, "rightCol/scrollerview")
	self._scrollercell = goutil.findChild(self.mainGO, "rightCol/scrollercell")

	local updateCellCallBack = GameUtil.handler(self._updateTaskCell, self)
	local clearCellCallBack = GameUtil.handler(self._clearTaskCell, self)

	self._taskScrollList = ScrollerList.create(self._scrollerview, self._scrollercell, updateCellCallBack, clearCellCallBack)
	self._bubble = goutil.findChild(self.mainGO, "scoreprogressview/bubble")
	self._btnbubTip = goutil.findChild(self.mainGO, "scoreprogressview/total/btnTip")
	self._closeBub = goutil.findChild(self.mainGO, "scoreprogressview/bubble/btnClose")
	self._txtBub = goutil.findChildTextComponent(self.mainGO, "scoreprogressview/bubble/txtDesc")
	self._progressNum = goutil.findChildTextComponent(self.mainGO, "scoreprogressview/total/txtNum")
	self._scrollerGo = goutil.findChild(self.mainGO, "scoreprogressview/scrollerview")

	local cellGo = goutil.findChild(self.mainGO, "scoreprogressview/scrollercell")
	local updateCellHandler = GameUtil.handler(self._updateProgressCell, self)
	local clearCellHandler = GameUtil.handler(self._clearProgressCell, self)

	self._lotteryProgress = ProgressList.create(self._scrollerGo, cellGo, updateCellHandler, clearCellHandler)
	self._progressEffList = {}
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._effectGo = goutil.findChild(self.mainGO, "effect")
	self._effect = nil
	self._mask = goutil.findChild(self.mainGO, "mask")

	GameUtil.SetActive(self._mask, false)

	self._skipAnim = self:getToggle("btnSkipAnim")
end

function ActivityDragonSpiritView:bindEvents()
	ActivityDragonSpiritView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnbubTip, self._popBubble, self)
	GameUtil.addClickHandler(self._closeBub, self._closeBubble, self)
	GameUtil.addClickHandler(self._skipAnim.gameObject, self._onClickBtnSkipAmin, self)
end

function ActivityDragonSpiritView:unbindEvents()
	ActivityDragonSpiritView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTips)
	GameUtil.rmClickHandler(self._btnbubTip)
	GameUtil.rmClickHandler(self._closeBub)
	GameUtil.rmClickHandler(self._skipAnim.gameObject)
end

function ActivityDragonSpiritView:destroyUI()
	ActivityDragonSpiritView.super.destroyUI(self)
end

function ActivityDragonSpiritView:onEnter()
	ActivityDragonSpiritView.super.onEnter(self)

	self._activityId = 17033
	self._showTypes = {
		161,
		162,
		163,
		164,
		165,
		166
	}
	self.cfg_base = OperationSummaryConfig.instance:getTaskBaseCfg(self._activityId)
	self.cfg_items = OperationSummaryConfig.instance:getTaskItemsCfg(self._activityId)
	self.cfg_deta = OperationSummaryConfig.instance:getTaskDetailsCfg(self._activityId)
	self.cfg_lottery_progress = OperationSummaryConfig.instance:getLotteryProgressCfg(self._activityId)
	self._isUseLottery = self.cfg_base.lotteryProgressPlanId ~= 0

	if not self._isUseLottery then
		FloatWordMgr.instance:show("没有开启抽奖功能")
		self:_onClickBtnClose()
	end

	GlobalDispatcher:addListener(GlobalNotify.PM_ActivitySummaryGetTaskInfo, self._onUpdateUI, self)
	OpSummaryController.instance:sendGetAllTask(self._activityId)
	self:_setPlaneUI()
end

function ActivityDragonSpiritView:onExit()
	ActivityDragonSpiritView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ActivitySummaryGetTaskInfo, self._onUpdateUI, self)

	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end

	if self._boxEffGo and self._boxEff then
		UIEffectManager.instance:stopEffect(self._boxEff)

		self._boxEff = nil
	end

	if self._goldItemCon then
		MaterialMgr.clearIcon(self._goldItemCon)
	end

	for _, eff in pairs(self._progressEffList) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self._progressEffList = {}

	self._taskScrollList:dispose()
	self._lotteryProgress:dispose()
end

function ActivityDragonSpiritView:_setPlaneUI()
	if self._txtTitle then
		self._txtTitle.text = self.cfg_base.summaryName or "未配置"
	end

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.Summary, self._activityId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	if self._txtOpenTime then
		self._txtOpenTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end

	if self._txtTipCost then
		local costNum = self.cfg_base.lotteryCostNum
		local conStr = MaterialMgr.getContentMatStr(self.cfg_base.lotteryFakeId, 40, -14, MaterialMgr.ICON_TYPE_ICON)

		self._txtTipCost.text = langPara("消耗 <color=#ffd30d>%s</color> %s开启", costNum, conStr)
	end

	if self._effectGo then
		local isNeedEff = not string.nilorempty(self.cfg_base.effect)

		if isNeedEff then
			UIEffectManager.instance:stopEffect(self._effect)

			local effPath = self.cfg_base.effect .. ".prefab"

			local function func(_, eff)
				eff:setParent(self._effectGo.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1)
			end

			self._effect = UIEffectManager.instance:playEffect(self, effPath, self._effectGo, 0, 0, true, false, nil, func)
		end

		self._skipAnim.isOn = self:_isNeedSkipAmin()
	end
end

function ActivityDragonSpiritView:_onUpdateUI()
	self:_onUpdateTaskDataMap()
	self:_onUpdateLotteryToken()
	self:_onUpdateLotteryBox()
	self:_updateTaskScrollerList()
	self:_updateLotteryProgress()
end

function ActivityDragonSpiritView:_onUpdateLotteryToken()
	if self._txtGoldNum then
		self._txtGoldNum.text = OpSummaryModel.instance.lotteryScores
	end

	local prizeStr = self.cfg_base.lotteryFakeId

	if self._goldItemCon and not string.nilorempty(prizeStr) then
		local arr = string.split(prizeStr, ":")

		MaterialMgr.setIcon(self._goldItemCon, arr[1], arr[2])
	end
end

function ActivityDragonSpiritView:_onUpdateLotteryBox()
	local isEnoughScores = OpSummaryController.instance:isEnoughLotteryScores(self._activityId)
	local isInScoresLimit = OpSummaryController.instance:isInLotteryScoresLimit(self._activityId)
	local isCanOpen = isEnoughScores and isInScoresLimit
	local tips = "-,-"

	if not isInScoresLimit then
		tips = "本周放烟花次数已达上限，下周再来吧~"
	elseif not isEnoughScores then
		local arr = string.split(self.cfg_base.lotteryFakeId, ":")
		local matType, matId = checknumber(arr[1]), checknumber(arr[2])
		local name = ""

		if matType == MatType.Item_Fake then
			local cfg = ItemConfig.instance:getFakeCfgById(matId)

			name = cfg.name
		else
			name = "抽奖道具"
		end

		tips = string.format("【%s】不足，无法燃放烟花哦~", name)
	end

	local func = GameUtil.handler(self._onClickBtnLotteryBox, self, isCanOpen, tips)

	GameUtil.addClickHandler(self._btnLotteryBox, func)
	UIEffectManager.instance:stopEffect(self._boxEff)

	if isCanOpen == true then
		local effPath = "20220128/longshenbaoxiang/fx_ui_lsbx_daiji.prefab"

		local function func(_, eff)
			eff:setClipping(self._boxEffGo:GetComponent(goutil.Type_RectTransform))
			eff:setParent(self._boxEffGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1)
		end

		self._boxEff = UIEffectManager.instance:playEffect(self, effPath, self._boxEffGo, 0, 0, true, false, nil, func)
	end
end

function ActivityDragonSpiritView:_onClickBtnLotteryBox(isCanOpen, tips)
	if isCanOpen == true then
		local handle
		local isNeedSkipAmin = self:_isNeedSkipAmin()

		OpSummaryController.instance:sendLotteryReq(self._activityId, (not isNeedSkipAmin or nil) and function(msg, status)
			local changeSetId = msg.changeSetId

			MaterialController.instance:saveChangeSetToTemp(changeSetId)

			local path = "storyconfig/animations/fx_longshenbaoxiang.txt"

			local function onAnimPlayFinish()
				GameUtil.SetActive(self._mask, false)
				MaterialController.instance:showChangeSetInTemp(changeSetId)
			end

			GameUtil.SetActive(self._mask, true)
			AnimationPlayer.play(path, onAnimPlayFinish, nil, self)
		end)
	else
		FloatWordMgr.instance:show(tips)
	end
end

function ActivityDragonSpiritView:_getSkipAminDataKey()
	return "ActivityDragonSpiritView" .. "SkipAmin" .. self._activityId
end

function ActivityDragonSpiritView:_isNeedSkipAmin()
	local key = self:_getSkipAminDataKey()

	return GameUtil.getUserData(key) == true
end

function ActivityDragonSpiritView:_onClickBtnSkipAmin()
	local isNeedSkipAmin = not self:_isNeedSkipAmin()

	self._skipAnim.isOn = isNeedSkipAmin

	local key = self:_getSkipAminDataKey()

	GameUtil.saveUserData(key, isNeedSkipAmin)
end

function ActivityDragonSpiritView:_onUpdateTaskDataMap()
	self._taskDataMap = {}

	for _, showType in ipairs(self._showTypes) do
		local taskList = {}

		for _, data in pairs(self.cfg_deta) do
			if data.taskPlanId == self._activityId and data.showType == showType then
				local tab = {}

				tab.data = data

				table.insert(taskList, tab)
			end
		end

		for i, v in ipairs(taskList) do
			taskList[i].state = self:_getCellState(v.data)
		end

		table.sort(taskList, function(a, b)
			if a.state == b.state then
				if a.data.id < b.data.id then
					return true
				end

				return false
			end

			return a.state < b.state
		end)
		table.insert(self._taskDataMap, taskList)
	end
end

function ActivityDragonSpiritView:_updateTaskScrollerList()
	local list = {}

	for _, taskList in ipairs(self._taskDataMap) do
		table.insert(list, taskList[1])
	end

	self._taskScrollList:reloadData(list)
end

function ActivityDragonSpiritView:_getCellState(data)
	local state = 0
	local obj = OpSummaryModel.instance:getTaskInfo(data.id)
	local hasGain = obj.hasGainPrize
	local num = math.min(checknumber(obj.curProgress), checknumber(data.maxProgress))

	if hasGain == true then
		state = 4

		return 4
	end

	state = num >= checknumber(data.maxProgress) and 1 or 2

	if data.judge == 1 then
		local FrontTaskData = OpSummaryModel.instance:getTaskInfo(data.id - 1)

		if FrontTaskData.hasGainPrize == false then
			state = 3
		end

		if FrontTaskData.hasGainPrize == nil then
			state = 3
		end
	end

	return state
end

function ActivityDragonSpiritView:_updateTaskCell(view, cellModel, cfg, tag)
	local data = cfg.data
	local state = cfg.state
	local cell = {}

	cell.mainGo = cellModel

	if cell.mainGo == nil then
		return nil
	end

	cell.btnRecieve = goutil.findChild(cell.mainGo, "btnRecieve")
	cell.btnGo = goutil.findChild(cell.mainGo, "btnGo")
	cell.receive = goutil.findChild(cell.mainGo, "receive")
	cell.txtTask = goutil.findChildTextComponent(cell.mainGo, "txtTask")
	cell.txtDesc = MaterialMgr.findGraphicText(cell.mainGo, "txtDesc")
	cell.txtNum = goutil.findChildTextComponent(cell.mainGo, "txtNum")
	cell.txtNotOpen = goutil.findChild(cell.mainGo, "txtNotOpen")
	cell.item = goutil.findChild(cell.mainGo, "item")

	local isNeedTitle = not string.nilorempty(data.title) and cell.txtTask

	if isNeedTitle then
		cell.txtTask.text = data.title
	end

	local isNeedDesc = not string.nilorempty(data.desc) and cell.txtDesc

	if cell.txtDesc then
		cell.txtDesc.text = data.desc
	end

	local obj = OpSummaryModel.instance:getTaskInfo(data.id)
	local num = checknumber(obj.curProgress)

	num = math.min(num, checknumber(data.maxProgress))

	GameUtil.SetActive(cell.txtNum, state ~= 4)

	if cell.txtNum then
		cell.txtNum.text = string.format("<color=#20B376FF>%s</color>", num) .. "/" .. checknumber(data.maxProgress)
	end

	if state ~= 4 then
		MaterialMgr.setCellByCfg(data.prize, cell.item, urlOrGo, luaCls, isOne)
	else
		MaterialMgr.resetAll(cell.item)
	end

	if state ~= 4 then
		MaterialMgr.setCellByCfg(data.prize, cell.item, urlOrGo, luaCls, isOne)
	else
		MaterialMgr.resetAll(cell.item)
	end

	GameUtil.SetActive(cell.btnRecieve, state == 1)
	GameUtil.SetActive(cell.btnGo, state == 2)
	GameUtil.SetActive(cell.txtNotOpen, state == 3)
	GameUtil.SetActive(cell.receive, state == 4)
	GameUtil.addClickHandler(cell.btnGo, GameUtil.handler(self._onClickBtnGo, self, data))
	GameUtil.addClickHandler(cell.btnRecieve, GameUtil.handler(self._onClickBtnRecieve, self, data))
end

function ActivityDragonSpiritView:_clearTaskCell(cell)
	local mainGo = cell
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function ActivityDragonSpiritView:_onClickBtnGo(data)
	local params = string.split(data.jumpTo, "#")
	local key = table.remove(params, 1)

	if key ~= "event" then
		-- block empty
	end

	GotoMgr.gotoByString(data.jumpTo)
end

function ActivityDragonSpiritView:_onClickBtnRecieve(data)
	OpSummaryController.instance:sendGetTaskPrize(self._activityId, data)
end

function ActivityDragonSpiritView:_updateLotteryProgress()
	local dataList = {}

	for _, cfg in ipairs(self.cfg_lottery_progress) do
		local hasLotteryTimes = OpSummaryModel.instance.hasLotteryTimes

		if not OpSummaryModel.instance.hasGainLotteryProgessPrize then
			local GainprizeIdList = {}
			local hasGain = table.indexof(GainprizeIdList, cfg.id) and true
			local data = {}

			data.id = cfg.id
			data.needTimes = cfg.needTimes
			data.prize = MaterialMgr.filterClothsArr(cfg.prize)[1]
			data.isHasGain = hasGain
			data.isCanGet = not hasGain and hasLotteryTimes - data.needTimes >= 0

			table.insert(dataList, data)
		end
	end

	self._lotteryProgress:reloadDataList(dataList)
	self._lotteryProgress:updateCell()

	local curCellIdx = 0
	local totalCellIdx = #self.cfg_lottery_progress
	local hasLotteryTimes = OpSummaryModel.instance.hasLotteryTimes
	local cellPercentage = 1 / totalCellIdx

	for idx, cfg in ipairs(self.cfg_lottery_progress) do
		if hasLotteryTimes < cfg.needTimes then
			break
		end

		curCellIdx = idx
	end

	local nextCellIdx = math.min(curCellIdx + 1, totalCellIdx)

	if self.cfg_lottery_progress[curCellIdx] then
		if not self.cfg_lottery_progress[curCellIdx].needTimes then
			local curCellNeedTimes = 0
			local nextCellNeedTimes = self.cfg_lottery_progress[nextCellIdx].needTimes

			self._lotteryProgress:updateProgress(curCellIdx / totalCellIdx + (hasLotteryTimes - curCellNeedTimes) / (nextCellNeedTimes - curCellNeedTimes) * cellPercentage)

			if self._progressNum then
				local week = OpSummaryController.instance:getWeekFromActStart(self._activityId)
				local limitTimes = self.cfg_base.lotteryWeekTimesLimit[week]

				self._progressNum.text = string.format("%d/%d次", hasLotteryTimes, limitTimes)
			end

			local index = curCellIdx

			for idx, data in ipairs(dataList) do
				if data.isCanGet then
					index = idx

					break
				end
			end

			self._lotteryProgress:rollToIdx(index)
		end
	end
end

function ActivityDragonSpiritView:_updateProgressCell(go, data, idx)
	local mainGo = go
	local item = goutil.findChild(mainGo, "item/itemcell")
	local received = goutil.findChild(mainGo, "item/received")
	local btn = goutil.findChild(mainGo, "btn")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")

	if not string.nilorempty(data.prize) then
		MaterialMgr.setCellByCfg(data.prize, item, urlOrGo, luaCls, isOne)
	end

	if txtNum then
		txtNum.text = data.needTimes
	end

	GameUtil.SetActive(received, data.isHasGain)
	GameUtil.SetActive(btn, data.isCanGet)
	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickBtnLotteryProgressCell, self, data.isCanGet, data.id))
	UIEffectManager.instance:stopEffect(self._progressEffList[mainGo])

	if data.isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(self._scrollerGo:GetComponent(ComponentType.ScrollRect))
			eff:setParent(item.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._progressEffList[mainGo] = UIEffectManager.instance:playEffect(self, effPath, item, 0, 0, true, false, nil, func, nil)
	end
end

function ActivityDragonSpiritView:_clearProgressCell(go, data, idx)
	local mainGo = go

	MaterialMgr.resetAll(goutil.findChild(mainGo, "item/itemcell"))
	GameUtil.rmClickHandler(goutil.findChild(mainGo, "btn"))
end

function ActivityDragonSpiritView:_onClickBtnLotteryProgressCell(isCanGet, prizeId)
	if isCanGet == true then
		OpSummaryController.instance:sendGainLotteryProgressPrize(self._activityId, prizeId)
	end
end

function ActivityDragonSpiritView:_onClickBtnClose()
	self:close()
end

function ActivityDragonSpiritView:_onClickBtnTips()
	TipsFacade.instance:openRulesView("noahbirthdayraffle")
end

function ActivityDragonSpiritView:_popBubble()
	if self._txtBub then
		-- block empty
	end

	if self._bubble then
		GameUtil.SetActive(self._bubble, true)
		removetimer(self._closeBubble, self)
		settimer(3, self._closeBubble, self, true)
	end
end

function ActivityDragonSpiritView:_closeBubble()
	removetimer(self._closeBubble, self)
	GameUtil.SetActive(self._bubble, false)
end

return ActivityDragonSpiritView
