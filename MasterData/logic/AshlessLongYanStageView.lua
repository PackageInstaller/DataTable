-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashlesslongyan/view/AshlessLongYanStageView.lua

module("logic.extensions.ashlesslongyan.view.AshlessLongYanStageView", package.seeall)

local AshlessLongYanStageView = class("AshlessLongYanStageView", ViewComponent)

function AshlessLongYanStageView:buildUI()
	AshlessLongYanStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._goldBarCon = self:getGo("goldBarCon/icon")
	self._txtGoldBarCon = self:getTxt("goldBarCon/txt")

	local phaseScrView = self:getGo("phaseCol/scrView")
	local phaseScrCell = self:getGo("phaseCol/scrCell")

	self._phaseScrollList = ScrollerList.create(phaseScrView, phaseScrCell, GameUtil.handler(self._updatePhaseCell, self), GameUtil.handler(self._clearPhaseCell, self))
	self._txtRule = self:getTxt("infoCol/txtRule/Viewport/Content")
	self._btnReset = self:getGo("infoCol/btnReset")

	local prizeScrView = self:getGo("infoCol/prizeCol/scrView")
	local prizeScrCell = self:getGo("infoCol/prizeCol/scrCell")

	self._prizeScrollList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._bagCol = self:getGo("bagCol")
	self._bagScrView = self:getGo("bagCol/scrView")
	self._bagScrCell = self:getGo("bagCol/scrCell")
	self._bagScrollList = ScrollerList.create(self._bagScrView, self._bagScrCell, GameUtil.handler(self._updateBagCell, self), GameUtil.handler(self._clearBagCell, self))
	self._emptyBag = self:getGo("bagCol/empty")
	self._txtEmptyBag = self:getTxt("bagCol/empty/txt")
	self._strEmptyBag = self._txtEmptyBag.text
	self._finishBonfire = self:getGo("finishBonfire")
	self._txtFinishBonfire = self:getTxt("finishBonfire/txt")
	self._btnBonfireTip = self:getGo("finishBonfire/txt/btnTip")
	self._effRootInFinishBonfire = self:getGo("finishBonfire/effRoot")
	self._flyPosFinishBonfire = self:getGo("finishBonfire/flyPos")
	self._woodView = self:getGo("woodView")
	self._woodCell = self:getGo("woodCell")
	self._bonfireCell = self:getGo("bonfireCell")
	self._woodBtns = self:getGo("woodBtns")
	self._btnClgWood = self:getGo("woodBtns/btnClg")
	self._btnSaveWood = self:getGo("woodBtns/btnSave")
	self._bonfireBtns = self:getGo("bonfireBtns")
	self._btnUseBonfire = self:getGo("bonfireBtns/btnUse")
	self._btnSaveBonfire = self:getGo("bonfireBtns/btnSave")

	GameUtil.SetActive(self._woodCell, false)
	GameUtil.SetActive(self._bonfireCell, false)
	GameUtil.SetActive(self._woodBtns, false)
	GameUtil.SetActive(self._bonfireBtns, false)

	self._customInputWoodBtns = UICustomInput.Get(self._woodBtns)
	self._customInputBonfireBtns = UICustomInput.Get(self._bonfireBtns)
	self._mainGoList = {}
	self._cellLists = {}
	self._cellPools = {}
	self._cellGos = {}
	self._updateCallBacks = {}
	self._clearCallBacks = {}
	self._btnsViews = {}

	for _, stageType in ipairs(LongYanEnum.StageTypes) do
		self._cellLists[stageType] = {}
		self._cellPools[stageType] = {}

		if stageType == LongYanEnum.StageType_Wood then
			self._cellGos[stageType] = self._woodCell
			self._updateCallBacks[stageType] = self._updateWoodCell
			self._clearCallBacks[stageType] = self._clearWoodCell
			self._btnsViews[stageType] = self._woodBtns
		elseif stageType == LongYanEnum.StageType_Bonfire then
			self._cellGos[stageType] = self._bonfireCell
			self._updateCallBacks[stageType] = self._updateBonfireCell
			self._clearCallBacks[stageType] = self._clearBonfireCell
			self._btnsViews[stageType] = self._bonfireBtns
		end
	end

	self._mutouEffs = {}
	self._sequenceFloats = {}
	self._sequenceFlys = {}
end

function AshlessLongYanStageView:bindEvents()
	AshlessLongYanStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnClgWood, self._onClickBtnClgWood, self)
	GameUtil.addClickHandler(self._btnSaveWood, self._onClickBtnSaveWood, self)
	GameUtil.addClickHandler(self._btnUseBonfire, self._onClickBtnUseBonfire, self)
	GameUtil.addClickHandler(self._btnSaveBonfire, self._onClickBtnSaveBonfire, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnBonfireTip, self._onClickBtnBonfireTip, self)
	GameUtil.addClickHandler(self._goldBarCon, self._onClickGoldBarCon, self)
	self._customInputWoodBtns:AddListener(self._onCustomInputCallback, self)
	self._customInputBonfireBtns:AddListener(self._onCustomInputCallback, self)
end

function AshlessLongYanStageView:unbindEvents()
	AshlessLongYanStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClgWood)
	GameUtil.rmClickHandler(self._btnSaveWood)
	GameUtil.rmClickHandler(self._btnUseBonfire)
	GameUtil.rmClickHandler(self._btnSaveBonfire)
	GameUtil.rmClickHandler(self._goldBarCon)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnBonfireTip)
	self._customInputWoodBtns:RemoveListener()
	self._customInputBonfireBtns:RemoveListener()
end

function AshlessLongYanStageView:onEnter()
	AshlessLongYanStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = AshlessLongYanController.instance:getActivityType()

	local isInTime = AshlessLongYanController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._longYanMo = AshlessLongYanController.instance:getLongYanMo(self._activityId)
	self._actData = AshlessLongYanConfig.instance:getActData(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_AshlessLongYanGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_AshlessLongYanResetPhaseRes, self._handlePM_AshlessLongYanResetPhaseRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_AshlessLongYanStashOrTakeRes, self._handlePM_AshlessLongYanStashOrTakeRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_AshlessLongYanUseWoodRes, self._handlePM_AshlessLongYanUseWoodRes, self)

	self._goldMatStr = AshlessLongYanConfig.instance:getGoldMat(self._activityId)

	local matType, matId, matNum = MaterialMgr.getMatParams(self._goldMatStr)

	self._goldMats = {
		matType = matType,
		matId = matId,
		matNum = matNum
	}

	MaterialMgr.setIcon(self._goldBarCon, matType, matId, nil, nil)
	AshlessLongYanController.instance:sendPM_AshlessLongYanGetInfoReq(self._activityId)
	self:_onUpdate()
end

function AshlessLongYanStageView:onExit()
	AshlessLongYanStageView.super.onExit(self)

	self._changeSetId = nil

	MaterialMgr.clearIcon(self._goldBarCon)
	self:_clearAllFloatWord()

	self._stashFires = nil

	self:_onClearPhaseCol()
	self:_onClearWoodCol()
	self:_onClearBagCol()
	self:_onClearInfoCol()
end

function AshlessLongYanStageView:destroyUI()
	AshlessLongYanStageView.super.destroyUI(self)
end

function AshlessLongYanStageView:_handlePM_AshlessLongYanResetPhaseRes()
	AshlessLongYanController.instance:sendPM_AshlessLongYanGetInfoReq(self._activityId)
end

function AshlessLongYanStageView:_handlePM_AshlessLongYanStashOrTakeRes()
	self:_onUpdateWoodColUI()
	self:_onUpdateBagColUI()
end

function AshlessLongYanStageView:_handlePM_AshlessLongYanUseWoodRes(msg)
	if msg:HasField("changeSetId") then
		self._changeSetId = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(self._changeSetId)
	end

	self._stashFires = self._stashFires or {}
	self._stashFires[msg.phaseId] = self._stashFires[msg.phaseId] or {}
	self._stashFires[msg.phaseId][msg.stageId] = msg.useCount

	self:_onUpdateWoodColUI()
	self:_onUpdatePlaneUI()
end

function AshlessLongYanStageView:_onUpdate()
	self._curPhaseId = self._longYanMo:getCurPhaseId()

	self:_onUpdateBagColData()
	self:_onUpdatePlaneUI()
	self:_onUpdatePhaseColUI()
	self:_onUpdateWoodColUI()
	self:_onUpdateBagColUI()
	self:_onUpdateInfoColUI()

	local changeSetId = self._longYanMo:popChangeSetId()

	if changeSetId then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

function AshlessLongYanStageView:_onUpdatePlaneUI()
	local fireCount = self._longYanMo:getPassStageCount(self._curPhaseId, LongYanEnum.StageType_Bonfire)

	self._txtFinishBonfire.text = fireCount

	local buffData = AshlessLongYanConfig.instance:getBuffData(self._activityId, self._curPhaseId, fireCount)

	if buffData then
		if not buffData.effPath then
			local effPath

			if not string.nilorempty(effPath) then
				self:playViewEffectUniGo(effPath .. ".prefab", self._effRootInFinishBonfire, self.mainGO, true)
			else
				self:stopViewEffectUniGo(self._effRootInFinishBonfire)
			end

			self._txtEmptyBag.text = string.format(self._strEmptyBag, self._maxStashCount)

			local cur = MaterialModel.instance:getMaterialsNumber(self._goldMats.matType, self._goldMats.matId)
			local max = self._longYanMo:getMaxNeedUseScoreInPhaseId(self._curPhaseId)

			self._txtGoldBarCon.text = cur > 0 and string.format("<color=#20b376>%s</color>/%s", cur, max) or string.format("%s/%s", cur, max)
		end
	end
end

function AshlessLongYanStageView:_onUpdatePhaseColUI()
	local cfg = AshlessLongYanConfig.instance:getPhaseCfg(self._activityId) or {}

	self._phaseScrollList:reloadData(cfg)
end

function AshlessLongYanStageView:_onClearPhaseCol()
	self._phaseScrollList:dispose()
end

function AshlessLongYanStageView:_updatePhaseCell(view, cell, data, tag)
	local phaseId = data.phaseId
	local isPass = self._longYanMo:isPassPhaseId(phaseId)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local imgPass = goutil.findChild(mainGo, "imgPass")
	local lock = goutil.findChild(mainGo, "lock")

	GameUtil.SetActive(imgPass, isPass)
	GameUtil.SetActive(lock, phaseId > self._curPhaseId)

	txtName.text = string.format("第%s关", phaseId)

	GameUtil.addClickHandler(mainGo, function()
		if isPass then
			FloatWordMgr.instance:show("已通关")

			return
		end

		if self._curPhaseId < phaseId then
			FloatWordMgr.instance:show("请完成上一层的事件再试哦~")

			return
		end
	end)
end

function AshlessLongYanStageView:_clearPhaseCell(cell)
	return
end

function AshlessLongYanStageView:_onUpdateWoodColUI()
	local phaseId = self._curPhaseId
	local stageDataList = AshlessLongYanConfig.instance:getStageDataList(self._activityId, phaseId) or {}

	table.clear(self._mainGoList)

	for _, stageType in ipairs(LongYanEnum.StageTypes) do
		local cellList = self._cellLists[stageType]

		for index = 1, #cellList do
			local cell = table.remove(cellList, #cellList)

			table.insert(self._cellPools[stageType], cell)
		end
	end

	for stageId, data in ipairs(stageDataList) do
		local stageType = data.type
		local mainGo = table.remove(self._cellPools[stageType], #self._cellPools[stageType])

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(self._cellGos[stageType], self._woodView.transform, self._cellGos[stageType].name)
		end

		mainGo.name = string.format(string.format("%s_%s_%s_%s", self._cellGos[stageType].name, stageId, data.group, data.layerId))

		table.insert(self._cellLists[stageType], mainGo)

		self._mainGoList[stageId] = mainGo

		self:_updateStageCell(self._activityId, phaseId, stageId)
	end

	for stageType, pool in ipairs(self._cellPools) do
		for _, mainGo in ipairs(pool) do
			GameUtil.SetActive(mainGo, false)
		end
	end
end

function AshlessLongYanStageView:_onClearWoodCol()
	table.clear(self._mainGoList)

	for stageType, cellList in pairs(self._cellLists) do
		for index = 1, #cellList do
			local cell = table.remove(cellList, #cellList)

			table.insert(self._cellPools[stageType], cell)
		end
	end

	for stageType, pool in pairs(self._cellPools) do
		for _, mainGo in pairs(pool) do
			GameUtil.callBack(self._clearCallBacks[stageType], self, mainGo)
		end
	end
end

function AshlessLongYanStageView:_updateStageCell(activityId, phaseId, stageId)
	local data = AshlessLongYanConfig.instance:getStageData(activityId, phaseId, stageId)
	local stageType = data.type
	local mainGo = self._mainGoList[stageId]

	if not data.pos then
		local pos = {}
		local x, y = checknumber(pos[1]), checknumber(pos[2])

		GameUtil.setLocalPos(mainGo, x, y)

		local siblingIndex = 0

		for group = 1, data.group - 1 do
			local layerCount = AshlessLongYanConfig.instance:getStageLayersCount(self._activityId, phaseId, group)

			siblingIndex = siblingIndex + layerCount
		end

		siblingIndex = siblingIndex + data.layerId - 1

		mainGo.transform:SetSiblingIndex(siblingIndex)
		GameUtil.callBack(self._updateCallBacks[stageType], self, mainGo, self._activityId, phaseId, data.stageId)
	end
end

function AshlessLongYanStageView:_updateWoodCell(mainGo, activityId, phaseId, stageId)
	local data = AshlessLongYanConfig.instance:getStageData(activityId, phaseId, stageId)
	local isPass = self._longYanMo:isPassStage(phaseId, stageId)
	local isInTopLayer = self._longYanMo:isInTopLayer(phaseId, data.group, data.layerId)
	local isContainInBag = self:_isContainInBag(stageId)
	local img = goutil.findChild(mainGo, "img")

	GameUtil.SetActive(mainGo, not isPass and not isContainInBag)
	GameUtil.SetGray(img, not isInTopLayer)
	GameUtil.addClickHandler(mainGo, function()
		self:_showOpView(mainGo, activityId, phaseId, stageId)
	end)
end

function AshlessLongYanStageView:_clearWoodCell(mainGo)
	GameUtil.rmClickHandler(mainGo)
end

function AshlessLongYanStageView:_updateBonfireCell(mainGo, activityId, phaseId, stageId)
	local data = AshlessLongYanConfig.instance:getStageData(activityId, phaseId, stageId)
	local isPass = self._longYanMo:isPassStage(phaseId, stageId)
	local isInTopLayer = self._longYanMo:isInTopLayer(phaseId, data.group, data.layerId)
	local isContainInBag = self:_isContainInBag(stageId)
	local maxCount = self._longYanMo:getMaxBonfireCount(phaseId, stageId)
	local curCount = self._longYanMo:getBonfireCount(phaseId, stageId)
	local leftCount = Mathf.Max(maxCount - curCount, 0)
	local img = goutil.findChild(mainGo, "img")
	local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")
	local icon = goutil.findChild(mainGo, "txtCount/icon")
	local effRoot = goutil.findChild(mainGo, "effRoot")
	local addGo = goutil.findChild(mainGo, "floatRoot/addGo")
	local txtAddGo = goutil.findChildTextComponent(mainGo, "floatRoot/addGo/txt")

	txtCount.text = leftCount

	GameUtil.SetActive(addGo, false)
	GameUtil.SetActive(mainGo, not isPass and not isContainInBag)
	GameUtil.SetGray(img, not isInTopLayer)
	MaterialMgr.setIcon(icon, self._goldMats.matType, self._goldMats.matId, nil, nil)
	GameUtil.addClickHandler(mainGo, function()
		self:_showOpView(mainGo, activityId, phaseId, stageId)
	end)
	self:_clearBonfireMutouEff(effRoot)
	self:_clearFloatWord(addGo)
	self:_clearFlyToBonfireAnim(mainGo)

	if self._stashFires and self._stashFires[phaseId] then
		if not self._stashFires[phaseId][stageId] then
			local useCount = 0

			if useCount > 0 then
				self._stashFires[phaseId][stageId] = nil

				if leftCount > 0 then
					self:_playBonfireMutouEff(effRoot)
					self:_playFloatWord(addGo, txtAddGo, useCount)
				else
					self:_playFlyToBonfireAnim(mainGo)
				end
			end
		end
	end
end

function AshlessLongYanStageView:_clearBonfireCell(mainGo)
	local effRoot = goutil.findChild(mainGo, "effRoot")
	local addGo = goutil.findChild(mainGo, "floatRoot/addGo")
	local icon = goutil.findChild(mainGo, "txtCount/icon")

	GameUtil.rmClickHandler(mainGo)
	GameUtil.SetGray(mainGo, false)
	MaterialMgr.clearIcon(icon)
	self:_clearBonfireMutouEff(effRoot)
	self:_clearFloatWord(addGo)
end

function AshlessLongYanStageView:_showOpView(mainGo, activityId, phaseId, stageId)
	local result = self:_getTryOpStageCellResultAndTips(true, activityId, phaseId, stageId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	self._opParams = {
		activityId = activityId,
		phaseId = phaseId,
		stageId = stageId
	}

	local stageType = AshlessLongYanConfig.instance:getStageType(activityId, phaseId, stageId)
	local go = self._btnsViews[stageType]

	GameUtil.setPos(go, Framework.TransformUtil.GetPos(mainGo.transform, 0, 0, 0))
	GameUtil.SetActive(go, true)
	GameUtil.SetGray(self._btnSaveWood, self:_isContainInBag(stageId) or self:_isFullStash())
	GameUtil.SetGray(self._btnSaveBonfire, self:_isContainInBag(stageId) or self:_isFullStash())
	GameUtil.SetGray(self._btnClgWood, self:_getTryClgWoodResultAndTips(false, activityId, phaseId, stageId) ~= GameEnum.ResultCode.Success)
	GameUtil.SetGray(self._btnUseBonfire, self:_getTryUseBonfireResultAndTips(false, activityId, phaseId, stageId) ~= GameEnum.ResultCode.Success)
end

function AshlessLongYanStageView:_closeOpView()
	for _, go in pairs(self._btnsViews) do
		GameUtil.SetActive(go, false)
	end

	self._opParams = nil
end

function AshlessLongYanStageView:_playBonfireMutouEff(effParent)
	local effPath = "20241220/wujinlongyantiaozhan/fx_ui_mutou.prefab"

	self:_clearBonfireMutouEff(effParent)

	local eff = self:playViewEffectUniGo(effPath, effParent, self.mainGO, false)

	eff.hideEffWhileNotOnTop = false
end

function AshlessLongYanStageView:_clearBonfireMutouEff(effParent)
	self:stopViewEffectUniGo(effParent)
end

function AshlessLongYanStageView:_playFloatWord(mainGo, txt, count)
	txt.text = string.format("-%s", count)

	self:_clearFloatWord(mainGo)

	local sequence = DG.Tweening.DOTween.Sequence()

	self._sequenceFloats[mainGo] = sequence

	GameUtil.setLocalPos(mainGo, 0, 0, 0)
	GameUtil.SetActive(mainGo, true)

	local toPos = GameUtil.getLocalPos(mainGo)

	toPos.y = toPos.y + 34

	local tweenerMove = mainGo.transform:DOLocalMove(toPos, 0.2)

	tweenerMove:SetEase(DG.Tweening.Ease.Linear)
	sequence:Join(tweenerMove)
	sequence:AppendInterval(0.5)
	sequence:OnComplete(function()
		GameUtil.SetActive(mainGo, false)
		self:_clearFloatWord(mainGo)
	end)
end

function AshlessLongYanStageView:_clearFloatWord(mainGo)
	if self._sequenceFloats[mainGo] then
		self._sequenceFloats[mainGo]:Kill(true)

		self._sequenceFloats[mainGo] = nil
	end
end

function AshlessLongYanStageView:_clearAllFloatWord()
	for k, v in pairs(self._sequenceFloats) do
		self:_clearFloatWord(k)
	end
end

function AshlessLongYanStageView:_playFlyToBonfireAnim(mainGo)
	self:_clearFlyToBonfireAnim(mainGo)

	local sequence = DG.Tweening.DOTween.Sequence()

	self._sequenceFlys[mainGo] = sequence

	local canvasGroup = mainGo:GetComponent(ComponentType.CanvasGroup)

	GameUtil.SetActive(mainGo, true)

	canvasGroup.alpha = 1

	local formPos = GameUtil.getPos(mainGo)
	local toPos = GameUtil.getPos(self._flyPosFinishBonfire)
	local distance = Vector2.Distance(formPos, toPos)
	local deltaTime = distance / 1.3
	local tweenerMove = mainGo.transform:DOMove(toPos, deltaTime)

	tweenerMove:SetEase(DG.Tweening.Ease.Linear)

	local tweenerFade = canvasGroup:DOFade(0.2, deltaTime)

	tweenerFade:SetEase(DG.Tweening.Ease.Linear)
	sequence:Join(tweenerMove)
	sequence:Join(tweenerFade)
	sequence:OnComplete(function()
		GameUtil.SetActive(mainGo, false)

		canvasGroup.alpha = 1

		self:_clearFlyToBonfireAnim(mainGo)
		self:_playBonfireDianRanEff()
	end)
end

function AshlessLongYanStageView:_clearFlyToBonfireAnim(mainGo)
	if self._sequenceFlys[mainGo] then
		self._sequenceFlys[mainGo]:Kill(true)

		self._sequenceFlys[mainGo] = nil
	end
end

function AshlessLongYanStageView:_clearAllFlyToBonfireAnim()
	for k, v in pairs(self._sequenceFlys) do
		self:_clearFlyToBonfireAnim(k)
	end
end

function AshlessLongYanStageView:_playBonfireDianRanEff()
	local effPath = "20241220/wujinlongyantiaozhan/fx_ui_dianran.prefab"

	self:stopViewEffectUniGo(self._flyPosFinishBonfire)

	local eff = self:playViewEffectUniGo(effPath, self._flyPosFinishBonfire, self.mainGO, false, function(handlerTarget, eff)
		self:_tryPopPassWin()
	end)
end

function AshlessLongYanStageView:_tryPopPassWin()
	if self._changeSetId == nil then
		return
	end

	self._changeSetId = nil

	local tipsContent = "通关本层"

	local function okFunc()
		MaterialController.instance:showChangeSetInTemp(self._changeSetId)

		if self._curPhaseId >= self._longYanMo:getMaxPhaseId() then
			self:close()
		else
			AshlessLongYanController.instance:sendPM_AshlessLongYanGetInfoReq(self._activityId)
		end
	end

	local alignment = UnityEngine.TextAnchor.MiddleCenter

	TipsFacade.instance:openTipWindowNoX("恭喜您", tipsContent, okFunc, "确定", alignment)
end

function AshlessLongYanStageView:_onClickBtnClgWood()
	local activityId = self._opParams.activityId
	local phaseId = self._opParams.phaseId
	local stageId = self._opParams.stageId
	local result = self:_getTryClgWoodResultAndTips(true, activityId, phaseId, stageId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	AshlessLongYanController.instance:enterBattle(activityId, phaseId, stageId)
	self:_closeOpView()
end

function AshlessLongYanStageView:_onClickBtnSaveWood()
	local stageId = self._opParams.stageId

	self:_statshStageId(stageId)
	self:_closeOpView()
end

function AshlessLongYanStageView:_onClickBtnUseBonfire()
	local activityId = self._opParams.activityId
	local phaseId = self._opParams.phaseId
	local stageId = self._opParams.stageId
	local result = self:_getTryUseBonfireResultAndTips(true, activityId, phaseId, stageId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local matType, matId = self._goldMats.matType, self._goldMats.matId
	local matName = MaterialMgr.getMaterialsNameByCfg(self._goldMatStr)
	local maxNum = self._longYanMo:getLeftBonfireCount(phaseId, stageId)
	local totalScore = self._longYanMo:getTotalScore()

	maxNum = Mathf.Min(maxNum, totalScore)

	TipsFacade.instance:openPopupCostAdjustView(matType, matId, 1, langPara("是否投入%s？", matName), function(num)
		result = self:_getTryUseBonfireResultAndTips(true, activityId, phaseId, stageId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		AshlessLongYanController.instance:sendPM_AshlessLongYanUseWoodReq(activityId, phaseId, stageId, num)
		self:_closeOpView()
	end, maxNum)
end

function AshlessLongYanStageView:_onClickBtnSaveBonfire()
	local stageId = self._opParams.stageId

	self:_statshStageId(stageId)
	self:_closeOpView()
end

function AshlessLongYanStageView:_onCustomInputCallback(hover)
	if not hover then
		self:_closeOpView()
	end
end

function AshlessLongYanStageView:_onUpdateBagColData()
	self._maxStashCount = AshlessLongYanConfig.instance:getStashCount(self._activityId, self._curPhaseId)

	local stashStageIds = self._longYanMo:getStashStageIds(self._curPhaseId)

	self._bagStageIdList = {}

	for index = 1, self._maxStashCount do
		table.insert(self._bagStageIdList, checknumber(stashStageIds[index]))
	end
end

function AshlessLongYanStageView:_onUpdateBagColUI()
	GameUtil.SetActive(self._bagCol, self._maxStashCount > 0)
	self._bagScrollList:reloadData(self._bagStageIdList)
	GameUtil.SetActive(self._emptyBag, self:_getStatshCount() <= 0)
	GameUtil.SetActive(self._bagScrView, not GameUtil.GetActive(self._emptyBag))
end

function AshlessLongYanStageView:_onClearBagCol()
	self._bagScrollList:dispose()
end

function AshlessLongYanStageView:_updateBagCell(view, cell, stageId, tag)
	local data = AshlessLongYanConfig.instance:getStageData(self._activityId, self._curPhaseId, stageId)
	local isEmpty = data == nil
	local index = cell.index + 1
	local mainGo = cell.gameObject
	local woodTag = goutil.findChild(mainGo, "woodTag")
	local bonfireTag = goutil.findChild(mainGo, "bonfireTag")

	GameUtil.SetActive(woodTag, false)
	GameUtil.SetActive(bonfireTag, false)

	if not isEmpty then
		local stageType = data.type

		if stageType == LongYanEnum.StageType_Wood then
			GameUtil.SetActive(woodTag, true)
		elseif stageType == LongYanEnum.StageType_Bonfire then
			GameUtil.SetActive(bonfireTag, true)
		end
	end

	GameUtil.addClickHandler(mainGo, function()
		local isInTop = index == self:_getStatshCount()

		if isInTop then
			self:_popStageId()
		else
			FloatWordMgr.instance:show("物品需要从右往左依次放回")
		end
	end)
end

function AshlessLongYanStageView:_clearBagCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function AshlessLongYanStageView:_statshStageId(stageId)
	if self:_isContainInBag(stageId) then
		return
	end

	if not self:_isFullStash() then
		local curCount = self:_getStatshCount()

		self._bagStageIdList[curCount + 1] = stageId

		AshlessLongYanController.instance:sendPM_AshlessLongYanStashOrTakeReq(self._activityId, self._curPhaseId, stageId, true)
	else
		FloatWordMgr.instance:show("火炉已满不可再放入")
	end
end

function AshlessLongYanStageView:_popStageId()
	local curCount = self:_getStatshCount()

	if curCount > 0 then
		local stageId = self._bagStageIdList[curCount]

		self._bagStageIdList[curCount] = 0

		AshlessLongYanController.instance:sendPM_AshlessLongYanStashOrTakeReq(self._activityId, self._curPhaseId, stageId, false)
	end
end

function AshlessLongYanStageView:_isFullStash()
	return self:_getStatshCount() >= self._maxStashCount
end

function AshlessLongYanStageView:_getStatshCount()
	local count = 0

	for _, stageId in ipairs(self._bagStageIdList) do
		if stageId > 0 then
			count = count + 1
		end
	end

	return count
end

function AshlessLongYanStageView:_isContainInBag(stageId)
	for i, v in ipairs(self._bagStageIdList) do
		if v == stageId then
			return true
		end
	end

	return false
end

function AshlessLongYanStageView:_onUpdateInfoColUI()
	local phaseData = AshlessLongYanConfig.instance:getPhaseData(self._activityId, self._curPhaseId)
	local arr

	self._prizeScrollList:reloadData((not string.nilorempty(phaseData.prize) or nil) and string.split(phaseData.prize, "#") or {})

	self._txtRule.text = phaseData.des
end

function AshlessLongYanStageView:_onClearInfoCol()
	self._prizeScrollList:dispose()
end

function AshlessLongYanStageView:_updatePrizeCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function AshlessLongYanStageView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function AshlessLongYanStageView:_getTryOpStageCellResultAndTips(isNeedTips, activityId, phaseId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	result = AshlessLongYanController.instance:getTryStartClgResultAndTips(isNeedTips, activityId)

	if result == GameEnum.ResultCode.Success then
		local mo = self._longYanMo
		local data = AshlessLongYanConfig.instance:getStageData(activityId, phaseId, stageId)

		if mo:isPassStage(phaseId, stageId) then
			result = GameEnum.ResultCode.Error
			tips = "已通关"
		elseif not mo:isInTopLayer(phaseId, data.group, data.layerId) then
			result = GameEnum.ResultCode.Error
			tips = "请完成上一层的事件再试哦~"
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result, tips
end

function AshlessLongYanStageView:_getTryClgWoodResultAndTips(isNeedTips, activityId, phaseId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	result = self:_getTryOpStageCellResultAndTips(true, activityId, phaseId, stageId)

	if result == GameEnum.ResultCode.Success and self:_isContainInBag(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "无法对火炉中的木材进行操作"
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function AshlessLongYanStageView:_getTryUseBonfireResultAndTips(isNeedTips, activityId, phaseId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	result = self:_getTryOpStageCellResultAndTips(true, activityId, phaseId, stageId)

	if result == GameEnum.ResultCode.Success then
		local totalScore = self._longYanMo:getTotalScore()

		if totalScore <= 0 then
			local matName = MaterialMgr.getMaterialsNameByCfg(self._goldMatStr)

			result = GameEnum.ResultCode.Error
			tips = string.format("%s不足", matName)
		elseif self:_isContainInBag(stageId) then
			result = GameEnum.ResultCode.Error
			tips = "无法对火炉中的火堆进行操作"
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function AshlessLongYanStageView:_getTryResetResultAndTips(isNeedTips, activityId, phaseId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	result = AshlessLongYanController.instance:getTryStartClgResultAndTips(true, activityId)

	if result == GameEnum.ResultCode.Success then
		local mo = self._longYanMo

		if mo:isPassPhaseId(phaseId) then
			result = GameEnum.ResultCode.Error
			tips = "已通关"
		else
			local isHave = false

			for _, stageType in ipairs(LongYanEnum.StageTypes) do
				local count = self._longYanMo:getPassStageCount(phaseId, stageType)

				if count > 0 then
					isHave = true

					break
				end
			end

			if not isHave then
				result = GameEnum.ResultCode.Error
				tips = "无需重置"
			end
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function AshlessLongYanStageView:_onClickBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function AshlessLongYanStageView:_onClickBtnReset()
	local activityId = self._activityId
	local phaseId = self._curPhaseId
	local result = self:_getTryResetResultAndTips(true, activityId, phaseId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local tipsContent = "是否确认重置当前所有关卡？"

	local function okFunc()
		local result = self:_getTryResetResultAndTips(true, activityId, phaseId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		AshlessLongYanController.instance:sendPM_AshlessLongYanResetPhaseReq(activityId, phaseId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

function AshlessLongYanStageView:_onClickBtnBonfireTip()
	UIStateManager.instance:push(ViewName.AshlessLongYanBonfireTipsView, self._activityId, self._curPhaseId)
end

function AshlessLongYanStageView:_onClickGoldBarCon()
	local matNum = MaterialModel.instance:getMaterialsNumber(self._goldMats.matType, self._goldMats.matId)

	CommonTipsMgr.instance:openMaterialTips(self._goldBarCon, self._goldMats.matType, self._goldMats.matId, matNum)
end

return AshlessLongYanStageView
