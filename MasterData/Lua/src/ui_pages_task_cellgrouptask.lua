local item = class("cellGroupTask", G_UIModuleBase)
local pageType = {SubTask = 2, Activity = 4}

function item.bind()
  return {
    tabId = 0,
    txtNameOn = "",
    txtNameOff = "",
    txtMapOn = "",
    txtMapOff = "",
    activeTackingOn = false,
    activeTackingOff = false,
    activeNoTackOn = true,
    activeNoTackOff = true,
    activeRed = false,
    anchoredPosNameOn = nil,
    anchoredPosNameOff = nil,
    activeLimitIcon = false,
    activeTimeLimit = false,
    txtTimeLimit = "",
    showLimit = false,
    txtLimit = ""
  }
end

function item.methods()
  return {}
end

function item:open()
  self.isOpen = true
  self.refreshTrackStateFunc = self.refreshTrackStateFunc or handler(self, self.refreshTrackState)
  AzurWorld.TaskMgr:RegisterEvent(C_ETaskEvent.SetCurrentTracedTask, self.refreshTrackStateFunc)
  if self.bind.endTime then
    self.bind.activeTimeLimit = true
    self:refreshTimeLimit()
    self.timer = Timer.repeated(1, self.refreshTimeLimit, self)
    local colorStr = self.bind.activeTackingOn and "#FF7E6D" or "#BCF6DE"
    local _, color = C_ColorUtility.TryParseHtmlString(colorStr)
    self.bindComponents.groupTimeLimit.color = color
  end
  self:refreshTrace(self.bind.tacking)
  self:refreshSelected()
end

function item:close()
  self.isOpen = false
  if self.refreshTrackStateFunc then
    AzurWorld.TaskMgr:UnregisterEvent(C_ETaskEvent.SetCurrentTracedTask, self.refreshTrackStateFunc)
  end
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function item:refreshTrackState(_, args)
  if self.bind and self.bind.tabId then
    self.bind.tacking = AzurWorld.TaskMgr:GetIsTraceTask(self.bind.tabId)
    self:refreshTrace(self.bind.tacking)
  end
end

function item:refreshTimeLimit()
  if type(self.bind.endTime) ~= "number" then
    if self.timer then
      Timer.remove(self.timer)
      self.timer = nil
    end
    return
  end
  if self.bind.endTime - L_TimeUtil.getServerTime() >= 0 then
    if self.bind.typeId == pageType.SubTask then
      self.bind.txtTimeLimit = L_TimeUtil.getLeftTimeString2(self.bind.endTime)
    elseif self.bind.typeId == pageType.Activity then
      self.bind.txtTimeLimit = L_WordsTpl:getValue("ui_game_events_end_time")
    end
  end
  if self.bind.refreshRightPage then
    self.bind.refreshRightPage(self.bind.endTime)
  end
end

function item:refreshSelected()
  if not self.isOpen then
    return
  end
  if self.bind.endTime then
    local colorStr = self.bindComponents.tabItem.isOn and "#FF7E6D" or "#BCF6DE"
    local _, color = C_ColorUtility.TryParseHtmlString(colorStr)
    self.bindComponents.groupTimeLimit.color = color
  end
  if self.bindComponents.tabItem.isOn then
    self.bind.activeRed = false
  end
end

function item:refreshTrace(tacking)
  if not self.bind.activeLimitIcon then
    self.bind.tacking = tacking
    self.bind.activeTackingOn = tacking
    self.bind.activeTackingOff = tacking
    self.bind.activeNoTackOn = not tacking
    self.bind.activeNoTackOff = not tacking
  end
end

return item
