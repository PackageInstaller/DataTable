local DatingEventCtrl = class("DatingEventCtrl", BaseCtrl)
DatingEventCtrl._mapNodeConfig = {
  imgBtnBg = {},
  btnSpeedUp = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SpeedUp"
  },
  imgSpeed1 = {},
  imgSpeed2 = {},
  imgAutoPlay1 = {},
  imgAutoPlay2 = {},
  btnSkip = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Skip"
  },
  btnAutoPlay = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AutoPlay"
  },
  goContent = {
    sNodeName = "Content",
    sComponentName = "RectTransform"
  },
  eventListSV = {sComponentName = "ScrollRect"},
  btnNextEvent = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_NextEvent"
  },
  goEventItem = {},
  goEventEndItem = {
    sComponentName = "RectTransform"
  },
  animEventEndItem = {
    sNodeName = "goEventEndItem",
    sComponentName = "Animator"
  },
  goEventSelectionItem = {},
  endItemLayoutElement = {
    sNodeName = "goEventEndItem",
    sComponentName = "LayoutElement"
  },
  txtEndTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dating_Event_End_Tip"
  },
  btnSend = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Send"
  },
  txtSendGift = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dating_Event_End_Send_Gift"
  },
  goSendGift = {},
  btnLeave = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Leave"
  },
  txtLeave = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Dating_Event_End_Leave"
  },
  rtImgTimeHour = {
    sNodeName = "imgTimeHour",
    sComponentName = "RectTransform"
  },
  rtImgTimeMin = {
    sNodeName = "imgTimeMin",
    sComponentName = "RectTransform"
  }
}
DatingEventCtrl._mapEventConfig = {
  DatingEventNext = "OnEvent_DatingEventNext"
}

function DatingEventCtrl:SetEventList(tbEvent, tbEventId)
  self:ReleaseSkipInputBlock()
  self.tbEventId = {}
  for i = 1, #tbEventId do
    table.insert(self.tbEventId, tbEventId[i])
  end
  self.tbEvent = {}
  for i = 1, #tbEvent do
    table.insert(self.tbEvent, tbEvent[i])
  end
  for _, v in ipairs(self.tbEvent) do
    local goItem, itemCtrl
    if v.tbOptions ~= nil then
      goItem = instantiate(self._mapNode.goEventSelectionItem, self._mapNode.goContent)
      if goItem ~= nil then
        itemCtrl = self:BindCtrlByNode(goItem, "Game.UI.Phone.Dating.DatingEventOptionItemCtrl")
      end
    else
      goItem = instantiate(self._mapNode.goEventItem, self._mapNode.goContent)
      if goItem ~= nil then
        itemCtrl = self:BindCtrlByNode(goItem, "Game.UI.Phone.Dating.DatingEventItemCtrl")
      end
    end
    if goItem ~= nil and itemCtrl ~= nil then
      goItem:SetActive(true)
      itemCtrl:InitItem(v)
      goItem:SetActive(false)
      table.insert(self.tbEventItemCtrl, itemCtrl)
    end
  end
  local listCount = 0
  
  local function foreachAffinityGift(mapData)
    local count = PlayerData.Item:GetItemCountByID(mapData.Id)
    if 0 < count then
      listCount = listCount + 1
    end
  end
  
  ForEachTableLine(DataTable.AffinityGift, foreachAffinityGift)
  self._mapNode.goSendGift.gameObject:SetActive(0 < listCount)
  self._mapNode.btnLeave[2].gameObject:SetActive(listCount == 0)
  NovaAPI.SetLayoutElementMinHeight(self._mapNode.endItemLayoutElement, 0 < listCount and 252 or 70)
  self.bSpeed = false
  self.bAuto = false
  self.bSkip = false
  self._mapNode.goEventEndItem.gameObject:SetActive(false)
  self._mapNode.imgSpeed1.gameObject:SetActive(not self.bSpeed)
  self._mapNode.imgSpeed2.gameObject:SetActive(self.bSpeed)
  self._mapNode.imgAutoPlay1.gameObject:SetActive(not self.bAuto)
  self._mapNode.imgAutoPlay2.gameObject:SetActive(self.bAuto)
  self.nCurIndex = 1
  if self.nEventId == nil then
    self.nEventId = 1
  end
  local eventData = self.tbEvent[self.nCurIndex]
  self.nEventIndex = 0
  self.nCurEventId = eventData.nEventId
  self.nLastEventId = self.nCurEventId
  self:StartEvent()
end

function DatingEventCtrl:AddEvent(tbEvent, tbEventId)
  for i = 1, #tbEventId do
    table.insert(self.tbEventId, tbEventId[i])
  end
  for i = 1, #tbEvent do
    table.insert(self.tbEvent, tbEvent[i])
  end
  for _, v in ipairs(tbEvent) do
    local goItem, itemCtrl
    if v.tbOptions ~= nil then
      goItem = instantiate(self._mapNode.goEventSelectionItem, self._mapNode.goContent)
      if goItem ~= nil then
        itemCtrl = self:BindCtrlByNode(goItem, "Game.UI.Phone.Dating.DatingEventOptionItemCtrl")
      end
    else
      goItem = instantiate(self._mapNode.goEventItem, self._mapNode.goContent)
      if goItem ~= nil then
        itemCtrl = self:BindCtrlByNode(goItem, "Game.UI.Phone.Dating.DatingEventItemCtrl")
      end
    end
    if goItem ~= nil and itemCtrl ~= nil then
      goItem:SetActive(true)
      itemCtrl:InitItem(v)
      goItem:SetActive(false)
      table.insert(self.tbEventItemCtrl, itemCtrl)
    end
  end
  local listCount = 0
  
  local function foreachAffinityGift(mapData)
    local count = PlayerData.Item:GetItemCountByID(mapData.Id)
    if 0 < count then
      listCount = listCount + 1
    end
  end
  
  ForEachTableLine(DataTable.AffinityGift, foreachAffinityGift)
  self._mapNode.goSendGift.gameObject:SetActive(0 < listCount)
  self._mapNode.btnLeave[2].gameObject:SetActive(listCount == 0)
  NovaAPI.SetLayoutElementMinHeight(self._mapNode.endItemLayoutElement, 0 < listCount and 252 or 70)
  if self.bSkip then
    self:OnBtnClick_Skip()
  else
    self.nCurIndex = self.nCurIndex + 1
    self:StartEvent()
  end
end

function DatingEventCtrl:StartEvent()
  local itemCtrl = self.tbEventItemCtrl[self.nCurIndex]
  if itemCtrl == nil then
    return
  end
  itemCtrl.gameObject:SetActive(true)
  self._mapNode.btnNextEvent.gameObject:SetActive(not itemCtrl:GetBranch() and not self.bSkip)
  local eventData = self.tbEvent[self.nEventId]
  self.nEventId = self.nEventId + 1
  if eventData.bLast then
    self.nLastEventId = eventData.nEventId
    self.nEventIndex = self.nEventIndex + 1
    self._mapNode.rtImgTimeMin:DOLocalRotate(Vector3(0, 0, -360), 1.2, RotateMode.FastBeyond360):SetUpdate(true)
    self._mapNode.rtImgTimeHour:DOLocalRotate(Vector3(0, 0, -self.nEventIndex / #self.tbEventId * 360), 1.2):SetUpdate(true)
    EventManager.Hit("DatingEventAction", self.nCurIndex, eventData.sResponse, eventData.nAffinity)
  end
  self.nCurEventId = eventData.nEventId
  
  local function wait()
    CS.UnityEngine.Canvas.ForceUpdateCanvases()
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.goContent)
    NovaAPI.SetVerticalNormalizedPosition(self._mapNode.eventListSV, 0)
    CS.UnityEngine.Canvas.ForceUpdateCanvases()
    coroutine.yield(nil)
    itemCtrl:StartEvent(self.bSpeed and 2 or 1, self.bAuto or self.bSkip)
  end
  
  cs_coroutine.start(wait)
end

function DatingEventCtrl:Awake()
  self.tbEventItemCtrl = {}
  self._mapNode.goEventItem.gameObject:SetActive(false)
  self._mapNode.rtImgTimeHour.localRotation = Quaternion.Euler(0, 0, 0)
end

function DatingEventCtrl:OnEnable()
  self._mapNode.imgAutoPlay1.gameObject:SetActive(true)
  self._mapNode.imgAutoPlay2.gameObject:SetActive(false)
end

function DatingEventCtrl:OnPreExit()
  self:ReleaseSkipInputBlock()
end

function DatingEventCtrl:OnDisable()
  self:ReleaseSkipInputBlock()
  for nInstanceId, objCtrl in pairs(self.tbEventItemCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbEventItemCtrl[nInstanceId] = nil
  end
end

function DatingEventCtrl:OnDestroy()
end

function DatingEventCtrl:OnBtnClick_SpeedUp()
  if self.tbEventItemCtrl[self.nCurIndex] ~= nil then
    self.bSpeed = not self.bSpeed
    self._mapNode.imgSpeed1.gameObject:SetActive(not self.bSpeed)
    self._mapNode.imgSpeed2.gameObject:SetActive(self.bSpeed)
    self.tbEventItemCtrl[self.nCurIndex]:ChangeSpeed(self.bSpeed and 2 or 1)
  end
end

function DatingEventCtrl:OnBtnClick_AutoPlay()
  self.bAuto = not self.bAuto
  if self.bAuto and self.nCurIndex <= #self.tbEvent then
    EventManager.Hit("DatingEventRefreshTip")
    EventManager.Hit("DatingEventNext")
  elseif not self.bAuto and self.tbEventItemCtrl[self.nCurIndex]:GetAuto() then
    self.tbEventItemCtrl[self.nCurIndex]:FinishImmediately(true)
  end
  self._mapNode.imgAutoPlay1.gameObject:SetActive(not self.bAuto)
  self._mapNode.imgAutoPlay2.gameObject:SetActive(self.bAuto)
end

function DatingEventCtrl:OnBtnClick_Skip()
  if self.nCurIndex <= #self.tbEventItemCtrl then
    if not self._bSkipInputBlocked then
      self._bSkipInputBlocked = true
      EventManager.Hit(EventId.BlockInput, true)
      self._objSkipInputTimeoutTimer = self:AddTimer(1, 10, function()
        printWarn("DatingEventCtrl: skip input block timed out")
        self:ReleaseSkipInputBlock()
      end, true, true, true)
    end
    self._bSkipLayoutReady = false
    self._bSkipEndAnimFinished = false
    self.bSkip = true
    self.tbEventItemCtrl[self.nCurIndex]:SkipTimer()
    for i = self.nCurIndex, #self.tbEventItemCtrl do
      self.tbEventItemCtrl[i].gameObject:SetActive(true)
      self.nCurIndex = self.nCurIndex + 1
    end
    self._mapNode.btnNextEvent.gameObject:SetActive(false)
    self.tbEventItemCtrl[#self.tbEventItemCtrl]:SkipTimer()
    local objSkipInputTimer = self._objSkipInputTimeoutTimer
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      if not self._bSkipInputBlocked or self._objSkipInputTimeoutTimer ~= objSkipInputTimer then
        return
      end
      CS.UnityEngine.Canvas.ForceUpdateCanvases()
      CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.goContent)
      NovaAPI.SetVerticalNormalizedPosition(self._mapNode.eventListSV, 0)
      self._bSkipLayoutReady = true
      self:TryReleaseSkipInputBlock()
    end
    
    cs_coroutine.start(wait)
    if self.tbEventId[#self.tbEventId].nType == GameEnum.DatingEventType.End then
      self._mapNode.goEventEndItem:SetParent(self._mapNode.goContent)
      self._mapNode.btnNextEvent.gameObject:SetActive(false)
      self._mapNode.goEventEndItem.gameObject:SetActive(true)
      EventManager.Hit("DatingEventFinish")
      if self._objSkipEndAnimTimer == nil then
        do
          local nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.animEventEndItem, {
            "DatingPanel_EventEndItem_in"
          })
          if 0 < nAnimLength then
            self._objSkipEndAnimTimer = self:AddTimer(1, nAnimLength, function()
              self._bSkipEndAnimFinished = true
              self:TryReleaseSkipInputBlock()
            end, true, true, true)
          end
        end
      end
    end
  end
end

function DatingEventCtrl:TryReleaseSkipInputBlock()
  if self._bSkipInputBlocked and self._bSkipLayoutReady and self._bSkipEndAnimFinished then
    self:ReleaseSkipInputBlock()
  end
end

function DatingEventCtrl:ReleaseSkipInputBlock()
  if self._objSkipEndAnimTimer ~= nil then
    self._objSkipEndAnimTimer:Cancel()
    self._objSkipEndAnimTimer = nil
  end
  if self._objSkipInputTimeoutTimer ~= nil then
    self._objSkipInputTimeoutTimer:Cancel()
    self._objSkipInputTimeoutTimer = nil
  end
  self._bSkipLayoutReady = false
  self._bSkipEndAnimFinished = false
  if self._bSkipInputBlocked then
    self._bSkipInputBlocked = false
    EventManager.Hit(EventId.BlockInput, false)
  end
end

function DatingEventCtrl:OnBtnClick_Send()
  EventManager.Hit("DatingSendGift")
end

function DatingEventCtrl:OnBtnClick_Leave()
  EventManager.Hit("CloseDatingPanel")
end

function DatingEventCtrl:OnBtnClick_NextEvent()
  if self.tbEventItemCtrl[self.nCurIndex]:GetAuto() then
    self.tbEventItemCtrl[self.nCurIndex]:FinishImmediately(false)
  else
    EventManager.Hit("DatingEventRefreshTip")
    EventManager.Hit("DatingEventNext")
  end
end

function DatingEventCtrl:OnEvent_DatingEventNext()
  if self.tbEventItemCtrl[self.nCurIndex]:GetAuto() then
    return
  end
  if self.bAuto and self.tbEventItemCtrl[self.nCurIndex]:GetBranch() then
    self.tbEventItemCtrl[self.nCurIndex]:SelectDefault()
    self.nCurIndex = self.nCurIndex + 1
    return
  end
  self.nCurIndex = self.nCurIndex + 1
  if self.nCurIndex > #self.tbEventItemCtrl then
    self._mapNode.rtImgTimeMin.localRotation = Quaternion.Euler(0, 0, -360)
    self._mapNode.rtImgTimeHour.localRotation = Quaternion.Euler(0, 0, -360)
    self._mapNode.goEventEndItem:SetParent(self._mapNode.goContent)
    self._mapNode.btnNextEvent.gameObject:SetActive(false)
    self._mapNode.goEventEndItem.gameObject:SetActive(true)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      NovaAPI.SetVerticalNormalizedPosition(self._mapNode.eventListSV, 0)
    end
    
    cs_coroutine.start(wait)
    EventManager.Hit("DatingEventFinish")
    return
  end
  self:StartEvent(self.bSpeed and 2 or 1, self.bAuto or self.bSkip)
end

return DatingEventCtrl
