local UITouchEndManager, Super = System.NewClass("UITouchEndManager", Manager)

function UITouchEndManager:ctor()
  Super.ctor(self)
  self.urlList = {}
end

function UITouchEndManager:Awake()
  Super.Awake(self)
  self:TouchEndProcess()
end

function UITouchEndManager:TouchEndProcess()
  EventMgr.Instance.OpenUIPanel:RegisterEvent(function(panelUrl)
    self:UICreateCheck(panelUrl)
  end)
  EventMgr.Instance.TouchBeginEvent:RegisterEvent(function(x, y, index, overUI)
    self:TouchBegin(x, y, index, overUI)
  end)
  EventMgr.Instance.TouchMoveEvent:RegisterEvent(function(x, y, index, overUI)
    self:DragCheck(x, y, index, overUI)
  end)
  EventMgr.Instance.TouchEndEvent:RegisterEvent(function(x, y, index, overUI)
    self:UICloseCheck()
  end)
end

function UITouchEndManager:UICreateCheck(panelUrl)
  local cfg = UIDefine.TouchEndCloseUrls[panelUrl]
  if not cfg then
    return
  end
  local needClose = cfg.upCheck
  local dragCheck = cfg.dragCheck
  if not needClose then
    return
  end
  FrameWaiter.OnNextFrame(function()
    local panel = UIManager.Instance:GetWindow(panelUrl)
    if panel then
      self.closeCheck = true
      table.insert(self.urlList, {
        panelUrl,
        needClose,
        dragCheck
      })
    end
  end)
end

function UITouchEndManager:TouchBegin(x, y, index, overUI)
  self.startMoveX = x
  self.startMoveY = y
end

function UITouchEndManager:DragCheck(x, y, index, overUI)
  if self.closeCheck then
    local data = self.urlList and self.urlList[1]
    local dragCheck = data and data[3] or false
    if dragCheck then
      local disX = self.startMoveX and math.abs(x - self.startMoveX)
      local disY = self.startMoveY and math.abs(y - self.startMoveY)
      if disX >= 50 or disY >= 50 then
        self.closeCheck = false
      end
    end
  end
end

function UITouchEndManager:UICloseCheck()
  if not self.closeCheck then
    if #self.urlList > 0 then
      self.closeCheck = true
    end
    return
  end
  for _, data in ipairs(self.urlList) do
    local panelUrl = data[1]
    UIManager.Instance:CloseByUrl(panelUrl)
  end
  table.clear(self.urlList)
  self.closeCheck = false
end

function UITouchEndManager:OnDestroy()
  Super.OnDestroy(self)
end

return UITouchEndManager
