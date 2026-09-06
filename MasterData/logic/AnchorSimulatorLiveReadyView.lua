-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anchorsimulator/view/AnchorSimulatorLiveReadyView.lua

module("logic.extensions.anchorsimulator.view.AnchorSimulatorLiveReadyView", package.seeall)

local AnchorSimulatorLiveReadyView = class("AnchorSimulatorLiveReadyView", ViewComponent)

function AnchorSimulatorLiveReadyView:buildUI()
	AnchorSimulatorLiveReadyView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")

	local propertyScrView = self:getGo("propertyCol/scrView")
	local propertyScrCell = self:getGo("propertyCol/scrCell")

	self._propertyScrollList = ScrollerList.create(propertyScrView, propertyScrCell, GameUtil.handler(self._updatePropertyCell, self), GameUtil.handler(self._clearPropertyCell, self))
	self._txtHotProgress = self:getTxt("infoCol/txtHotProgress")
	self._txtCurLevel = self:getTxt("infoCol/txtCurLevel")
	self._title3 = self:getGo("infoCol/title3")
	self._txtNextLevel = self:getTxt("infoCol/txtNextLevel")

	local goalScrView = self:getGo("guestCol/goalCol/scrView")
	local goalScrCell = self:getGo("guestCol/goalCol/scrCell")

	self._goalScrollList = ScrollerList.create(goalScrView, goalScrCell, GameUtil.handler(self._updateGoalCell, self), GameUtil.handler(self._clearGoalCell, self))

	local guestScrView = self:getGo("guestCol/guest/scrView")
	local guestScrCell = self:getGo("guestCol/guest/scrCell")

	self._guestScrollList = ScrollerList.create(guestScrView, guestScrCell, GameUtil.handler(self._updateGuestCell, self), GameUtil.handler(self._clearGuestCell, self))
	self._btnReset = self:getGo("guestCol/btnReset")
	self._btnSure = self:getGo("guestCol/btnSure")
	self._txtVirtualHeat = self:getTxt("guestCol/virtualHeat/txt")
	self._txtGuestCount = self:getTxt("guestCol/txtGuestCount")
	self._strTxtGuestCount = self._txtGuestCount.text
	self._txtLeftLiveTimes = self:getTxt("guestCol/txtLeftLiveTimes")
	self._strTxtLeftLiveTimes = self._txtLeftLiveTimes.text
	self._valueScrollerListDic = {}
end

function AnchorSimulatorLiveReadyView:bindEvents()
	AnchorSimulatorLiveReadyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRefreshBuff, self._onClickBtnRefreshBuff, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function AnchorSimulatorLiveReadyView:unbindEvents()
	AnchorSimulatorLiveReadyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRefreshBuff)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnSure)
end

function AnchorSimulatorLiveReadyView:onEnter()
	AnchorSimulatorLiveReadyView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = AnchorSimulatorController.instance:getActivityType()

	local isInTime = AnchorSimulatorController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._anchorSimulatorMo = AnchorSimulatorController.instance:getAnchorSimulatorMo(self._activityId)
	self._actData = AnchorSimulatorConfig.instance:getActData(self._activityId)
	self._goalArray = AnchorSimulatorConfig.instance:getGoalArray(self._activityId)
	self._guestIds = {}
	self._realyProgressInGoals = {}
	self._exAddProgressInGoals = {}
	self._virtualProgressInGoals = {}
	self._virtualHeat = 0

	self.addGEvent(self, GlobalNotify.HandlePM_AnchorSimulatorGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_AnchorSimulatorStartLiveRes, self._handlePM_AnchorSimulatorStartLiveRes, self)
	self:_onSetUI()
	self:_onUpdate()
end

function AnchorSimulatorLiveReadyView:onExit()
	AnchorSimulatorLiveReadyView.super.onExit(self)
	self:_onClearPropertyCol()
	self:_onClearGoalCol()
	self:_onClearGuestCol()
end

function AnchorSimulatorLiveReadyView:_handlePM_AnchorSimulatorStartLiveRes(msg)
	self:close()
	UIStateManager.instance:push(ViewName.AnchorSimulatorLiveTrainMainView, self._activityId)
	UIStateManager.instance:push(ViewName.AnchorSimulatorLiveShowView, self._activityId, msg)
end

function AnchorSimulatorLiveReadyView:_onSetUI()
	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
end

function AnchorSimulatorLiveReadyView:_onUpdate()
	self._curFinishLiveRounds = self._anchorSimulatorMo:getFinishLiveRounds() + 1
	self._goalData = AnchorSimulatorConfig.instance:getGoalData(self._activityId, self._curFinishLiveRounds)
	self._guestLimit = self._goalData.guestLimit

	table.clear(self._realyProgressInGoals)

	local propertyCfg = AnchorSimulatorConfig.instance:getPropertyCfg(self._activityId) or {}

	for _, data in ipairs(propertyCfg) do
		local exp = self._anchorSimulatorMo:getCurPropertyExp(data.propertyType)
		local data = AnchorSimulatorConfig.instance:getPropertyLevelDataByExp(self._activityId, data.propertyType, exp)

		for index, value in ipairs(data.dataValues) do
			self._realyProgressInGoals[index] = checknumber(self._realyProgressInGoals[index]) + value
		end
	end

	table.clear(self._exAddProgressInGoals)

	for _, guestId in pairs(self._guestIds) do
		local data = AnchorSimulatorConfig.instance:getGuestData(self._activityId, guestId)

		if data then
			for index, value in ipairs(data.goalValues) do
				self._exAddProgressInGoals[index] = checknumber(self._exAddProgressInGoals[index]) + value
			end
		end
	end

	table.clear(self._virtualProgressInGoals)

	for index, data in ipairs(self._goalData.goalValues) do
		local realyProgress = checknumber(self._realyProgressInGoals[index])
		local exAddProgress = checknumber(self._exAddProgressInGoals[index])

		self._virtualProgressInGoals[index] = realyProgress + exAddProgress
	end

	self:_onUpdatePropertyColUI()
	self:_onUpdateGoalColUI()
	self:_onUpdateGuestColUI()

	local curHeatValue = self._anchorSimulatorMo:getHeatValue()
	local curLevelData = AnchorSimulatorConfig.instance:getLevelDataByHeat(self._activityId, curHeatValue)
	local maxLevel = AnchorSimulatorConfig.instance:getMaxLevel(self._activityId)
	local nextLevel = Mathf.Min(curLevelData.level + 1, maxLevel)
	local nextLevelData = AnchorSimulatorConfig.instance:getLevelData(self._activityId, nextLevel)

	self._txtHotProgress.text = string.format("%s/%s", curHeatValue, nextLevelData.heatValue)
	self._txtCurLevel.text = curLevelData.desc
	self._txtNextLevel.text = nextLevelData.desc

	GameUtil.SetActive(self._title3, maxLevel > curLevelData.level)
	GameUtil.SetActive(self._txtNextLevel.gameObject, maxLevel > curLevelData.level)

	self._virtualHeat = 0

	for index, value in ipairs(self._goalData.goalValues) do
		local maxProgress = checknumber(self._goalData.goalValues[index])
		local vituralProgress = self._virtualProgressInGoals[index]

		if maxProgress <= vituralProgress then
			self._virtualHeat = self._virtualHeat + checknumber(self._goalData.incHeatValues[index])
		end
	end

	self._txtVirtualHeat.text = self._virtualHeat

	local guestCount = self:_getCurGuestIdCount()

	self._txtGuestCount.text = string.format(self._strTxtGuestCount, guestCount, self._guestLimit)

	if self._txtLeftLiveTimes then
		local cur = self._anchorSimulatorMo:getTodayLiveTimes()
		local max = AnchorSimulatorConfig.instance:getDailyLiveLimit(self._activityId)

		self._txtLeftLiveTimes.text = string.format(self._strTxtLeftLiveTimes, Mathf.Max(0, max - cur))
	end

	GameUtil.SetGray(self._btnReset, guestCount == 0)

	local result = self:_getTryStartResultAndTips(false, self._activityId)

	GameUtil.SetGray(self._btnSure, result ~= GameEnum.ResultCode.Success)
end

function AnchorSimulatorLiveReadyView:_onUpdatePropertyColUI()
	local cfg = AnchorSimulatorConfig.instance:getPropertyCfg(self._activityId) or {}

	self._propertyScrollList:reloadData(cfg)
end

function AnchorSimulatorLiveReadyView:_onClearPropertyCol()
	self._propertyScrollList:dispose()
end

function AnchorSimulatorLiveReadyView:_updatePropertyCell(view, cell, data, tag)
	local propertyType = data.propertyType
	local realyExp = self._anchorSimulatorMo:getCurPropertyExp(propertyType)
	local realyLevel = AnchorSimulatorConfig.instance:getPropertyLevelByExp(self._activityId, propertyType, realyExp)
	local realyProgress = AnchorSimulatorController.instance:getProgressByExp(self._activityId, propertyType, realyExp)
	local mainGo = cell.gameObject
	local txtLevel = goutil.findChildTextComponent(mainGo, "txtLevel")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local realySlider = goutil.findChild(mainGo, "realySlider"):GetComponent(ComponentType.Slider)

	txtName.text = data.desc
	txtLevel.text = string.format("等级%s", realyLevel)
	realySlider.value = realyProgress
end

function AnchorSimulatorLiveReadyView:_clearPropertyCell(cell)
	return
end

function AnchorSimulatorLiveReadyView:_onUpdateGoalColUI()
	local list = {}

	for index, v in ipairs(self._goalArray) do
		table.insert(list, index)
	end

	self._goalScrollList:reloadData(list)
end

function AnchorSimulatorLiveReadyView:_onClearGoalCol()
	self._goalScrollList:dispose()
end

function AnchorSimulatorLiveReadyView:_updateGoalCell(view, cell, index, tag)
	local name = self._goalArray[index]
	local maxProgress = checknumber(self._goalData.goalValues[index])
	local realyProgress = checknumber(self._realyProgressInGoals[index])
	local vituralProgress = self._virtualProgressInGoals[index]
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtProgress = goutil.findChildTextComponent(mainGo, "txtProgress")
	local virtualSlider = goutil.findChild(mainGo, "virtualSlider"):GetComponent(ComponentType.Slider)
	local realySlider = goutil.findChild(mainGo, "realySlider"):GetComponent(ComponentType.Slider)

	txtName.text = name
	realySlider.value = realyProgress
	virtualSlider.value = vituralProgress
	txtProgress.text = string.format("%s/%s", vituralProgress, maxProgress)

	if self._actData.goalIconArray then
		local spriteName = self._actData.goalIconArray[index]

		if not string.nilorempty(spriteName) then
			local spritePath = GameUrl.getBigbgPngUrl(spriteName)

			uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, spritePath, function()
				icon:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end)
		else
			uGuiUtil.clearImage(icon)
		end
	end
end

function AnchorSimulatorLiveReadyView:_clearGoalCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
end

function AnchorSimulatorLiveReadyView:_onUpdateGuestColUI()
	local list = {}
	local cfg = AnchorSimulatorConfig.instance:getGuestCfg(self._activityId) or {}

	for _, data in ipairs(cfg) do
		table.insert(list, data.guestId)
	end

	local aSelected, bSelected = false, false
	local aUnlocked, bUnlocked = false, false

	table.sort(list, function(a, b)
		aSelected = self:_isSelectedGuest(a)
		bSelected = self:_isSelectedGuest(b)

		if aSelected and not bSelected then
			return true
		elseif not aSelected and bSelected then
			return false
		end

		aUnlocked = self:_isUnlockGuest(a)
		bUnlocked = self:_isUnlockGuest(b)

		if aUnlocked and not bUnlocked then
			return true
		elseif not aUnlocked and bUnlocked then
			return false
		elseif aUnlocked and bUnlocked then
			return b < a
		end

		return a < b
	end)
	self._guestScrollList:reloadData(list)
end

function AnchorSimulatorLiveReadyView:_onClearGuestCol()
	self._guestScrollList:dispose()
end

function AnchorSimulatorLiveReadyView:_updateGuestCell(view, cell, guestId, tag)
	local data = AnchorSimulatorConfig.instance:getGuestData(self._activityId, guestId)
	local propertyData = AnchorSimulatorConfig.instance:getPropertyData(self._activityId, data.propertyType)
	local isUnLock = self:_isUnlockGuest(guestId)
	local isSelected = self:_isSelectedGuest(guestId)
	local mainGo = cell.gameObject
	local lock = goutil.findChild(mainGo, "lock")
	local txtLock = goutil.findChildTextComponent(mainGo, "lock/txt")
	local content = goutil.findChild(mainGo, "content")
	local con = goutil.findChild(mainGo, "content/mask/con")
	local values = goutil.findChild(mainGo, "content/values")
	local valueScrView = goutil.findChild(mainGo, "content/valueScrView")
	local valueScrCell = goutil.findChild(mainGo, "content/valueScrCell")
	local imgSelect = goutil.findChild(mainGo, "imgSelect")

	if not self._valueScrollerListDic[mainGo] then
		local scrollerList = ScrollerList.create(valueScrView, valueScrCell, GameUtil.handler(self._updateGuestCellValueCell, self), GameUtil.handler(self._clearGuestCellValueCell, self))

		self._valueScrollerListDic[mainGo] = self._valueScrollerListDic[mainGo]

		self._valueScrollerListDic[mainGo]:reloadData(data.goalValues)
		MaterialMgr.setIcon(con, MatType.Pet, data.skinId, nil, nil)

		txtLock.text = string.format("%s达Lv%s后解锁", propertyData and propertyData.desc, data.unlockLevel)

		GameUtil.SetActive(lock, not isUnLock)
		GameUtil.SetActive(content, isUnLock)
		GameUtil.SetActive(imgSelect, isSelected)
		GameUtil.addClickHandler(mainGo, function()
			if not isUnLock then
				FloatWordMgr.instance:show("该嘉宾未达解锁条件")

				return
			end

			if self:_addGuestId(not self:_isSelectedGuest(guestId), guestId) then
				self:_onUpdate()
			end
		end)
	end
end

function AnchorSimulatorLiveReadyView:_clearGuestCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "content/mask/con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(mainGo)

	local scrollerList = self._valueScrollerListDic[mainGo]

	if scrollerList then
		scrollerList:dispose()

		self._valueScrollerListDic[mainGo] = nil
	end
end

function AnchorSimulatorLiveReadyView:_updateGuestCellValueCell(view, cell, value, tag)
	local index = cell.data
	local mainGo = cell.gameObject
	local txtValue = goutil.findChildTextComponent(mainGo, "txtValue")
	local icon = goutil.findChild(mainGo, "icon")

	txtValue.text = value

	if self._actData.goalIconArray then
		local spriteName = self._actData.goalIconArray[index]

		if not string.nilorempty(spriteName) then
			local spritePath = GameUrl.getBigbgPngUrl(spriteName)

			uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, spritePath, function()
				icon:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end)
		else
			uGuiUtil.clearImage(icon)
		end
	end
end

function AnchorSimulatorLiveReadyView:_clearGuestCellValueCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
end

function AnchorSimulatorLiveReadyView:_isUnlockGuest(guestId)
	local data = AnchorSimulatorConfig.instance:getGuestData(self._activityId, guestId)
	local propertyType = data.propertyType
	local propertyData = AnchorSimulatorConfig.instance:getPropertyData(self._activityId, propertyType)
	local curPropertyLevel = self._anchorSimulatorMo:getCurPropertyExp(propertyType)
	local propertyLevel = AnchorSimulatorConfig.instance:getPropertyLevelByExp(self._activityId, propertyType, curPropertyLevel)

	return propertyLevel >= data.unlockLevel
end

function AnchorSimulatorLiveReadyView:_addGuestId(isAdd, guestId)
	local result = false

	if isAdd then
		if self:_getCurGuestIdCount() >= self._guestLimit then
			FloatWordMgr.instance:show("当前邀请已达上限")
		elseif self._guestIds[guestId] == nil then
			self._guestIds[guestId] = guestId
			result = true
		end
	elseif self._guestIds[guestId] then
		self._guestIds[guestId] = nil
		result = true
	end

	return result
end

function AnchorSimulatorLiveReadyView:_isSelectedGuest(guestId)
	return self._guestIds[guestId] ~= nil
end

function AnchorSimulatorLiveReadyView:_getCurGuestIdCount()
	local count = 0

	for _ in pairs(self._guestIds) do
		count = count + 1
	end

	return count
end

function AnchorSimulatorLiveReadyView:_getTryStartResultAndTips(isShowTips, activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not AnchorSimulatorController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success then
		local cur = self._anchorSimulatorMo:getTodayLiveTimes()
		local max = AnchorSimulatorConfig.instance:getDailyLiveLimit(activityId)

		if max <= cur then
			result = GameEnum.ResultCode.Error
			tips = "今日直播次数已用完，明日再来吧！"
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function AnchorSimulatorLiveReadyView:_onClickBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function AnchorSimulatorLiveReadyView:_onClickBtnReset()
	if next(self._guestIds) == nil then
		FloatWordMgr.instance:show(string.format("未添加嘉宾，无需重置"))

		return
	end

	table.clear(self._guestIds)
	self:_onUpdate()
end

function AnchorSimulatorLiveReadyView:_onClickBtnSure()
	local result = self:_getTryStartResultAndTips(true, self._activityId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local guestIds = TableUtil.toList(self._guestIds)

	AnchorSimulatorController.instance:sendPM_AnchorSimulatorStartLiveReq(self._activityId, guestIds)
end

return AnchorSimulatorLiveReadyView
