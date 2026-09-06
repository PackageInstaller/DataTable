-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapterTwoMainView.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapterTwoMainView", package.seeall)

local BoccaccioChapterTwoMainView = class("BoccaccioChapterTwoMainView", ViewComponent)

function BoccaccioChapterTwoMainView:ctor()
	BoccaccioChapterTwoMainView.super.ctor(self)

	self._passagesCells = {}
	self._wordUnits = {}
	self._wordUnitsByTxt = {}
end

function BoccaccioChapterTwoMainView:buildUI()
	BoccaccioChapterTwoMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnStage = self:getGo("btnStage")
	self._btnLeft = self:getGo("btnLeft")
	self._btnRight = self:getGo("btnRight")
	self._guide = self:getGo("guide")
	self._txtBubbleGuide = self:getTxt("guide/bubble/txt")
	self._passagesView = self:getGo("passagesCol/passagesView")
	self._passagesCell = self:getGo("passagesCol/passagesCell")
	self._passagesPoint = self:getGo("passagesPoint")
	self._wordUnit = self:getGo("wordUnit")
	self._wordUnitPoolRoot = self:getGo("wordUnitPool")

	GameUtil.SetActive(self._passagesPoint, false)
	GameUtil.SetActive(self._passagesCell, false)
	GameUtil.SetActive(self._wordUnit, false)

	local wordScrView = self:getGo("wordCol/scrView")
	local wordScrCell = self:getGo("wordCol/scrCell")

	self._wordScrollerList = ScrollerList.create(wordScrView, wordScrCell, GameUtil.handler(self._updateWordCell, self), GameUtil.handler(self._clearWordCell, self))

	self._wordScrollerList:setDragCallBack("drayPlane", function(eventData, data, go)
		self:_onDragBeginWordScrCell(eventData, data, go)
	end, function(eventData, data, go)
		self:_onDragWordScrCell(eventData, data, go)
	end, function(eventData, data, go)
		self:_onDragEndWordScrCell(eventData, data, go)
	end)

	self._tagEmptyWordCol = self:getGo("wordCol/tagEmpty")
	self._wordPoint = self:getGo("wordPoint")
	self._txtContentInWordPoint = self:getTxt("wordPoint/txtContent")

	GameUtil.SetActive(self._wordPoint, false)

	self._progressCol = self:getGo("progressCol")
	self._progressScrView = self:getGo("progressCol/scrView")
	self._progressScrCell = self:getGo("progressCol/scrCell")
	self._progressBar = self:getGo("progressCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("progressCol/scrView/Viewport/Content/progressBar")
	self._txtProgress = self:getTxt("progressCol/progress/txt")
	self._progressScrollerList = ScrollerList.create(self._progressScrView, self._progressScrCell, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
end

function BoccaccioChapterTwoMainView:bindEvents()
	BoccaccioChapterTwoMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnStage, self._onClickBtnStage, self)
	GameUtil.addClickHandler(self._btnLeft, GameUtil.handler(self._changeStory, self, -1))
	GameUtil.addClickHandler(self._btnRight, GameUtil.handler(self._changeStory, self, 1))
end

function BoccaccioChapterTwoMainView:unbindEvents()
	BoccaccioChapterTwoMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStage)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
end

function BoccaccioChapterTwoMainView:onEnter()
	BoccaccioChapterTwoMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._chapterId = BoccaccioChapterEnum.ChapterId_2
	self._subMo = BoccaccioChapterController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_BoccaccioChapterInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_BoccaccioChapterOneClickGainProgressPrizeRes, self._onUpdateProgressCol, self)
	self.addGEvent(self, GlobalNotify.HandlePM_BoccaccioChapter2FindErrorWordRes, self._handlePM_BoccaccioChapter2FindErrorWordRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_BoccaccioChapter2RecoverySequenceRes, self._handlePM_BoccaccioChapter2RecoverySequenceRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_BoccaccioChapter2ReplaceWordRes, self._handlePM_BoccaccioChapter2ReplaceWordRes, self)

	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	GameUtil.SetActive(self._passagesPoint, false)
	self:_onUpdate()
end

function BoccaccioChapterTwoMainView:onExit()
	BoccaccioChapterTwoMainView.super.onExit(self)

	self._dragiPassagesCell = false
	self._dragiWordScrCell = false

	self:_onClearProgressCol()
	self:_onClearPassagesCol()
	self:_onClearWordCol()
	self:_onClearWordUnitCol()
	self:_onClearGuide()
end

function BoccaccioChapterTwoMainView:destroyUI()
	BoccaccioChapterTwoMainView.super.destroyUI(self)
	self:_onDestroyPassagesCol()
end

function BoccaccioChapterTwoMainView:_handlePM_BoccaccioChapter2FindErrorWordRes(msg)
	local storyId = msg.storyId
	local errorWordId = msg.errorWordId

	if not self._wordUnits[errorWordId] then
		for i, v in ipairs(self._wordUnits[errorWordId]) do
			self:_updateWordUnit(v, errorWordId, i)
		end

		if self._subMo:isAllErrorWordsSearched(storyId) then
			self:_onUpdateUI()
		end
	end
end

function BoccaccioChapterTwoMainView:_handlePM_BoccaccioChapter2RecoverySequenceRes(msg)
	self:_onUpdateUI()
end

function BoccaccioChapterTwoMainView:_handlePM_BoccaccioChapter2ReplaceWordRes(msg)
	local storyId = msg.storyId
	local errorWordId = msg.errorWordId

	if self._subMo:isAllErrorWordsReplaced(storyId) then
		local effPath = "20241220/zhongyanzhizhan/fx_ui_bianbai.prefab"

		local function finishHandle(handlerTarget, eff)
			local maxStoryId = self._subMo:getMaxStoryId()
			local nextStoryId = storyId + 1

			if maxStoryId < nextStoryId then
				self:_onUpdateUI()
				BoccaccioChapterController.instance:unlockPlot(self._activityId, BoccaccioChapterEnum.PolotUnlockType.C2AllRight, 1)
			else
				self:_changeStory(1)
			end
		end

		self:playViewEffect(effPath, self.mainGO, nil, false, 0, 0, finishHandle, nil)
	else
		local datas = BoccaccioChapterConfig.instance:getChapter2PassagesDatas(self._activityId, storyId) or {}

		for _, data in ipairs(datas) do
			if not data.errorWordIdList then
				if data.errorWordIdList and table.indexof(data.errorWordIdList, errorWordId) ~= false then
					local passagesId = data.passagesId
					local cell = self._passagesCells[passagesId]

					self:_updatePassagesCell(cell, passagesId)

					break
				end
			end
		end

		self:_onUpdateWordCol()
		self:_onUpdateProgressCol()
	end
end

function BoccaccioChapterTwoMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function BoccaccioChapterTwoMainView:_onUpdateData()
	self._curStoryId = self._curStoryId or 0

	if self._curStoryId > 0 and not self._subMo:isUnlockStory(self._curStoryId) then
		self._curStoryId = 0
	end

	if self._curStoryId <= 0 then
		local dataList = BoccaccioChapterConfig.instance:getChapter2StoryDatas(self._activityId) or {}

		for storyId, data in ipairs(dataList) do
			if self._subMo:isUnlockStory(storyId) then
				self._curStoryId = storyId
			else
				break
			end

			if not self._subMo:isAllErrorWordsReplaced(storyId) then
				break
			end
		end
	end

	self._passagesIdListInCfg = {}

	local passagesDatass = BoccaccioChapterConfig.instance:getChapter2PassagesDatass(self._activityId) or {}

	for storyId, datas in ipairs(passagesDatass) do
		self._passagesIdListInCfg[storyId] = {}

		for passagesId, data in ipairs(datas) do
			self._passagesIdListInCfg[storyId][passagesId] = passagesId
		end
	end
end

function BoccaccioChapterTwoMainView:_onUpdateUI()
	self._passagesIdListInCurSort = {}

	local isRecoverySequence = self._subMo:isRecoverySequenceInStory(self._curStoryId)
	local passagesDatas = BoccaccioChapterConfig.instance:getChapter2PassagesDatas(self._activityId, self._curStoryId) or {}

	for passagesId, data in ipairs(passagesDatas) do
		if isRecoverySequence then
			self._passagesIdListInCurSort[passagesId] = passagesId
		else
			self._passagesIdListInCurSort[data.sortId] = passagesId
		end
	end

	self:_onUpdateProgressCol()
	self:_onUpdatePassagesCol()
	self:_onUpdateWordCol()
	self:_onUpdateWordUnitCol()
	self:_onUpdateGuide()

	local maxStoryId = self._subMo:getMaxStoryId()

	GameUtil.SetActive(self._btnLeft, self._curStoryId > 1)
	GameUtil.SetActive(self._btnRight, maxStoryId > self._curStoryId)
end

function BoccaccioChapterTwoMainView:_onUpdatePassagesCol()
	local passagesIdList = self._passagesIdListInCurSort
	local cellCount = #self._passagesCells

	for sortId = 1, Mathf.Max(cellCount, #passagesIdList) do
		if sortId <= #passagesIdList then
			local cell = self._passagesCells[sortId]

			if cell == nil then
				local mainGo = goutil.cloneAndSetParent(self._passagesCell, self._passagesView.transform, self._passagesCell.name .. "_" .. sortId)

				cell = {
					_mainGo = mainGo,
					_sortId = sortId,
					_txtDesc = self:_findGraphicText(mainGo, "txtDesc"),
					_tagError = goutil.findChild(mainGo, "tagError"),
					_tagInserLine = goutil.findChild(mainGo, "tagInserLine")
				}

				local triggerGo = mainGo

				cell._beginDragHandler = BeginDragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
					self:_onDragBeginPassagesCell(eventData, cell)
				end)
				cell._dragHandler = DragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
					self:_onDragPassagesCell(eventData, cell)
				end)
				cell._endDragHandler = EndDragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
					self:_onDragEndPassagesCell(eventData, cell)
				end)
				self._passagesCells[sortId] = cell
			end

			self:_updatePassagesCell(cell, sortId)
		else
			local cell = self._passagesCells[sortId]

			self:_clearPassagesCell(cell)
		end
	end
end

function BoccaccioChapterTwoMainView:_onClearPassagesCol()
	for _, cell in pairs(self._passagesCells) do
		self:_clearPassagesCell(cell)
	end
end

function BoccaccioChapterTwoMainView:_onDestroyPassagesCol()
	for _, cell in pairs(self._passagesCells) do
		local triggerGo = cell._mainGo

		if cell._beginDragHandler then
			BeginDragHandler.Get(triggerGo):RemoveLuaHandler(cell._beginDragHandler)
		end

		if cell._endDragHandler then
			EndDragHandler.Get(triggerGo):RemoveLuaHandler(cell._endDragHandler)
		end

		if cell._dragHandler then
			DragHandler.Get(triggerGo):RemoveLuaHandler(cell._dragHandler)
		end

		cell._beginDragHandler = nil
		cell._endDragHandler = nil
		cell._dragHandler = nil
	end
end

function BoccaccioChapterTwoMainView:_updatePassagesCell(cell, sortId)
	local passagesId = self._passagesIdListInCurSort[sortId]
	local correctPassagesId = self._passagesIdListInCfg[self._curStoryId][sortId]
	local isCorrectOrder = passagesId == correctPassagesId

	GameUtil.SetActive(cell._mainGo, true)
	GameUtil.SetActive(cell._tagError, not isCorrectOrder)
	GameUtil.SetActive(cell._tagInserLine, false)
	self:_updateTxtGraphicContent(cell._txtDesc, passagesId)
end

function BoccaccioChapterTwoMainView:_updateTxtGraphicContent(txtGraphic, passagesId)
	local data = BoccaccioChapterConfig.instance:getChapter2PassagesData(self._activityId, self._curStoryId, passagesId)
	local content = data.desc

	if not data.errorWordIdList then
		if #data.errorWordIdList > 0 then
			local wordList = {}

			for _, errorWordId in ipairs(data.errorWordIdList) do
				local word

				if self._subMo:isReplaceErrorWord(errorWordId) then
					local correctData = BoccaccioChapterConfig.instance:getChapter2WordDataByError(self._activityId, errorWordId)

					word = self:_chnageContent(correctData.content, data.storyId, data.passagesId, errorWordId, 23, -4.3)
				else
					local errorData = BoccaccioChapterConfig.instance:getChapter2ErrorWordData(self._activityId, errorWordId)

					word = self:_chnageContent(errorData.content, data.storyId, data.passagesId, errorWordId, 23, -4.3)
				end

				table.insert(wordList, word)
			end

			self:_setTxtGraphicContent(txtGraphic, string.format(content, GameUtil.unpack10(wordList)))
		else
			self:_setTxtGraphicContent(txtGraphic, content)
		end
	end
end

function BoccaccioChapterTwoMainView:_setTxtGraphicContent(txtGraphic, content)
	if txtGraphic.text == content then
		return
	end

	local units = self._wordUnitsByTxt[txtGraphic]

	if units then
		for _, unit in pairs(units) do
			self:_clearWordUnit(unit)
		end

		self._wordUnitsByTxt[txtGraphic] = {}
	end

	txtGraphic.text = content
end

function BoccaccioChapterTwoMainView:_clearPassagesCell(cell)
	self:_setTxtGraphicContent(cell._txtDesc, "")
	GameUtil.SetActive(cell._mainGo, false)
end

function BoccaccioChapterTwoMainView:_onDragBeginPassagesCell(eventData, cell)
	if self._subMo:isRecoverySequenceInStory(self._curStoryId) then
		return
	end

	local sortId = cell._sortId
	local passagesId = self._passagesIdListInCurSort[sortId]
	local correctPassagesId = self._passagesIdListInCfg[self._curStoryId][sortId]
	local isCorrectOrder = passagesId == correctPassagesId

	if isCorrectOrder then
		return
	end

	self._dragiPassagesCell = true

	GameUtil.SetActive(self._passagesPoint, true)
end

function BoccaccioChapterTwoMainView:_onDragPassagesCell(eventData, cell)
	if not self._dragiPassagesCell then
		return
	end

	local worldPos = uGuiUtil.GetTouchWorldPosition()

	GameUtil.setPos(self._passagesPoint, worldPos.x, worldPos.y, worldPos.z)

	local targetCell = self:_getPassagesCellByPointer(eventData)

	if self._oldTargetCell and self._oldTargetCell ~= targetCell then
		GameUtil.SetActive(self._oldTargetCell._tagInserLine, false)
	end

	self._oldTargetCell = targetCell

	if targetCell then
		GameUtil.SetActive(targetCell._tagInserLine, true)
	end
end

function BoccaccioChapterTwoMainView:_onDragEndPassagesCell(eventData, cell)
	if not self._dragiPassagesCell then
		return
	end

	self._dragiPassagesCell = false

	GameUtil.SetActive(self._passagesPoint, false)

	self._oldTargetCell = nil

	local passagesIdList = self._passagesIdListInCurSort

	for sortId, passagesId in ipairs(passagesIdList) do
		local cell = self._passagesCells[sortId]

		if cell then
			GameUtil.SetActive(cell._tagInserLine, false)
		end
	end

	local targetCell = self:_getPassagesCellByPointer(eventData)

	if targetCell then
		local sortId = targetCell._sortId
		local targetPassagesId = self._passagesIdListInCurSort[sortId]
		local correctPassagesId = self._passagesIdListInCfg[self._curStoryId][sortId]

		if targetPassagesId == correctPassagesId then
			FloatWordMgr.instance:show("位置错误")

			return
		end

		local dargPassagesId = self._passagesIdListInCurSort[cell._sortId]

		if dargPassagesId == correctPassagesId then
			FloatWordMgr.instance:show("位置正确")

			local sortIdA = cell._sortId
			local sortIdB = targetCell._sortId

			self._passagesIdListInCurSort[sortIdA] = self._passagesIdListInCurSort[sortIdB]
			self._passagesIdListInCurSort[sortIdB] = self._passagesIdListInCurSort[sortIdA]

			self:_updatePassagesCell(cell, sortIdA)
			self:_updatePassagesCell(targetCell, sortIdB)

			local isAllSequenceCompleted = true

			for sortId, passagesId in ipairs(self._passagesIdListInCurSort) do
				local correctPassagesId = self._passagesIdListInCfg[self._curStoryId][sortId]

				if passagesId ~= correctPassagesId then
					isAllSequenceCompleted = false

					break
				end
			end

			if isAllSequenceCompleted then
				BoccaccioChapterController.instance:sendPM_BoccaccioChapter2RecoverySequenceReq(self._activityId, self._curStoryId)
			end
		else
			FloatWordMgr.instance:show("位置错误")
		end
	end
end

function BoccaccioChapterTwoMainView:_getPassagesCellByPointer(eventData)
	local result

	for sortId, cell in ipairs(self._passagesCells) do
		local isInRect = UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(cell._mainGo.transform, eventData.position, GlobalModel.instance.uiCamera)

		if isInRect then
			result = cell

			break
		end
	end

	return result
end

function BoccaccioChapterTwoMainView:_onUpdateWordUnitCol()
	local datas = BoccaccioChapterConfig.instance:getChapter2PassagesDatas(self._activityId, self._curStoryId) or {}

	for _, data in ipairs(datas) do
		if not data.errorWordIdList then
			for index, errorWordId in ipairs(data.errorWordIdList) do
				local unit = self:_getWordUnit(data.storyId, data.passagesId, errorWordId, index)

				self:_updateWordUnit(unit, errorWordId, index)
			end
		end
	end
end

function BoccaccioChapterTwoMainView:_onClearWordUnitCol()
	for _, units in pairs(self._wordUnits) do
		for _, unit in pairs(units) do
			self:_clearWordUnit(unit)
		end
	end
end

function BoccaccioChapterTwoMainView:_updateWordUnit(unit, errorWordId, index)
	local isSearched = self._subMo:isSearchedErrorWord(errorWordId)
	local isReplace = self._subMo:isReplaceErrorWord(errorWordId)
	local errorData = BoccaccioChapterConfig.instance:getChapter2ErrorWordData(self._activityId, errorWordId)
	local wordData = BoccaccioChapterConfig.instance:getChapter2WordDataByError(self._activityId, errorWordId)
	local errorChars = StringUtil.utf8split(errorData.content)

	unit._txtError.text = errorChars[index] or ""

	local correctChars = StringUtil.utf8split(wordData.content)

	unit._txtCorrect.text = correctChars[index] or ""

	GameUtil.SetActive(unit._txtError.gameObject, not isReplace)
	GameUtil.SetActive(unit._txtCorrect.gameObject, isReplace)
	GameUtil.SetActive(unit._tagCircle, isSearched and not isReplace)
	GameUtil.addClickHandler(unit._mainGo, function()
		if not self._subMo:isRecoverySequenceInStory(self._curStoryId) then
			return
		end

		local isSearched = self._subMo:isSearchedErrorWord(errorWordId)

		if isSearched then
			return
		end

		local isReplace = self._subMo:isReplaceErrorWord(errorWordId)

		if isReplace then
			return
		end

		BoccaccioChapterController.instance:sendPM_BoccaccioChapter2FindErrorWordReq(self._activityId, self._curStoryId, errorWordId)
	end)
end

function BoccaccioChapterTwoMainView:_clearWordUnit(unit)
	goutil.addChildToParent(unit._mainGo, self._wordUnitPoolRoot)
	GameUtil.rmClickHandler(unit._mainGo)
	GameUtil.SetActive(unit._mainGo, false)
end

function BoccaccioChapterTwoMainView:_chnageContent(content, storyId, passagesId, errorWordId, qsize, ofy)
	qsize = qsize or 23
	ofy = ofy or 0

	if not string.nilorempty(content) then
		local res = ""
		local i = 1
		local index = 1
		local len = string.len(content)
		local width = 1

		while index <= len do
			local char = string.byte(content, index)
			local size = StringUtil.utf8CharSize(char)

			if size > 0 then
				local value = string.sub(content, index, index + size - 1)

				index = index + size

				local des = string.format("%s:%s:%s:%s:%s", value, storyId, passagesId, errorWordId, i)

				res = res .. string.format("<quad name=%s size=%s width=%s offsetY=%s/>", des, qsize, width, ofy)
				i = i + 1
			else
				index = index + 1
			end
		end

		return res
	end

	return ""
end

function BoccaccioChapterTwoMainView:_findGraphicText(mainGo, path)
	local txt = goutil.findChildComponent(mainGo, path, ComponentType.UIGraphicTextNew)

	txt:SetLuaCallBack(function(go, des, size)
		local arr = string.split(des, ":")
		local storyId = checknumber(arr[2])
		local passagesId = checknumber(arr[3])
		local errorWordId = checknumber(arr[4])
		local index = checknumber(arr[5])
		local unit = self:_getWordUnit(storyId, passagesId, errorWordId, index)

		self._wordUnitsByTxt[txt] = self._wordUnitsByTxt[txt] or {}

		for k, v in pairs(self._wordUnitsByTxt) do
			for kk, vv in pairs(v) do
				if vv == unit then
					self._wordUnitsByTxt[k][kk] = nil

					break
				end
			end
		end

		self._wordUnitsByTxt[txt][unit] = unit

		goutil.addChildToParent(unit._mainGo, go)

		unit._mainGo:GetComponent(goutil.Type_RectTransform).sizeDelta = size

		GameUtil.SetActive(unit._mainGo, true)
		GameUtil.setLocalPos(unit._mainGo, 0, 0)
		self:_updateWordUnit(unit, errorWordId, index)
	end, nil)

	return txt
end

function BoccaccioChapterTwoMainView:_getWordUnit(storyId, passagesId, errorWordId, index)
	if self._wordUnits[errorWordId] then
		local unit = self._wordUnits[errorWordId][index]

		if self._wordUnits[errorWordId] == nil then
			local name = string.format("%s_%s_%s_%s_%s", self._wordUnit.name, storyId, passagesId, errorWordId, index)
			local mainGo = goutil.cloneAndSetParent(self._wordUnit, self._wordUnitPoolRoot.transform, name)

			unit = {
				_mainGo = mainGo,
				_txtError = goutil.findChildTextComponent(mainGo, "txtError"),
				_txtCorrect = goutil.findChildTextComponent(mainGo, "txtCorrect"),
				_tagCircle = goutil.findChild(mainGo, "tagCircle"),
				_storyId = storyId,
				_passagesId = passagesId,
				_errorWordId = errorWordId,
				_index = index
			}

			GameUtil.SetActive(mainGo, false)

			self._wordUnits[errorWordId] = self._wordUnits[errorWordId] or {}
			self._wordUnits[errorWordId][index] = self._wordUnits[errorWordId]
		end

		return self._wordUnits[errorWordId]
	end
end

function BoccaccioChapterTwoMainView:_onUpdateWordCol()
	local wordIdList = {}
	local datas = BoccaccioChapterConfig.instance:getChapter2WordDatas(self._activityId) or {}

	for _, data in ipairs(datas) do
		local wordId = data.wordId
		local count = self._subMo:getGainWordCountInStory(self._curStoryId, wordId)

		if count > 0 then
			table.insert(wordIdList, wordId)
		end
	end

	self._wordScrollerList:reloadData(wordIdList)
	self._wordScrollerList:MoveCellToBegin(0)
	GameUtil.SetActive(self._tagEmptyWordCol, #wordIdList == 0)
end

function BoccaccioChapterTwoMainView:_onClearWordCol()
	self._wordScrollerList:dispose()
end

function BoccaccioChapterTwoMainView:_updateWordCell(view, cell, wordId, tag)
	local mainGo = cell.gameObject
	local count = self._subMo:getGainWordCountInStory(self._curStoryId, wordId)
	local data = BoccaccioChapterConfig.instance:getChapter2WordData(self._activityId, wordId)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")

	txtName.text = data.content
	txtCount.text = string.format("x%s", count)
end

function BoccaccioChapterTwoMainView:_clearWordCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function BoccaccioChapterTwoMainView:_onDragBeginWordScrCell(eventData, wordId, go)
	if self._subMo:isAllErrorWordsReplaced(self._curStoryId) then
		FloatWordMgr.instance:show("已完成")

		return
	end

	if not self._subMo:isAllErrorWordsSearched(self._curStoryId) then
		FloatWordMgr.instance:show("未找出所有错字")

		return
	end

	local count = self._subMo:getGainWordCountInStory(self._curStoryId, wordId)

	if count <= 0 then
		FloatWordMgr.instance:show("字数不足")

		return
	end

	self._dragiWordScrCell = true

	local data = BoccaccioChapterConfig.instance:getChapter2WordData(self._activityId, wordId)

	self._txtContentInWordPoint.text = data.content

	GameUtil.SetActive(self._wordPoint, true)
end

function BoccaccioChapterTwoMainView:_onDragWordScrCell(eventData, wordId, go)
	if not self._dragiWordScrCell then
		return
	end

	local worldPos = uGuiUtil.GetTouchWorldPosition()

	GameUtil.setPos(self._wordPoint, worldPos.x, worldPos.y, worldPos.z)
end

function BoccaccioChapterTwoMainView:_onDragEndWordScrCell(eventData, wordId, go)
	if not self._dragiWordScrCell then
		return
	end

	self._dragiWordScrCell = false

	GameUtil.SetActive(self._wordPoint, false)

	local result = false
	local tips = ""
	local targetWordUnit
	local datas = BoccaccioChapterConfig.instance:getChapter2PassagesDatas(self._activityId, self._curStoryId) or {}

	for _, data in ipairs(datas) do
		local isEndFor = false

		if not data.errorWordIdList then
			for _, errorWordId in ipairs(data.errorWordIdList) do
				local isReplace = self._subMo:isReplaceErrorWord(errorWordId)

				if not isReplace then
					local errorData = BoccaccioChapterConfig.instance:getChapter2ErrorWordData(self._activityId, errorWordId)
					local replaceWordId = errorData.replaceWordId

					if not self._wordUnits[errorWordId] then
						for index, unit in ipairs(self._wordUnits[errorWordId]) do
							local isInRect = UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(unit._mainGo.transform, eventData.position, GlobalModel.instance.uiCamera)

							if isInRect then
								if replaceWordId == wordId then
									tips = "位置正确"
									result = true
									targetWordUnit = unit
								else
									tips = "位置错误"
								end

								isEndFor = true

								break
							end
						end
					end
				end

				if isEndFor then
					break
				end
			end

			if isEndFor then
				break
			end
		end
	end

	FloatWordMgr.instance:show(tips)

	if not result then
		self:_onShowErrorEffect()

		return
	end

	local storyId = targetWordUnit._storyId
	local errorWordId = targetWordUnit._errorWordId

	self:_onShowCorrectEffect()
	BoccaccioChapterController.instance:sendPM_BoccaccioChapter2ReplaceWordReq(self._activityId, storyId, errorWordId)
end

function BoccaccioChapterTwoMainView:_changeStory(delta)
	local maxStoryId = self._subMo:getMaxStoryId()
	local nextStoryId = Mathf.Clamp(self._curStoryId + delta, 1, maxStoryId)

	if self._curStoryId == nextStoryId then
		return
	end

	if not self._subMo:isUnlockStory(nextStoryId) then
		FloatWordMgr.instance:show("未解锁")

		return
	end

	self._curStoryId = nextStoryId

	self:_onClearPassagesCol()
	self:_onUpdateUI()
end

function BoccaccioChapterTwoMainView:_onUpdateProgressCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = 0

	for idx, data in ipairs(dataList) do
		if not self:_isHasGainPrize(data) then
			index = idx - 1

			break
		end
	end

	self._progressScrollerList:reloadData(dataList)
	self._progressScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._progressScrollerList:MoveCellToCenter(index)

	self._txtProgress.text = curProgress
end

function BoccaccioChapterTwoMainView:_onClearProgressCol()
	self._progressScrollerList:dispose()
end

function BoccaccioChapterTwoMainView:_getProgressDataList()
	return BoccaccioChapterConfig.instance:getProgressPrizeDatas(self._activityId, self._chapterId) or {}
end

function BoccaccioChapterTwoMainView:_getSliderComp()
	return self._sliderComp
end

function BoccaccioChapterTwoMainView:_getScrollRect()
	return self._progressScrView:GetComponent(ComponentType.ScrollRect)
end

function BoccaccioChapterTwoMainView:_getCurProgress()
	return self._subMo:getCurProgress(self._chapterId)
end

function BoccaccioChapterTwoMainView:_getProgressByData(data)
	return checknumber(data.progress)
end

function BoccaccioChapterTwoMainView:_getPrizeIdByData(data)
	return data.progressId
end

function BoccaccioChapterTwoMainView:_getPrizeStrByData(data)
	return data.prize
end

function BoccaccioChapterTwoMainView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isHasGainPrize(self._chapterId, prizeId)
end

function BoccaccioChapterTwoMainView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isEnoughGetPrize(self._chapterId, prizeId)
end

function BoccaccioChapterTwoMainView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isCanGetPrize(self._chapterId, prizeId)
end

function BoccaccioChapterTwoMainView:_updateProgressCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isHasGain = self:_isHasGainPrize(data)
	local isCanGet = self:_isCanGetPrize(data)
	local progress = self:_getProgressByData(data)
	local prizeStr = self:_getPrizeStrByData(data)
	local scrollRect = self:_getScrollRect()
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local received = goutil.findChild(mainGo, "received")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	if not string.nilorempty(prizeStr) then
		MaterialMgr.setCellByCfg(prizeStr, item)
	else
		MaterialMgr.resetAll(item)
	end

	if txtScore then
		txtScore.text = progress
	end

	GameUtil.SetActive(received, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	if isCanGet then
		local function loadedHandler(handlerTarget, eff)
			eff:setScrollRectClipping(scrollRect)
		end

		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, nil, true, nil, loadedHandler)
	else
		self:stopViewEffectUniGo(effectRoot)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
end

function BoccaccioChapterTwoMainView:_clearProgressCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function BoccaccioChapterTwoMainView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeId = self:_getPrizeIdByData(data)

	BoccaccioChapterController.instance:sendPM_BoccaccioChapterOneClickGainProgressPrizeReq(self._activityId, self._chapterId)
end

function BoccaccioChapterTwoMainView:_onUpdateGuide()
	local state = 0

	if self._subMo:isAllErrorWordsReplaced(self._curStoryId) then
		state = 0
	elseif not self._subMo:isRecoverySequenceInStory(self._curStoryId) then
		state = 1
	elseif not self._subMo:isAllErrorWordsSearched(self._curStoryId) then
		state = 2
	elseif self._subMo:isAllErrorWordsSearched(self._curStoryId) then
		local wordCount = self._subMo:getGainWordTotalCountInStory(self._curStoryId)

		state = wordCount <= 0 and 3 or 4
	end

	GameUtil.SetActive(self._guide, true)

	if state == 0 then
		GameUtil.SetActive(self._guide, false)
	elseif state == 1 then
		self._txtBubbleGuide.text = "长按小说片段，拖拽更改为正确顺序吧！"
	elseif state == 2 then
		self._txtBubbleGuide.text = "点击圈出段落内的“错误词语”"
	elseif state == 3 then
		self._txtBubbleGuide.text = "去挑战关卡，获得词语吧!"
	elseif state == 4 then
		self._txtBubbleGuide.text = "将正确词语拖拽至红圈位置，替换掉错误词语吧!"
	end
end

function BoccaccioChapterTwoMainView:_onClearGuide()
	self._txtBubbleGuide.text = ""

	GameUtil.SetActive(self._guide, false)
end

function BoccaccioChapterTwoMainView:_onClickBtnTip()
	BoccaccioChapterController.instance:openChapterRule(self._activityId, self._chapterId)
end

function BoccaccioChapterTwoMainView:_onClickBtnStage()
	if self._curStoryId <= 0 then
		printError("self._curStoryId <= 0")

		return
	end

	if not self._subMo:isAllErrorWordsSearched(self._curStoryId) then
		FloatWordMgr.instance:show("请先找出所有错词")

		return
	end

	if self._subMo:isAllErrorWordsReplaced(self._curStoryId) then
		FloatWordMgr.instance:show("已完成")

		return
	end

	UIStateManager.instance:push(ViewName.BoccaccioChapterTwoStageView, self._activityId, self._curStoryId)
end

function BoccaccioChapterTwoMainView:_onShowErrorEffect()
	local root = self:getGo("errorEff")
	local x, y, z = Framework.TransformUtil.GetPos(self._wordPoint.transform, 0, 0, 0)

	GameUtil.setPos(root, x, y, z)

	local effPath = "20260403/bojiaqiufuben/fx_ui_bjqfb_wzcw.prefab"

	self:playViewEffectUniGo(effPath, root, nil, false, nil, nil)
end

function BoccaccioChapterTwoMainView:_onShowCorrectEffect()
	local root = self:getGo("correctEff")
	local x, y, z = Framework.TransformUtil.GetPos(self._wordPoint.transform, 0, 0, 0)

	GameUtil.setPos(root, x, y, z)

	local effPath = "20260403/bojiaqiufuben/fx_ui_bjqfb_wzzq.prefab"

	self:playViewEffectUniGo(effPath, root, nil, false, nil, nil)
end

return BoccaccioChapterTwoMainView
