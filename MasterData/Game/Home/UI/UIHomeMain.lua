local UIHomeMain = class("UIHomeMain", UIBaseWindow)
local base = UIBaseWindow
local CS_OasisCameraController = CS.OasisCameraController
local CS_CmCoreState = CS.Cinemachine.CinemachineCore.Stage
local cs_GameObject = CS.UnityEngine.GameObject
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_coroutine = require("XLua.Common.cs_coroutine")
local HomeAdjutant = require("Game.Home.HomeAdjutant")
local UINHomeUp = require("Game.Home.UI.UINHomeUp")
local UINHomeLeft = require("Game.Home.UI.UINHomeLeft")
local UINHomeRight = require("Game.Home.UI.UINHomeRight")
local JumpManager = require("Game.Jump.JumpManager")
local COST_TIME_RATE = 0.4
local TOUCH_DIFF = UIManager.csUIManager.BackgroundStretchSize.x * 0.3
local L2D_ENTER_X = 5
local PIC_ENTER_X = 10000
local RESET_POS_TIME = 0.2

function UIHomeMain:OnInit()
  self.resloader = CS.ResLoader.Create()
  self.homeController = ControllerManager:GetController(ControllerTypeId.HomeController, true)
  self.fakeCameraHome = cs_GameObject.Find("FakeCameraHome")
  local camera = self.fakeCameraHome:FindComponent(eUnityComponentID.Camera)
  self.__fakeCamera = camera
  self.canvas = self.__fakeCamera:FindComponent("Canvas", eUnityComponentID.Canvas)
  self:OnScreenSizeChanged(true)
  self.fakeCameraHomeConstraint = self.fakeCameraHome:GetComponent("PositionConstraint")
  self.fakeCameraHomeConstraint.constraintActive = true
  self.fakeCameraHomeConstraintRotation = self.fakeCameraHome:GetComponent("RotationConstraint")
  self.fakeCameraHomeConstraintRotation.constraintActive = true
  self.bind = {}
  UIUtil.LuaUIBindingTable(CS_OasisCameraController.Instance.transform, self.bind)
  self.home2SectorVCBody = self.bind.toSectorVHomeCam:GetCinemachineComponent(CS_CmCoreState.Body)
  self.home2OasisCamVCBody = self.bind.toOasiaVHomeCam:GetCinemachineComponent(CS_CmCoreState.Body)
  self.__OnAdjutantCompleted = BindCallback(self, self.OnAdjutantCompleted)
  self.homeAdjutant = HomeAdjutant.New()
  self.homeAdjutant:InitHomeAdjutant(self.bind, self.bind.emptyHolder, self.__OnAdjutantCompleted)
  self.homeUpNdoe = UINHomeUp.New()
  self.homeUpNdoe:Init(self.ui.obj_upper)
  self.homeUpNdoe:InitHomeUpNode(self)
  self.homeLeftNode = UINHomeLeft.New()
  self.homeLeftNode:Init(self.ui.obj_left)
  self.homeLeftNode:InitHomeLeftNode(self)
  self.homeRightNode = UINHomeRight.New()
  self.homeRightNode:Init(self.ui.obj_right)
  self.homeRightNode:InitHomeRightNode(self)
  local eventTrigger = CS.EventTriggerListener.Get(self.ui.scrollRect_pageList.gameObject)
  eventTrigger:onBeginDrag("+", BindCallback(self, self.OnBeginDragRight))
  eventTrigger:onEndDrag("+", BindCallback(self, self.OnEndDragRight))
  self.__OnUpdateHome = BindCallback(self, self.OnUpdateHome)
  UpdateManager:AddUpdate(self.__OnUpdateHome)
  if isEditorMode and CS.GMController.Instance.battleShortcut and ExplorationManager:HasUncompletedEp() then
    ExplorationManager:ContinueLastExploration()
  end
  GuideManager:TryTriggerGuide(eGuideCondition.FInHome)
  self.homeController:OnInitHomeUI()
  self:RefreshHomeMainBg()
  self.__isUnfold = false
  self.__flag = 1
  self.__OnScreenSizeChanged = BindCallback(self, self.OnScreenSizeChanged)
  MsgCenter:AddListener(eMsgEventId.OnScreenSizeChanged, self.__OnScreenSizeChanged)
  self.__RefreshHomeMainBgCallback = BindCallback(self, self.RefreshHomeMainBg)
  MsgCenter:AddListener(eMsgEventId.AdjCustomModify, self.__RefreshHomeMainBgCallback)
  MsgCenter:AddListener(eMsgEventId.AdjCustomChange, self.__RefreshHomeMainBgCallback)
  self.__OnFingerDownCallback = BindCallback(self, self.__OnFingerDown)
  self.__OnFingerUpCallback = BindCallback(self, self.__OnFingerUp)
  CS_LeanTouch.OnFingerDown("+", self.__OnFingerDownCallback)
  CS_LeanTouch.OnFingerUp("+", self.__OnFingerUpCallback)
  self._defaultL2dParentPos = self.bind.live2DRoot.transform.localPosition
  self._defaultPicParentPos = self.bind.heroHolder.transform.localPosition
end

function UIHomeMain:OnScreenSizeChanged(force)
  if self.homeController:IsNormalState() or force then
    self.__fakeCamera.enabled = true
    self.__fakeCamera.enabled = false
    self:AlignToFakeCamera(self.__fakeCamera, self.__fakeCamera)
    self.__fakeCameraPos = self.fakeCameraHome.transform.position
  end
end

function UIHomeMain:OnShow(isFromOasis)
  self.homeController:OnShowHomeUI(isFromOasis)
  self.homeUpNdoe:OnHomeShow()
  self.homeLeftNode:OnHomeShow()
  self.homeRightNode:OnHomeShow()
  if isFromOasis then
    TimerManager:StartTimer(0.4, function()
      if not IsNull(self.fakeCameraHomeConstraint) then
        self.fakeCameraHomeConstraint.weight = 1
      end
    end, nil, true)
  end
  self.ui.scrollRect_pageList.onValueChanged:AddListener(BindCallback(self, self.OnValueChange))
  base.OnShow(self)
end

function UIHomeMain:ShowTween()
  self.ui.canvasGroup.alpha = 0
  self.ui.canvasGroup:DOFade(1, 0.5):SetLink(self.ui.canvasGroup.gameObject)
end

function UIHomeMain:m_SetMainCameraEnabled(enabled)
  CS_OasisCameraController.Instance.MainCamera.enabled = enabled
end

function UIHomeMain:SetFrom2Home(from, playReturnHomeCv)
  if from == AreaConst.Sector or from == AreaConst.FactoryDorm then
    self.__flag = 1
    if self.bind.homeToSectorGo.activeInHierarchy then
      UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
      self.bind.homeToSectorGo:SetActive(true)
      self.bind.homeToOasisGo:SetActive(false)
      self.bind.homeToMenuGo:SetActive(false)
      self.__curVCBody = self.home2SectorVCBody
      self:PlaySectorTimeLine(from)
    end
  elseif from == AreaConst.Oasis then
    self.__flag = -1
    self.bind.homeToSectorGo:SetActive(false)
    self.bind.homeToOasisGo:SetActive(true)
    self.bind.homeToMenuGo:SetActive(false)
    self.__curVCBody = self.home2OasisCamVCBody
    self.homeController:ResetHomeMainBg()
  else
    self.homeController:ResetHomeMainBg()
  end
  if playReturnHomeCv then
    if JumpManager:IsHaveBack2Home() then
      return
    end
    if JumpManager.isJumping then
      return
    end
    if not self.homeController:TryPlayVoReturnHome() then
      self.__playReturnHomeCv = true
    end
  end
end

function UIHomeMain:SetTo(to)
  if to == AreaConst.Sector or to == AreaConst.FactoryDorm then
    self.bind.homeToSectorGo:SetActive(true)
    self.bind.homeToOasisGo:SetActive(false)
    self.bind.homeToMenuGo:SetActive(false)
    self.__curVCBody = self.home2SectorVCBody
  elseif to == AreaConst.Oasis then
    self.bind.homeToSectorGo:SetActive(false)
    self.bind.homeToOasisGo:SetActive(true)
    self.bind.homeToMenuGo:SetActive(false)
    self.__curVCBody = self.home2OasisCamVCBody
  end
end

function UIHomeMain:RefreshHomeMainBg()
  if self.homeController == nil then
    return
  end
  self.homeController:RefreshHomeMainBg()
end

function UIHomeMain:OpenOtherWin()
  self:m_SetMainCameraEnabled(false)
  self.homeAdjutant:HideBordGirl()
  self:Hide()
end

function UIHomeMain:OpenOtherWinWithMainCamera()
  self.homeAdjutant:HideBordGirl()
  self.ui.canvsGroup_root.alpha = 0.3
  self.ui.canvsGroup_root.interactable = false
end

function UIHomeMain:OpenOtherCoverWin()
  self.homeController:OnCoverHomeUI()
end

function UIHomeMain:HideBordGirl()
  self.homeAdjutant:HideBordGirl()
end

function UIHomeMain:BackFromOtherWin()
  AudioManager:PlayAudioById(1089)
  self:m_SetMainCameraEnabled(true)
  self.homeAdjutant:ShowBordGirl()
  self:Show()
end

function UIHomeMain:BackFromOtherCoverWin()
  self.homeController:OnShowHomeUI()
end

function UIHomeMain:BackFromOtherWinWithMainCamera()
  self.homeAdjutant:ShowBordGirl()
  self.ui.canvsGroup_root.alpha = 1
  self.ui.canvsGroup_root.interactable = true
end

function UIHomeMain:ShowBordGirl()
  self.homeAdjutant:ShowBordGirl()
end

function UIHomeMain:SetHomeShowMainUI(bool)
  if bool then
    self.homeUpNdoe:Show()
    self.homeLeftNode:Show()
    self.homeRightNode:Show()
  else
    self.homeUpNdoe:Hide()
    self.homeLeftNode:Hide()
    self.homeRightNode:Hide()
  end
end

function UIHomeMain:PlaySectorTimeLine(from)
  local timeline
  if from == AreaConst.Sector then
    timeline = self.bind.sectorPlayableDirector
  else
    timeline = self.bind.factorydormPlayableDirector
  end
  self.homeController.isRewindingBack2HomeTimeLine = true
  self.__tlSectorCo = TimelineUtil.Rewind(timeline, function()
    self.__tlSectorCo = nil
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    self.homeController.isRewindingBack2HomeTimeLine = false
    self.homeController:ResetHomeMainBg()
    if not JumpManager:TryCallBack2HomeMsgFunc(UIUtil.backStack:Empty()) then
      self.fakeCameraHomeConstraint.constraintActive = true
    end
  end)
end

function UIHomeMain:PauseEnterTimeLine()
  if self.__tlSectorCo ~= nil then
    TimelineUtil.StopTlCo(self.__tlSectorCo)
    self.__tlSectorCo = nil
    self.homeController.isRewindingBack2HomeTimeLine = false
  end
end

function UIHomeMain:PlayEnterTimeLine()
  self:PauseEnterTimeLine()
  self:PlaySectorTimeLine(AreaConst.Sector)
end

function UIHomeMain:IsHomeRightRealyCompleteFold()
  if self.__isUnfold then
    return false
  end
  if self.ui.scrollRect_pageList.horizontalNormalizedPosition > 0.001 then
    return false
  end
  if self.__couldUpdateList then
    return false
  end
  return true
end

function UIHomeMain:OnBeginDragRight(go, pointerEvent)
  self.__couldUpdateList = false
  if not self.fakeCameraHomeConstraint.constraintActive then
    self.fakeCameraHomeConstraint.constraintActive = true
  end
  self.fakeCameraHomeConstraint.weight = 1
  self:_fakeCameraConstraintParent(true)
end

function UIHomeMain:OnEndDragRight(go, pointerEvent)
  if self.ui.scrollRect_pageList.horizontalNormalizedPosition > 0.1 and not self.__isUnfold then
    self.__isUnfold = true
    AudioManager:PlayAudioById(1086)
  elseif self.ui.scrollRect_pageList.horizontalNormalizedPosition < 0.9 and self.__isUnfold then
    self.__isUnfold = false
  end
  self.__couldUpdateList = true
  self.currNPos = self.ui.scrollRect_pageList.horizontalNormalizedPosition
  self.passedTime = 0
  if self.__isUnfold then
    self.costTime = (1 - self.currNPos) * COST_TIME_RATE
  else
    self.costTime = self.currNPos * COST_TIME_RATE
  end
end

function UIHomeMain:OnValueChange(_)
  if IsNull(self.gameObject) then
    return
  end
  local rate = self.ui.scrollRect_pageList.horizontalNormalizedPosition
  self.homeAdjutant:HomeRightUnfoldRate(rate)
  self:__vCameraUnfoldRate(rate)
  if self.homeRightNode ~= nil then
    self.homeRightNode:UpdateHomeRightUnfoldRate(rate)
  end
end

function UIHomeMain:OnAdjutantCompleted()
  self:OnValueChange()
  if self.__playReturnHomeCv then
    self.__playReturnHomeCv = nil
    self.homeController:TryPlayVoReturnHome()
  end
end

function UIHomeMain:OnUpdateHome()
  if self.__couldUpdateList then
    self.passedTime = self.passedTime + Time.deltaTime
    if self.passedTime > self.costTime then
      self:SetIsUnfold(self.__isUnfold)
      return
    end
    if self.__isUnfold then
      self.ui.scrollRect_pageList.horizontalNormalizedPosition = self:__GetLerpedNum(self.currNPos, 1, self.passedTime / self.costTime)
    else
      self.ui.scrollRect_pageList.horizontalNormalizedPosition = self:__GetLerpedNum(self.currNPos, 0, self.passedTime / self.costTime)
    end
  end
end

function UIHomeMain:SetIsUnfold(bool, forceSetCamera)
  self.__isUnfold = bool
  if bool then
    self.ui.scrollRect_pageList.horizontalNormalizedPosition = 1
  else
    self.ui.scrollRect_pageList.horizontalNormalizedPosition = 0
    if forceSetCamera then
      self.fakeCameraHome.transform.position = self.__fakeCameraPos
    end
  end
  self.__couldUpdateList = false
  if self.__curVCBody ~= nil then
    self.__curVCBody.m_XDamping = 0.2
  end
  self.homeRightNode:OnHomeRightIsUnfold(bool)
  self:_fakeCameraConstraintParent(false)
end

function UIHomeMain:__vCameraUnfoldRate(rate)
  if self.__curVCBody ~= nil then
    self.__curVCBody.m_PathOffset = Vector3.New(-2 * rate * self.__flag, 0, 0)
    self.__curVCBody.m_XDamping = 0
  end
end

function UIHomeMain:__GetLerpedNum(sV, eV, rate)
  rate = rate - 1
  eV = eV - sV
  return eV * (rate * rate * rate * rate * rate + 1) + sV
end

function UIHomeMain:SwitchUnfold()
  if not self.fakeCameraHomeConstraint.constraintActive then
    self.fakeCameraHomeConstraint.constraintActive = true
  end
  self:_fakeCameraConstraintParent(true)
  self.__isUnfold = not self.__isUnfold
  self.__couldUpdateList = true
  self.currNPos = self.ui.scrollRect_pageList.horizontalNormalizedPosition
  self.passedTime = 0
  if self.__isUnfold then
    self.costTime = (1 - self.currNPos) * COST_TIME_RATE
    AudioManager:PlayAudioById(1086)
  else
    self.costTime = self.currNPos * COST_TIME_RATE
  end
  return self.__isUnfold
end

function UIHomeMain:__CheckFinger()
  if GuideManager.inGuide or self._isAutoMoving or self.__isUnfold then
    return false
  end
  if not self.homeController:IsNormalState() then
    return
  end
  if not self.gameObject.activeInHierarchy or self.ui.canvsGroup_root.alpha ~= 1 then
    return false
  end
  if PlayerDataCenter.allAdjCustomData:HasAdjPresetCount() == 1 then
    return false
  end
  return true
end

function UIHomeMain:__OnFingerDown(finger)
  if not self:__CheckFinger() then
    return
  end
  if self._chageCoroutine ~= nil then
    CS_coroutine.stop(self._chageCoroutine)
    self._chageCoroutine = nil
  end
  if finger.IsOverGui then
    local raycastResults = CS_LeanTouch.RaycastGui(finger.ScreenPosition)
    for i = 0, raycastResults.Count - 1 do
      local raycastResult = raycastResults[i]
      if raycastResult.gameObject.transform.parent ~= self.bind.heroHolder.transform then
        return
      end
    end
  end
  self._leanTouchIndex = finger.Index
  self._startScreenPos = finger.ScreenPosition
  self._startL2dOriPos = TransitionScreenPoint(UIManager:GetMainCamera(), self.bind.live2DRoot.gameObject, self._startScreenPos)
  self._startPicOriPos = TransitionScreenPoint(UIManager:GetMainCamera(), self.bind.heroHolder.gameObject, self._startScreenPos)
end

function UIHomeMain:__OnFingerUp(finger)
  if finger.Index ~= self._leanTouchIndex then
    return
  end
  self._leanTouchIndex = nil
  self._startL2dOriPos = nil
  self._startPicOriPos = nil
  if not self:__CheckFinger() then
    self._startScreenPos = nil
    self:__AdjHolderReset()
    return
  end
  local diffX = finger.ScreenPosition.x - self._startScreenPos.x
  self._startScreenPos = nil
  local selectAdjId
  local curAdjIndex = PlayerDataCenter.allAdjCustomData:GetUsingAdjCustomPresetId()
  if diffX > TOUCH_DIFF then
    for i = curAdjIndex - 1, 1, -1 do
      if PlayerDataCenter.allAdjCustomData:GetAdjCustomPresetData(i) ~= nil then
        selectAdjId = i
        break
      end
    end
    if selectAdjId == nil then
      for i = ConfigData.game_config.adjCustomTeamMax, curAdjIndex, -1 do
        if PlayerDataCenter.allAdjCustomData:GetAdjCustomPresetData(i) ~= nil then
          selectAdjId = i
          break
        end
      end
    end
  elseif diffX < -TOUCH_DIFF then
    for i = curAdjIndex + 1, ConfigData.game_config.adjCustomTeamMax do
      if PlayerDataCenter.allAdjCustomData:GetAdjCustomPresetData(i) ~= nil then
        selectAdjId = i
        break
      end
    end
    if selectAdjId == nil then
      for i = 1, curAdjIndex do
        if PlayerDataCenter.allAdjCustomData:GetAdjCustomPresetData(i) ~= nil then
          selectAdjId = i
          break
        end
      end
    end
  end
  if selectAdjId ~= nil then
    self._isAutoMoving = true
    local network = NetworkManager:GetNetwork(NetworkTypeID.AdjCustom)
    network:CS_MainInterface_PresetChange(selectAdjId, function()
      if IsNull(self.transform) then
        return
      end
      self.fakeCameraHomeConstraint.constraintActive = false
      self.fakeCameraHomeConstraintRotation.constraintActive = false
      self:__NewAdjChangeEnter(diffX < 0)
    end)
  end
end

function UIHomeMain:__OnFingerDrag(fingerList)
end

function UIHomeMain:__NewAdjChangeEnter(isMoveNextAdj)
  local ratio = isMoveNextAdj and 1 or -1
  if not self.homeController.homeCurrAdjutantLoaded then
    self.homeAdjutant:HideBordGirl()
    self._chageCoroutine = CS_coroutine.start(function()
      while not self.homeController.homeCurrAdjutantLoaded do
        coroutine.yield(nil)
      end
      self._chageCoroutine = nil
      self.bind.canvasGroup_heroHolder.alpha = 0
      local l2dvec = self.bind.live2DRoot.transform.localPosition
      l2dvec.x = ratio * L2D_ENTER_X
      self.bind.live2DRoot.transform.localPosition = l2dvec
      local picvec = self.bind.heroHolder.transform.localPosition
      picvec.x = ratio * PIC_ENTER_X
      self.bind.heroHolder.transform.localPosition = picvec
      self.homeAdjutant:ShowBordGirl()
      self:__AdjHolderReset()
    end)
  else
    self.bind.canvasGroup_heroHolder.alpha = 0
    local l2dvec = self.bind.live2DRoot.transform.localPosition
    l2dvec.x = ratio * L2D_ENTER_X
    self.bind.live2DRoot.transform.localPosition = l2dvec
    local picvec = self.bind.heroHolder.transform.localPosition
    picvec.x = ratio * PIC_ENTER_X
    self.bind.heroHolder.transform.localPosition = picvec
    self:__AdjHolderReset()
  end
end

function UIHomeMain:__AdjHolderReset()
  local curTime = Time.realtimeSinceStartup
  local l2dPosDiff = self._defaultL2dParentPos - self.bind.live2DRoot.transform.localPosition
  local picPosDiff = self._defaultPicParentPos - self.bind.heroHolder.transform.localPosition
  local alphaDiff = 1 - self.bind.canvasGroup_heroHolder.alpha
  self._chageCoroutine = CS_coroutine.start(function()
    while Time.realtimeSinceStartup < curTime + RESET_POS_TIME do
      local ratio = (Time.realtimeSinceStartup - curTime) / RESET_POS_TIME
      local addtionL2dPos = l2dPosDiff * (1 - ratio)
      local addtionPicPos = picPosDiff * (1 - ratio)
      local addtionAlpha = alphaDiff * (1 - ratio)
      self.bind.live2DRoot.transform.localPosition = self._defaultL2dParentPos - addtionL2dPos
      self.bind.heroHolder.transform.localPosition = self._defaultPicParentPos - addtionPicPos
      self.bind.canvasGroup_heroHolder.alpha = 1 - addtionAlpha
      coroutine.yield(nil)
    end
    self.bind.live2DRoot.transform.localPosition = self._defaultL2dParentPos
    self.bind.heroHolder.transform.localPosition = self._defaultPicParentPos
    self.bind.canvasGroup_heroHolder.alpha = 1
    self._isAutoMoving = false
    self._chageCoroutine = nil
    self.fakeCameraHomeConstraint.constraintActive = true
    self.fakeCameraHomeConstraintRotation.constraintActive = true
  end)
end

function UIHomeMain:_fakeCameraConstraintParent(enable)
  if IsNull(self.fakeCameraHome) then
    return
  end
  local targetTransform = enable and UIManager:GetMainCamera().transform or nil
  self.fakeCameraHome.transform:SetParent(targetTransform)
end

function UIHomeMain:GetHomeMainL2dParent()
  return self.bind.live2DRoot, self.bind.canvas_canvasGroup
end

function UIHomeMain:GetHomeMainPicParent()
  return self.bind.heroHolder
end

function UIHomeMain:OnHide()
  self.homeRightNode:OnHomeHide()
  self.homeController:OnHideHomeUI()
  self.ui.scrollRect_pageList.onValueChanged:RemoveListener(BindCallback(self, self.OnValueChange))
  base.OnHide(self)
end

function UIHomeMain:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnScreenSizeChanged, self.__OnScreenSizeChanged)
  MsgCenter:RemoveListener(eMsgEventId.AdjCustomModify, self.__RefreshHomeMainBgCallback)
  MsgCenter:RemoveListener(eMsgEventId.AdjCustomChange, self.__RefreshHomeMainBgCallback)
  CS_LeanTouch.OnFingerDown("-", self.__OnFingerDownCallback)
  CS_LeanTouch.OnFingerUp("-", self.__OnFingerUpCallback)
  if self._chageCoroutine ~= nil then
    CS_coroutine.stop(self._chageCoroutine)
    self._chageCoroutine = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.homeController:OnDeleteHomeUI()
  self:PauseEnterTimeLine()
  if self.homeUpNdoe ~= nil then
    self.homeUpNdoe:Delete()
  end
  if self.homeLeftNode ~= nil then
    self.homeLeftNode:Delete()
  end
  if self.homeRightNode ~= nil then
    self.homeRightNode:Delete()
  end
  if self.homeAdjutant ~= nil then
    self.homeAdjutant:Delete()
    self.homeAdjutant = nil
  end
  UpdateManager:RemoveUpdate(self.__OnUpdateHome)
  base.OnDelete(self)
end

return UIHomeMain
