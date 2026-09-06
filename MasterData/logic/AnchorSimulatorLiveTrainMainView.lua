-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anchorsimulator/view/AnchorSimulatorLiveTrainMainView.lua

module("logic.extensions.anchorsimulator.view.AnchorSimulatorLiveTrainMainView", package.seeall)

local AnchorSimulatorLiveTrainMainView = class("AnchorSimulatorLiveTrainMainView", ViewComponent)

function AnchorSimulatorLiveTrainMainView:buildUI()
	AnchorSimulatorLiveTrainMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")

	local propertyScrView = self:getGo("propertyCol/scrView")
	local propertyScrCell = self:getGo("propertyCol/scrCell")

	self._propertyScrollList = ScrollerList.create(propertyScrView, propertyScrCell, GameUtil.handler(self._updatePropertyCell, self), GameUtil.handler(self._clearPropertyCell, self))
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._strTxtDescBuff = self._txtDescBuff.text
	self._btnRefreshBuff = self:getGo("buffCol/btnRefresh")
	self._txtRefreshBuff = self:getTxt("buffCol/refresh/txt")
	self._iconEnergy = self:getGo("trainCol/energy/icon")
	self._txtEnergy = self:getTxt("trainCol/energy/txt")
	self._txtLeftDay = self:getTxt("trainCol/txtLeftDay")
	self._strTxtLeftDay = self._txtLeftDay.text

	local classesScrView = self:getGo("trainCol/classesCol/scrView")
	local classesScrCell = self:getGo("trainCol/classesCol/scrCell")

	self._classesScrollList = ScrollerList.create(classesScrView, classesScrCell, GameUtil.handler(self._updateClassesCell, self), GameUtil.handler(self._clearClassesCell, self))
	self._trainView = self:getGo("trainCol/trainView")
	self._btnReset = self:getGo("trainCol/btnReset")
	self._btnSure = self:getGo("trainCol/btnSure")
	self._txtBtnSure = self:getTxt("trainCol/btnSure/txt")
	self._strTxtBtnSure = self._txtBtnSure.text
	self._btnTask = self:getGo("btnTask")
	self._redBtnTask = self:getGo("btnTask/redPoint")
end

function AnchorSimulatorLiveTrainMainView:bindEvents()
	AnchorSimulatorLiveTrainMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRefreshBuff, self._onClickBtnRefreshBuff, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
end

function AnchorSimulatorLiveTrainMainView:unbindEvents()
	AnchorSimulatorLiveTrainMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRefreshBuff)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnTask)
end

function AnchorSimulatorLiveTrainMainView:onEnter()
	AnchorSimulatorLiveTrainMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = AnchorSimulatorController.instance:getActivityType()

	local isInTime = AnchorSimulatorController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._anchorSimulatorMo = AnchorSimulatorController.instance:getAnchorSimulatorMo(self._activityId)

	if self._anchorSimulatorMo:isCanStartLive() then
		self:close()

		return
	end

	self._actData = AnchorSimulatorConfig.instance:getActData(self._activityId)
	self._classLimit = AnchorSimulatorConfig.instance:getClassLimit(self._activityId)
	self._readyClassesList = {}
	self._costEnergy = 0

	self.addGEvent(self, GlobalNotify.HandlePM_AnchorSimulatorGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_AnchorSimulatorRefreshBuffRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_AnchorSimulatorTrainRes, self._handlePM_AnchorSimulatorTrainRes, self)
	self:_onSetUI()
	self:_onUpdate()
end

function AnchorSimulatorLiveTrainMainView:onExit()
	AnchorSimulatorLiveTrainMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnTask)
	MaterialMgr.clearIcon(self._iconEnergy)
	self:_onClearPropertyCol()
	self:_onClearTrainCol()
end

function AnchorSimulatorLiveTrainMainView:_handlePM_AnchorSimulatorTrainRes(msg)
	local propertyExps = TableUtil.deepcopy(self._basePropertyExps)

	if self._anchorSimulatorMo:isCanStartLive() then
		self:close()
		UIStateManager.instance:push(ViewName.AnchorSimulatorLiveReadyView, self._activityId)
	else
		self:_resetClassesList()
		self:_onUpdate()
	end

	UIStateManager.instance:push(ViewName.AnchorSimulatorLiveTrainResultView, msg, propertyExps)
end

function AnchorSimulatorLiveTrainMainView:_onSetUI()
	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local matStr = AnchorSimulatorConfig.instance:getStrengthItem(self._activityId)
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

	MaterialMgr.setIcon(self._iconEnergy, matType, matId, nil, nil)

	local redId = AnchorSimulatorController.instance:getEventTaskRedId()

	if redId then
		RedPointController.instance:regRedPoint(self._redBtnTask, redId)
	end
end

function AnchorSimulatorLiveTrainMainView:_onUpdate()
	self._basePropertyExps = {}

	local cfg = AnchorSimulatorConfig.instance:getPropertyCfg(self._activityId) or {}

	for propertyType, data in ipairs(cfg) do
		self._basePropertyExps[propertyType] = self._anchorSimulatorMo:getCurPropertyExp(propertyType)
	end

	self:_onUpdatePropertyColUI()
	self:_onUpdateTrainCol()

	if self._txtRefreshBuff then
		local cur = self._anchorSimulatorMo:getRefreshBuffTimes()
		local max = AnchorSimulatorConfig.instance:getMaxBuffTimes(self._activityId)
		local left = Mathf.Max(0, max - cur)

		self._txtRefreshBuff.text = string.format("%s/%s", left, max)
	end

	if self._txtLeftDay then
		local cur = self._anchorSimulatorMo:getCurRoundTrainTimes()
		local max = AnchorSimulatorConfig.instance:getTrainTimes(self._activityId)

		self._txtLeftDay.text = string.format(self._strTxtLeftDay, Mathf.Max(0, max - cur))
	end

	if self._txtEnergy then
		local cur = self._anchorSimulatorMo:getCurStrength()
		local max = AnchorSimulatorConfig.instance:getStrengthLimit(self._activityId)

		self._txtEnergy.text = string.format("%s/%s", cur - self._costEnergy, max)
	end

	if self._txtDescBuff then
		local buffId = self._anchorSimulatorMo:getBuffId()
		local buffRatio = AnchorSimulatorConfig.instance:getBuffRatio(self._activityId)
		local data = self:_getPropertyData(buffId)

		self._txtDescBuff.text = string.format(self._strTxtDescBuff, data.desc, buffRatio * 100)
	end

	GameUtil.SetGray(self._btnRefreshBuff, self:_getTryRefreshBuffResultAndTips(false, self._activityId) ~= GameEnum.ResultCode.Success)
	GameUtil.SetGray(self._btnReset, #self._readyClassesList <= 0)
	GameUtil.SetGray(self._btnSure, self:_getTryStartTrainResultAndTips(false, self._activityId) ~= GameEnum.ResultCode.Success)

	self._txtBtnSure.text = string.format(self._strTxtBtnSure, #self._readyClassesList, self._classLimit)
end

function AnchorSimulatorLiveTrainMainView:_onUpdatePropertyColUI()
	local cfg = AnchorSimulatorConfig.instance:getPropertyCfg(self._activityId) or {}

	self._propertyScrollList:reloadData(cfg)
end

function AnchorSimulatorLiveTrainMainView:_onClearPropertyCol()
	self._propertyScrollList:dispose()
end

function AnchorSimulatorLiveTrainMainView:_updatePropertyCell(view, cell, data, tag)
	local propertyType = data.propertyType
	local realyExp = self._anchorSimulatorMo:getCurPropertyExp(propertyType)
	local curLevel = AnchorSimulatorConfig.instance:getPropertyLevelByExp(self._activityId, propertyType, realyExp)
	local curProgress = AnchorSimulatorController.instance:getProgressByExp(self._activityId, propertyType, realyExp)
	local exPropertyTypeCount = self:_getPropertyTypeCount(propertyType)
	local virtualExp = realyExp + exPropertyTypeCount * AnchorSimulatorConfig.instance:getClassExp(self._activityId)
	local virtualLevel = AnchorSimulatorConfig.instance:getPropertyLevelByExp(self._activityId, propertyType, virtualExp)
	local virtualProgress = AnchorSimulatorController.instance:getProgressByExp(self._activityId, propertyType, virtualExp)
	local mainGo = cell.gameObject
	local txtLevel = goutil.findChildTextComponent(mainGo, "txtLevel")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local virtualSlider = goutil.findChild(mainGo, "virtualSlider"):GetComponent(ComponentType.Slider)
	local realySlider = goutil.findChild(mainGo, "realySlider"):GetComponent(ComponentType.Slider)

	txtName.text = data.desc
	txtLevel.text = string.format("等级%s", virtualLevel)

	GameUtil.setUITextColorIdx(txtLevel, realyExp < virtualExp and 1 or 0)

	realySlider.value = curLevel < virtualLevel and 0 or curProgress
	virtualSlider.value = virtualProgress
end

function AnchorSimulatorLiveTrainMainView:_clearPropertyCell(cell)
	return
end

function AnchorSimulatorLiveTrainMainView:_onUpdateTrainCol()
	local list = {}

	for i = 1, self._classLimit do
		table.insert(list, i)
	end

	self._classesScrollList:reloadData(list)

	local propertyTypeList = {}
	local cfg = AnchorSimulatorConfig.instance:getPropertyCfg(self._activityId) or {}

	for _, data in ipairs(cfg) do
		table.insert(propertyTypeList, data.propertyType)
	end

	table.insert(propertyTypeList, 0)

	for idx, propertyType in ipairs(propertyTypeList) do
		local mainGo = self._trainView.transform:GetChild(idx - 1).gameObject

		if mainGo == nil then
			printError(string.format("错误，预制体不存在，但配置配置了( export_养成属性| idx:%s, propertyType:%s )", idx, propertyType))
		else
			self:_updateTrainCell(mainGo, idx, propertyType)
		end
	end
end

function AnchorSimulatorLiveTrainMainView:_onClearTrainCol()
	self._classesScrollList:dispose()

	for idx = 1, self._trainView.transform.childCount do
		local mainGo = self._trainView.transform:GetChild(idx - 1).gameObject

		self:_clearTrainCell(mainGo)
	end
end

function AnchorSimulatorLiveTrainMainView:_updateClassesCell(view, cell, idx, tag)
	local propertyType = self._readyClassesList[idx]
	local isEmpty = propertyType == nil
	local data = self:_getPropertyData(propertyType)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local btnRemove = goutil.findChild(mainGo, "btnRemove")
	local imgAdd = goutil.findChild(mainGo, "imgAdd")

	GameUtil.SetActive(imgAdd, isEmpty)
	GameUtil.SetActive(btnRemove, not isEmpty)

	if isEmpty then
		uGuiUtil.clearImage(con)
		GameUtil.rmClickHandler(btnRemove)
	else
		local spriteName = GameUrl.getBigbgPngUrl(data.classesBg)

		uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, spriteName, function()
			return
		end)
		GameUtil.addClickHandler(btnRemove, function()
			local result = self:_rmClassesFormList(idx)

			if result then
				self:_onUpdate()
			end
		end)
	end
end

function AnchorSimulatorLiveTrainMainView:_clearClassesCell(cell)
	local mainGo = cell.gameObject
	local btnRemove = goutil.findChild(mainGo, "btnRemove")
	local con = goutil.findChild(mainGo, "mask/con")

	uGuiUtil.clearImage(con)
	GameUtil.rmClickHandler(btnRemove)
end

function AnchorSimulatorLiveTrainMainView:_updateTrainCell(mainGo, idx, propertyType)
	local data = self:_getPropertyData(propertyType)
	local con = goutil.findChild(mainGo, "mask/con")
	local imgAdd = goutil.findChild(mainGo, "imgAdd")
	local txtName = goutil.findChildTextComponent(mainGo, "name/txt")

	txtName.text = data.desc

	local spriteName = GameUrl.getBigbgPngUrl(data.classesBg)

	uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, spriteName, function()
		return
	end)
	GameUtil.addClickHandler(mainGo, function()
		self:_addClassesToList(propertyType)
		self:_onUpdate()
	end)
end

function AnchorSimulatorLiveTrainMainView:_clearTrainCell(mainGo)
	local con = goutil.findChild(mainGo, "mask/con")

	uGuiUtil.clearImage(con)
	GameUtil.rmClickHandler(mainGo)
end

function AnchorSimulatorLiveTrainMainView:_addClassesToList(propertyType)
	local result = false

	if self:_isClassesFull() then
		FloatWordMgr.instance:show("训练课程已满")
	else
		local costEnergy = self._costEnergy

		costEnergy = propertyType == 0 and costEnergy - AnchorSimulatorConfig.instance:getBreakAddStrength(self._activityId) or costEnergy + AnchorSimulatorConfig.instance:getClassCostStrength(self._activityId)

		local cur = self._anchorSimulatorMo:getCurStrength()

		if cur - costEnergy < 0 then
			FloatWordMgr.instance:show("奶龙体力不足，先去休息一下吧~")
		else
			self._costEnergy = costEnergy

			table.insert(self._readyClassesList, propertyType)

			result = true
		end
	end

	return result
end

function AnchorSimulatorLiveTrainMainView:_rmClassesFormList(idx)
	local result = false
	local propertyType = self._readyClassesList[idx]

	if propertyType then
		self._costEnergy = propertyType == 0 and self._costEnergy + AnchorSimulatorConfig.instance:getBreakAddStrength(self._activityId) or self._costEnergy - AnchorSimulatorConfig.instance:getClassCostStrength(self._activityId)

		table.remove(self._readyClassesList, idx)

		result = true
	end

	return result
end

function AnchorSimulatorLiveTrainMainView:_resetClassesList()
	table.clear(self._readyClassesList)

	self._costEnergy = 0
end

function AnchorSimulatorLiveTrainMainView:_getPropertyTypeCount(propertyType)
	local count = 0

	for _, v in ipairs(self._readyClassesList) do
		if v == propertyType then
			count = count + 1
		end
	end

	return count
end

function AnchorSimulatorLiveTrainMainView:_isClassesFull()
	return #self._readyClassesList >= self._classLimit
end

function AnchorSimulatorLiveTrainMainView:_getPropertyData(propertyType)
	if propertyType == 0 then
		local data = {}

		data.desc = "休息"
		data.classesBg = AnchorSimulatorEnum.RelaxationClassesBgPath

		return data
	else
		return AnchorSimulatorConfig.instance:getPropertyData(self._activityId, propertyType)
	end
end

function AnchorSimulatorLiveTrainMainView:_getTryRefreshBuffResultAndTips(isShowTips, activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local mo = self._anchorSimulatorMo

	if not AnchorSimulatorController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success then
		local cur = mo:getRefreshBuffTimes()
		local max = AnchorSimulatorConfig.instance:getMaxBuffTimes(activityId)

		if max <= cur then
			result = GameEnum.ResultCode.Error
			tips = "刷新次数已达上限"
		else
			local next = cur + 1
			local data = AnchorSimulatorConfig.instance:getBuffData(activityId, next)
			local cost = data and data.cost

			if not string.nilorempty(cost) then
				local matType, matId, matNum = MaterialMgr.getMatParams(cost)
				local withNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

				if withNum < matNum then
					result = GameEnum.ResultCode.Error

					local matName = MaterialMgr.getMaterialsName(matType, matId)

					tips = string.format("%s不足", matName)
				end
			end
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function AnchorSimulatorLiveTrainMainView:_getTryStartTrainResultAndTips(isShowTips, activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not AnchorSimulatorController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success and not self:_isClassesFull() then
		result = GameEnum.ResultCode.Error
		tips = "课程未满"
	end

	if result == GameEnum.ResultCode.Success then
		local cur = self._anchorSimulatorMo:getCurStrength()

		for _, propertyType in ipairs(self._readyClassesList) do
			cur = propertyType == 0 and cur + AnchorSimulatorConfig.instance:getBreakAddStrength(activityId) or cur - AnchorSimulatorConfig.instance:getClassCostStrength(activityId)

			if cur < 0 then
				result = GameEnum.ResultCode.Error
				tips = "奶龙体力不足，先去休息一下吧~"

				break
			end
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function AnchorSimulatorLiveTrainMainView:_onClickBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function AnchorSimulatorLiveTrainMainView:_onClickBtnRefreshBuff()
	local result = self:_getTryRefreshBuffResultAndTips(true, self._activityId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local cur = self._anchorSimulatorMo:getRefreshBuffTimes()
	local max = AnchorSimulatorConfig.instance:getMaxBuffTimes(self._activityId)
	local next = cur + 1
	local left = Mathf.Max(0, max - cur)
	local data = AnchorSimulatorConfig.instance:getBuffData(self._activityId, next)
	local cost = data and data.cost
	local matType, matId, matNum = MaterialMgr.getMatParams(cost)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local content = string.format("是否确认消耗<color=#eb4624>%s%s</color>刷新一次增益？\n剩余刷新次数：%s", matNum, matName, left)

	local function successCallBack()
		AnchorSimulatorController.instance:sendPM_AnchorSimulatorRefreshBuffReq(self._activityId)
	end

	local toggleFunc, togTxt
	local alignment = UnityEngine.TextAnchor.MiddleCenter
	local autoOpenSource

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, successCallBack, toggleFunc, togTxt, alignment, nil, autoOpenSource)
end

function AnchorSimulatorLiveTrainMainView:_onClickBtnReset()
	if #self._readyClassesList <= 0 then
		FloatWordMgr.instance:show(string.format("未添加课程，无需重置"))

		return
	end

	self:_resetClassesList()
	self:_onUpdate()
end

function AnchorSimulatorLiveTrainMainView:_onClickBtnSure()
	local result = self:_getTryStartTrainResultAndTips(true, self._activityId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	AnchorSimulatorController.instance:sendPM_AnchorSimulatorTrainReq(self._activityId, self._readyClassesList)
end

function AnchorSimulatorLiveTrainMainView:_onClickBtnTask()
	AnchorSimulatorController.instance:opEventTask()
end

return AnchorSimulatorLiveTrainMainView
