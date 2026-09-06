-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/grandsummary/ActivityGrandSummaryView.lua

module("logic.extensions.operationsummary.view.grandsummary.ActivityGrandSummaryView", package.seeall)

local ActivityGrandSummaryView = class("ActivityGrandSummaryView", ViewComponent)

function ActivityGrandSummaryView:ctor()
	ActivityGrandSummaryView.super.ctor(self)
end

function ActivityGrandSummaryView:buildUI()
	ActivityGrandSummaryView.super.buildUI(self)

	self.leftTop = goutil.findChild(self.mainGO, "leftTop")
	self.leftTop_btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self.leftTop_txtTitle = goutil.findChildComponent(self.mainGO, "leftTop/txtTitle", goutil.Type_UIText)
	self.leftTop_btnTips = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self.btnDark = goutil.findChild(self.mainGO, "btnDark")
	self.bg = goutil.findChild(self.mainGO, "bg")
	self.openTime = goutil.findChild(self.mainGO, "openTime")
	self.openTime_txt = goutil.findChildComponent(self.mainGO, "openTime/txt", goutil.Type_UIText)
	self.effectGo = goutil.findChild(self.mainGO, "effect")
	self.effect = nil
end

function ActivityGrandSummaryView:bindEvents()
	ActivityGrandSummaryView.super.bindEvents(self)
	GameUtil.addClickHandler(self.leftTop_btnClose, self.onClickClose, self)
	GameUtil.addClickHandler(self.leftTop_btnTips, self.onClickBtnTips, self)
end

function ActivityGrandSummaryView:unbindEvents()
	ActivityGrandSummaryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.leftTop_btnClose)
	GameUtil.rmClickHandler(self.leftTop_btnTips)
end

function ActivityGrandSummaryView:destroyUI()
	ActivityGrandSummaryView.super.destroyUI(self)
end

function ActivityGrandSummaryView:onEnter()
	ActivityGrandSummaryView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_StoryPrizeInfoRes, self._onStoryInfoRes, self)
	self.addGEvent(self, GlobalNotify.EndStory, self._onEndStory, self)

	self.activityId = checknumber(self:_getSumActivityId())

	if self.activityId == 0 then
		printError("活动id错误，id = 0, 请修改代码，重写 _getSumActivityId() 函数")
		self:onClickClose()

		return
	end

	self.cfg_task_base = OperationSummaryConfig.instance:getTaskBaseCfg(self.activityId)
	self.cfg_task_progress = OperationSummaryConfig.instance:getProgressCfg(self.activityId)
	self.cfg_task_items = OperationSummaryConfig.instance:getTaskItemsCfg(self.activityId)
	self.cfg_lottery_progress = OperationSummaryConfig.instance:getLotteryProgressCfg(self.activityId)
	self.cfg_task_details = OperationSummaryConfig.instance:getTaskDetailsCfg(self.activityId)

	if not self.cfg_task_base then
		printError("没有找到配置，要检查检查活动id")
		self:onClickClose()

		return
	end

	self:buildAllUI()
	self:setMainUI()
	self:onCreateUI()

	local isNeedToSendTaskReq = false

	for _, data in pairs(self.cfg_task_items) do
		if data.showType ~= 0 then
			isNeedToSendTaskReq = true

			break
		end
	end

	local isNeedToSendCollectReq = false

	for _, data in pairs(self.cfg_task_items) do
		local actCollectConfs = OperationSummaryConfig.instance:getCollectCfgs(data.planId, data.id)

		if actCollectConfs then
			isNeedToSendCollectReq = true

			break
		end
	end

	if isNeedToSendTaskReq then
		GlobalDispatcher:addListener(GlobalNotify.PM_ActivitySummaryGetTaskInfo, self.onUpdateUI, self)
		OpSummaryController.instance:sendGetAllTask(self.activityId)
	end

	if isNeedToSendCollectReq then
		GlobalDispatcher:addListener(GlobalNotify.PM_ActivitySummaryStatisticsGetInfoRes, self.onUpdateUI, self)
		ActivitySummaryStatisticsAgent.instance:sendPM_ActivitySummaryStatisticsGetInfoReq()
	end

	if not isNeedToSendTaskReq and not isNeedToSendCollectReq then
		self:onUpdateUI()
	end

	local storyId = self.cfg_task_base.firstStoryId

	local function firstTimeCallback()
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
	end

	local function nextTimeCallback()
		self:ifNeedDayAnimThenPlay()
	end

	if storyId > 0 then
		local key = string.format("ActivityGrandSummaryView_First_Story_%s", self.activityId)

		GameUtil.doCallbackWhenFirst(key, firstTimeCallback, nextTimeCallback)
	else
		nextTimeCallback()
	end

	self:startActCellEnterAnim()
end

function ActivityGrandSummaryView:onEnterFinished()
	ActivityGrandSummaryView.super.onEnterFinished(self)
end

function ActivityGrandSummaryView:onExit()
	ActivityGrandSummaryView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ActivitySummaryGetTaskInfo, self.onUpdateUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ActivitySummaryStatisticsGetInfoRes, self.onUpdateUI, self)

	if self.bg then
		uGuiUtil.clearImage(self.bg)
	end

	if self.effect then
		UIEffectManager.instance:stopEffect(self.effect)
	end

	self:OnExitActivity()
	self:OnExitReward()
	self:OnExitGuidelines()
	self:OnExitLottery()
	self:OnExitVersionControl()
	self:OnExitActivityTimeProgress()
end

function ActivityGrandSummaryView:buildAllUI()
	self:versionControlBuildUI()
	self:activityBuildUI()
	self:guidelinesBuildUI()
	self:rewardBuildUI()
	self:lotteryBuildUI()
	self:heatProgressBuildUI()
	self:activityTimeProgressBuildUI()
end

function ActivityGrandSummaryView:setMainUI()
	self.leftTop_txtTitle.text = self.leftTop_txtTitle and (self.cfg_task_base.summaryName or "未配置")

	self:ShowActivityTimeUI()

	if self.effectGo then
		local isNeedEff = not string.nilorempty(self.cfg_task_base.effect)

		if self.effectGo then
			UIEffectManager.instance:stopEffect(self.effect)

			local effPath = self.cfg_task_base.effect .. ".prefab"

			local function func(_, eff)
				eff:setParent(self.effectGo.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1)
			end

			self.effect = UIEffectManager.instance:playEffect(self, effPath, self.effectGo, 0, 0, true, false, nil, func)
		end

		local bgName = self.cfg_task_base.bgName

		if self.bg then
			local isNeedSetBg = not string.nilorempty(bgName)

			local function localFunc()
				local image = self.bg:GetComponent(goutil.Type_UIImage)

				if image then
					image:SetNativeSize()
				end
			end

			if isNeedSetBg then
				local bgUrl = string.format("ui/bigbg/%s.png", bgName)

				uGuiUtil.setSpriteToImage(self.bg, uGuiUtil.SpriteType.BigBg, bgUrl, localFunc)
			end
		end
	end
end

function ActivityGrandSummaryView:onCreateUI()
	self:CreatActivity()
	self:CreatReward()
end

function ActivityGrandSummaryView:onUpdateUI()
	self:updateActivity()
	self:updateReward()
	self:_onUpdateLottery()
	self:onUpdateVersionControl()
	self:onUpdateHeatProgress()
end

function ActivityGrandSummaryView:onClickClose()
	self:close()
end

function ActivityGrandSummaryView:onClickBtnTips()
	TipsFacade.instance:openRulesView("dragonfestival")
end

function ActivityGrandSummaryView:activityBuildUI()
	self.activityContent = goutil.findChild(self.mainGO, "objs")

	if self.activityContent then
		self.canvasGroup = self.activityContent:GetComponent(ComponentType.CanvasGroup)
	end

	self._actCellList = self._actCellList or {}
end

function ActivityGrandSummaryView:CreatActivity()
	for _, data in pairs(self.cfg_task_items) do
		local cell = self:createActCell(data)

		if cell then
			table.insert(self._actCellList, cell)
		end
	end
end

function ActivityGrandSummaryView:createActCell(data)
	local cellModel = goutil.findChild(self.mainGO, data.cellName)

	goutil.setActive(cellModel, false)

	if cellModel == nil then
		printError(string.format("cell预制缺失，请检查( activityId:%s, prefabName:%s, cellName:%s | export_任务面板  in  y运营-活动汇总面板-任务型.xlsx  )", self.activityId, self.mainGO.name, data.cellName))

		return nil
	end

	local go = goutil.findChild(self.activityContent, string.format("%s_%s", data.cellName, data.id))

	if go == nil then
		go = goutil.clone(cellModel, string.format("%s_%s", data.cellName, data.id))
	else
		return nil
	end

	goutil.addChildToParent(go, self.activityContent)
	GameUtil.setLocalPos(go, data.pos[1] or 0, data.pos[2] or 0)

	local cell = {}

	cell.mainGo = go
	cell.icon = goutil.findChild(cell.mainGo, "node/icon/con")
	cell.bgIcon = goutil.findChild(cell.mainGo, "node/bg")
	cell.redPoint = goutil.findChild(cell.mainGo, "node/imgRed")
	cell.newObj = goutil.findChild(cell.mainGo, "node/new")
	cell.tab = goutil.findChild(cell.mainGo, "node/tab")
	cell.txtTab = goutil.findChildTextComponent(cell.mainGo, "node/tab/txt")
	cell.txtName = goutil.findChildTextComponent(cell.mainGo, "node/txtName")
	cell.over = goutil.findChild(cell.mainGo, "node/over")
	cell.txtOver = goutil.findChildTextComponent(cell.mainGo, "node/over/txt")
	cell.time = goutil.findChild(cell.mainGo, "time")
	cell.txtTime = goutil.findChildTextComponent(cell.mainGo, "time/txtTime")
	cell.progress = goutil.findChild(cell.mainGo, "node/progress")
	cell.txtProgress = goutil.findChildTextComponent(cell.mainGo, "node/progress/txt")
	cell.slogan = goutil.findChild(cell.mainGo, "slogan")
	cell.txtSlogan = goutil.findChildTextComponent(cell.mainGo, "slogan/txtSlogan")
	cell.actProgress = goutil.findChild(cell.mainGo, "actProgress")

	if cell.actProgress then
		cell.actProgressCell = goutil.findChild(cell.mainGo, "actProgress/cell")
		cell.actProgressCells = {}
	end

	cell.data = data
	cell.id = data.id

	GameUtil.addClickHandler(cell.mainGo, GameUtil.handler(self.onClickActivityCell, self, cell, data))

	return cell
end

function ActivityGrandSummaryView:updateActivity()
	for _, cell in pairs(self._actCellList) do
		self:updateActivityCell(cell)
	end

	RedPointModel.instance:updateAllRedPoint()
end

function ActivityGrandSummaryView:updateActivityCell(cell)
	local data = cell.data
	local isNeedShow = data.planId == self.activityId

	GameUtil.SetActive(cell.mainGo, isNeedShow)

	if not isNeedShow then
		return
	end

	local isNeedTips = not string.nilorempty(data.tips) and cell.txtTab

	GameUtil.SetActive(cell.tab, isNeedTips)

	if isNeedTips then
		cell.txtTab.text = data.tips
	end

	local isNeedName = not string.nilorempty(data.name) and cell.txtName

	if isNeedName then
		GameUtil.SetActive(cell.txtName.gameObject, isNeedName)

		cell.txtName.text = data.name
	end

	local isNeedSlogan = not string.nilorempty(data.slogan) and cell.slogan

	GameUtil.SetActive(cell.slogan, isNeedSlogan)

	if isNeedSlogan then
		cell.txtSlogan.text = data.slogan
	end

	local isNeedSetIcon = not string.nilorempty(data.icon) and cell.icon

	if isNeedSetIcon then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/%s.png", data.icon)

		local function func()
			if self:_isIconSetNativeSize(data) then
				cell.icon:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(cell.icon, spriteType, spriteName, func)
	end

	local isNeedSetBgIcon = not string.nilorempty(data.bgIcon) and cell.bgIcon

	if isNeedSetBgIcon then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/%s.png", data.bgIcon)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(cell.bgIcon, spriteType, spriteName, func)
	end

	local tabActTimePeriod = OpSummaryController.instance:getActTimePeriodAsTab(data.id)

	GameUtil.SetActive(cell.mainGo, OpSummaryController.instance:isInShowTimeAsTab(data.id))
	RedPointController.instance:regRedPoint(cell.newObj, OpSummaryController.instance:getRedIdAsTabNew(data.id))
	OpSummaryController.instance:updateRedIdAsTabNew(data.id)
	GameUtil.SetActive(cell.time, tabActTimePeriod == GameUtil.beforeTimePeriod)

	if cell.txtTime then
		local tabActCfg = ActivityDefineConfig.instance:getCfgById(data.activityType, data.activityId)

		if tabActCfg then
			cell.txtTime.text = GameUtil.formatTimeStamp("%m.%d %H:%M后开启", GameUtil.string2time(tabActCfg.startTime))
		end
	end

	GameUtil.SetActive(cell.over, tabActTimePeriod == GameUtil.afterTimePeriod)
	GameUtil.SetActive(cell.redPoint, false)

	if cell.redPoint then
		local isNeedToRegRed = not (string.nilorempty(data.redpointId) or tabActTimePeriod ~= GameUtil.inTimePeriod)

		if isNeedToRegRed then
			RedPointController.instance:unregRedPoint(cell.redPoint)
			RedPointController.instance:regRedPoint(cell.redPoint, unpack(string.split(data.redpointId or "", "#")))
		end

		if data.showType ~= 0 then
			local num = 0
			local total = 0
			local isCanGet = false

			for _, detailCfg in pairs(self.cfg_task_details) do
				if data.showType == detailCfg.showType then
					local info = OpSummaryModel.instance:getTaskInfo(detailCfg.id)

					if info.hasGainPrize then
						num = num + 1
					else
						local isEnough = checknumber(info.curProgress) >= checknumber(detailCfg.maxProgress)

						isCanGet = isCanGet or isEnough
					end

					total = total + 1
				end
			end

			if cell.txtProgress then
				cell.txtProgress.text = num .. "/" .. total
			end

			local isActive = isCanGet and tabActTimePeriod == GameUtil.inTimePeriod

			if isActive == true then
				RedPointController.instance:unregRedPoint(cell.redPoint)
				GameUtil.SetActive(cell.redPoint, true)
			end
		end

		self:_destroyActProgressCells(cell)

		if cell.actProgress then
			local actCollectConfs = OperationSummaryConfig.instance:getCollectCfgs(data.planId, data.id)
			local isShowActProgress = tabActTimePeriod ~= GameUtil.beforeTimePeriod and actCollectConfs

			GameUtil.SetActive(cell.actProgress, isShowActProgress)

			if isShowActProgress then
				local model = OpSummaryModel.instance

				for i, actCollectConf in pairs(actCollectConfs) do
					if checknumber(i) > 0 then
						local pCell = goutil.cloneAndSetParent(cell.actProgressCell, cell.actProgress.transform)

						goutil.setActive(pCell, true)

						local imgProgressIcon = goutil.findChild(pCell, "iconContainer/icon")
						local txtActProgress = goutil.findChildTextComponent(pCell, "txtActProgress")
						local matType, id, _ = MaterialMgr.getMatParams(actCollectConf.actItemEntry)

						if imgProgressIcon then
							MaterialMgr.setIcon(imgProgressIcon, matType, id)
						end

						if txtActProgress then
							txtActProgress.text = string.format("%d/%d", model:getCollectionNum(data.id, i), checknumber(actCollectConf.maxNum))
						end

						table.insert(cell.actProgressCells, pCell)
					end
				end
			end
		end
	end
end

function ActivityGrandSummaryView:onClickActivityCell(cell, data)
	if not OpSummaryController.instance:isInActTimeAsTab(data.id) then
		FloatWordMgr.instance:show("不在开放时间内噢~")

		return
	end

	SurveyController.instance:reportBehavior(data.reportBehavior)

	if not string.nilorempty(data.gotoStr) then
		GotoMgr.gotoByString(data.gotoStr)
	elseif checknumber(data.funcId) > 0 then
		if string.nilorempty(data.params) then
			FuncOpenController.instance:openFunc(data.funcId)
		else
			local arr = string.split(data.params, "#")

			FuncOpenController.instance:openFunc(data.funcId, unpack(arr))
		end
	elseif not string.nilorempty(data.viewname) then
		FuncOpenController.instance:openFuncByViewName(data.viewname)
	elseif data.paramObj ~= nil and checknumber(data.paramObj.story) > 0 then
		local storyId = checknumber(data.paramObj.story)
		local canGainPrize = StoryPrizeConfig.instance:getStoryPrizeCfg(storyId) ~= nil
		local hasGainPrize = StoryPrizeModel.instance:storyHasGainPrize(storyId)

		if hasGainPrize == nil then
			StoryPrizeController.instance:sendPM_StoryPrizeInfoReq(storyId)
		elseif not hasGainPrize then
			StoryPrizeController.instance:sendPM_StoryPrizeGainPrizeReq(storyId)
		end

		GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
	end

	OpSummaryController.instance:saveRedIdAsTabNew(data.id)
end

function ActivityGrandSummaryView:OnExitActivity()
	if self._actCellList then
		for _, cell in pairs(self._actCellList) do
			if cell.redPoint then
				RedPointController.instance:unregRedPoint(cell.redPoint)
			end

			RedPointController.instance:unregRedPoint(cell.newObj)

			if cell.icon then
				uGuiUtil.clearImage(cell.icon)
			end

			if cell.bgIcon then
				uGuiUtil.clearImage(cell.bgIcon)
			end

			self:_destroyActProgressCells(cell)
		end
	end

	removetimer(self._updateEnterAnim, self)
end

function ActivityGrandSummaryView:_destroyActProgressCells(cell)
	if cell.actProgress then
		for _, pCell in pairs(cell.actProgressCells) do
			local imgProgressIcon = goutil.findChild(pCell, "iconContainer/icon")

			MaterialMgr.clearIcon(imgProgressIcon)
			goutil.destroy(pCell)
		end

		cell.actProgressCells = {}
	end
end

function ActivityGrandSummaryView:startActCellEnterAnim()
	if not self.cfg_task_base or self.cfg_task_base.enterAnim ~= 1 then
		return
	end

	local offest = 120

	self.interval = 5
	self._totalStep = offest / self.interval
	self._curStep = 0
	self.canvasGroup.alpha = 0
	self._alphaStep = 1 / self._totalStep
	self.cellList = {}

	local pos

	for _, cell in pairs(self._actCellList) do
		if cell.data.planId == self.activityId then
			GameUtil.setLocalPos(cell.mainGo, (cell.data.pos[1] or 0) - offest, cell.data.pos[2] or 0, 0)
			table.insert(self.cellList, cell)
		end
	end

	settimer(0, self._updateEnterAnim, self, true)
end

function ActivityGrandSummaryView:_updateEnterAnim()
	self._curStep = self._curStep + 1

	if self._curStep > self._totalStep then
		removetimer(self._updateEnterAnim, self)

		return
	end

	local pos

	for i, cell in ipairs(self.cellList) do
		pos = GameUtil.getLocalPos(cell.mainGo)

		GameUtil.setLocalPos(cell.mainGo, pos.x + self.interval, pos.y, pos.z)
	end

	self.canvasGroup.alpha = self.canvasGroup.alpha + self._alphaStep
end

function ActivityGrandSummaryView:rewardBuildUI()
	self.reward = goutil.findChild(self.mainGO, "reward")
	self.isUseReward = #self.cfg_task_progress ~= 0 and self.reward ~= nil

	if not self.isUseReward then
		GameUtil.SetActive(self.reward, false)

		return
	end

	self.reward_total = goutil.findChild(self.mainGO, "reward/total")
	self.reward_total_item = goutil.findChild(self.mainGO, "reward/total/item")
	self.reward_total_txtNum = goutil.findChildComponent(self.mainGO, "reward/total/txtNum", goutil.Type_UIText)
	self.reward_slider = goutil.findChild(self.mainGO, "reward/slider")
	self.reward_sliderComponent = self:getSlider("reward/slider")
	self.reward_con = goutil.findChild(self.mainGO, "reward/con")
	self.reward_cell = goutil.findChild(self.mainGO, "reward/cell")

	goutil.setActive(self.reward_cell, false)

	self.rewardCellList = {}
	self.valueStepArr = {}
	self.progStepArr = {}
	self.rwEffList = {}
end

function ActivityGrandSummaryView:OnExitReward()
	if not self.isUseReward then
		return
	end

	for _, v in pairs(self.rwEffList) do
		UIEffectManager.instance:stopEffect(v)
	end

	for _, cell in pairs(self.rewardCellList) do
		MaterialMgr.clearIcon(cell.item)
	end

	MaterialMgr.resetAll(self.reward_total_item)
end

function ActivityGrandSummaryView:CreatReward()
	if not self.isUseReward then
		return
	end

	self:_SetTotal()
	self:_SetRewardList()
end

function ActivityGrandSummaryView:_SetTotal()
	local fakeId = self.cfg_task_base.fakeId
	local matType, cfgId = MaterialMgr.getMatParams(fakeId)

	MaterialMgr.setIcon(self.reward_total_item, matType, cfgId)

	self.reward_total_txtNum.text = "9999"

	GameUtil.rmClickHandler(self.reward_total)
	GameUtil.addClickHandler(self.reward_total, GameUtil.handler(self.onClickRewardTotal, self, self.reward_total, matType, cfgId))
end

function ActivityGrandSummaryView:_SetRewardList()
	if #self.rewardCellList ~= 0 then
		return
	end

	local width = GameUtil.getWidth(self.reward_slider)
	local per = 1 / #self.cfg_task_progress

	table.insert(self.valueStepArr, 0)
	table.insert(self.progStepArr, 0)

	self.rewardCellList = {}

	for i, v in ipairs(self.cfg_task_progress) do
		table.insert(self.valueStepArr, v.needScore)
		table.insert(self.progStepArr, per * i)

		local posX = per * width * i

		table.insert(self.rewardCellList, self:_CreatRewardCell(v, posX))
	end
end

function ActivityGrandSummaryView:_CreatRewardCell(data, posX)
	local item_cell = goutil.clone(self.reward_cell, "cell_" .. data.id)

	goutil.addChildToParent(item_cell, self.reward_slider)
	GameUtil.setLocalPos(item_cell, posX, 0, 0)
	goutil.setActive(item_cell, true)

	local cell = {}

	cell.mainGo = item_cell
	cell.item = goutil.findChild(cell.mainGo, "item")
	cell.recieve = goutil.findChild(cell.mainGo, "recieve")
	cell.txtNum = goutil.findChildTextComponent(cell.mainGo, "txtNum")
	cell.top = goutil.findChild(cell.mainGo, "top")
	cell.id = data.id
	cell.txtNum.text = data.needScore

	GameUtil.rmClickHandler(cell.mainGo)
	GameUtil.addClickHandler(cell.mainGo, GameUtil.handler(self.onClickRewardCell, self, cell, data))
	GameUtil.SetActive(cell.mainGo, true)
	GameUtil.SetActive(cell.item, true)
	GameUtil.SetActive(cell.recieve, false)

	return cell
end

function ActivityGrandSummaryView:updateReward()
	if not self.isUseReward then
		return
	end

	self:updateRewardProgress()

	for _, cell in pairs(self.rewardCellList) do
		self:updateRewardCell(cell)
	end
end

function ActivityGrandSummaryView:updateRewardProgress()
	local curValue = OpSummaryModel.instance.totalScore

	self.reward_total_txtNum.text = curValue

	GameUtil.setProgress(self.reward_sliderComponent, curValue, self.valueStepArr, self.progStepArr)
end

function ActivityGrandSummaryView:updateRewardCell(cell)
	if not self.cfg_task_progress[cell.id] then
		local data = {}
		local GainprizeIdList = OpSummaryModel.instance.hasGainProgessPrize
		local totalScore = OpSummaryModel.instance.totalScore
		local hasGain = table.indexof(GainprizeIdList, data.id) and true

		GameUtil.SetActive(cell.top, false)
		UIEffectManager.instance:stopEffect(self.rwEffList[cell.id])

		local strTable = MaterialMgr.filterClothsArr(data.prize)

		MaterialMgr.setCellByCfg(strTable[1], cell.item)
		GameUtil.SetActive(cell.recieve, hasGain)

		local isScoreFinish = checknumber(totalScore) >= checknumber(data.needScore)

		if isScoreFinish and not hasGain then
			GameUtil.SetActive(cell.top, true)

			local effPath = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"

			local function func(_, eff)
				eff:setClipping(cell.item:GetComponent(goutil.Type_RectTransform))
				eff:setParent(cell.item.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1)
			end

			self.rwEffList[cell.id] = UIEffectManager.instance:playEffect(self, effPath, cell.item, 0, 0, true, false, nil, func)
		end
	end
end

function ActivityGrandSummaryView:onClickRewardCell(cell, data)
	local totalScore = OpSummaryModel.instance.totalScore
	local GainprizeIdList = OpSummaryModel.instance.hasGainProgessPrize
	local hasGain = table.indexof(GainprizeIdList, data.id)
	local isEnough = checknumber(totalScore) >= checknumber(data.needScore)

	if not hasGain and isEnough then
		OpSummaryController.instance:sendGetPrize(self.activityId, data)

		return
	end

	local matType, cfgId = MaterialMgr.getMatParams(data.prize)

	CommonTipsMgr.instance:openMaterialTips(cell.item, matType, cfgId)
end

function ActivityGrandSummaryView:onClickRewardTotal(total, matType, cfgId)
	CommonTipsMgr.instance:openMaterialTips(total, matType, cfgId)
end

function ActivityGrandSummaryView:guidelinesBuildUI()
	self.btnGuidelines = goutil.findChild(self.mainGO, "btnGuidelines")
	self.isUseGuidelines = not not (self.cfg_task_base.isUseGuide and self.btnGuidelines)

	if self.isUseGuidelines == false then
		GameUtil.SetActive(self.btnGuidelines, false)

		return
	end

	GameUtil.addClickHandler(self.btnGuidelines, self.onClickBtnGuidelines, self)
end

function ActivityGrandSummaryView:OnExitGuidelines()
	if not self.isUseGuidelines then
		return
	end

	GameUtil.rmClickHandler(self.btnGuidelines)
end

function ActivityGrandSummaryView:onClickBtnGuidelines()
	UIStateManager.instance:push(ViewName.ActivityWelfareGuidelinesView, self.activityId)
end

function ActivityGrandSummaryView:lotteryBuildUI()
	self.lotteryGo = goutil.findChild(self.mainGO, "lottery")
	self.isUseLottery = not not (#self.cfg_lottery_progress ~= 0 and self.lotteryGo)

	GameUtil.SetActive(self.lotteryGo, self.isUseLottery)

	if not self.isUseLottery then
		return
	end

	self.mask = goutil.findChild(self.mainGO, "mask")

	GameUtil.SetActive(self.mask, false)

	self.goldBarCon = goutil.findChild(self.lotteryGo, "goldBarCon")
	self.itemCon = goutil.findChild(self.lotteryGo, "goldBarCon/item")
	self.txtNum = goutil.findChildTextComponent(self.lotteryGo, "goldBarCon/txtNum")
	self.btnLotteryBox = goutil.findChild(self.lotteryGo, "lotteryBox/btnLotteryBox")
	self.txtBoxCount = goutil.findChildTextComponent(self.lotteryGo, "lotteryBox/txtCount")
	self.itemCost = goutil.findChild(self.lotteryGo, "lotteryBox/cost/item")
	self.txtTipCost = goutil.findChildTextComponent(self.lotteryGo, "lotteryBox/cost/txtTip")
	self.boxEffGo = goutil.findChild(self.lotteryGo, "lotteryBox/effect")
	self.boxEff = nil
	self.ScrollerGo = goutil.findChild(self.lotteryGo, "tableview")

	local cellGo = goutil.findChild(self.lotteryGo, "tablecell")
	local updateCellCallBack = GameUtil.handler(self._updateLotteryCell, self)
	local clearCellCallBack = GameUtil.handler(self._clearLotteryCell, self)

	self.lotteryScrollList = ScrollerList.create(self.ScrollerGo, cellGo, updateCellCallBack, clearCellCallBack)

	GameUtil.SetActive(cellGo, false)

	self.lotteryCellList = {}
	self.itemEffList = {}
end

function ActivityGrandSummaryView:_onUpdateLottery()
	if not self.isUseLottery then
		return
	end

	self:_onUpdateLotteryToken()
	self:_onUpdateLotteryBox()
	self:_onUpdateLotteryScroller()
end

function ActivityGrandSummaryView:_onUpdateLotteryToken()
	if self.txtNum then
		self.txtNum.text = OpSummaryModel.instance.lotteryScores
	end

	local prizeStr = self.cfg_task_base.lotteryFakeId

	if self.itemCon and not string.nilorempty(prizeStr) then
		local arr = string.split(prizeStr, ":")

		MaterialMgr.setIcon(self.itemCon, arr[1], arr[2])
	end
end

function ActivityGrandSummaryView:_onUpdateLotteryBox()
	if self.txtBoxCount then
		local hasLotteryTimes = OpSummaryModel.instance.hasLotteryTimes

		self.txtBoxCount.text = langPara("已开奖<color=#ffd30d>%s</color>次", hasLotteryTimes)
	end

	if self.txtTipCost then
		local costNum = self.cfg_task_base.lotteryCostNum

		self.txtTipCost.text = langPara("消耗 <color=#ffd30d>%s</color>            开启", costNum)
	end

	local prizeStr = self.cfg_task_base.lotteryFakeId

	if self.itemCost and not string.nilorempty(prizeStr) then
		local arr = string.split(prizeStr, ":")

		MaterialMgr.setIcon(self.itemCost, arr[1], arr[2])
	end

	local lotteryScores = OpSummaryModel.instance.lotteryScores
	local lotteryCostNum = self.cfg_task_base.lotteryCostNum
	local isCanOpen = lotteryScores - lotteryCostNum >= 0

	UIEffectManager.instance:stopEffect(self.boxEff)

	if isCanOpen == true then
		local effPath = "20211126/xiaonuoshengrihui/fx_ui_xiaonuoshengrihui_kaijiang.prefab"

		local function func(_, eff)
			eff:setClipping(self.boxEffGo:GetComponent(goutil.Type_RectTransform))
			eff:setParent(self.boxEffGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1)
		end

		self.boxEff = UIEffectManager.instance:playEffect(self, effPath, self.boxEffGo, 0, 0, true, false, nil, func)
	end

	local func = GameUtil.handler(self.onClickBtnLotteryBox, self, isCanOpen)

	GameUtil.addClickHandler(self.btnLotteryBox, func)
end

function ActivityGrandSummaryView:_onUpdateLotteryScroller()
	local dataList = self:_getLotteryDataList()

	self.lotteryScrollList:reloadData(dataList)
	self.lotteryScrollList:refresh()
end

function ActivityGrandSummaryView:_getLotteryDataList()
	local dataList = {}

	for _, cfg in ipairs(self.cfg_lottery_progress) do
		local hasLotteryTimes = OpSummaryModel.instance.hasLotteryTimes

		if not OpSummaryModel.instance.hasGainLotteryProgessPrize then
			local hasGain = table.indexof(OpSummaryModel.instance.hasGainLotteryProgessPrize, cfg.id) and true
			local data = {}

			data.id = cfg.id
			data.needTimes = cfg.needTimes
			data.prize = MaterialMgr.filterClothsArr(cfg.prize)[1]
			data.isHasGain = hasGain
			data.isCanGet = not hasGain and hasLotteryTimes - data.needTimes >= 0

			table.insert(dataList, data)
		end
	end

	return dataList
end

function ActivityGrandSummaryView:_updateLotteryCell(_, cellModel, data, tag)
	local cell = {}

	cell._mainGo = cellModel
	cell._item = goutil.findChild(cell._mainGo, "item")
	cell._btnGet = goutil.findChild(cell._mainGo, "btnGet")
	cell._con = goutil.findChild(cell._mainGo, "item/con")
	cell._bg = goutil.findChild(cell._mainGo, "item/bg")
	cell._receive = goutil.findChild(cell._mainGo, "item/receive")
	cell._txtTip = goutil.findChildTextComponent(cell._mainGo, "txtTip")
	self.lotteryCellList[cell._mainGo] = cell

	local proxy = MaterialMgr.setCellByCfg(data.prize, cell._con, urlOrGo, luaCls, isOne)

	cell._txtTip.text = langPara("%s抽必得", data.needTimes)

	UIEffectManager.instance:stopEffect(self.itemEffList[cell._mainGo])

	if data.isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(self.ScrollerGo:GetComponent(ComponentType.ScrollRect))
			eff:setParent(cell._item.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(0.68, 0.68, 0.68)

			eff.hideEffWhileNotOnTop = true
		end

		self.itemEffList[cell._mainGo] = UIEffectManager.instance:playEffect(self, effPath, cell._item, 0, 0, true, false, nil, func, nil)
	end

	GameUtil.SetActive(cell._btnGet, data.isCanGet)
	GameUtil.rmClickHandler(cell._btnGet)

	if data.isCanGet == true then
		local func = GameUtil.handler(self.onClickBtnLotteryCell, self, data.isCanGet, data.id)

		GameUtil.addClickHandler(cell._btnGet, func)
	end

	GameUtil.SetActive(cell._receive, data.isHasGain)
end

function ActivityGrandSummaryView:_clearLotteryCell(cellGo)
	if not self.isUseLottery then
		return
	end

	MaterialMgr.resetAll(goutil.findChild(cellGo, "item/con"))
end

function ActivityGrandSummaryView:OnExitLottery()
	if not self.isUseLottery then
		return
	end

	self.lotteryScrollList:dispose()

	for _, eff in pairs(self.itemEffList) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self.itemEffList = {}

	if self.boxEffGo and self.boxEff then
		UIEffectManager.instance:stopEffect(self.boxEff)

		self.boxEff = nil
	end

	if self.itemCon then
		MaterialMgr.clearIcon(self.itemCon)
	end
end

function ActivityGrandSummaryView:onClickBtnLotteryTips()
	TipsFacade.instance:openRulesView("noahbirthdayraffle")
end

function ActivityGrandSummaryView:onClickBtnLotteryBox(isCanOpen)
	if isCanOpen == true then
		local function handle(msg, status)
			local changeSetId = msg.changeSetId

			MaterialController.instance:saveChangeSetToTemp(changeSetId)

			local path = "storyconfig/animations/shengrixiangzi_donghua.txt"

			local function onAnimPlayFinish()
				GameUtil.SetActive(self.mask, false)
				MaterialController.instance:showChangeSetInTemp(changeSetId)
			end

			GameUtil.SetActive(self.mask, true)
			AnimationPlayer.play(path, onAnimPlayFinish, nil, self)
		end

		OpSummaryController.instance:sendLotteryReq(self.activityId, handle)
	else
		local itemStr = self.cfg_task_base.lotteryFakeId
		local arr = string.split(itemStr, ":")
		local matType, matId = checknumber(arr[1]), checknumber(arr[2])
		local name = ""

		if matType == MatType.Item_Fake then
			local cfg = ItemConfig.instance:getFakeCfgById(matId)

			name = cfg.name
		else
			name = "抽奖道具"
		end

		FloatWordMgr.instance:show(langPara("text_LotteryBox_Tips_No", name))
	end
end

function ActivityGrandSummaryView:onClickBtnLotteryCell(isCanGet, prizeId)
	if isCanGet == true then
		OpSummaryController.instance:sendGainLotteryProgressPrize(self.activityId, prizeId)
	end
end

function ActivityGrandSummaryView:heatProgressBuildUI()
	self._leftContent = goutil.findChild(self.mainGO, "leftContent")

	local heatPlanId = self.cfg_task_base.heatPlanId

	self._isUseHeatProgress = self._leftContent ~= nil and not string.nilorempty(heatPlanId)

	if not self._isUseHeatProgress then
		return
	end

	local arr = string.split(heatPlanId, "#")
	local actId, id = arr[1], arr[2]

	self.heatProgressPresentor = ViewMgr.instance:openAt(self._leftContent, ViewName.HeatProgressView, self._viewPresentor, actId, id)
end

function ActivityGrandSummaryView:onUpdateHeatProgress()
	if not self._isUseHeatProgress then
		return
	end

	local heatPlanId = self.cfg_task_base.heatPlanId
	local arr = string.split(heatPlanId, "#")
	local actId, id = arr[1], arr[2]

	GlobalDispatcher:dispatch(GlobalNotify.HeatProgressOnUpdatePlanCfg, id)
end

function ActivityGrandSummaryView:versionControlBuildUI()
	self._right = goutil.findChild(self.mainGO, "right")
	self.versionControlList = self.cfg_task_base.versionControlList

	if self.versionControlList == nil then
		return
	end

	self.isUseVersionControl = self._right ~= nil and #self.versionControlList ~= 0 or false

	if not self.isUseVersionControl then
		return
	end

	self._ctBtnCellList = {}

	for i = 1, #self.versionControlList do
		local btnGo = goutil.findChild(self._right, "btn_" .. i)
		local actId = self.versionControlList[i]
		local data = OperationSummaryConfig.instance:getTaskBaseCfg(actId)

		if btnGo then
			local cell = {}

			cell._mainGo = btnGo
			cell._select = goutil.findChild(cell._mainGo, "select")
			cell._ctRed = goutil.findChild(cell._mainGo, "ctRed")
			cell._txtTime = goutil.findChildTextComponent(cell._mainGo, "txtTime")
			cell._data = data

			GameUtil.addClickHandler(cell._mainGo, GameUtil.handler(self.onClickBtnVersionControl, self, cell))
			table.insert(self._ctBtnCellList, cell)
		else
			printError("控制按钮的预制体索引不是序列性的 -- " .. i)
		end
	end

	self:selectFitVersion()
end

function ActivityGrandSummaryView:OnExitVersionControl()
	if not self.isUseVersionControl then
		return
	end

	for _, cell in pairs(self._ctBtnCellList) do
		GameUtil.rmClickHandler(cell._mainGo)
		RedPointController.instance:unregRedPoint(cell._ctRed)
	end

	self.isHaveSelectFitVersion = false
end

function ActivityGrandSummaryView:onUpdateVersionControl()
	if not self.isUseVersionControl then
		return
	end

	for _, cell in pairs(self._ctBtnCellList) do
		GameUtil.SetActive(cell._select, cell._data.summaryId == self.activityId)

		local cfg_Summary = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.Summary, cell._data.summaryId)
		local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.Summary, cell._data.summaryId)
		local curTimeType = GameUtil.getTimePeriodType(cfg_Summary.startTime, cfg_Summary.endTime)
		local isInShowTime = curTimeType == GameUtil.inTimePeriod
		local startDate = os.date("*t", startTime)

		GameUtil.SetActive(cell._txtTime.gameObject, not isInShowTime)

		if cell._txtTime then
			cell._txtTime.text = langPara("%d.%02d 5:00 开启", startDate.month, startDate.day)
		end

		local cfg_task_items = OperationSummaryConfig.instance:getTaskItemsCfg(cell._data.summaryId)
		local redIdList = {}

		for _, v in pairs(cfg_task_items) do
			local cfg_Activity = ActivityDefineConfig.instance:getCfgById(v.activityType, v.activityId)
			local curActivityTimeType = GameUtil.getTimePeriodType(cfg_Activity.startTime, cfg_Activity.endTime)
			local curTabShowTimeType = GameUtil.getTimePeriodType(v.startTime, v.endTime)
			local isInActTime = curActivityTimeType == GameUtil.inTimePeriod
			local isInTabShowTime = curTabShowTimeType == GameUtil.inTimePeriod
			local isHaveId = not string.nilorempty(v.redpointId)

			if isInActTime and isInTabShowTime and isHaveId then
				for _, id in pairs(string.split(v.redpointId or "", "#")) do
					table.insert(redIdList, id)
				end
			end
		end

		GameUtil.SetActive(cell._ctRed, false)

		local isNeedToRegRed = true

		goto label_66_0

		::label_66_0::

		if isNeedToRegRed then
			RedPointController.instance:unregRedPoint(cell._ctRed)
			RedPointController.instance:regRedPoint(cell._ctRed, unpack(redIdList))
		end
	end
end

function ActivityGrandSummaryView:onClickBtnVersionControl(cell)
	local data = cell._data
	local summaryId = checknumber(data.summaryId)

	if summaryId == 0 then
		printError("没有目标活动id")

		return
	end

	local cfg_Summary = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.Summary, summaryId)
	local curSummaryTimeType = GameUtil.getTimePeriodType(cfg_Summary.startTime, cfg_Summary.endTime)

	if curSummaryTimeType == GameUtil.beforeTimePeriod then
		FloatWordMgr.instance:show(lang("活动未开启噢"))

		return
	elseif curSummaryTimeType == GameUtil.afterTimePeriod then
		FloatWordMgr.instance:show(lang("活动已结束噢"))

		return
	end

	self.activityId = summaryId

	self:onEnter()
	self:onEnterFinished()
end

function ActivityGrandSummaryView:selectFitVersion()
	if not self.isUseVersionControl or self.isHaveSelectFitVersion then
		return
	end

	self.isHaveSelectFitVersion = true

	local fitActId = self.activityId
	local idx = 1

	for i = 1, #self.versionControlList do
		local actId = self.versionControlList[i]
		local data = OperationSummaryConfig.instance:getTaskBaseCfg(actId)
		local cfg_Summary = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.Summary, actId)
		local curTimeType = GameUtil.getTimePeriodType(cfg_Summary.startTime, cfg_Summary.endTime)
		local isInShowTime = curTimeType == GameUtil.inTimePeriod

		if isInShowTime then
			fitActId = actId
			idx = i
		end
	end

	if fitActId ~= self.activityId then
		local cell = self._ctBtnCellList[idx]

		self:onClickBtnVersionControl(cell)
	end
end

function ActivityGrandSummaryView:ifNeedDayAnimThenPlay()
	local animPath = self.cfg_task_base.animPath

	local function onAnimPlayFinish()
		ViewBlockMgr.instance:blockClick(false, self)
	end

	local function onAnimPlayStart()
		return
	end

	local function beforePlay()
		ViewBlockMgr.instance:blockClick(true, self)
	end

	if not string.nilorempty(animPath) then
		OpSummaryController.instance:ifNeedDayAnimThenPlay(self.activityId, animPath, beforePlay, onAnimPlayFinish, onAnimPlayStart, self)
	end
end

function ActivityGrandSummaryView:activityTimeProgressBuildUI()
	self._isNeedTimeProgress = false

	local activityId = self:_getSumActivityId()
	local dataList = OperationSummaryConfig.instance:getActSumTimeProDataList(activityId)

	if dataList and #dataList > 0 then
		self._isNeedTimeProgress = true
	end

	if not self._isNeedTimeProgress then
		return
	end

	self._timeProgressViewRoot = goutil.findChild(self.mainGO, "timeProgressViewRoot")

	if self._timeProgressViewRoot then
		self.timeProgressPresentor = ViewMgr.instance:openAt(self._timeProgressViewRoot, ViewName.ActivityTimeProgressView, self._viewPresentor, activityId)
	else
		printError(string.format("缺失预制，联系开发处理。( activityId=%s )", activityId))
	end
end

function ActivityGrandSummaryView:OnExitActivityTimeProgress()
	if not self._isNeedTimeProgress then
		return
	end
end

function ActivityGrandSummaryView:onUpdateActivityTimeProgress()
	if not self._isNeedTimeProgress then
		return
	end
end

function ActivityGrandSummaryView:ShowActivityTimeUI()
	if self.openTime_txt then
		goutil.setActive(self.openTime, true)

		self.openTime_txt.text = ActivityDefineController.instance:getActTimeShow(self.activityId)
	end
end

function ActivityGrandSummaryView:_onStoryInfoRes(storyId, hasGain)
	if not hasGain then
		StoryPrizeController.instance:sendPM_StoryPrizeGainPrizeReq(storyId)
	end
end

function ActivityGrandSummaryView:_onEndStory(storyId, isAllEnd)
	local storyPrizeCfg = StoryPrizeConfig.instance:getStoryPrizeCfg(storyId)
	local hasGain = StoryPrizeModel.instance:storyHasGainPrize(storyId)
	local prizeStr = StoryPrizeController.instance:getPrizeStack()

	if storyPrizeCfg and prizeStr then
		local list = {}
		local matType, matId, matNum = MaterialMgr.getMatParams(prizeStr)
		local mo = MaterialModel.instance:createMo(matType, matId, matNum)

		table.insert(list, mo)

		local obj = {}

		obj.items = list
		obj.ci = 0

		MaterialController.instance:addInList(MaterialController.TYPE_ITEMSET, obj)
		MaterialController.instance:checkAndOpenDisplay()
		StoryPrizeModel.instance:setStoryHasGainPrize(storyId, true)
	end
end

function ActivityGrandSummaryView:_getSumActivityId()
	return nil
end

function ActivityGrandSummaryView:_isIconSetNativeSize(itemCfg)
	return false
end

return ActivityGrandSummaryView
