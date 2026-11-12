local CustomerItemCtrl = class("CustomerItemCtrl", BaseCtrl)
local IceCreamUtils = require("Game.UI.Play_IceCreamTruck.Play.IceCreamUtils")
local TimerManager = require("GameCore.Timer.TimerManager")
local IceCreamTruckGameCtrl = require("Game.UI.Play_IceCreamTruck.Play.IceCreamTruckGameCtrl")
local enumQueueType = IceCreamUtils.EnumQueueType
local enumCustomerState = IceCreamUtils.EnumCustomerState
local SpineManager = require("Game.Spine.SpineManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local MOVE_TICK_INTERVAL = 0.02
local MOVE_BASE_PX_PER_SEC = 1
local LEAVE_PERFORM_MAP = {
  [enumCustomerState.happy] = enumCustomerState.happy_walk,
  [enumCustomerState.angry] = enumCustomerState.angry_walk
}
local FALLBACK_PERFORM_DURATION = 1.0
CustomerItemCtrl._mapNodeConfig = {
  Patience = {
    sComponentName = "RectTransform"
  },
  imgProgressBar = {sComponentName = "Image"},
  IconStar = {
    sComponentName = "RectTransform"
  },
  img_ProgressLock = {},
  img_ProgressBarLock = {},
  IceCreamOrder = {
    sCtrlName = "Game.UI.Play_IceCreamTruck.Play.IceCreamOrdersCtrl"
  },
  IceCreamOrderAnim = {
    sNodeName = "IceCreamOrder",
    sComponentName = "Animator"
  },
  imgIceCreamOrder = {
    sComponentName = "RectTransform"
  },
  Char = {},
  IceCreamIcon = {
    sComponentName = "RectTransform"
  },
  Icon_ = {nCount = 6, sComponentName = "Image"},
  CompleteRoot = {},
  CompleteRootAnimator = {
    sNodeName = "CompleteRoot",
    sComponentName = "Animator"
  },
  txt_BaseScore = {
    sNodeName = "txt_AddScore",
    sComponentName = "TMP_Text"
  },
  txt_X = {},
  txt_TimesScore = {
    sNodeName = "txt_TimesScore",
    sComponentName = "TMP_Text"
  }
}
CustomerItemCtrl._mapEventConfig = {
  Event_CustomerMoveTo = "CustomerMoveTo",
  Event_CustomerLeaveQueue = "CustomerLeaveQueue",
  Event_OrderMakeMistake = "Event_OrderMakeMistake",
  Event_CustomerTeleportTo = "CustomerTeleportTo",
  Event_FeverModeChanged = "FeverModeChanged",
  Event_IceCreamPatienceFreeze = "Event_IceCreamPatienceFreeze",
  Event_SetPause = "Event_Pause",
  Event_IceCreamSpeedScaleChanged = "Event_IceCreamSpeedScaleChanged"
}

function CustomerItemCtrl:Awake()
end

function CustomerItemCtrl:OnEnable()
  self.moveTimer = nil
  self.tbMoveCtx = nil
  self.fFeverFactor = self.fFeverFactor or 1
  self.fBuffFactor = self.fBuffFactor or 1
  self.nRemainSpeedBuff = self.nRemainSpeedBuff or 1
  self._bStartLeavingFired = false
  self:EnableIceIcon(false)
end

function CustomerItemCtrl:OnDisable()
  self:_TryFireStartLeavingOnInterrupt()
  self:KillUpDateTime()
  self:KillMoveTimer()
  self:_KillLeavePerformTimer()
  self:_KillScorePopupTimer()
  self:_KillOrderOutDoneTimer()
  self:ClearSpine()
  self.CurSpineObj = nil
end

function CustomerItemCtrl:OnDestroy()
  self:_TryFireStartLeavingOnInterrupt()
  self:KillUpDateTime()
  self:KillMoveTimer()
  self:_KillLeavePerformTimer()
  self:_KillScorePopupTimer()
  self:_KillOrderOutDoneTimer()
end

function CustomerItemCtrl:SetBlankData(recyclePoint, patienceValue)
  if not self._mapNode or not self._mapNode.imgIceCreamOrder then
    printError("初始化上层节点未绑定完毕")
    return
  end
  self.nCharacterId = nil
  self.nRoleId = nil
  self.nPoint = self.gameObject.transform.position
  if patienceValue then
    self.MaxPatienceValue = patienceValue
    self.PatienceValue = self.MaxPatienceValue
  end
  self.CustomerState = nil
  self.MoveSpeed = 5
  self.bGetOrder = false
  self.bIsSpecial = false
  self.nItemID = 0
  self.bInPatience = false
  self.bInFever = false
  self.bFreezePatience = false
  self.fFeverFactor = 1
  self.fBuffFactor = 1
  self.nRemainSpeedBuff = 1
  self._bStartLeavingFired = false
  if recyclePoint then
    self.RecyclePoint = recyclePoint
    local tr = self.gameObject:GetComponent("RectTransform")
    tr.position = self.RecyclePoint.position
  end
  self._bLeaving = false
  self:SetShowOrder(false)
  self:SetPatienceLockBuff(self.bFreezePatience)
  self:RefreshSpecialState()
end

function CustomerItemCtrl:ResetData()
  self:_TryFireStartLeavingOnInterrupt()
  self:KillMoveTimer()
  self:KillUpDateTime()
  self:_KillLeavePerformTimer()
  self:_KillScorePopupTimer()
  self:_KillOrderOutDoneTimer()
  self:ReverTrIceIcon()
  self:ClearSpine()
  self:SetBlankData()
  self._mapNode.CompleteRoot:SetActive(false)
end

function CustomerItemCtrl:SetActiveData(nInstId, nRoleId, bIsSpecial, nItemID, nMaxPatienceValue, nMaxScoop, tbUnlockSlot)
  self.nCharacterId = nInstId
  self.nRoleId = nRoleId
  self.bIsSpecial = bIsSpecial
  if self.bIsSpecial then
    self.nItemID = nItemID
    if self.nItemID == nil or self.nItemID == 0 then
      printError("丢失道具ID")
    end
  end
  self:CreatSpine(self.nRoleId)
  self:RefreshSpecialState()
  self.bGetOrder = self._mapNode.IceCreamOrder:SetNewOrder(self.nCharacterId, nMaxScoop, tbUnlockSlot, self.bIsSpecial)
  if not self.bGetOrder then
    printError("丢失订单")
  end
  self.MaxPatienceValue = nMaxPatienceValue
  self.PatienceValue = self.MaxPatienceValue
  self:CreatIceCreamIcon()
  self:_SyncGlobalRuntimeState()
end

function CustomerItemCtrl:_SyncGlobalRuntimeState()
  local gameCtrl = IceCreamTruckGameCtrl.GetInstance()
  if gameCtrl == nil then
    return
  end
  self:FeverModeChanged(gameCtrl.bInFever and true or false)
  self:Event_IceCreamSpeedScaleChanged(gameCtrl.fSpeedScale or 1)
  self:Event_IceCreamPatienceFreeze(gameCtrl.bFreezePatience and true or false)
end

function CustomerItemCtrl:CustomerMoveTo(QueuePoints)
  if self.nCharacterId == nil or QueuePoints.currentCustomerId == nil then
    return
  end
  if QueuePoints.currentCustomerId ~= self.nCharacterId then
    return
  end
  if QueuePoints.enumQueueTyp == enumQueueType.InQueue then
    self:SetStatusSwitch(enumCustomerState.walk)
    self:MoveToTargetPoint(QueuePoints.Point, function()
      self:SetStatusSwitch(enumCustomerState.idle)
      self:SetShowOrder(false)
    end)
  elseif QueuePoints.enumQueueTyp == enumQueueType.InMake then
    self:SetStatusSwitch(enumCustomerState.walk)
    self:MoveToTargetPoint(QueuePoints.Point, function()
      self:SetStatusSwitch(enumCustomerState.idle)
      self:SetShowOrder(true)
      self.bInPatience = true
      self:_StartPatienceTween()
      local gameCtrl = IceCreamTruckGameCtrl.GetInstance()
      if gameCtrl then
        gameCtrl:Event_CustomerReadyToServe(self)
      end
    end)
  end
end

function CustomerItemCtrl:PlayVoice(nState)
  local CustomerData = ConfigTable.GetData("IceCreamChar", self.nRoleId)
  if CustomerData == nil then
    printError("没有该角色信息：" .. self.nRoleId)
    return
  end
  local voiceEvent
  if nState == enumCustomerState.happy then
    voiceEvent = CustomerData.Voice_Happy
    WwiseAudioMgr:PostEvent("mode_400013_love")
  elseif nState == enumCustomerState.sad then
    voiceEvent = CustomerData.Voice_Sad
    WwiseAudioMgr:PostEvent("mode_400013_bad")
  elseif nState == enumCustomerState.angry then
    voiceEvent = CustomerData.Voice_Angry
    WwiseAudioMgr:PostEvent("mode_400013_angry")
  end
  if voiceEvent and voiceEvent ~= "" then
    WwiseAudioMgr:PlaySound(voiceEvent, WwiseAudioMgr.AkListener, true)
  end
end

function CustomerItemCtrl:CreatSpine(nId)
  if self.CurSpineObj then
    self:ClearSpine()
    self.CurSpineObj = nil
  end
  local nCurSpineObj = SpineManager.Create(nId, self._mapNode.Char.transform, PanelId.IceCreamTruckGamePanel)
  if not nCurSpineObj then
    printError("Spine对象创建失败：" .. nId)
    return
  end
  self.CurSpineObj = nCurSpineObj
end

function CustomerItemCtrl:SetStatusSwitch(eState, bLoop, sNextLoop)
  self.CustomerState = eState
  if not self.CurSpineObj then
    return
  end
  if bLoop == nil then
    bLoop = true
  end
  SpineManager.PlayAnim(self.CurSpineObj, eState, bLoop)
  if not bLoop and sNextLoop then
    SpineManager.AddAnim(self.CurSpineObj, sNextLoop, true, 0)
  end
  self:PlayVoice(eState)
end

function CustomerItemCtrl:ClearSpine()
  if self.CurSpineObj then
    SpineManager.Destroy(self.CurSpineObj)
    self.CurSpineObj = nil
  end
end

function CustomerItemCtrl:SetSpineSpeed()
  if self.CurSpineObj then
    SpineManager.SetTimeScale(self.CurSpineObj, self:_GetMoveScale())
    self.time = 0.37 / self:_GetMoveScale()
  end
end

function CustomerItemCtrl:MoveToTargetPoint(Point, callback)
  self:KillMoveTimer()
  local tr = self.gameObject:GetComponent("RectTransform")
  local fromWorld = tr.position
  local targetWorld = Point.position
  local cam
  local fromScreen = CS.UnityEngine.RectTransformUtility.WorldToScreenPoint(cam, fromWorld)
  local targetScreen = CS.UnityEngine.RectTransformUtility.WorldToScreenPoint(cam, targetWorld)
  local distPx = Vector2.Distance(fromScreen, targetScreen)
  if distPx < 0.01 then
    if callback then
      local nGen = IceCreamTruckGameCtrl.GetRestartGen()
      cs_coroutine.start(function()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        if nGen ~= IceCreamTruckGameCtrl.GetRestartGen() then
          return
        end
        callback()
      end)
    end
    return
  end
  self.tbMoveCtx = {
    trRect = tr,
    vStartWorld = fromWorld,
    vTargetWorld = targetWorld,
    fTotalPx = distPx,
    fTraveledPx = 0,
    fBasePxPerSec = self.MoveSpeed * MOVE_BASE_PX_PER_SEC,
    fnCallback = callback,
    nGen = IceCreamTruckGameCtrl.GetRestartGen()
  }
  self.moveTimer = self:AddTimer(0, MOVE_TICK_INTERVAL, "MoveTick", true, true, false)
  if self.moveTimer ~= nil then
    self.moveTimer:SetSpeed(self:_GetMoveScale())
    local gameCtrl = IceCreamTruckGameCtrl.GetInstance()
    if gameCtrl and gameCtrl.bIPause then
      self.moveTimer:Pause(true)
    end
  end
  return
end

function CustomerItemCtrl:CustomerTeleportTo(nCustomerId, SpawnPoint)
  if self.nCharacterId == nil or nCustomerId == nil then
    return
  end
  if nCustomerId ~= self.nCharacterId then
    return
  end
  self:KillMoveTimer()
  local tr = self.gameObject:GetComponent("RectTransform")
  tr.position = SpawnPoint.position
end

function CustomerItemCtrl:MoveTick()
  local ctx = self.tbMoveCtx
  if ctx == nil or self.nCharacterId == nil then
    self:KillMoveTimer()
    return
  end
  if ctx.nGen ~= IceCreamTruckGameCtrl.GetRestartGen() then
    self:KillMoveTimer()
    return
  end
  local dPx = ctx.fBasePxPerSec * MOVE_TICK_INTERVAL
  ctx.fTraveledPx = ctx.fTraveledPx + dPx
  local t = ctx.fTraveledPx / ctx.fTotalPx
  if 1 <= t then
    ctx.trRect.position = ctx.vTargetWorld
    local fn = ctx.fnCallback
    self:KillMoveTimer()
    if fn then
      fn()
    end
    return
  end
  ctx.trRect.position = CS.UnityEngine.Vector3.Lerp(ctx.vStartWorld, ctx.vTargetWorld, t)
end

function CustomerItemCtrl:KillMoveTimer()
  if self.moveTimer ~= nil then
    TimerManager.Remove(self.moveTimer)
    self.moveTimer = nil
  end
  self.tbMoveCtx = nil
end

function CustomerItemCtrl:KillUpDateTime()
  if self.remainTimer ~= nil then
    TimerManager.Remove(self.remainTimer)
    self.remainTimer = nil
  end
  self:_KillPatienceTween()
end

function CustomerItemCtrl:_StartPatienceTween()
  self:_KillPatienceTween()
  local img = self._mapNode and self._mapNode.imgProgressBar
  if img == nil then
    return
  end
  local nMax = self.MaxPatienceValue
  if nMax == nil or nMax <= 0 then
    return
  end
  local nCur = math.max(0, math.min(self.PatienceValue or 0, nMax))
  self.PatienceValue = nCur
  NovaAPI.SetImageFillAmount(img, nCur / nMax)
  if nCur <= 0 then
    if self.bIsSpecial then
      EventManager.Hit("Event_SpecialPGLeave", self.nCharacterId)
    else
      EventManager.Hit("Event_CustomerLeave_False", self.nCharacterId)
    end
    return
  end
  local fDur = nCur
  self._nPatienceGen = IceCreamTruckGameCtrl.GetRestartGen()
  local nGen = self._nPatienceGen
  local nCharId = self.nCharacterId
  self._patienceTweener = DOTween.To(function()
    return img.fillAmount
  end, function(v)
    img.fillAmount = v
  end, 0, fDur)
  if self._patienceTweener == nil then
    return
  end
  self._patienceTweener:SetEase(CS.DG.Tweening.Ease.Linear)
  self._patienceTweener:OnComplete(function()
    if nGen ~= IceCreamTruckGameCtrl.GetRestartGen() then
      return
    end
    if self.nCharacterId == nil or self.nCharacterId ~= nCharId then
      return
    end
    if self._patienceTweener == nil then
      return
    end
    self._patienceTweener = nil
    self.PatienceValue = 0
    if self.bIsSpecial then
      EventManager.Hit("Event_SpecialPGLeave", self.nCharacterId)
    else
      EventManager.Hit("Event_CustomerLeave_False", self.nCharacterId)
    end
  end)
  if self.bInFever or self.bFreezePatience then
    self._patienceTweener:Pause()
  else
    local gameCtrl = IceCreamTruckGameCtrl.GetInstance()
    if gameCtrl and gameCtrl.bIPause then
      self._patienceTweener:Pause()
    end
  end
  self:_ApplyPatienceTweenScale()
end

function CustomerItemCtrl:_SnapshotPatienceFromImage()
  local img = self._mapNode and self._mapNode.imgProgressBar
  local nMax = self.MaxPatienceValue
  if img == nil or nMax == nil or nMax <= 0 then
    return
  end
  local fFill = img.fillAmount or 0
  if fFill < 0 then
    fFill = 0
  elseif 1 < fFill then
    fFill = 1
  end
  self.PatienceValue = math.max(0, math.min(nMax, fFill * nMax))
end

function CustomerItemCtrl:_ApplyPatienceTweenScale()
  if self._patienceTweener == nil then
    return
  end
  local fScale = self.fBuffFactor or 1
  if fScale <= 0 then
    fScale = 1
  end
  self._patienceTweener.timeScale = fScale
end

function CustomerItemCtrl:_KillPatienceTween()
  if self._patienceTweener ~= nil then
    self._patienceTweener:Kill()
    self._patienceTweener = nil
  end
  self._nPatienceGen = nil
end

function CustomerItemCtrl:RefreshSpecialState()
  local canvasGroup = self._mapNode.IconStar:GetComponent("CanvasGroup")
  NovaAPI.SetCanvasGroupAlpha(canvasGroup, self.bIsSpecial and 1 or 0)
end

function CustomerItemCtrl:SetShowOrder(bShow)
  if bShow then
    self._mapNode.IceCreamOrderAnim:Play("IceCreamOrder_in")
    WwiseAudioMgr:PostEvent("mode_400013_pop")
    self._mapNode.CompleteRoot:SetActive(false)
    self._bPendingOrderOut = false
    self._bScorePopupPlaying = false
  elseif self._bScorePopupPlaying then
    self._bPendingOrderOut = true
  else
    self:_PlayOrderOutNow()
  end
  local canvasOrder = self._mapNode.imgIceCreamOrder:GetComponent("CanvasGroup")
  NovaAPI.SetCanvasGroupAlpha(canvasOrder, bShow and 1 or 0)
  local canvasPatience = self._mapNode.Patience:GetComponent("CanvasGroup")
  NovaAPI.SetCanvasGroupAlpha(canvasPatience, bShow and 1 or 0)
end

function CustomerItemCtrl:_PlayOrderOutNow()
  self._bPendingOrderOut = false
  self._mapNode.IceCreamOrderAnim:Play("IceCreamOrder_out")
  if self._fnOrderOutDone == nil then
    return
  end
  local nDur = NovaAPI.GetAnimClipLength(self._mapNode.IceCreamOrderAnim, {
    "IceCreamOrder_out"
  })
  if type(nDur) ~= "number" or nDur <= 0 then
    nDur = 0.5
  end
  if self.orderOutDoneTimer ~= nil then
    TimerManager.Remove(self.orderOutDoneTimer)
    self.orderOutDoneTimer = nil
  end
  self.orderOutDoneTimer = self:AddTimer(1, nDur, "_OnOrderOutDone", true, true)
end

function CustomerItemCtrl:_OnOrderOutDone()
  self.orderOutDoneTimer = nil
  local fn = self._fnOrderOutDone
  self._fnOrderOutDone = nil
  if fn then
    fn()
  end
end

function CustomerItemCtrl:SetOnOrderOutDone(fnDone)
  self._fnOrderOutDone = fnDone
end

function CustomerItemCtrl:_KillOrderOutDoneTimer()
  if self.orderOutDoneTimer ~= nil then
    TimerManager.Remove(self.orderOutDoneTimer)
    self.orderOutDoneTimer = nil
  end
  self._fnOrderOutDone = nil
end

function CustomerItemCtrl:MoveTrIceIcon()
  local trParent = self.CurSpineObj.transform:Find("Skeleton/hand_right")
  if not trParent then
    return
  end
  local trIcon = self._mapNode.IceCreamIcon.transform
  trIcon:SetParent(trParent, false)
  trIcon.localPosition = Vector3.zero
  trIcon.localRotation = Quaternion.identity
  trIcon.localScale = Vector3.one
  local rt = trIcon:GetComponent("RectTransform")
  if rt then
    rt.anchoredPosition3D = Vector3.zero
    rt.sizeDelta = rt.sizeDelta
  end
  self._mapNode.IceCreamIcon:SetParent(trParent)
  self.time = 0.37 / self:_GetMoveScale()
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.time))
    self:EnableIceIcon(true)
  end
  
  cs_coroutine.start(wait)
end

function CustomerItemCtrl:CreatIceCreamIcon()
  for _, txt in ipairs(self._mapNode.Icon_) do
    local canvasGroup = txt:GetComponent("CanvasGroup")
    NovaAPI.SetCanvasGroupAlpha(canvasGroup, 0)
  end
  if self.bGetOrder then
    local tbSlots = self._mapNode.IceCreamOrder:GetSlots()
    if tbSlots == nil then
      return
    end
    for step, v in ipairs(tbSlots) do
      if v ~= 0 then
        local nDisplay = self._mapNode.IceCreamOrder:GetDisplayIndex(step)
        if nDisplay ~= nil then
          local IconPath = IceCreamUtils.SetCondimentIcon(step, v)
          if IconPath == "" then
            printError("资源路径是空的")
            NovaAPI.SetCanvasGroupAlpha(self._mapNode.Icon_[nDisplay]:GetComponent("CanvasGroup"), 0)
          else
            self:SetActivityAtlasSprite_New(self._mapNode.Icon_[nDisplay], "_400013/SpriteAtlas/Item", IconPath)
            NovaAPI.SetCanvasGroupAlpha(self._mapNode.Icon_[nDisplay]:GetComponent("CanvasGroup"), 1)
          end
        end
      end
    end
  end
end

function CustomerItemCtrl:EnableIceIcon(bShow)
  self._mapNode.IceCreamIcon.gameObject:SetActive(bShow)
end

function CustomerItemCtrl:ReverTrIceIcon()
  self._mapNode.IceCreamIcon:SetParent(self._mapNode.Char.transform)
  self:EnableIceIcon(false)
end

function CustomerItemCtrl:RefreshPatienceList()
  local img = self._mapNode and self._mapNode.imgProgressBar
  if img == nil then
    return
  end
  local nMax = self.MaxPatienceValue
  local nCur = math.max(0, self.PatienceValue or 0)
  if nMax == nil or nMax <= 0 then
    nMax = 0 < nCur and nCur or 1
  end
  if nCur > nMax then
    nCur = nMax
  end
  NovaAPI.SetImageFillAmount(img, nCur / nMax)
end

function CustomerItemCtrl:SetPatienceLockBuff(bShow)
  self._mapNode.img_ProgressLock:SetActive(bShow)
  self._mapNode.img_ProgressBarLock:SetActive(bShow)
end

function CustomerItemCtrl:CustomerLeaveQueue(nCustomerId, bSucceed)
  if self.nCharacterId == nil or nCustomerId == nil then
    return
  end
  if nCustomerId ~= self.nCharacterId then
    return
  end
  if self._bLeaving then
    return
  end
  self._bLeaving = true
  self._bStartLeavingFired = false
  self.bInPatience = false
  self:SetShowOrder(false)
  TimerManager.Remove(self.remainTimer)
  self.remainTimer = nil
  self:_KillPatienceTween()
  local ePerform
  if bSucceed then
    ePerform = enumCustomerState.happy
    if self.bIsSpecial and self.nItemID ~= 0 then
      EventManager.Hit("Event_GetNewItem", self.nItemID)
    end
    self:MoveTrIceIcon()
  else
    ePerform = enumCustomerState.angry
  end
  self:SetStatusSwitch(ePerform, false)
  local eWalk = LEAVE_PERFORM_MAP[ePerform]
  local nGen = IceCreamTruckGameCtrl.GetRestartGen()
  local fDur = SpineManager.GetAnimDuration(self.CurSpineObj, ePerform)
  if fDur == nil or fDur <= 0 then
    fDur = FALLBACK_PERFORM_DURATION
  end
  self:_StartLeavePerformDelay(fDur, nGen, function()
    if nGen ~= IceCreamTruckGameCtrl.GetRestartGen() then
      return
    end
    if self.nCharacterId == nil then
      return
    end
    self:_FireStartLeavingOnce()
    if eWalk then
      self:SetStatusSwitch(eWalk, true)
    end
    self:MoveToTargetPoint(self.RecyclePoint, function()
      EventManager.Hit("Event_ReturnCustomer", self.nCharacterId)
    end)
  end)
end

function CustomerItemCtrl:_FireStartLeavingOnce()
  if self._bStartLeavingFired then
    return
  end
  self._bStartLeavingFired = true
  EventManager.Hit("Event_FirstCustomerStartLeaving", self.nCharacterId)
end

function CustomerItemCtrl:_StartLeavePerformDelay(fDuration, nGen, fnDone)
  self:_KillLeavePerformTimer()
  self.tbLeavePerformCtx = {nGen = nGen, fnDone = fnDone}
  self.leavePerformTimer = self:AddTimer(1, fDuration, "_OnLeavePerformDone", true, true, false)
  if self.leavePerformTimer ~= nil then
    self.leavePerformTimer:SetSpeed(self:_GetMoveScale())
    local gameCtrl = IceCreamTruckGameCtrl.GetInstance()
    if gameCtrl and gameCtrl.bIPause then
      self.leavePerformTimer:Pause(true)
    end
  end
end

function CustomerItemCtrl:_OnLeavePerformDone()
  local ctx = self.tbLeavePerformCtx
  self:_KillLeavePerformTimer()
  if ctx == nil then
    return
  end
  if ctx.nGen ~= IceCreamTruckGameCtrl.GetRestartGen() then
    return
  end
  if ctx.fnDone then
    ctx.fnDone()
  end
end

function CustomerItemCtrl:_KillLeavePerformTimer()
  if self.leavePerformTimer ~= nil then
    TimerManager.Remove(self.leavePerformTimer)
    self.leavePerformTimer = nil
  end
  self.tbLeavePerformCtx = nil
end

function CustomerItemCtrl:_TryFireStartLeavingOnInterrupt()
  if self._bLeaving and not self._bStartLeavingFired then
    self:_FireStartLeavingOnce()
  end
end

function CustomerItemCtrl:GetOrdersCtrl()
  return self._mapNode.IceCreamOrder
end

function CustomerItemCtrl:GetCustomerId()
  return self.nCharacterId
end

function CustomerItemCtrl:IsSpecial()
  return self.bIsSpecial
end

function CustomerItemCtrl:IsReadyToServe()
  return self.bInPatience == true
end

function CustomerItemCtrl:ShowCompleteRoot(BaseScore, FComboMul, FeverMul, FBuffMul)
  self._mapNode.CompleteRoot:SetActive(true)
  local nBaseScore = BaseScore * FeverMul
  local sBaseScore = string.format("+%d", nBaseScore)
  local nBuffMul = FComboMul * FBuffMul
  NovaAPI.SetTMPText(self._mapNode.txt_BaseScore, sBaseScore)
  NovaAPI.SetTMPText(self._mapNode.txt_TimesScore, string.format("%.1f", nBuffMul))
  self._mapNode.txt_BaseScore.gameObject:SetActive(not self.bIsSpecial)
  self._mapNode.txt_TimesScore.gameObject:SetActive(not self.bIsSpecial)
  self._mapNode.txt_X.gameObject:SetActive(not self.bIsSpecial)
  local sKey = "CompleteRoot_in1"
  if 1 <= nBuffMul and nBuffMul < 1.2 then
    sKey = "CompleteRoot_in1"
  elseif 1.2 <= nBuffMul and nBuffMul <= 1.5 then
    sKey = "CompleteRoot_in1_2"
  elseif 1.5 < nBuffMul and nBuffMul <= 2.5 then
    sKey = "CompleteRoot_in1_5"
  elseif 3 <= nBuffMul then
    sKey = "CompleteRoot_in2"
  end
  self._mapNode.CompleteRootAnimator:Play(sKey)
  WwiseAudioMgr:PostEvent("mode_400013_goal")
  if 1.2 <= nBuffMul then
    WwiseAudioMgr:PostEvent("mode_400013_goal_ex")
  end
  self._bScorePopupPlaying = true
  local nDur = NovaAPI.GetAnimClipLength(self._mapNode.CompleteRootAnimator, {sKey})
  if type(nDur) ~= "number" or nDur <= 0 then
    nDur = 1.0
  end
  if self.scorePopupTimer ~= nil then
    TimerManager.Remove(self.scorePopupTimer)
    self.scorePopupTimer = nil
  end
  self.scorePopupTimer = self:AddTimer(1, nDur, "_OnScorePopupDone", true, true)
end

function CustomerItemCtrl:_OnScorePopupDone()
  self.scorePopupTimer = nil
  self._bScorePopupPlaying = false
  if self._bPendingOrderOut then
    self:_PlayOrderOutNow()
  end
end

function CustomerItemCtrl:_KillScorePopupTimer()
  if self.scorePopupTimer ~= nil then
    TimerManager.Remove(self.scorePopupTimer)
    self.scorePopupTimer = nil
  end
  self._bScorePopupPlaying = false
  self._bPendingOrderOut = false
end

function CustomerItemCtrl:Event_OrderMakeMistake(nCustomerId)
  if self.nCharacterId == nil or nCustomerId == nil then
    return
  end
  if nCustomerId ~= self.nCharacterId then
    return
  end
  self:SetStatusSwitch(enumCustomerState.sad, false, enumCustomerState.idle)
end

function CustomerItemCtrl:Event_Pause(bPause)
  if self.remainTimer ~= nil then
    self.remainTimer:Pause(bPause)
  end
  if self._patienceTweener ~= nil then
    if bPause then
      self:_SnapshotPatienceFromImage()
      self._patienceTweener:Pause()
    elseif not self.bInFever and not self.bFreezePatience then
      self._patienceTweener:Play()
    end
  end
  if self.moveTimer ~= nil then
    self.moveTimer:Pause(bPause)
  end
  if self.leavePerformTimer ~= nil then
    self.leavePerformTimer:Pause(bPause)
  end
  if self.scorePopupTimer ~= nil then
    self.scorePopupTimer:Pause(bPause)
  end
  if self.orderOutDoneTimer ~= nil then
    self.orderOutDoneTimer:Pause(bPause)
  end
  if self.CurSpineObj then
    if bPause then
      SpineManager.Pause(self.CurSpineObj)
    else
      SpineManager.Resume(self.CurSpineObj)
    end
  end
end

function CustomerItemCtrl:_GetMoveScale()
  return (self.fFeverFactor or 1) * (self.fBuffFactor or 1)
end

function CustomerItemCtrl:FeverModeChanged(bInFever)
  self.bInFever = bInFever
  self.fFeverFactor = bInFever and 2 or 1
  self:RecalcSpeedBuff()
  self:_ApplyPatienceGating()
end

function CustomerItemCtrl:Event_IceCreamPatienceFreeze(bFreeze)
  self.bFreezePatience = bFreeze and true or false
  self:SetPatienceLockBuff(self.bFreezePatience)
  self:_ApplyPatienceGating()
end

function CustomerItemCtrl:_ApplyPatienceGating()
  if self._patienceTweener == nil then
    return
  end
  local gameCtrl = IceCreamTruckGameCtrl.GetInstance()
  local bGlobalPause = gameCtrl and gameCtrl.bIPause
  if self.bInFever or self.bFreezePatience or bGlobalPause then
    self:_SnapshotPatienceFromImage()
    self._patienceTweener:Pause()
  else
    self._patienceTweener:Play()
  end
end

function CustomerItemCtrl:RecalcSpeedBuff()
  self.nRemainSpeedBuff = self.fBuffFactor or 1
  if self.remainTimer ~= nil then
    self.remainTimer:SetSpeed(self.nRemainSpeedBuff)
  end
  self:_ApplyPatienceTweenScale()
  if self.moveTimer ~= nil then
    self.moveTimer:SetSpeed(self:_GetMoveScale())
  end
  if self.leavePerformTimer ~= nil then
    self.leavePerformTimer:SetSpeed(self:_GetMoveScale())
  end
  self:SetSpineSpeed()
end

function CustomerItemCtrl:Event_IceCreamSpeedScaleChanged(fBuffScale_Speed)
  self.fBuffFactor = fBuffScale_Speed
  self:RecalcSpeedBuff()
end

function CustomerItemCtrl:RefillPatienceToMax()
  self.PatienceValue = self.MaxPatienceValue or self.PatienceValue
  if self.bInPatience then
    self:_StartPatienceTween()
  else
    self:RefreshPatienceList()
  end
end

function CustomerItemCtrl:AddPatienceVal(nPatienceVal)
  self:_SnapshotPatienceFromImage()
  if 0 <= nPatienceVal then
    self.PatienceValue = math.min(self.PatienceValue + nPatienceVal, self.MaxPatienceValue)
  else
    self.PatienceValue = math.max(self.PatienceValue + nPatienceVal, 0)
  end
  if self.bInPatience then
    self:_StartPatienceTween()
  else
    self:RefreshPatienceList()
  end
  local sTip = string.format("当前顾客耐心值：%d", self.PatienceValue)
  EventManager.Hit(EventId.OpenMessageBox, sTip)
end

function CustomerItemCtrl:RefreshCurrentCustomer(CustomerId)
  self:ClearSpine()
  self:CreatSpine(CustomerId)
end

return CustomerItemCtrl
