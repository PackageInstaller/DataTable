local cls = class("pageEntrustPages", G_UIPageBase)
local EnterPageName = "pageEntrustTaskEntrance"
local DetailPageName = "pageEntrustChallenge"
local FlowState = {
  IDLE = 0,
  LOADING_ENTER = 1,
  READY = 2,
  CLOSING = 3,
  CLOSED = 4
}

function cls.bind()
  return {}
end

function cls.methods()
  return {}
end

function cls:check(options, callback)
  local condId = AzurWorld.ConditionMgr:CreateCond({70001}, nil)
  if not AzurWorld.ConditionMgr:CheckCond(condId) then
    local cond = AzurWorld.ConditionMgr:GetCond(condId)
    if cond then
      local str = cond:ShowMsg()
      L_FlyMsgManager:showNormalMsg(str)
    end
    callback(false)
    return
  end
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.Dungeon, true) then
    callback(false)
    return
  end
  if options and options.checkGuid and L_GuideManager:isGuideOnRunning() then
    callback(false)
    return
  end
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.entrustTask)
  callback(true)
end

function cls:created(obj, config, binderData)
  cls.super.created(self, obj, config, binderData)
  self.flowState = FlowState.IDLE
  self.pendingShowDetailRequest = false
end

function cls:reCreated(obj, options)
  self.flowState = FlowState.IDLE
  self.pendingShowDetailRequest = false
end

function cls:preOpen(options)
  cls.super.preOpen(self, options)
  if options and options.checkGuid and L_GuideManager:isGuideOnRunning() then
    L_UI:close(self.pageName)
    return
  end
  self.enterPageInstance = nil
  self.detailPageInstace = nil
  self.options = options or {}
  if options and options.jumpParams then
    options.openDetail = true
  end
  if options and options.openDetail then
    print("收到开启子界面的命令，开始等待")
    self.pendingShowDetailRequest = true
  end
  self.flowState = FlowState.IDLE
  self:startFlow(options)
end

function cls:escHandle()
  self:closePageFunc()
end

function cls:open(options)
end

function cls:close(options)
  self:closePageFunc(true)
end

function cls:startFlow(options)
  if self.flowState ~= FlowState.IDLE then
    return
  end
  self.flowState = FlowState.LOADING_ENTER
  
  local function onEnterReadyCallback()
    self:onEnterReady()
  end
  
  local function onEnterPageClose()
    self:onEnterPageClose()
  end
  
  L_UI:open(EnterPageName, {
    onReady = onEnterReadyCallback,
    _closeFunc = onEnterPageClose,
    isInDetail = options and options.openDetail or false
  }, function(isOpen)
    if not isOpen then
      warn("打开失败")
      self:closePageFunc(true)
    elseif options and options.checkGuid and L_GuideManager:isGuideOnRunning() then
      L_UI:close(self.pageName)
      return
    end
  end)
end

function cls:onEnterReady()
  if self.flowState ~= FlowState.LOADING_ENTER then
    return
  end
  self.flowState = FlowState.READY
  if self.pendingShowDetailRequest then
    self:requestShowDetailPage()
    self.pendingShowDetailRequest = false
  end
end

function cls:onEnterPageClose()
  self:closePageFunc()
end

function cls:requestShowDetailPage()
  if self.flowState == FlowState.READY then
    local selectId, entrustType, selectTab, isLock
    if self.options and self.options.selectId then
      selectId = self.options.selectId
    end
    if self.options and self.options.entrustType then
      entrustType = self.options.entrustType
    end
    if self.options and self.options.selectTab then
      selectTab = self.options.selectTab
    end
    if self.options and self.options.isLock then
      isLock = self.options.isLock
    end
    if self.options and self.options.jumpParams and self.options.jumpParams[1] then
      entrustType = tonumber(self.options.jumpParams[1])
    end
    if self.options and self.options.jumpParams and self.options.jumpParams[2] then
      selectTab = tonumber(self.options.jumpParams[2])
    end
    if self.options and self.options.jumpParams and self.options.jumpParams[3] then
      selectId = tonumber(self.options.jumpParams[3])
    end
    if self.options and self.options.jumpParams and self.options.jumpParams[4] then
      isLock = tonumber(self.options.jumpParams[4])
    end
    local page = L_UI:getPage("pageEntrustTaskEntrance")
    page.timelineControl:playTimelineState(L_Const.EntrustTimelineState.End, true, false)
    L_UI:open(DetailPageName, {
      selectId = selectId,
      entrustType = entrustType,
      selectTab = selectTab,
      isLock = isLock,
      timelineControl = page.timelineControl
    }, function(isOpen)
      if not isOpen then
        warn("打开失败")
        self:closePageFunc(true)
        return
      end
      self.detailPageInstace = L_UI:getPage(DetailPageName)
      local enterPage = L_UI:getPage(EnterPageName)
      if enterPage and enterPage.setMainPageActive then
        enterPage:setMainPageActive(false)
      end
    end)
  elseif self.flowState == FlowState.LOADING_ENTER then
    self.pendingShowDetailRequest = true
  else
    print("entrustPageFlow: 当前状态无法打开Detail界面，状态为:", self.flowState)
  end
end

function cls:closePageFunc(isForce)
  if not self.bind or self.flowState == FlowState.CLOSED then
    return
  end
  if not isForce and (self.flowState == FlowState.LOADING_ENTER or self.flowState == FlowState.CLOSING) then
    return
  end
  self.flowState = FlowState.CLOSING
  L_UI:close(DetailPageName)
  L_UI:close(EnterPageName)
  if self.pageName ~= nil then
    L_UI:close(self.pageName)
  end
  L_TimerManager:clearTimer(self)
  self.flowState = FlowState.CLOSED
  print("entrustPageFlow: 委托管理界面已关闭")
end

return cls
