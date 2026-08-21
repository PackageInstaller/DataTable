_class("UIN19P5SignInItem", UICustomWidget)
UIN19P5SignInItem = UIN19P5SignInItem

function UIN19P5SignInItem:OnShow()
  self.rect = self:GetUIComponent("RectTransform", "rect")
  self.getPool = self:GetUIComponent("UISelectObjectPath", "get")
  self.Bg = self:GetGameObject("Bg")
  self.getPoolGo = self:GetGameObject("get")
  self.finishPoolGo = self:GetGameObject("finish")
  self.lockPoolGo = self:GetGameObject("lock")
  self.finishPool = self:GetUIComponent("UISelectObjectPath", "finish")
  self.lockPool = self:GetUIComponent("UISelectObjectPath", "lock")
  self.layout = self:GetUIComponent("LayoutElement", "UIN19P5SignInItem")
  self:AddListener()
end

function UIN19P5SignInItem:AddListener()
  if self.Bg then
    UIEventTriggerListener.Get(self.Bg).onClick = function(PointerEventData)
      if self.callback then
        self.callback(self.idx)
      end
    end
    UIEventTriggerListener.Get(self.Bg).onDrag = function(PointerEventData)
      if self.onDrag then
        self.onDrag(PointerEventData)
      end
    end
    UIEventTriggerListener.Get(self.Bg).onBeginDrag = function(PointerEventData)
      if self.beginDrag then
        self.beginDrag(PointerEventData)
      end
    end
    UIEventTriggerListener.Get(self.Bg).onEndDrag = function(PointerEventData)
      if self.endDrag then
        self.endDrag(PointerEventData)
      end
    end
  end
end

function UIN19P5SignInItem:SetOffsetX(x)
  self.rect.anchoredPosition = Vector2(x, 0)
end

function UIN19P5SignInItem:RefreshType(type)
  self.type = type
  self:Height()
  self.pool:RefreshType(self.type)
end

function UIN19P5SignInItem:Height()
  local height
  if self.type == UIN19P5SignInPosType.Current then
    height = 350
  elseif self.type == UIN19P5SignInPosType.Down then
    height = 230
  elseif self.type == UIN19P5SignInPosType.Up then
    height = 230
  end
  self.layout.preferredHeight = height
end

function UIN19P5SignInItem:Flush(idx, awards, status, type, callback, beginDrag, onDrag, endDrag)
  self.idx = idx
  self.status = status
  self.type = type
  self.awards = awards
  self.callback = callback
  self.beginDrag = beginDrag
  self.onDrag = onDrag
  self.endDrag = endDrag
  self.pool = self:GetPool()
  self:Height()
  self.pool:Flush(self.idx, self.awards, self.status, self.type, self.callback)
end

function UIN19P5SignInItem:GetPool()
  if self.status == UIN19P5SignInStatus.Get then
    if not self.get then
      self.get = self.getPool:SpawnObject("UIN19P5SignInGet")
    end
    self.getPoolGo:SetActive(true)
    self.finishPoolGo:SetActive(false)
    self.lockPoolGo:SetActive(false)
    return self.get
  elseif self.status == UIN19P5SignInStatus.Finish then
    if not self.finish then
      self.finish = self.finishPool:SpawnObject("UIN19P5SignInFinish")
    end
    self.getPoolGo:SetActive(false)
    self.finishPoolGo:SetActive(true)
    self.lockPoolGo:SetActive(false)
    return self.finish
  elseif self.status == UIN19P5SignInStatus.Lock then
    if not self.lock then
      self.lock = self.lockPool:SpawnObject("UIN19P5SignInLock")
    end
    self.getPoolGo:SetActive(false)
    self.finishPoolGo:SetActive(false)
    self.lockPoolGo:SetActive(true)
    return self.lock
  end
end
