_class("AircraftInteractivePoolManager", Object)
AircraftInteractivePoolManager = AircraftInteractivePoolManager

function AircraftInteractivePoolManager:Constructor(aircraftMain)
  self._main = aircraftMain
end

function AircraftInteractivePoolManager:Init()
  local canvasRoot = UnityEngine.GameObject.Find("LogicRoot")
  local AircraftTalkCanvas = canvasRoot.transform:Find("AircraftRoot/AircraftTalkCanvas")
  local bubbleEffName = Cfg.cfg_aircraft_const.bubbleEffName.StrValue
  local texGos = {}
  local bubbleReqs = {}
  self._aircraftTexPool = AircraftInteractiveTexPool:New()
  local maxCount = self._aircraftTexPool:GetMaxCount()
  for i = 1, maxCount do
    local texTr = AircraftTalkCanvas:GetChild(i - 1)
    local texGo = texTr.gameObject
    local bubbleReq = ResourceManager:GetInstance():SyncLoadAsset(bubbleEffName, LoadType.GameObject)
    table.insert(texGos, texGo)
    table.insert(bubbleReqs, bubbleReq)
  end
  self._aircraftTexPool:Init(texGos, bubbleReqs)
end

function AircraftInteractivePoolManager:SetClickTexActive(active)
  local showTable = self._aircraftTexPool:GetAllShowItem()
  if showTable and table.count(showTable) > 0 then
    for key, value in pairs(showTable) do
      if not value._isClosing then
        value:SetTexActive(not active)
      end
    end
  end
end

function AircraftInteractivePoolManager:DequeueTexItem()
  local item = self._aircraftTexPool:Dequeue()
  return item
end

function AircraftInteractivePoolManager:EnqueueTexItem(item)
  self._aircraftTexPool:Enqueue(item)
end

function AircraftInteractivePoolManager:Update(dms)
  if self._aircraftTexPool then
    self._aircraftTexPool:Update()
  end
end

function AircraftInteractivePoolManager:Dispose()
  if self._aircraftTexPool then
    self._aircraftTexPool:Dispose()
  end
end

_class("AircraftInteractiveTexPool", Object)
AircraftInteractiveTexPool = AircraftInteractiveTexPool

function AircraftInteractiveTexPool:Constructor()
  self._closeTable = {}
  self._showTable = {}
  self._animTable = {}
  self._removeList = {}
  self._maxCount = 10
  self._animTime = 600
  self._running = true
end

function AircraftInteractiveTexPool:GetAllShowItem()
  return self._showTable
end

function AircraftInteractiveTexPool:GetMaxCount()
  return self._maxCount
end

function AircraftInteractiveTexPool:Init(texGos, bubbleGos)
  for i = 1, self._maxCount do
    local texGo = texGos[i]
    local scale = texGo.transform:Find("anim/scale")
    local layoutGo = texGo.transform:Find("anim/scale/layout").gameObject
    local layout = layoutGo:GetComponent("VerticalLayoutGroup")
    local filter = layoutGo:GetComponent("ContentSizeFitter")
    local layoutRect = layoutGo:GetComponent("RectTransform")
    local texUIGo = texGo.transform:Find("anim/scale/layout/AircraftTalkText").gameObject
    local texRect = texUIGo:GetComponent("RectTransform")
    local texUI = texUIGo:GetComponent("UILocalizationText")
    local bubbleGo = bubbleGos[i]
    local item = AircraftInteractiveTexItem:New()
    item:SetGo(i, texGo, layout, filter, scale, layoutRect, texRect, texUI, bubbleGo)
    self:Enqueue(item, true)
  end
end

function AircraftInteractiveTexPool:Dequeue()
  Log.debug("###[AircraftInteractiveTexPool] 借用一个文本")
  if self._showTable and self._closeTable then
    local showCount = table.count(self._showTable)
    local closeCount = table.count(self._closeTable)
    Log.debug("###[AircraftInteractiveTexPool] showCount:", showCount)
    Log.debug("###[AircraftInteractiveTexPool] closeCount:", closeCount)
    if table.count(self._closeTable) > 0 then
      local item = self._closeTable[1]
      table.remove(self._closeTable, 1)
      table.insert(self._showTable, item)
      Log.debug("###[AircraftInteractiveTexPool] Get a New Item ! index --> ", item._index)
      return item
    else
      Log.error("###[AircraftInteractiveTexPool] Dequeue --> close table count <= 0 !")
    end
  end
end

function AircraftInteractiveTexPool:Update(dms)
  if not self._running then
    return
  end
  if self._animTable and #self._animTable > 0 then
    for i = 1, #self._animTable do
      local timeItem = self._animTable[i]
      timeItem.time = timeItem.time + dms
      if timeItem.time >= self._animTime then
        table.insert(self._removeList, i)
      end
    end
  end
  if self._removeList and 0 < #self._removeList then
    for i = 1, #self._removeList do
      local idx = self._removeList[i]
      local timeItem = self._animTable[idx]
      local item = timeItem.item
      table.remove(self._animTable, idx)
      self:_EnqueueTable(item)
    end
    table.clear(self._removeList)
  end
end

function AircraftInteractiveTexPool:_EnqueueAnimTable(item)
  local timeItem = {}
  timeItem.item = item
  timeItem.time = 0
  self._animTable[#self._animTable + 1] = timeItem
end

function AircraftInteractiveTexPool:_EnqueueTable(item)
  Log.debug("###[AircraftInteractiveTexPool] 归还一个文本")
  if self._showTable and self._closeTable then
    local showCount = table.count(self._showTable)
    local closeCount = table.count(self._closeTable)
    Log.debug("###[AircraftInteractiveTexPool] showCount:", showCount)
    Log.debug("###[AircraftInteractiveTexPool] closeCount:", closeCount)
    if table.count(self._showTable) > 0 then
      for i = 1, #self._showTable do
        if self._showTable[i]._index == item._index then
          Log.debug("###[AircraftInteractiveTexPool] show 2 close ! index --> ", item._index)
          item:Reset()
          table.insert(self._closeTable, item)
          table.remove(self._showTable, i)
          return
        end
      end
    else
      Log.debug("###[AircraftInteractiveTexPool] out 2 close ! index --> ", item._index)
      table.insert(self._closeTable, item)
    end
  end
end

function AircraftInteractiveTexPool:Enqueue(item, init)
  self:_EnqueueTable(item)
end

function AircraftInteractiveTexPool:Dispose()
  self._running = false
  if table.count(self._closeTable) > 0 then
    for key, value in pairs(self._closeTable) do
      value:Dispose()
    end
  end
  if 0 < table.count(self._showTable) then
    for key, value in pairs(self._showTable) do
      value:Dispose()
    end
  end
  self._closeTable = nil
  self._showTable = nil
  self._maxCount = 0
end

_class("AircraftInteractiveTexItem", Object)
AircraftInteractiveTexItem = AircraftInteractiveTexItem

function AircraftInteractiveTexItem:Constructor()
  self._texGo = nil
  self._bubbleGo = nil
  self._texUI = nil
  self._layout = nil
  self._filter = nil
  self._layoutRect = nil
  self._texRect = nil
  self._index = 0
  local posOffset = Cfg.cfg_aircraft_const.AircraftTalkTexPosOffset.ArrayValue
  if posOffset == nil then
    Log.error("###cfg_aircraft_const[AircraftTalkTexPosOffset] is nil !")
  end
  self._talkTextPosOffset = Vector3(posOffset[1], posOffset[2], posOffset[3])
  self._talkBubblePosOffset = Vector3(posOffset[1] - 0.42, posOffset[2] - 0.87, posOffset[3])
  self._selfMsgWidth = 544
end

function AircraftInteractiveTexItem:Reset()
  if self._texGo then
    self._texGo:SetActive(false)
    self._texGo.transform.position = Vector3(0, 0, 0)
  end
  if self._bubbleGo then
    self._bubbleGo:SetActive(false)
    self._bubbleGo.transform.position = Vector3(0, 0, 0)
  end
  if self._texUI then
    self._texUI:SetText("")
  end
end

function AircraftInteractiveTexItem:SetGo(idx, texGo, layout, filter, scale, layoutRect, texRect, texUI, bubbleReq)
  self._index = idx
  self._texGo = texGo
  self._scale = scale
  self._layout = layout
  self._filter = filter
  self._layoutRect = layoutRect
  self._bgImg = self._layoutRect:GetChild(0).gameObject:GetComponent("Image")
  self._texRect = texRect
  self._texGo = texGo
  self._texUI = texUI
  self._bubbleReq = bubbleReq
  self._bubbleGo = self._bubbleReq.Obj
  self._bubbleGo:GetComponent("Animation").enabled = false
  self._anim = self._texGo:GetComponent("Animation")
end

function AircraftInteractiveTexItem:_SetText(tex)
  self._texUI:SetText(tex)
  self._filter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize
  self._layout.childControlWidth = true
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._layoutRect)
  if self._texUI.preferredWidth > self._selfMsgWidth then
    self._filter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.Unconstrained
    self._layout.childControlWidth = false
    self._layoutRect.sizeDelta = Vector2(self._selfMsgWidth, self._layoutRect.sizeDelta.y)
    self._texRect.sizeDelta = Vector2(self._selfMsgWidth, self._texRect.sizeDelta.y)
  else
    self._filter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize
    self._layout.childControlWidth = true
  end
end

function AircraftInteractiveTexItem:SetScale(scale)
  local layoutScale = scale
  self._scale.transform.localScale = Vector3(layoutScale, layoutScale, layoutScale)
end

function AircraftInteractiveTexItem:SetData(pos, tex, showBubble)
  if showBubble then
    self._bubbleGo:SetActive(true)
    self._texGo:SetActive(false)
  else
    self._bubbleGo:SetActive(false)
    self._texGo:SetActive(true)
  end
  self:_SetText(tex)
  self._bubbleGo.transform.position = pos + self._talkBubblePosOffset
  self._texGo.transform.position = pos + self._talkTextPosOffset
  self._isClosing = false
end

function AircraftInteractiveTexItem:PlayOpenAnim()
  local c = self._texUI.color
  self._texUI.color = Color(c.r, c.g, c.b, 1)
  self._bgImg.color = Color(1, 1, 1, 1)
  if self._anim then
    self._anim:Stop()
    self._anim:Play("uieff_AircraftTalkRoot_chuxian")
  end
end

function AircraftInteractiveTexItem:PLayCloseAnim()
  if self._anim then
    self._anim:Stop()
    self._anim:Play("uieff_AircraftTalkRoot_xiaoshi")
    self._isClosing = true
  end
end

function AircraftInteractiveTexItem:UpDataPos(pos)
  self._bubbleGo.transform.position = pos + self._talkBubblePosOffset
  self._texGo.transform.position = pos + self._talkTextPosOffset
end

function AircraftInteractiveTexItem:SetTexActive(active)
  if self._isClosing then
    return
  end
  if self._texGo then
    self._texGo:SetActive(active)
  end
  if self._bubbleGo then
    self._bubbleGo:SetActive(not active)
  end
end

function AircraftInteractiveTexItem:Dispose()
  self._texGo = nil
  self._texUI = nil
  self._layout = nil
  self._filter = nil
  self._layoutRect = nil
  self._texRect = nil
  if self._bubbleReq then
    self._bubbleReq:Dispose()
  end
  self._bubbleReq = nil
  self._bubbleGo = nil
  self._index = 0
end
