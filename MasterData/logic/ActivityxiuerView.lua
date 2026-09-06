-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivityxiuerView.lua

module("logic.extensions.operationsummary.view.ActivityxiuerView", package.seeall)

local ActivityxiuerView = class("ActivityxiuerView", ViewComponent)

function ActivityxiuerView:ctor()
	ActivityxiuerView.super.ctor(self)
end

function ActivityxiuerView:buildUI()
	ActivityxiuerView.super.buildUI(self)

	self.btnClose = self:getGo("leftTop/btnClose")
	self.container = self:getGo("objs")
	self.cell1 = self:getGo("cell1")
	self.cell2 = self:getGo("cell2")
	self.btnDark = self:getGo("btnDark")
	self.reward = self:getGo("reward")
	self.rewardCon = self:getGo("reward/con")
	self.rewardCell = self:getGo("reward/cell")

	GameUtil.SetActive(self.rewardCell, false)

	self.slider = self:getSlider("reward/slider")
	self.total = self:getGo("reward/total/item")
	self.txtTotalNum = self:getTxt("reward/total/txtNum")
	self.openTime = self:getTxt("openTime/txt")
end

function ActivityxiuerView:bindEvents()
	ActivityxiuerView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnDark, self.onClickDark, self)
end

function ActivityxiuerView:unbindEvents()
	ActivityxiuerView.super.unbindEvents(self)
end

function ActivityxiuerView:destroyUI()
	ActivityxiuerView.super.destroyUI(self)
end

function ActivityxiuerView:onEnter()
	ActivityxiuerView.super.onEnter(self)

	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self._effect = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._effect:setParent(self.mainGO.transform)
	self._effect:setLocalPos(10, 0, 0)
	self._effect:setScale(1)

	self._activityId = 17007

	local baseCfg = OperationSummaryConfig.instance:getTaskBaseCfg(self._activityId)
	local type, id, num = MaterialMgr.getMatParams(baseCfg.fakeId)

	MaterialMgr.setIcon(self.total, type, id)
	GameUtil.rmClickHandler(self.total)
	GameUtil.addClickHandler(self.total, function()
		CommonTipsMgr.instance:openMaterialTips(self.total, type, id)
	end)

	self._mainCfg = OperationSummaryConfig.instance:getTaskItemsCfg(self._activityId)
	self.effMap = {}
	self.items = {}
	self.itemsCfg = {}

	goutil.clearChildren(self.rewardCon)
	goutil.clearChildren(self.container)

	for k, v in pairs(self._mainCfg) do
		local cell = self:createCell(v)

		table.insert(self.itemsCfg, v)
		table.insert(self.items, cell)
	end

	local taskRewardList = OperationSummaryConfig.instance:getTaskRewardCfg(self._activityId)
	local width = GameUtil.getWidth(self.rewardCon)
	local halfWidth = width * 0.5
	local per = 1 / #taskRewardList
	local perW = per * width

	self.valueStepArr = {}
	self.rewardItemList = {}
	self.progStepArr = {}

	table.insert(self.valueStepArr, 0)
	table.insert(self.progStepArr, 0)

	for i, v in ipairs(taskRewardList) do
		local offX = perW * i - halfWidth
		local cell = self:createRewardCell(v, offX)

		table.insert(self.rewardItemList, cell)
		table.insert(self.valueStepArr, v.needScore)
		table.insert(self.progStepArr, i * per)
	end

	self.openTime.text = self:_getOpenTime()

	GlobalDispatcher:addListener(GlobalNotify.PM_ActivitySummaryGetTaskInfo, self.onRefreshUI, self)
	OpSummaryController.instance:sendGetAllTask(self._activityId)
	self:onRefreshUI()
end

function ActivityxiuerView:onEnterFinished()
	ActivityxiuerView.super.onEnterFinished(self)
end

function ActivityxiuerView:onExit()
	ActivityxiuerView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ActivitySummaryGetTaskInfo, self.onRefreshUI, self)

	for k, v in pairs(self.effMap) do
		UIEffectManager.instance:stopEffect(v)
	end

	self.effMap = {}

	UIEffectManager.instance:stopEffect(self._effect)

	self._effect = nil

	for i, v in ipairs(self.items) do
		local redPoint = goutil.findChild(v, "node/imgRed")

		RedPointController.instance:unregRedPoint(redPoint)
	end
end

function ActivityxiuerView:onExitFinished()
	ActivityxiuerView.super.onExitFinished(self)
end

function ActivityxiuerView:onRefreshUI()
	local curValue = OpSummaryModel.instance.totalScore

	GameUtil.setProgress(self.slider, curValue, self.valueStepArr, self.progStepArr)

	self.txtTotalNum.text = curValue

	for i, v in ipairs(self.rewardItemList) do
		self:updateRewardCell(v, i)
	end

	for i, v in ipairs(self.items) do
		self:updateCell(v, i)
	end
end

function ActivityxiuerView:onClickDark()
	printError(">>>>>   文档没写这按钮干嘛的")
end

function ActivityxiuerView:_getOpenTime()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.Summary, self._activityId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	return string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function ActivityxiuerView:onClickCell(data)
	if checknumber(data.funcId) > 0 then
		SurveyController.instance:reportBehavior(data.reportBehavior)

		if string.nilorempty(data.params) then
			FuncOpenController.instance:openFunc(data.funcId)
		else
			local arr = string.split(data.params, "#")

			FuncOpenController.instance:openFunc(data.funcId, unpack(arr))
		end

		OpSummaryModel.instance:setNewItem(data)
		self:onRefreshUI()
	elseif not string.nilorempty(data.viewname) then
		SurveyController.instance:reportBehavior(data.reportBehavior)
		FuncOpenController.instance:openFuncByViewName(data.viewname)
		OpSummaryModel.instance:setNewItem(data)
		self:onRefreshUI()
	else
		printError(">>>>>>> 未配置 ")
	end
end

function ActivityxiuerView:createCell(data)
	local cellName = data.cellName
	local cell
	local cellGo = goutil.clone(cellName == "cell1" and self.cell1 or self.cell2, "cell_" .. data.id)

	GameUtil.SetActive(cellGo, true)
	goutil.addChildToParent(cellGo, self.container)

	if not data.pos then
		GameUtil.setAnchoredPos(cellGo, data.pos[1], data.pos[2])
		GameUtil.addClickHandler(cellGo, GameUtil.handler(self.onClickCell, self, data))

		local icon = goutil.findChild(cellGo, "node/icon/con")
		local redPoint = goutil.findChild(cellGo, "node/imgRed")
		local newObj = goutil.findChild(cellGo, "node/new")
		local tab = goutil.findChild(cellGo, "node/tab")
		local txtTab = goutil.findChildTextComponent(cellGo, "node/tab/txt")
		local txtName = goutil.findChildTextComponent(cellGo, "node/txtName")

		GameUtil.SetActive(tab, false)

		local over = goutil.findChild(cellGo, "over")
		local time = goutil.findChild(cellGo, "time")

		GameUtil.SetActive(over, false)
		GameUtil.SetActive(time, false)

		local txtTime = goutil.findChildTextComponent(cellGo, "time/txtTime")

		if newObj then
			local isNew = OpSummaryModel.instance:isNewItem(data, math.floor(data.planId / 1000))

			goutil.setActive(newObj, isNew)
		end

		local curType, startTime = OperationSummaryConfig.instance:getOpenTimeInfo(data)

		if time then
			goutil.setActive(time, curType == GameUtil.beforeTimePeriod)
		end

		if over then
			goutil.setActive(over, curType == GameUtil.afterTimePeriod)
		end

		if startTime and time then
			txtTime.text = self:_getDateTime(startTime)
		end

		txtName.text = data.name

		if not string.nilorempty(data.icon) then
			uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getOperationSummaryIconUrl(data.icon), function()
				icon.gameObject:GetComponent("Image"):SetNativeSize()
			end)
		end

		print(">>>>>>>>>>>>>>>>>>>>>>>>>>>> ActivityxiuerView RedPointController", data.redpointId)

		if not string.nilorempty(data.redpointId) then
			RedPointController.instance:regRedPoint(redPoint, unpack(string.split(data.redpointId or "", "#")))
		else
			GameUtil.SetActive(redPoint, false)
		end

		local isShow = GameUtil.checkIsInTimePeriod(data.startTime, data.endTime)

		GameUtil.SetActive(cellGo, isShow)

		return cellGo
	end
end

function ActivityxiuerView:updateCell(cellGo, idx)
	local tab = goutil.findChild(cellGo, "node/tab")
	local txtTab = goutil.findChildTextComponent(cellGo, "node/tab/txt")
	local redPoint = goutil.findChild(cellGo, "node/imgRed")
	local newObj = goutil.findChild(cellGo, "node/new")
	local data = self.itemsCfg[idx]

	if newObj then
		local isNew = OpSummaryModel.instance:isNewItem(data, math.floor(data.planId / 1000))

		goutil.setActive(newObj, isNew)
	end

	local str = data.taskList

	if not string.nilorempty(str) then
		local arr = string.splitToNumber(str, "#")

		if #arr > 0 then
			local num, hasRed = OpSummaryModel.instance:getTaskCompleteNum(self._activityId, arr)

			GameUtil.SetActive(tab, true)
			GameUtil.SetActive(redPoint, hasRed)

			txtTab.text = num .. "/" .. #arr
		end
	elseif not string.nilorempty(data.tips) then
		GameUtil.SetActive(tab, true)

		txtTab.text = data.tips
	end
end

function ActivityxiuerView:_getDateTime(dataStr)
	local dataInfo = os.date("*t", GameUtil.string2time(dataStr))

	return string.format("%02d.%02d %02d:%02d\n上线", dataInfo.month, dataInfo.day, dataInfo.hour, dataInfo.min)
end

function ActivityxiuerView:createRewardCell(data, offX)
	local cellGo = goutil.clone(self.rewardCell, "cell_" .. data.id)

	GameUtil.SetActive(cellGo, true)
	goutil.addChildToParent(cellGo, self.rewardCon)
	GameUtil.setLocalPos(cellGo, offX, 0, 0)
	GameUtil.addClickHandler(cellGo, GameUtil.handler(self.onClickRewardCell, self, data))

	local item = goutil.findChild(cellGo, "item")
	local recieve = goutil.findChild(cellGo, "recieve")
	local txtNum = goutil.findChildTextComponent(cellGo, "txtNum")

	GameUtil.SetActive(recieve, false)
	MaterialMgr.setCellByCfg(data.prize, item)

	txtNum.text = data.needScore

	return cellGo
end

function ActivityxiuerView:updateRewardCell(cellGo, idx)
	local item = goutil.findChild(cellGo, "item")
	local recieve = goutil.findChild(cellGo, "recieve")
	local top = goutil.findChild(cellGo, "top")
	local txtNum = goutil.findChildTextComponent(cellGo, "txtNum")
	local curValue = OpSummaryModel.instance.totalScore
	local taskRewardList = OperationSummaryConfig.instance:getTaskRewardCfg(self._activityId)

	if not taskRewardList[idx] then
		local data = {}

		if not OpSummaryModel.instance.hasGainProgessPrize then
			local prize = {}
			local hasGain = table.indexof(prize, data.id)

			GameUtil.SetActive(recieve, hasGain)
			GameUtil.SetActive(top, false)

			local eff = self.effMap[idx]

			UIEffectManager.instance:stopEffect(eff)

			if checknumber(curValue) >= checknumber(data.needScore) and not hasGain then
				GameUtil.SetActive(top, true)

				local effPath = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"
				local eff = UIEffectManager.instance:playEffect(self, effPath, item, 0, 0, true, false, nil, function(target, eff)
					eff:setClipping(item:GetComponent(goutil.Type_RectTransform))
				end)

				eff:setParent(item.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1)

				self.effMap[idx] = eff
			end
		end
	end
end

function ActivityxiuerView:onClickRewardCell(data)
	local curValue = OpSummaryModel.instance.totalScore
	local taskRewardList = OperationSummaryConfig.instance:getTaskRewardCfg(self._activityId)

	if not taskRewardList[data.id] then
		local data = {}

		if not OpSummaryModel.instance.hasGainProgessPrize then
			local prize = {}
			local hasGain = table.indexof(prize, data.id)

			if checknumber(curValue) >= checknumber(data.needScore) and not hasGain then
				OpSummaryController.instance:sendGetPrize(self._activityId, data)
			end
		end
	end
end

return ActivityxiuerView
