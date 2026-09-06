-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/awakenoathancestor/view/AwakenOathAncestorMainView.lua

module("logic.extensions.awakenoathancestor.view.AwakenOathAncestorMainView", package.seeall)

local AwakenOathAncestorMainView = class("AwakenOathAncestorMainView", ViewComponent)

function AwakenOathAncestorMainView:buildUI()
	AwakenOathAncestorMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnCollect = self:getGo("btnCollect")
	self._redBtnCollect = self:getGo("btnCollect/red")
	self._con = self:getGo("con")
	self._tips = self:getGo("tips")
	self._prizeCol = self:getGo("prizeCol")
	self._prizeScrollerview = self:getGo("prizeCol/scrView")
	self._prizeScrollercell = self:getGo("prizeCol/scrCell")
	self._progressBar = self:getGo("prizeCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/scrView/Viewport/Content/progressBar")
	self._prizeCol_total_txtNum = self:getTxt("prizeCol/total/txtNum")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._pointView = self:getGo("pointCol/view")
	self._pointCell = self:getGo("pointCol/cell")

	GameUtil.SetActive(self._pointCell, false)
end

function AwakenOathAncestorMainView:bindEvents()
	AwakenOathAncestorMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnCollect, self._onClickBtnCollect, self)
end

function AwakenOathAncestorMainView:unbindEvents()
	AwakenOathAncestorMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnCollect)
end

function AwakenOathAncestorMainView:onEnter()
	AwakenOathAncestorMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = AwakenOathAncestorController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = AwakenOathAncestorController.instance:getSubMo(self._activityId)
	self._actData = AwakenOathAncestorConfig.instance:getActData(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_AwakenOathAncestorInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_AwakenOathAncestorUnlockPointRes, self._handlePM_AwakenOathAncestorUnlockPointRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_GainProgressPrizeRes, self._onUpdate, self)
	AwakenOathAncestorController.instance:sendPM_AwakenOathAncestorInfoReq(self._activityId)
	FuYaoStoryController.instance:tryPlayPlotOnce(FuYaoStoryEnum.Story_Plot_2)
end

function AwakenOathAncestorMainView:onExit()
	AwakenOathAncestorMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self:_onClear()
end

function AwakenOathAncestorMainView:_handlePM_AwakenOathAncestorUnlockPointRes(msg)
	local pointId = msg.maxUnlockPointId

	self._changeSetId = nil

	if msg:HasField("changeSetId") then
		self._changeSetId = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(self._changeSetId)
	end

	local mainGo = self._pointCellList[pointId]
	local effRoot = goutil.findChild(mainGo, "effRoot")

	local function finishHandle(handlerTarget, eff)
		local params = FuYaoStoryController.instance:getParamsInPlot(FuYaoStoryEnum.Story_Plot_3)

		if not string.nilorempty(params) then
			local pointIds = string.split(params, "#")

			for _, id in ipairs(pointIds) do
				if checknumber(id) == pointId then
					FuYaoStoryController.instance:tryPlayPlotOnce(FuYaoStoryEnum.Story_Plot_3)

					break
				end
			end
		end

		if self._subMo:isUnlockAllPoint() then
			self:_onUpdatePointCol()
			self:playViewEffect("20241220/zhongyanzhizhan/fx_ui_bianbai.prefab", self.mainGO, nil, false, 0, 0, function()
				FuYaoStoryController.instance:tryPlayPlotOnce(FuYaoStoryEnum.Story_Plot_4, function()
					self:_onUpdate()
					MaterialController.instance:showChangeSetInTemp(self._changeSetId)

					self._changeSetId = nil
				end)
			end, nil)
		else
			self:_onUpdate()
		end
	end

	self:playViewEffectUniGo("fx_ui_shijianzhilun/fx_ui_baokai_shijianzhilun.prefab", effRoot, nil, false, finishHandle, nil)
end

function AwakenOathAncestorMainView:_onUpdate()
	local isUnlockAllPoint = self._subMo:isUnlockAllPoint()

	if isUnlockAllPoint then
		local skinId = 12037
		local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

		if not modelCfg[3] then
			local x, y, scale = checknumber(modelCfg[1]), checknumber(modelCfg[2]), 1

			self._loader = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, modelCfg[3], nil, true, x, y)

			self:_onClearPointCol()
		end
	else
		self._role = RoleObjectPool.instance:removeRole(self._role)

		self:_onUpdatePointCol()
	end

	GameUtil.SetActive(self._tips, isUnlockAllPoint)
	self:_onUpdatePrizeCol()
end

function AwakenOathAncestorMainView:_onClear()
	self:_onClearPrizeCol()
	self:_onClearPointCol()
end

function AwakenOathAncestorMainView:_onUpdatePointCol()
	local cfg = AwakenOathAncestorConfig.instance:getPointCfg(self._activityId) or {}

	self._pointCellList = GameUtil.updateCellsList(self._pointView, self._pointCell, cfg, self._updatePointCell, self)
end

function AwakenOathAncestorMainView:_onClearPointCol()
	self._pointCellList = {}

	GameUtil.clearCells(self._pointView, self._clearPointCell, self)
end

function AwakenOathAncestorMainView:_updatePointCell(mainGo, data, index)
	local pointId = data.pointId
	local curNum = self._subMo:getBloodNum(pointId)
	local maxNum = self._subMo:getMaxBloodNum()
	local isUnlock = self._subMo:isUnlockPoint(pointId)
	local isEnough = self._subMo:isEnoughPoint(pointId)
	local isCan = self._subMo:isCanUnlockPoint(pointId)
	local progressGo = goutil.findChild(mainGo, "progress")
	local con = goutil.findChild(mainGo, "progress/con")
	local tagGain = goutil.findChild(mainGo, "tagGain")
	local imgCon = con:GetComponent(ComponentType.Image)
	local txtTips = goutil.findChildTextComponent(mainGo, "tips/txt")

	if not data.pos then
		if not data.pos[3] then
			local x, y, scale = checknumber(data.pos[1]), checknumber(data.pos[2]), 1

			GameUtil.setLocalPos(mainGo, x, y, 0)
			GameUtil.setLocalScale(mainGo, data.pos[3], data.pos[3], data.pos[3])

			txtTips.text = string.format("%s/<color=#9aff77>%s</color>", curNum, maxNum)

			GameUtil.SetActive(tagGain, isCan)
			GameUtil.SetActive(txtTips.gameObject, not isCan)

			local progress = 0

			if maxNum > 0 then
				progress = curNum / maxNum
			end

			imgCon.fillAmount = curNum / maxNum

			GameUtil.addClickHandler(progressGo, function()
				if self._subMo:isUnlockPoint(pointId) then
					FloatWordMgr.instance:show("已激活")

					return
				elseif not self._subMo:isEnoughPoint(pointId) then
					FloatWordMgr.instance:show("血液不足")

					return
				elseif not self._subMo:isUnlockLastPoint(pointId) then
					FloatWordMgr.instance:show("上一个法阵未激活")

					return
				end

				AwakenOathAncestorController.instance:sendPM_AwakenOathAncestorUnlockPointReq(self._activityId, pointId)
			end)
		end
	end
end

function AwakenOathAncestorMainView:_clearPointCell(mainGo)
	local progressGo = goutil.findChild(mainGo, "progress")

	GameUtil.rmClickHandler(progressGo)
end

function AwakenOathAncestorMainView:_onUpdatePrizeCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = 0

	for idx, data in ipairs(dataList) do
		if self:_isHasGainPrize(data) then
			index = idx

			break
		end
	end

	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._prizeCol_total_txtNum.text = curProgress
end

function AwakenOathAncestorMainView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
	MaterialMgr.clearIcon(self._prizeCol_total_icon)
end

function AwakenOathAncestorMainView:_getProgressDataList()
	return AwakenOathAncestorConfig.instance:getProgressPrizeCfg(self._activityId) or {}
end

function AwakenOathAncestorMainView:_getSliderComp()
	return self._sliderComp
end

function AwakenOathAncestorMainView:_getScrollClipGo()
	return self._prizeScrollerClipGo
end

function AwakenOathAncestorMainView:_getCurProgress()
	return self._subMo:getMaxUnlockPointId()
end

function AwakenOathAncestorMainView:_getProgressByData(data)
	return data.progress
end

function AwakenOathAncestorMainView:_getPrizeIdByData(data)
	return data.progressId
end

function AwakenOathAncestorMainView:_getPrizeStrByData(data)
	return data.prize
end

function AwakenOathAncestorMainView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isHasGainPrize(prizeId)
end

function AwakenOathAncestorMainView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isEnoughGetPrize(prizeId)
end

function AwakenOathAncestorMainView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isCanGetPrize(prizeId)
end

function AwakenOathAncestorMainView:_updatePrizeCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isHasGain = self:_isHasGainPrize(data)
	local isCanGet = self:_isCanGetPrize(data)
	local progress = self:_getProgressByData(data)
	local prizeStr = self:_getPrizeStrByData(data)
	local clipGo = self:_getScrollClipGo()
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
		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, clipGo, true, nil)
	else
		self:stopViewEffectUniGo(effectRoot)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
end

function AwakenOathAncestorMainView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function AwakenOathAncestorMainView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeId = self:_getPrizeIdByData(data)

	AwakenOathAncestorController.instance:sendPM_GainProgressPrizeReq(self._activityId, prizeId)
end

function AwakenOathAncestorMainView:_onClickBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function AwakenOathAncestorMainView:_onClickBtnCollect()
	UIStateManager.instance:push(ViewName.AwakenOathAncestorStageView, self._activityId)
end

return AwakenOathAncestorMainView
