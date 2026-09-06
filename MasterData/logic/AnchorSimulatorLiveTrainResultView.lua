-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anchorsimulator/view/AnchorSimulatorLiveTrainResultView.lua

module("logic.extensions.anchorsimulator.view.AnchorSimulatorLiveTrainResultView", package.seeall)

local AnchorSimulatorLiveTrainResultView = class("AnchorSimulatorLiveTrainResultView", ViewComponent)

function AnchorSimulatorLiveTrainResultView:buildUI()
	AnchorSimulatorLiveTrainResultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local propertyScrView = self:getGo("propertyCol/scrView")
	local propertyScrCell = self:getGo("propertyCol/scrCell")

	self._propertyScrollList = ScrollerList.create(propertyScrView, propertyScrCell, GameUtil.handler(self._updatePropertyCell, self), GameUtil.handler(self._clearPropertyCell, self))

	local classesScrView = self:getGo("classesCol/scrView")
	local classesScrCell = self:getGo("classesCol/scrCell")

	self._classesScrollList = ScrollerList.create(classesScrView, classesScrCell, GameUtil.handler(self._updateClassesCell, self), GameUtil.handler(self._clearClassesCell, self))

	self._classesScrollList:setCenterMode(true)
end

function AnchorSimulatorLiveTrainResultView:bindEvents()
	AnchorSimulatorLiveTrainResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AnchorSimulatorLiveTrainResultView:unbindEvents()
	AnchorSimulatorLiveTrainResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AnchorSimulatorLiveTrainResultView:onEnter()
	AnchorSimulatorLiveTrainResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local msg = params[1]

	self._basePropertyDic = params[2] or {}
	self._activityId = msg.activityId
	self._selectClasses = msg.selectClasses
	self._topPropertyDic = {}

	for _, v in ipairs(msg.propertyList) do
		self._topPropertyDic[v.propertyType] = v.exp
	end

	self._actData = AnchorSimulatorConfig.instance:getActData(self._activityId)

	self:_onStart()
end

function AnchorSimulatorLiveTrainResultView:onExit()
	AnchorSimulatorLiveTrainResultView.super.onExit(self)

	if self._propertyCells then
		table.clear(self._propertyCells)
	end

	if self._classesSequence then
		self._classesSequence:Kill(false)

		self._classesSequence = nil
	end

	if self._propertySequenceList then
		for key, sequence in ipairs(self._propertySequenceList) do
			sequence:Kill(false)

			self._propertySequenceList[key] = nil
		end
	end

	self._classesScrollList:dispose()
	self._classesScrollList:regReloadFinish(nil, nil)
	self._propertyScrollList:dispose()
	self._propertyScrollList:regReloadFinish(nil, nil)
end

function AnchorSimulatorLiveTrainResultView:_onStart()
	self._totalShowTime = 2
	self._curShowTime = 0
	self._classesSliders = {}

	self._classesScrollList:regReloadFinish(function()
		if self._classesSequence then
			self._classesSequence:Kill(false)

			self._classesSequence = nil
		end

		for slider, index in pairs(self._classesSliders) do
			slider.value = 0
		end

		local sequence = DG.Tweening.DOTween.Sequence()

		for classesIndex = 1, #self._selectClasses do
			local duration = self._totalShowTime / #self._selectClasses
			local tweener = TweenUtil.DOTweenNum(0, 1, duration, function(value)
				for slider, index in pairs(self._classesSliders) do
					if index == classesIndex then
						slider.value = value

						break
					end
				end
			end, {})

			tweener:SetEase(DG.Tweening.Ease.Linear)
			sequence:Append(tweener)
		end

		sequence:OnComplete(function()
			self._classesSequence = nil

			self:_onEnd()
		end)

		self._classesSequence = sequence
	end)
	self._classesScrollList:reloadData(self._selectClasses)

	local propertyCfg = AnchorSimulatorConfig.instance:getPropertyCfg(self._activityId) or {}

	self._propertyCells = {}

	self._propertyScrollList:regReloadFinish(function()
		self._propertySequenceList = self._propertySequenceList or {}

		for key, sequence in ipairs(self._propertySequenceList) do
			sequence:Kill(false)

			self._propertySequenceList[key] = nil
		end

		for propertyType, data in ipairs(propertyCfg) do
			local baseExp = checknumber(self._basePropertyDic[propertyType])
			local topExp = checknumber(self._topPropertyDic[propertyType])
			local baseLevel = AnchorSimulatorConfig.instance:getPropertyLevelByExp(self._activityId, propertyType, baseExp)
			local topLevel = AnchorSimulatorConfig.instance:getPropertyLevelByExp(self._activityId, propertyType, topExp)
			local firstBaseProgress = AnchorSimulatorController.instance:getProgressByExp(self._activityId, propertyType, baseExp)
			local lastTopProgress = AnchorSimulatorController.instance:getProgressByExp(self._activityId, propertyType, topExp)

			lastTopProgress = Mathf.Max(firstBaseProgress, lastTopProgress)

			local firstTopProgress, lastBaseProgress = 1, 0

			if baseLevel == topLevel then
				firstTopProgress = lastTopProgress
				lastBaseProgress = lastTopProgress
			end

			local sequence = DG.Tweening.DOTween.Sequence()
			local baseDuration, perDuration, topDuration = 0, 0, 0
			local num = Mathf.Max(topLevel - baseLevel - 1, 0)
			local s1 = firstTopProgress - firstBaseProgress
			local s2 = num
			local s3 = lastTopProgress - lastBaseProgress
			local speed = (s1 + s2 + s3) / self._totalShowTime

			baseDuration = s1 / speed
			perDuration = s2 / speed / num
			topDuration = s3 / speed

			for mainGo, cell in pairs(self._propertyCells) do
				if cell._propertyType == propertyType then
					cell._realySlider.value = firstBaseProgress
					cell._virtualSlider.value = firstBaseProgress
					cell._txtLevel.text = string.format("等级%s", baseLevel)

					GameUtil.SetActive(cell._imgUp, false)

					break
				end
			end

			if baseDuration > 0 then
				local tweener = TweenUtil.DOTweenNum(firstBaseProgress, firstTopProgress, baseDuration, function(value)
					local cell = self:_getPropertyCell(propertyType)

					if cell then
						cell._virtualSlider.value = value
					end
				end, {})

				tweener:SetEase(DG.Tweening.Ease.Linear)
				tweener:OnComplete(function()
					if firstTopProgress >= 1 then
						local cell = self:_getPropertyCell(propertyType)

						if cell then
							GameUtil.SetActive(cell._imgUp, true)
						end
					end
				end)
				sequence:Append(tweener)
			end

			for idx = 1, num do
				local tweener = TweenUtil.DOTweenNum(0, 1, perDuration, function(value)
					local cell = self:_getPropertyCell(propertyType)

					if cell then
						cell._virtualSlider.value = value
					end
				end, {})

				tweener:SetEase(DG.Tweening.Ease.Linear)
				tweener:OnStart(function()
					local cell = self:_getPropertyCell(propertyType)

					if cell then
						cell._realySlider.value = 0
						cell._virtualSlider.value = 0
						cell._txtLevel.text = string.format("等级%s", baseLevel + idx)
					end
				end)
				sequence:Append(tweener)
			end

			if topDuration > 0 then
				local tweener = TweenUtil.DOTweenNum(lastBaseProgress, lastTopProgress, topDuration, function(value)
					local cell = self:_getPropertyCell(propertyType)

					if cell then
						cell._virtualSlider.value = value
					end
				end, {})

				tweener:SetEase(DG.Tweening.Ease.Linear)
				tweener:OnStart(function()
					local cell = self:_getPropertyCell(propertyType)

					if cell then
						cell._realySlider.value = 0
						cell._virtualSlider.value = 0
						cell._txtLevel.text = string.format("等级%s", topLevel)
					end
				end)
				sequence:Append(tweener)
			end

			self._propertySequenceList[propertyType] = sequence
		end
	end)
	self._propertyScrollList:reloadData(propertyCfg)
	GameUtil.SetActive(self._btnClose, false)
end

function AnchorSimulatorLiveTrainResultView:_onEnd()
	GameUtil.SetActive(self._btnClose, true)
end

function AnchorSimulatorLiveTrainResultView:_updateClassesCell(view, cell, propertyType, tag)
	local data = self:_getPropertyData(propertyType)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local slider = goutil.findChild(mainGo, "slider"):GetComponent(ComponentType.Slider)
	local spriteName = GameUrl.getBigbgPngUrl(data.classesBg)

	uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, spriteName, function()
		return
	end)

	self._classesSliders[slider] = cell.data
end

function AnchorSimulatorLiveTrainResultView:_clearClassesCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")

	uGuiUtil.clearImage(con)
end

function AnchorSimulatorLiveTrainResultView:_updatePropertyCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local cell = {}

	cell._imgUp = goutil.findChild(mainGo, "imgUp")
	cell._txtLevel = goutil.findChildTextComponent(mainGo, "txtLevel")
	cell._txtName = goutil.findChildTextComponent(mainGo, "txtName")
	cell._virtualSlider = goutil.findChild(mainGo, "virtualSlider"):GetComponent(ComponentType.Slider)
	cell._realySlider = goutil.findChild(mainGo, "realySlider"):GetComponent(ComponentType.Slider)
	cell._data = data
	cell._propertyType = data.propertyType
	self._propertyCells[mainGo] = cell
	cell._txtName.text = data.desc
end

function AnchorSimulatorLiveTrainResultView:_clearPropertyCell(cell)
	local mainGo = cell.gameObject

	self._propertyCells[mainGo] = nil
end

function AnchorSimulatorLiveTrainResultView:_getPropertyCell(propertyType)
	for mainGo, cell in pairs(self._propertyCells) do
		if cell._propertyType == propertyType then
			return cell
		end
	end
end

function AnchorSimulatorLiveTrainResultView:_getPropertyData(propertyType)
	if propertyType == 0 then
		local data = {}

		data.desc = "休息"
		data.classesBg = AnchorSimulatorEnum.RelaxationClassesBgPath

		return data
	else
		return AnchorSimulatorConfig.instance:getPropertyData(self._activityId, propertyType)
	end
end

return AnchorSimulatorLiveTrainResultView
