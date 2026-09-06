-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivityTimeProgressView.lua

module("logic.extensions.heatprogress.view.ActivityTimeProgressView", package.seeall)

local ActivityTimeProgressView = class("ActivityTimeProgressView", ViewComponent)

function ActivityTimeProgressView:ctor()
	ActivityTimeProgressView.super.ctor(self)
end

function ActivityTimeProgressView:buildUI()
	ActivityTimeProgressView.super.buildUI(self)

	self._ScrollRect = goutil.findChild(self.mainGO, "sliderCol/ScrollRect")
	self._progressBar = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content/progressBar")
	self._content = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content")
	self._gridView = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content/gridView")
	self._gridCell = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content/gridCell")

	local exParams = {
		Content = self._content,
		cellGroup = self._gridView,
		progressBar = self._progressBar
	}

	self._progressList = ProgressList.create(self._ScrollRect, self._gridCell, GameUtil.handler(self._updateProgressGrid, self), GameUtil.handler(self._clearProgressCell, self), exParams)
end

function ActivityTimeProgressView:bindEvents()
	ActivityTimeProgressView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._popBubble, self)
end

function ActivityTimeProgressView:unbindEvents()
	ActivityTimeProgressView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
end

function ActivityTimeProgressView:destroyUI()
	ActivityTimeProgressView.super.destroyUI(self)
end

function ActivityTimeProgressView:onEnter()
	ActivityTimeProgressView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		printError("缺失参数 activityId")
		self:close()

		return
	end

	self:_onUpdate()
end

function ActivityTimeProgressView:onExit()
	ActivityTimeProgressView.super.onExit(self)
end

function ActivityTimeProgressView:_onUpdate()
	self:_onUpdateSliderColUI()
end

function ActivityTimeProgressView:_getCurProgress(activityId)
	local index = self:_getCurIndex(activityId)
	local data = OperationSummaryConfig.instance:getActSumTimeProData(activityId, index)

	return checknumber((data or nil) and (data.index or 0))
end

function ActivityTimeProgressView:_getMaxProgress(activityId)
	local dataList = OperationSummaryConfig.instance:getActSumTimeProDataList(activityId)
	local data = dataList[#dataList]

	return checknumber(data and data.index)
end

function ActivityTimeProgressView:_getCurIndex(activityId)
	local index = 0
	local dataList = OperationSummaryConfig.instance:getActSumTimeProDataList(activityId)

	for _, data in ipairs(dataList) do
		if self:_getTimePeriod(activityId, data.index) >= GameUtil.inTimePeriod then
			index = data.index
		else
			break
		end
	end

	return index
end

function ActivityTimeProgressView:_isPass(activityId, index)
	return self:_getTimePeriod(activityId, index) > GameUtil.inTimePeriod
end

function ActivityTimeProgressView:_getTimePeriod(activityId, index)
	local data = OperationSummaryConfig.instance:getActSumTimeProData(activityId, index)

	return (data or nil) and GameUtil.getTimePeriod(data.startTime, data.endTime)
end

function ActivityTimeProgressView:_onUpdateSliderColUI()
	local dataList = OperationSummaryConfig.instance:getActSumTimeProDataList(self._activityId)
	local curProgress = self:_getCurProgress(self._activityId)
	local maxProgress = self:_getMaxProgress(self._activityId)

	self._progressList:reloadDataList(dataList)
	self._progressList:updateCell()

	local proList = {}

	for _, data in ipairs(dataList) do
		table.insert(proList, data.index)
	end

	self._progressList:updateProgressByList(proList, curProgress)

	local index = self:_getCurIndex(self._activityId)

	if index ~= 0 then
		self._progressList:rollToIdx(index)
	else
		self._progressList:rollToIdxNewest(proList, curProgress)
	end
end

function ActivityTimeProgressView:_onClearSliderColUI()
	self._progressList:dispose()
end

function ActivityTimeProgressView:_updateProgressGrid(go, data, idx)
	local mainGo = go
	local imgBg = goutil.findChild(mainGo, "imgBg")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local isPass = self:_isPass(self._activityId, data.index)
	local isNewest = idx == self:_getCurIndex(self._activityId)
	local path = data.picturePath

	if isNewest and not isPass then
		path = data.lightPicturePath
	end

	local bgGo = imgBg

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			local image = bgGo:GetComponent(goutil.Type_UIImage)
			local sprite = image.sprite

			image.rectTransform.sizeDelta = sprite.rect.size
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		uGuiUtil.clearImage(bgGo)
	end

	txtName.text = data.name

	local fTimeStr = ""
	local startDate, endDate

	if not string.nilorempty(data.startTime) then
		startDate = GameUtil.string2date(data.startTime)
	end

	if not string.nilorempty(data.endTime) then
		endDate = GameUtil.string2date(data.endTime)
	end

	if startDate == nil and endDate == nil then
		fTimeStr = ""
	elseif startDate and endDate then
		fTimeStr = string.format("%s.%s-%s.%s", startDate.month, startDate.day, endDate.month, endDate.day)
	elseif startDate == nil and startDate then
		fTimeStr = string.format("%s.%s 结束", endDate.month, endDate.day)
	elseif startDate and startDate == nil then
		fTimeStr = string.format("%s.%s 开始", startDate.month, startDate.day)
	end

	txtTime.text = fTimeStr

	GameUtil.SetGray(mainGo, isPass)
end

function ActivityTimeProgressView:_clearProgressCell(go, data, idx)
	local mainGo = go
	local imgBg = goutil.findChild(mainGo, "imgBg")

	uGuiUtil.clearImage(imgBg)
end

return ActivityTimeProgressView
