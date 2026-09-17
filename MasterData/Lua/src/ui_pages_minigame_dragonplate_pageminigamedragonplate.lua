local this = class("pageMiniGameDragonPlate", G_UIPageBase)

function this.bind()
  return {
    isActive_main = true,
    isActive_shortcut_rotateLeft = false,
    isActive_shortcut_rotateRight = false,
    isActive_shortcut_change_circle = false
  }
end

function this.methods()
  return {
    onClick_left = function(self)
      self:callRotateLeft()
    end,
    onClick_right = function(self)
      self:callRotateRight()
    end,
    onClick_reset = function(self)
      self:callReset()
    end,
    onClick_start = function(self)
      self:callFlow()
    end,
    onClick_change_circle = function(self)
      self:callChangeCircle()
    end
  }
end

function this:onTopBarRefresh()
  C_IntegrateMgr.TopBarModule:SetTopBarCloseFunc(function()
    self:callQuit()
    L_UI:close(self.pageName)
  end)
  C_IntegrateMgr.TopBarModule:setTopBarMainBtnFunc(function()
    self:callQuit()
    L_UI:close(self.pageName)
  end)
end

function this:preOpen(options)
  self.rotating = false
  if L_DeviceTpl:getIsPc() then
    self.bind.isActive_shortcut_rotateLeft = true
    self.bind.isActive_shortcut_rotateRight = true
    self.bind.isActive_shortcut_change_circle = true
  else
    self.bind.isActive_shortcut_rotateLeft = false
    self.bind.isActive_shortcut_rotateRight = false
    self.bind.isActive_shortcut_change_circle = false
  end
  self.onFlowEndHandle = handler(self, self.onFlowEnd)
  self.onFlowStartHandle = handler(self, self.onFlowStart)
  self.onRotateStartHandle = handler(self, self.onRotateStart)
  self.onRotateEndHandle = handler(self, self.onRotateEnd)
  C_WorldEvent.instance:Listen(C_EWorldEvent.OnRotatePlateRotateBegin, self.onRotateStartHandle)
  C_WorldEvent.instance:Listen(C_EWorldEvent.OnRotatePlateRotateEnd, self.onRotateEndHandle)
  C_WorldEvent.instance:Listen(C_EWorldEvent.OnRotatePlateFlowBegin, self.onFlowStartHandle)
  C_WorldEvent.instance:Listen(C_EWorldEvent.OnRotatePlateFlowEnd, self.onFlowEndHandle)
end

function this:close(options)
end

function this:escHandle()
  if self.bind.isActive_main then
    self:callQuit()
    L_UI:close(self.pageName)
  end
end

function this:callRotateLeft()
  if self.rotating then
    return
  end
  local list = C_VarList:Get()
  list:AddInt(1)
  C_WorldEvent.instance:Dispatch(C_EWorldEvent.OnRotatePlateRotate, list)
end

function this:callRotateRight()
  if self.rotating then
    return
  end
  local list = C_VarList:Get()
  list:AddInt(-1)
  C_WorldEvent.instance:Dispatch(C_EWorldEvent.OnRotatePlateRotate, list)
end

function this:callReset()
  if self.rotating then
    return
  end
  C_WorldEvent.instance:Dispatch(C_EWorldEvent.OnRotatePlateReset)
end

function this:callFlow()
  if self.rotating then
    return
  end
  C_WorldEvent.instance:Dispatch(C_EWorldEvent.OnRotatePlateFlow)
end

function this:callQuit()
  C_WorldEvent.instance:Dispatch(C_EWorldEvent.OnRotatePlateQuit)
end

function this:callChangeCircle()
  C_WorldEvent.instance:Dispatch(C_EWorldEvent.OnRotatePlateChangeCircle)
end

function this:onRotateStart()
  self.rotating = true
end

function this:onRotateEnd()
  self.rotating = false
end

function this:onFlowStart()
  self.rotating = true
  self.bind.isActive_main = false
end

function this:onFlowEnd(id, param)
  self.rotating = false
  local result = param:GetInt(0)
  if result == 0 then
    self.bind.isActive_main = true
  elseif result == 1 then
    L_UI:close(self.pageName)
  end
end

function this:close()
  C_WorldEvent.instance:Cancel(C_EWorldEvent.OnRotatePlateRotateBegin, self.onRotateStartHandle)
  C_WorldEvent.instance:Cancel(C_EWorldEvent.OnRotatePlateRotateEnd, self.onRotateEndHandle)
  C_WorldEvent.instance:Cancel(C_EWorldEvent.OnRotatePlateFlowBegin, self.onFlowStartHandle)
  C_WorldEvent.instance:Cancel(C_EWorldEvent.OnRotatePlateFlowEnd, self.onFlowEndHandle)
end

return this
