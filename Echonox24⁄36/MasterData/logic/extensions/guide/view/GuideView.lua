-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideView.lua

module("logic.extensions.guide.view.GuideView", package.seeall)

local GuideView = class("GuideView", ViewComponent)
local kChangeDuration = 0.5
local kVector3Scale = Vector3.New(2, 2, 1)
local kVector3TagetScale = Vector3.New(1, 1, 1)
local rotationList = {
	315,
	45,
	135,
	225
}
local dialogContentDefaultX = 410
local kguideInterval = 0.2
local foundUITimes = 25
local waitUIAnimTimes = 12
local GUIDE_VIEW_OPEN = "guide_open"
local GUIDE_VIEW_END = "guide_end"
local GUIDE_VIEW_HOLD = "guide_hold"
local rect_open_anim = "RectFocus_open"
local circle_open_anim = "CircleFocus_open"
local focuse_anim = "focusRoot"
local dialog_open = "dialogRoot_open"
local circle_focus = "circle_focus"
local rect_focus = "rect_focus"
local guide_open = "guideopen"
local guide_loop = "guideloop"
local guide_reset = "guidereset"
local showDialogMap = false
local mainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()
local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

function GuideView:buildUI()
	self._guidePanelCanvasGroup = self.mainGO:GetComponent(ComponentType.CanvasGroup)
	self._guideContent = self:getGo("guideview_1569937816")
	self._guideMaskColor = self:getImage("guideview_1569937816")
	self._guideMask = GuideMask.Get(self._guideContent)

	self._guideMask:SetUICamera(uiCamera)

	self._passEvent = PassEvent.Get(self._guideContent)
	self._dialogRoot = {
		self:getGo("guideview_1448151918"),
		self:getGo("guideview_-1094250986"),
		self:getGo("guideview_548351298"),
		self:getGo("guideview_828023177"),
		self:getGo("guideview_607440311")
	}
	self._dialogPanel = self:getGo("guideview_1960384741")
	self._dialogPanelCanvasGroup = self._dialogPanel:GetComponent(ComponentType.CanvasGroup)
	self._dialogContentHide = self:getUIComponent("guideview_-165600755", typeof(TMPro.TextMeshProUGUI))
	self._dialogContentBg = self:getUIComponent("guideview_1960384741", UIComponentType.RectTransform)
	self._dialogContent = self:getUIComponent("guideview_-1811459713", typeof(TMPro.TextMeshProUGUI))
	self._dialogHeadIcon = self:getImage("guideview_351718462")

	goutil.setActive(self._dialogPanel, true)

	self._dialogPanelCanvasGroup.alpha = 0
	self._simpleDialogPanel = self:getGo("guideview_1700786178")
	self._simpleDialogContent = self:getUIComponent("guideview_1937733104", typeof(TMPro.TextMeshProUGUI))
	self._simpleDialogContentHide = self:getUIComponent("guideview_-1124475315", typeof(TMPro.TextMeshProUGUI))
	self._simpleDialogContentBg = goutil.findChildComponent(self._simpleDialogPanel, "Bg", UIComponentType.RectTransform)
	self._simpleDialogPanelCanvasGroup = self._simpleDialogPanel:GetComponent(ComponentType.CanvasGroup)
	self._simpleDialogPanelCanvasGroup.alpha = 0

	goutil.setActive(self._simpleDialogPanel, true)

	self._typeWriter = TextTypeWriter.Get(self._dialogContent.gameObject)
	self._fingerImg = self:getGo("guideview_-51899225")
	self._fingerAnimation = self._fingerImg:GetComponent(ComponentType.Animation)
	self._focusGO = self:getGo("guideview_-1151364553")
	self._rectFocusGo = self:getGo("guideview_-539411689")

	self:_hideFocusAnim()

	self._fullScreenMask = self:getGo("guideview_320621804")

	self:_setFullMask(false)

	self._arrowImage = self:getImage("guideview_-1777440321")
	self._arrowAimaImg = self:getImage("guideview_526272536")

	goutil.setActive(self._arrowImage.gameObject, false)

	self._slideArrow = self:getGo("guideview_-79049519")

	goutil.setActive(self._slideArrow, false)

	self._circleFocus = self:getGo("guideview_1132895176")
	self._rectFocuse = self:getGo("guideview_-395998384")

	goutil.setActive(self._circleFocus.gameObject, false)
	goutil.setActive(self._rectFocuse, false)

	self._circleFingerNode = {
		self:getGo("guideview_-1738238194"),
		self:getGo("guideview_-1381689407"),
		self:getGo("guideview_934977295"),
		self:getGo("guideview_1958224524")
	}
	self._rectFingerNode = {
		self:getGo("guideview_2068574709"),
		self:getGo("guideview_777442727"),
		self:getGo("guideview_1805511305"),
		self:getGo("guideview_-688874854")
	}
	self._guideComponentPos = nil
	self._guideComponentScale = nil
	self._guideViewAnim = self.mainGO:GetComponent(typeof(Astral.GUITimelineAniLua))
	self._btnSkip = self:getBtn("guideview_-715623052")

	self:_updateSkipBtn(false)
end

function GuideView:bindEvents()
	self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	self._guideMask:AddListener(self._onClickHollowArea, self)
	GlobalDispatcher:addEventListener(EventType.TRIGGER_GUIDE, self._onTriggerGuide, self)
	BattleDispatcher:addEventListener(BattleEventType.OnOperateNextUnit, self._onTriggerRound, self)
	GlobalDispatcher:addEventListener(EventType.FINISH_GUIDE_STEP, self._onFinishStep, self)
	GlobalDispatcher:addEventListener(EventType.GET_GUIDE_TEXT, self._getText, self)
	GlobalDispatcher:addEventListener(EventType.PAUSE_GUIDE_EVENT, self._setGuideEventState, self)
	self._btnSkip:AddClickListener(self._onClickSkip, self)
	GlobalDispatcher:addEventListener(EventType.SHOW_SKIP_GUIDE_INFO, self._setGuideSkip, self)
end

function GuideView:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.SHOW_SKIP_GUIDE_INFO, self._setGuideSkip, self)
	self._btnSkip:RemoveClickListener()
	self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	self._guideMask:RemoveListener()
	GlobalDispatcher:removeEventListener(EventType.TRIGGER_GUIDE, self._onTriggerGuide, self)
	BattleDispatcher:removeEventListener(BattleEventType.OnOperateNextUnit, self._onTriggerRound, self)
	GlobalDispatcher:removeEventListener(EventType.FINISH_GUIDE_STEP, self._onFinishStep, self)
	GlobalDispatcher:removeEventListener(EventType.GET_GUIDE_TEXT, self._getText, self)
	GlobalDispatcher:removeEventListener(EventType.PAUSE_GUIDE_EVENT, self._setGuideEventState, self)
end

function GuideView:destroyUI()
	self._guideContent = nil
	self._guideMask = nil

	table.clear(self._dialogRoot)

	self._dialogRoot = nil
	self._dialogPanel = nil
	self._dialogPanelCanvasGroup = nil
	self._dialogPanelAnimation = nil
	self._dialogContent = nil
	self._dialogHeadIcon = nil
	self._focusGO = nil
	self._focusAnimation = nil
	self._fingerImg = nil
	self._fingerAnimation = nil

	table.clear(self._circleFingerNode)
	table.clear(self._rectFingerNode)

	self._guideComponentPos = nil
	self._guideComponentScale = nil
	self._guiddeUIComAnchoredPos = nil
	self._typeWriter = nil
end

function GuideView:onEnter()
	local openParamArr = self:getOpenParam()

	self._guideComponentPos = nil
	self._guideComponentScale = nil
	self._guiddeUIComAnchoredPos = nil

	if openParamArr then
		local params = openParamArr[1]

		self:_showGuide(params)
	end
end

function GuideView:onEnterFinished()
	self._guidePanelCanvasGroup.alpha = 1
end

function GuideView:onExit()
	GuideController.instance:updateJumpGuideInfo(false)
	self:_updateSkipBtn(false)
	self:_setGuideEventState(nil, false)
	self:_setGuideMaskAlpha(0)
	self:_setDefaultState()

	self._tickTimes = 0

	self:_hideFocusAnim()
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Guide)
	self._guideMask:ResetDragThreshold()
	self:_setFullMask(false)

	self._canTriggerRound = false

	removetimer(self._showStep, self)
	removetimer(self._delayShowGuide, self)
	self._arrowAimaImg.transform:DOKill(false)

	if self._delayTween then
		self._delayTween:Kill(false)

		self._delayTween = nil
	end
end

function GuideView:_getText(evt, text, id)
	if id == GameEnum.DescriptionEnum.NewbieGuideStep and self._stepCO then
		self._stepCO.tipsContent = text
	end
end

function GuideView:_onTriggerGuide(name, params)
	self:_showGuide(params)
end

function GuideView:_onTriggerRound()
	settimer(1, self._delayShowGuide, self)
end

function GuideView:_delayShowGuide()
	self:_setFullMask(false)
	GuideController.instance:setEnterDungeonGuide(false)
	removetimer(self._delayShowGuide, self)
end

function GuideView:_showGuide(params)
	self._canTriggerRound = false
	self._isPlayOpenAnim = false

	goutil.setActive(self._arrowImage.gameObject, false)
	goutil.setActive(self._slideArrow, false)

	if params.stepCO.guideControlType == GuideEnum.GuideControlType.MoveCamera then
		self:_setGuideMaskAlpha(params.stepCO.maskLevel)
		self:_setFullMask(true)

		return
	end

	local guideControlType = params.stepCO.guideControlType
	local dragThresholdState = guideControlType == GuideEnum.GuideControlType.ReadyBeforeBattle or guideControlType == GuideEnum.GuideControlType.ShowFullScreenImageGuide

	self._guideMask:SetDragThreshold(not dragThresholdState)
	self:_setDefaultState()
	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Guide)

	self._stepCO = params.stepCO
	self._guideId = params.stepCO.guideId
	self._clickCallback = params.callback
	self._clickCallbackSelf = params.callbackSelf
	self._guideButtonCallback = params.btnCallBack or false
	self._tickTimes = 0
	self._isDungeon = GuideController.instance:getEnterDungeonGuide()
	self._isGameStart = GuideController.instance:isGMStartGuide()

	self:_setFullMask(self._isDungeon and not self._isGameStart)

	showDialogMap = {}

	settimer(kguideInterval, self._showStep, self, true)
end

function GuideView:_showStep()
	self:_setPassEvent(false)

	if not self._stepCO then
		if enableErrorLog then
			printError("load step failed!")
		end

		self:_stopStep()

		return
	end

	self._isPlayFocusAnim = false

	local center, hollowArea, clickArea
	local stepCO = self._stepCO
	local completeType = stepCO.completeType
	local canvas = ViewMgr.instance:getUICanvas()
	local resolution = Astral.GeometryUtil.GetCanvasSize(canvas)
	local canvasScale = canvas.transform.localScale

	if stepCO.guideControlType == GuideEnum.GuideControlType.ControlUI or stepCO.guideControlType == GuideEnum.GuideControlType.ActiveUI then
		center, clickArea, hollowArea = self:_uiGuide(stepCO.guideControlParam, stepCO.guideControlType, completeType, canvasScale, resolution, canvas)
	elseif stepCO.guideControlType == GuideEnum.GuideControlType.CurPosInDungeon then
		local params = self._stepCO.guideControlParam

		if not params then
			removetimer(self._showStep, self)

			return
		end

		local coordinate = string.split(params, ",")

		if not coordinate or #coordinate ~= 2 then
			if enableErrorLog then
				printError("coordinate invaild ")
			end

			self:_stopStep()
			removetimer(self._showStep, self)

			return
		end

		if not BattleMgr.instance:isInBattle() then
			if enableErrorLog then
				printError("Guide error:it's not in battle.")
			end

			self:_stopStep()

			return
		end

		local cellIndex = BoardIndexConverter.coordinatesToUnionIndex(coordinate[1], coordinate[2])
		local worldpos = BattleMgr.instance:getBoardMgr():getCellPosition(cellIndex)

		center, clickArea, hollowArea = self:_getBattleGuidePos(worldpos, mainCamera, canvas, uiCamera, canvasScale, completeType, resolution)

		removetimer(self._showStep, self)
	elseif stepCO.guideControlType == GuideEnum.GuideControlType.NpcId then
		local params = self._stepCO.guideControlParam

		if not params then
			printError("params is null,could not find npc")
			self:_stopStep()
			removetimer(self._showStep, self)

			return
		end

		local npcCode = tonumber(params)
		local unit = BattleMgr.instance:getUnitMgr():getUnitByEntityCode(npcCode)

		if unit then
			local cellIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCurrentCoordinates())
			local worldpos = BattleMgr.instance:getBoardMgr():getCellPosition(cellIndex)

			center, clickArea, hollowArea = self:_getBattleGuidePos(worldpos, mainCamera, canvas, uiCamera, canvasScale, completeType, resolution)
		elseif enableErrorLog then
			printError("params invaild,could not found npc with npc code: " .. params)
			self:_stopStep()
		end

		removetimer(self._showStep, self)
	elseif stepCO.guideControlType == GuideEnum.GuideControlType.ReadyBeforeBattle then
		local uiPath, cellCoordinate = self:_getDragBeforeBattleParam(stepCO)

		center, clickArea, hollowArea = self:_uiGuide(uiPath, stepCO.guideControlType, completeType, canvasScale, resolution, canvas)

		if not center then
			return
		end

		local cellIndex = BoardIndexConverter.coordinatesToUnionIndex(cellCoordinate.x, cellCoordinate.y)
		local worldpos = BattleMgr.instance:getBoardMgr():getCellPosition(cellIndex)
		local cellCenter, cellClickArea, cellHollowArea = self:_getBattleGuidePos(worldpos, mainCamera, canvas, uiCamera, canvasScale, completeType, resolution)
		local distance = Vector3.Distance(Vector3.New(cellCenter.x, cellCenter.y, 0), Vector3.New(center.x, center.y, 0))
		local angle = Mathf.Atan2(cellCenter.y - center.y, cellCenter.x - center.x) * 180 / Mathf.PI

		RectTransformUtils.SetSize(self._arrowImage.transform, distance, 35)
		Astral.TransformUtil.SetLocalPos(self._arrowImage.transform, center.x, center.y, 0)
		Astral.TransformUtil.SetLocalRotation(self._arrowImage.transform, 0, 0, angle + 180)
		goutil.setActive(self._arrowImage.gameObject, true)
		self:_playArrowAnim(distance)
	elseif stepCO.guideControlType == GuideEnum.GuideControlType.SwipeToUI then
		local uiPath, arrowType = self:_getSwapToParam(stepCO)

		center, clickArea, hollowArea = self:_uiGuide(uiPath, stepCO.guideControlType, completeType, canvasScale, resolution, canvas)

		if not center then
			return
		end

		local angle = self:_getAngleByArrow(arrowType)

		Astral.TransformUtil.SetLocalPos(self._slideArrow.transform, center.x, center.y, 0)
		Astral.TransformUtil.SetLocalRotation(self._slideArrow.transform, 0, 0, angle)
		goutil.setActive(self._slideArrow.gameObject, true)
	elseif stepCO.guideControlType == GuideEnum.GuideControlType.SceneObject then
		local params = self._stepCO.guideControlParam

		if not params then
			removetimer(self._showStep, self)

			return
		end

		local guideComponent = goutil.find(params)

		if goutil.isNil(guideComponent) then
			self:_stopStep()

			if enableWarnLog then
				printWarn(string.format("3D gameobject is not found[path=%s]", params))
			end

			return
		end

		local box = guideComponent:GetComponent(ComponentType.BoxCollider)
		local canvasRT = canvas:GetComponent(UIComponentType.RectTransform)
		local rect = Astral.GeometryUtil.GetBoxColliderRectInCanvas(box, mainCamera, canvasRT, uiCamera)
		local resolution = Astral.GeometryUtil.GetCanvasSize(canvas)
		local guideContentW = Astral.GeometryUtil.GetWidth(self._guideContent.transform)
		local guideContentH = Astral.GeometryUtil.GetHeight(self._guideContent.transform)

		hollowArea = {
			x = rect.x + guideContentW / 2 + rect.width,
			y = rect.y + guideContentH / 2,
			w = math.abs(rect.width),
			h = math.abs(rect.height)
		}
		clickArea = {
			x = rect.x + 5 + guideContentW / 2 + rect.width,
			y = rect.y + 5 + guideContentH / 2,
			w = math.abs(rect.width - 10),
			h = math.abs(rect.height - 10)
		}
		center = {
			x = rect.x + rect.width / 2,
			y = rect.y + rect.height / 2
		}

		removetimer(self._showStep, self)
	elseif stepCO.guideControlType == GuideEnum.GuideControlType.None then
		center = {
			x = 0,
			y = 0
		}
		hollowArea = {
			w = 0,
			h = 0,
			x = 0,
			y = 0
		}
		clickArea = {
			w = 4096,
			h = 4096,
			x = 0,
			y = 0
		}

		removetimer(self._showStep, self)
		self:_setPassEvent(completeType == GuideEnum.CompleteType.ClickAnywhereWithPassEvent)
	end

	if not center then
		return
	end

	self._isShowAllDesc = false

	local isCircleMask = stepCO.isCircleMask == 1

	self:_setTipDialogState(not string.nilorempty(self._stepCO.tipsContent), isCircleMask)
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Guide)

	local showEnterFocuse = stepCO.guideControlType ~= GuideEnum.GuideControlType.None

	self:_setGuideEventState(nil, false)
	self:_showHollowArea(hollowArea, isCircleMask)
	self:_setGuideSetpCode(stepCO.id)

	if clickArea then
		self:_setClickableArea(clickArea)
	end

	self:_showClickFocusEffect(center, isCircleMask)

	if showEnterFocuse then
		self:_playStartFource(center, hollowArea, isCircleMask)
	end

	self:_setGuideMaskAlpha(stepCO.maskLevel)

	if completeType == GuideEnum.CompleteType.WaitUIViewClose or completeType == GuideEnum.CompleteType.WaitUICloseBySpecial then
		self:_setMaskDisable(false)
	else
		self:_setFullMask(false)
	end
end

function GuideView:_setGuideMaskAlpha(maskLevel)
	local maskPrefabMap = {
		[0] = 0,
		175,
		220,
		242
	}
	local maskAlpha = (maskPrefabMap[maskLevel] or 0) / 255

	self._guideMaskColor.color = Color.New(0, 0, 0, maskAlpha)
end

function GuideView:_clickGuideBtn(guideId, stepId)
	if self._guideButtonCallback then
		self._guideButtonCallback(self._clickCallbackSelf, guideId, stepId)
	end
end

function GuideView:_onClickHollowArea(isInHollowArea, stepId)
	if not isInHollowArea and self._stepCO.completeType == GuideEnum.CompleteType.ClickTargetControl and self._isPlayOpenAnim then
		return
	end

	if self._clickCallback and stepId > 0 and self._stepCO.id == stepId then
		self._clickCallback(self._clickCallbackSelf, isInHollowArea)

		if self._passEvent.isPassEvent then
			self:_setPassEvent(false)
		end
	end
end

function GuideView:_showFocusWhenClickWrong()
	local isCircleMask = self._stepCO and self._stepCO.isCircleMask == 1 or false

	goutil.setActive(self._focusGO, isCircleMask)

	if self._isPlayFocusAnim then
		return
	end

	self._guideViewAnim:StopTimelineAni()
	self._guideViewAnim:PlayAniByName(guideopen)

	self._isPlayFocusAnim = true
end

function GuideView:_updateFocuseAnimPos(center)
	local isCircleMask = self._stepCO and self._stepCO.isCircleMask == 1 or false

	if isCircleMask then
		RectTransformUtils.SetAnchoredPosition(self._focusGO.transform, center.x, center.y)
	end
end

function GuideView:_hideFocusAnim()
	goutil.setActive(self._focusGO, false)
end

function GuideView:_showHollowArea(area, isCircleMask)
	if area then
		self._guideMask:SetHollowArea(area.x, area.y, area.w, area.h, isCircleMask)
	end
end

function GuideView:_setClickableArea(area)
	if area then
		self._guideMask:SetClickableArea(area.x, area.y, area.w, area.h)
	end
end

function GuideView:_setGuideSetpCode(code)
	if code then
		self._guideMask:SetGuideStepCode(code)
	end
end

function GuideView:_setTipDialogState(active, isCircleMask)
	if active then
		if not showDialogMap[self._stepCO.id] then
			local dialogDirection = self._stepCO.dialogDirection
			local isInBorder = self:_isDialgInBorder(dialogDirection)

			self._curIsInBorderDialog = isInBorder
			showDialogMap[self._stepCO.id] = true

			local offsetX = 0

			if not string.nilorempty(self._stepCO.tipsContent) then
				local text = StringUtil.replaceAllRed(self._stepCO.tipsContent)

				if isInBorder then
					self._dialogContentHide.text = text

					RectTransformUtils.ForceRebuildLayoutImmediate(self._dialogPanel.transform)

					offsetX = self._dialogContentBg.sizeDelta.x - dialogContentDefaultX
					offsetX = offsetX / 2
					self._dialogContent.text = text
					self._dialogPanelCanvasGroup.alpha = 1
					self._simpleDialogPanelCanvasGroup.alpha = 0

					if dialogDirection == 2 then
						offsetX = 0 - offsetX
					elseif dialogDirection == 4 then
						offsetX = Mathf.Abs(offsetX)
					else
						offsetX = 0
					end

					Astral.TransformUtil.SetLocalPos(self._dialogPanel.transform, offsetX, 0, 0)
					goutil.addChildToParent(self._dialogPanel, self._dialogRoot[dialogDirection ~= 0 and dialogDirection or 5])

					if not string.nilorempty(self._stepCO.tipsHeadIconName) then
						IconLoader.setSprite(self._dialogHeadIcon, IconType.RoleCard, self._stepCO.tipsHeadIconName)
					end
				else
					self._simpleDialogContent.text = text

					self:_setSimplePos(dialogDirection, isCircleMask)
				end
			end
		end
	else
		if self._dialogPanelCanvasGroup.alpha ~= 0 then
			self._dialogPanelCanvasGroup.alpha = 0
		end

		if self._simpleDialogPanelCanvasGroup.alpha ~= 0 then
			self._simpleDialogPanelCanvasGroup.alpha = 0
		end
	end
end

function GuideView:_setSimplePos(dialogDirection, isCircleMask)
	local index = dialogDirection and dialogDirection - 4 or 1
	local realIndex = self:_getSimpleDialogIndex(index)

	if isCircleMask then
		goutil.addChildToParent(self._simpleDialogPanel.gameObject, self._circleFingerNode[realIndex])
	else
		goutil.addChildToParent(self._simpleDialogPanel.gameObject, self._rectFingerNode[realIndex])
	end

	RectTransformUtils.ForceRebuildLayoutImmediate(self._simpleDialogPanel.transform)

	if self._delayTween then
		self._delayTween:Kill(false)

		self._delayTween = nil
	end

	self._delayTween = DoTweenUtil.DelayedCall(0.1, function()
		local posX, posY = self:_getSimpleDialogPos(realIndex)

		Astral.TransformUtil.SetLocalPos(self._simpleDialogPanel.transform, posX, posY, 0)

		self._dialogPanelCanvasGroup.alpha = 0
		self._simpleDialogPanelCanvasGroup.alpha = 1
	end)
end

function GuideView:_getSimpleDialogPos(realIndex)
	local posX, posY = 0, 0
	local width = RectTransformUtils.GetWidth(self._simpleDialogContentBg)
	local height = RectTransformUtils.GetHeight(self._simpleDialogContentBg)

	if realIndex == 1 then
		posX = width / 2
		posY = -height / 2
	elseif realIndex == 2 then
		posX = width / 2
		posY = height / 2
	elseif realIndex == 3 then
		posX = -width / 2
		posY = height / 2
	elseif realIndex == 4 then
		posX = -width / 2
		posY = -height / 2
	end

	return posX, posY
end

function GuideView:_getSimpleDialogIndex(index)
	if index == 1 then
		return 2
	elseif index == 2 then
		return 1
	elseif index == 3 then
		return 4
	elseif index == 4 then
		return 3
	end
end

function GuideView:_isDialgInBorder(dialogDirection)
	if dialogDirection then
		return dialogDirection <= 4
	end

	return false
end

function GuideView:_setFingerState(isCircleMask)
	if self._stepCO.completeType == GuideEnum.CompleteType.DragBeforeBattle then
		return
	end

	local dir = self._stepCO.arrowDirection

	goutil.setActive(self._fingerImg.gameObject, dir ~= 0)

	if dir > 0 then
		if isCircleMask then
			goutil.addChildToParent(self._fingerImg.gameObject, self._circleFingerNode[dir])
		else
			goutil.addChildToParent(self._fingerImg.gameObject, self._rectFingerNode[dir])
		end

		Astral.TransformUtil.SetLocalPos(self._fingerImg.transform, 0, 0, 0)
		Astral.TransformUtil.SetLocalRotation(self._fingerImg.transform, 0, 0, rotationList[dir])
		self._fingerAnimation:Play("guideview_fingerroot")
	end
end

function GuideView:_showClickFocusEffect(center)
	if center then
		self:_updateFocuseAnimPos(center)
	end
end

function GuideView:_playStartFource(center, hollowArea, isCircleMask)
	if not center then
		return
	end

	local rectOffsetX = 0
	local rectOffsetY = 0
	local circleOffset = 0

	if self._stepCO.guideControlType == GuideEnum.GuideControlType.SwipeToUI or self._stepCO.guideControlType == GuideEnum.GuideControlType.ReadyBeforeBattle then
		goutil.setActive(self._circleFocus.gameObject, false)
		goutil.setActive(self._rectFocuse, false)
	else
		goutil.setActive(self._circleFocus.gameObject, isCircleMask)
		goutil.setActive(self._rectFocuse, not isCircleMask)
	end

	self._guideViewAnim:StopTimelineAni()

	if self._stepCO.guideControlType == GuideEnum.GuideControlType.ControlUI and self._stepCO.completeType == GuideEnum.CompleteType.ClickAnywhere then
		self._guideViewAnim:PlayAniByName(guide_reset)
	else
		self._guideViewAnim:PlayAniByName(guide_open)
	end

	local maskScale = self._stepCO.maskScale <= 0 and 1 or self._stepCO.maskScale

	if isCircleMask then
		RectTransformUtils.SetAnchoredPosition(self._circleFocus.transform, center.x, center.y)

		local diameter = 100

		if hollowArea.showWidth and hollowArea.showHeight then
			diameter = Mathf.Sqrt(math.pow(hollowArea.showWidth, 2) + math.pow(hollowArea.showHeight, 2))
		else
			diameter = Mathf.Sqrt(math.pow(hollowArea.w, 2) + math.pow(hollowArea.h, 2))
		end

		RectTransformUtils.SetSize(self._circleFocus.transform, (diameter + circleOffset) * maskScale, (diameter + circleOffset) * maskScale)
	else
		RectTransformUtils.SetAnchoredPosition(self._rectFocuse.transform, center.x, center.y)

		if hollowArea.showWidth and hollowArea.showHeight then
			RectTransformUtils.SetSize(self._rectFocuse.transform, (hollowArea.showWidth + rectOffsetX) * maskScale, (hollowArea.showHeight + rectOffsetY) * maskScale)
			RectTransformUtils.SetSize(self._rectFocusGo.transform, (hollowArea.showWidth + rectOffsetX) * maskScale, (hollowArea.showHeight + rectOffsetY) * maskScale)
		else
			RectTransformUtils.SetSize(self._rectFocuse.transform, (hollowArea.w + rectOffsetX) * maskScale, (hollowArea.h + rectOffsetY) * maskScale)
			RectTransformUtils.SetSize(self._rectFocusGo.transform, (hollowArea.w + rectOffsetX) * maskScale, (hollowArea.h + rectOffsetY) * maskScale)
		end
	end

	self._isPlayOpenAnim = true
end

function GuideView:_startAnimationFinish()
	if not self._stepCO then
		return
	end

	local isCircleMask = self._stepCO.isCircleMask == 1

	self:_setFingerState(isCircleMask)
end

function GuideView:_onFinishStep()
	if not self._stepCO then
		return
	end

	self:_onEndInComplete()
end

function GuideView:_setGuideEventState(evt, pauseEvent)
	self._guideMask:SetGuideEventState(pauseEvent)
end

function GuideView:_playEndFource(isCircleMask)
	if isCircleMask then
		-- block empty
	end
end

function GuideView:_onEndInComplete()
	goutil.setActive(self._circleFocus.gameObject, false)
	goutil.setActive(self._rectFocuse, false)
end

function GuideView:_setDefaultState()
	if self._guideButtonAdapter then
		self._guideButtonAdapter:RemoveClickListener()
	end

	self._guideButtonAdapter = false

	goutil.setActive(self._guideContent, true)
	goutil.setActive(self._fullScreenMask, false)
	goutil.setActive(self._fingerImg.gameObject, false)

	if self._dialogPanelCanvasGroup then
		self._dialogPanelCanvasGroup.alpha = 0
	end

	if self._simpleDialogPanelCanvasGroup then
		self._simpleDialogPanelCanvasGroup.alpha = 0
	end

	self:_hideFocusAnim()
	goutil.setActive(self._circleFocus.gameObject, false)
	goutil.setActive(self._rectFocuse, false)

	local hollowArea = {
		w = 0,
		h = 0,
		x = 0,
		y = 0
	}
	local clickArea = {
		w = 0,
		h = 0,
		x = 0,
		y = 0
	}

	self:_showHollowArea(hollowArea, false)
	self:_setClickableArea(clickArea)
	self:_setGuideSetpCode(0)
	goutil.setActive(self._arrowImage.gameObject, false)

	showDialogMap = false
end

function GuideView:_nextStep()
	removetimer(self._showStep, self)
	GlobalDispatcher:dispatchEvent(EventType.TRIGGER_NEXT_STEP)
end

function GuideView:_stopStep()
	removetimer(self._showStep, self)
	GuideController.instance:closeGuide(true)
end

function GuideView:_getDragBeforeBattleParam(stepCO)
	local params = stepCO.guideControlParam
	local cellCoordinate = Vector2.New(0, 0)
	local uiPath = false

	if params then
		local tempParams = string.split(params, "#")

		if #tempParams ~= 3 then
			if enableErrorLog then
				printError("GuideStep==>params invalid in drag before battle action , step id:" .. tostring(stepId) .. " _ params:" .. guideStepCO.guideControlParam)
			end

			return
		end

		uiPath = tempParams[1]

		local posParam = string.split(tempParams[2], ",")

		if #posParam ~= 2 then
			if enableErrorLog then
				printError("GuideStep==>params invalid in drag before battle action , step id:" .. tostring(stepId) .. " _ params:" .. guideStepCO.guideControlParam)
			end

			return
		end

		cellCoordinate = Vector2.New(posParam[1], posParam[2])
	end

	return uiPath, cellCoordinate
end

function GuideView:_getSwapToParam(stepCO)
	local params = stepCO.guideControlParam
	local arrowType = 1
	local uiPath = false

	if params then
		local tempParams = string.split(params, "#")

		if #tempParams ~= 2 then
			if enableErrorLog then
				printError("GuideStep==>params invalid in drag before battle action , step id:" .. tostring(stepId))
			end

			return
		end

		uiPath = tempParams[1]
		arrowType = tonumber(tempParams[2])
	end

	return uiPath, arrowType
end

function GuideView:_getAngleByArrow(arrowType)
	local angle = 0

	if arrowType == 1 then
		angle = 90
	elseif arrowType == 2 then
		angle = 0
	elseif arrowType == 3 then
		angle = -90
	elseif arrowType == 4 then
		angle = 180
	end

	return angle
end

function GuideView:_uiGuide(path, guideControlType, completeType, canvasScale, resolution, canvas)
	local center, hollowArea, clickArea
	local guideComponent = goutil.find(path)

	self._tickTimes = self._tickTimes + 1

	if not guideComponent then
		if self._tickTimes > foundUITimes then
			if enableErrorLog then
				printError("Guide Error:could not found ui with path :" .. path)
			end

			self:_stopStep()
		end

		return
	elseif not guideComponent.activeInHierarchy then
		if guideControlType == GuideEnum.GuideControlType.ActiveUI then
			goutil.setActive(guideComponent, true)
			self:_nextStep()
		else
			if self._tickTimes > waitUIAnimTimes then
				if enableWarnLog then
					printWarn(string.format("component is not active[path=%s]", path))
				end

				self:_stopStep()
			end

			return
		end
	elseif guideControlType == GuideEnum.GuideControlType.ActiveUI then
		self:_nextStep()
	end

	if completeType == GuideEnum.CompleteType.ClickTargetControl and self._stepCO.guideControlType == GuideEnum.GuideControlType.ControlUI and guideComponent and not goutil.isNil(guideComponent) and not self._guideButtonAdapter then
		self._guideButtonAdapter = SpaceX.GuideButtonAdapter.Get(guideComponent)

		self._guideButtonAdapter:SetGuideInfo(self._stepCO.guideId, self._stepCO.id)
		self._guideButtonAdapter:AddClickListener(self._clickGuideBtn, self)
	end

	local rt = guideComponent.transform
	local pos = rt.position
	local rectTran = guideComponent:GetComponent(UIComponentType.RectTransform)
	local anchoredPosition = rectTran.anchoredPosition
	local componentScale = rt.lossyScale

	if self._guideComponentPos ~= pos or self._guideComponentScale ~= componentScale or self._guiddeUIComAnchoredPos ~= anchoredPosition then
		self._guideComponentPos = pos
		self._guiddeUIComAnchoredPos = anchoredPosition
		self._guideComponentScale = componentScale

		return
	end

	local uiLocalPos = self._guideContent.transform:InverseTransformPoint(pos)
	local guideContentW = Astral.GeometryUtil.GetWidth(self._guideContent.transform)
	local guideContentH = Astral.GeometryUtil.GetHeight(self._guideContent.transform)
	local wpos = Astral.GeometryUtil.LocalToCanvasPos(rt, canvas)
	local scale = rt.lossyScale
	local width = Astral.GeometryUtil.GetWidth(rt) * scale.x / canvasScale.x
	local height = Astral.GeometryUtil.GetHeight(rt) * scale.y / canvasScale.y
	local pivot = rt.pivot

	wpos.x = wpos.x + (0.5 - pivot.x) * width
	wpos.y = wpos.y + (0.5 - pivot.y) * height
	uiLocalPos.x = uiLocalPos.x + (0.5 - pivot.x) * width
	uiLocalPos.y = uiLocalPos.y + (0.5 - pivot.y) * height
	center = {
		x = wpos.x,
		y = wpos.y
	}

	if completeType == GuideEnum.CompleteType.ClickTargetControl or completeType == GuideEnum.CompleteType.DragBeforeBattle or completeType == GuideEnum.CompleteType.SwipeTo then
		local rw, rh = width * 0.89, height * 0.89

		clickArea = {
			x = uiLocalPos.x + guideContentW / 2 - width / 2,
			y = uiLocalPos.y + guideContentH / 2 - height / 2,
			w = rw,
			h = rh
		}
	elseif completeType == GuideEnum.CompleteType.ClickAnywhere then
		clickArea = {
			w = 0,
			h = 0,
			x = 0,
			y = 0
		}
	end

	hollowArea = {
		x = uiLocalPos.x + guideContentW / 2 - width / 2,
		y = uiLocalPos.y + guideContentH / 2 - height / 2,
		w = Mathf.Abs(width),
		h = Mathf.Abs(height),
		showWidth = Mathf.Abs(width),
		showHeight = Mathf.Abs(height)
	}

	removetimer(self._showStep, self)

	return center, clickArea, hollowArea
end

function GuideView:_getBattleGuidePos(worldpos, mainCamera, canvas, uiCamera, canvasScale, completeType, resolution)
	local center, hollowArea, clickArea
	local screenPos = mainCamera:WorldToScreenPoint(worldpos)
	local guideContentW = Astral.GeometryUtil.GetWidth(self._guideContent.transform)
	local guideContentH = Astral.GeometryUtil.GetHeight(self._guideContent.transform)
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
	local targetX, targetY = RectTransformUtils.ScreenPointToLocalPointInRectangle(self._guideContent.transform, screenPos.x, screenPos.y, uiCamera, 0, 0)
	local uiLocalPos = {
		x = targetX,
		y = targetY
	}
	local uiPos = Astral.GeometryUtil.ScreenToLocalPos(screenPos, canvas.transform, uiCamera)
	local width = 1 / canvasScale.x
	local height = 1 / canvasScale.y

	center = {
		x = uiPos.x,
		y = uiPos.y
	}

	if completeType == GuideEnum.CompleteType.ClickTargetControl then
		local rw, rh = width * 0.89, height * 0.89

		clickArea = {
			x = uiLocalPos.x + guideContentW / 2 - width / 2,
			y = uiLocalPos.y + guideContentH / 2 - height / 2,
			w = rw,
			h = rh
		}
		hollowArea = {
			h = 0,
			w = 0,
			x = uiLocalPos.x + guideContentW / 2 - width / 2,
			y = uiLocalPos.y + guideContentH / 2 - height / 2,
			showWidth = Mathf.Abs(width),
			showHeight = Mathf.Abs(height)
		}
	elseif completeType == GuideEnum.CompleteType.ClickAnywhere then
		clickArea = {
			w = 0,
			h = 0,
			x = 0,
			y = 0
		}
		hollowArea = {
			x = uiLocalPos.x + guideContentW / 2 - width / 2,
			y = uiLocalPos.y + guideContentH / 2 - height / 2,
			w = Mathf.Abs(width),
			h = Mathf.Abs(height)
		}
	end

	return center, clickArea, hollowArea
end

function GuideView:_playArrowAnim(distance)
	local width = RectTransformUtils.GetWidth(self._arrowAimaImg.transform)
	local startPosX = distance / 2 - width / 2
	local endPosX = -distance / 2

	RectTransformUtils.SetAnchoredPosition(self._arrowAimaImg.transform, startPosX, 36)
	self._arrowAimaImg.rectTransform:DOAnchorPosX(endPosX, 2):SetLoops(-1)
end

function GuideView:_setFullMask(active)
	goutil.setActive(self._fullScreenMask, active)
	goutil.setActive(self._guideContent, not active)

	if active then
		self._dialogPanelCanvasGroup.alpha = 0
		self._simpleDialogPanelCanvasGroup.alpha = 0
	end
end

function GuideView:_setMaskDisable(active)
	goutil.setActive(self._fullScreenMask, active)
	goutil.setActive(self._guideContent, active)

	if not active then
		self._dialogPanelCanvasGroup.alpha = 0
		self._simpleDialogPanelCanvasGroup.alpha = 0
	end
end

function GuideView:_handleViewAniDoneEvent(key, tagName, reason)
	if rect_open_anim == tagName then
		-- block empty
	elseif circle_open_anim == tagName then
		-- block empty
	elseif GUIDE_VIEW_OPEN == tagName then
		self._isPlayOpenAnim = false

		self._guideViewAnim:StopTimelineAni()
		self._guideViewAnim:PlayAniByName(guide_loop)
	elseif GUIDE_VIEW_HOLD == tagName then
		self._guideViewAnim:StopTimelineAni()
		self._guideViewAnim:PlayAniByName(guide_loop)
	elseif tagName ~= "rect_open" and tagName == "circle_open" then
		-- block empty
	end

	if circle_focus == tagName or rect_focus == tagName then
		self._isPlayFocusAnim = false
	end

	if GUIDE_VIEW_END == tagName then
		self:_onEndInComplete()
	end
end

function GuideView:_setPassEvent(active)
	self._passEvent.isPassEvent = active
end

function GuideView:_onClickSkip()
	GuideController.instance:pauseGuideEvent(true)

	local dialog = Dialog.showMessage(lang("tip_skip_guide"), lang("tip_force_skip_guide"))

	dialog:setConfirmListener(self._onPassCurGuide, self)
	dialog:setCancelListener(self._onClosePassCurGuide, self)
	dialog:setCloseListener(self._onClosePassCurGuide, self)
end

function GuideView:_onPassCurGuide()
	GuideController.instance:updateJumpGuideInfo(false)
	GuideController.instance:finishStep(self._guideId, nil, true)
	GlobalDispatcher:dispatchEvent(EventType.PASS_GUIDE_BY_CLICK, self._guideId)
end

function GuideController:_onClosePassCurGuide()
	GuideController.instance:updateJumpGuideInfo(false)
	GuideController.instance:pauseGuideEvent(false)
end

function GuideView:_setGuideSkip(evt, active)
	self:_updateSkipBtn(active)
end

function GuideView:_updateSkipBtn(active)
	if self._btnSkip and not goutil.isNil(self._btnSkip.gameObject) then
		goutil.setActive(self._btnSkip.gameObject, active)
	end
end

return GuideView
