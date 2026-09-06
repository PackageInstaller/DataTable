-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapterOneMainView.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapterOneMainView", package.seeall)

local BoccaccioChapterOneMainView = class("BoccaccioChapterOneMainView", ViewComponent)

function BoccaccioChapterOneMainView:buildUI()
	BoccaccioChapterOneMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._starCol = self:getGo("starCol")
	self._starScrView = self:getGo("starCol/scrView")
	self._starScrCell = self:getGo("starCol/scrCell")
	self._starScrollerList = ScrollerList.create(self._starScrView, self._starScrCell, GameUtil.handler(self._updateStarCell, self), GameUtil.handler(self._clearStarCell, self))
	self._stageView = self:getGo("stageCol/stageView")
	self._stageCell = self:getGo("stageCol/stageCell")
	self._progressCol = self:getGo("progressCol")
	self._progressScrView = self:getGo("progressCol/scrView")
	self._progressScrCell = self:getGo("progressCol/scrCell")
	self._progressBar = self:getGo("progressCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("progressCol/scrView/Viewport/Content/progressBar")
	self._txtProgress = self:getTxt("progressCol/progress/txt")
	self._progressScrollerList = ScrollerList.create(self._progressScrView, self._progressScrCell, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
end

function BoccaccioChapterOneMainView:bindEvents()
	BoccaccioChapterOneMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function BoccaccioChapterOneMainView:unbindEvents()
	BoccaccioChapterOneMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function BoccaccioChapterOneMainView:onEnter()
	BoccaccioChapterOneMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._chapterId = BoccaccioChapterEnum.ChapterId_1
	self._starId = checknumber(self._starId)
	self._subMo = BoccaccioChapterController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_BoccaccioChapterInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_BoccaccioChapterOneClickGainProgressPrizeRes, self._onUpdate, self)

	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	self:_onUpdate()
end

function BoccaccioChapterOneMainView:onEnterFinished()
	BoccaccioChapterOneMainView.super.onEnterFinished(self)

	local newestPassStageId = self._subMo:getPassStageCountC1()

	if newestPassStageId > 0 then
		BoccaccioChapterController.instance:unlockPlot(self._activityId, BoccaccioChapterEnum.PolotUnlockType.C1PassStage, newestPassStageId)
	end
end

function BoccaccioChapterOneMainView:onExit()
	BoccaccioChapterOneMainView.super.onExit(self)
	self:_onClearStarCol()
	self:_onClearStageCol()
	self:_onClearProgressCol()
end

function BoccaccioChapterOneMainView:_onUpdate()
	if self._starId <= 0 then
		local dataLists = BoccaccioChapterConfig.instance:getChapter1StageDataListsInStar(self._activityId) or {}

		for starId, _ in ipairs(dataLists) do
			self._starId = starId

			if not self._subMo:isPassStarC1(starId) then
				break
			end
		end
	end

	self:_onUpdateUI()
end

function BoccaccioChapterOneMainView:_onUpdateUI()
	self:_onUpdateStarCol()
	self:_onUpdateStageCol()
	self:_onUpdateProgressCol()
end

function BoccaccioChapterOneMainView:_onUpdateStarCol()
	local dataLists = BoccaccioChapterConfig.instance:getChapter1StageDataListsInStar(self._activityId) or {}
	local starIdList = {}

	for starId, _ in ipairs(dataLists) do
		table.insert(starIdList, starId)
	end

	self._starScrollerList:reloadData(starIdList)

	local index = 0

	for starId, _ in ipairs(starIdList) do
		if self._starId == starId then
			index = starId - 1

			break
		end
	end

	self._starScrollerList:MoveCellToCenter(index)
end

function BoccaccioChapterOneMainView:_onClearStarCol()
	self._starScrollerList:dispose()
end

function BoccaccioChapterOneMainView:_updateStarCell(view, cell, starId, tag)
	local mainGo = cell.gameObject
	local isPass = self._subMo:isPassStarC1(starId)
	local isUnlock = self._subMo:isUnlockStarC1(starId)
	local isSelect = self._starId == starId
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local tagSelect = goutil.findChild(mainGo, "tagSelect")
	local tagPass = goutil.findChild(mainGo, "tagPass")
	local tagLock = goutil.findChild(mainGo, "tagLock")

	txtName.text = string.format("星系%d", starId)

	GameUtil.SetActive(tagSelect, isSelect)
	GameUtil.SetActive(tagPass, isPass)
	GameUtil.SetActive(tagLock, not isUnlock)
	GameUtil.SetGray(mainGo, isPass)
	GameUtil.addClickHandler(mainGo, function()
		if self._starId == starId then
			return
		end

		local result = GameEnum.ResultCode.Success
		local tips
		local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

		if not isInTime then
			result = GameEnum.ResultCode.Error
			tips = "不在活动时间范围内"
		elseif isPass then
			result = GameEnum.ResultCode.Error
			tips = isShowTips and "已通关"
		elseif not isUnlock then
			result = GameEnum.ResultCode.Error
			tips = "请先通关前置关卡"
		end

		FloatWordMgr.instance:show(tips)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		self._starId = starId

		self:_onUpdateUI()
	end)
end

function BoccaccioChapterOneMainView:_clearStarCell(cell)
	local mainGo = cell.gameObject

	GameUtil.SetGray(mainGo, false)
	GameUtil.rmClickHandler(mainGo)
end

function BoccaccioChapterOneMainView:_onUpdateStageCol()
	local dataList = BoccaccioChapterConfig.instance:getChapter1StageDataListInStar(self._activityId, self._starId) or {}

	GameUtil.updateCellsList(self._stageView, self._stageCell, dataList, self._updateStageCell, self)
end

function BoccaccioChapterOneMainView:_onClearStageCol()
	GameUtil.clearCells(self._stageView, self._clearStageCell, self)
end

function BoccaccioChapterOneMainView:_updateStageCell(mainGo, data, tabIdx)
	local stageId = data.stageId
	local isPass = self._subMo:isPassStageC1(stageId)
	local isUnlock = self._subMo:isUnlockStageC1(stageId)
	local isSelect = self._subMo:getCurLatestStageIdC1() == stageId
	local tagPass = goutil.findChild(mainGo, "tagPass")
	local tagLock = goutil.findChild(mainGo, "tagLock")
	local tagSelect = goutil.findChild(mainGo, "tagSelect")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	if not data.pos then
		if not data.pos[3] then
			local x, y, scale = checknumber(data.pos[1]), checknumber(data.pos[2]), 1

			GameUtil.setLocalPos(mainGo, x, y)
			GameUtil.setLocalScale(mainGo, data.pos[3])
			GameUtil.setUIImageSpriteIdx(mainGo, tabIdx - 1)
			GameUtil.SetActive(tagPass, isPass)
			GameUtil.SetActive(tagLock, not isUnlock)
			GameUtil.SetActive(tagSelect, isSelect)

			txtName.text = data.name

			GameUtil.addClickHandler(mainGo, function()
				local result = GameEnum.ResultCode.Success
				local tips
				local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

				if not isInTime then
					result = GameEnum.ResultCode.Error
					tips = "不在活动时间范围内"
				elseif isPass then
					result = GameEnum.ResultCode.Error
					tips = isShowTips and "已通关"
				elseif not isUnlock then
					result = GameEnum.ResultCode.Error
					tips = "请先通关前置关卡"
				end

				FloatWordMgr.instance:show(tips)

				if result ~= GameEnum.ResultCode.Success then
					return
				end

				BoccaccioChapterController.instance:enterBattleC1(self._activityId, stageId)
			end)
		end
	end
end

function BoccaccioChapterOneMainView:_clearStageCell(mainGo)
	GameUtil.rmClickHandler(mainGo)
end

function BoccaccioChapterOneMainView:_onUpdateProgressCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = -1

	for idx, data in ipairs(dataList) do
		if not self:_isHasGainPrize(data) then
			index = idx

			break
		end
	end

	self._progressScrollerList:reloadData(dataList)
	self._progressScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._progressScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._txtProgress.text = curProgress
end

function BoccaccioChapterOneMainView:_onClearProgressCol()
	self._progressScrollerList:dispose()
end

function BoccaccioChapterOneMainView:_getProgressDataList()
	return BoccaccioChapterConfig.instance:getProgressPrizeDatas(self._activityId, self._chapterId) or {}
end

function BoccaccioChapterOneMainView:_getSliderComp()
	return self._sliderComp
end

function BoccaccioChapterOneMainView:_getScrollRect()
	return self._progressScrView:GetComponent(ComponentType.ScrollRect)
end

function BoccaccioChapterOneMainView:_getCurProgress()
	return self._subMo:getCurProgress(self._chapterId)
end

function BoccaccioChapterOneMainView:_getProgressByData(data)
	return checknumber(data.progress)
end

function BoccaccioChapterOneMainView:_getPrizeIdByData(data)
	return data.progressId
end

function BoccaccioChapterOneMainView:_getPrizeStrByData(data)
	return data.prize
end

function BoccaccioChapterOneMainView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isHasGainPrize(self._chapterId, prizeId)
end

function BoccaccioChapterOneMainView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isEnoughGetPrize(self._chapterId, prizeId)
end

function BoccaccioChapterOneMainView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isCanGetPrize(self._chapterId, prizeId)
end

function BoccaccioChapterOneMainView:_updateProgressCell(view, cell, data, tag)
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

function BoccaccioChapterOneMainView:_clearProgressCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function BoccaccioChapterOneMainView:_onClickPrizeGet(data)
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

function BoccaccioChapterOneMainView:_onClickBtnTip()
	BoccaccioChapterController.instance:openChapterRule(self._activityId, self._chapterId)
end

return BoccaccioChapterOneMainView
