_class("Guide", Object)

function Guide:Constructor(manager, data)
  self.manager = manager
  self.data = data
  self.done = false
  self.count = 0
  self.act = 0
end

function Guide:Init()
  if self.inited then
    return
  end
  local steps = Cfg.cfg_guide({
    guide = self.data.guide
  })
  if not steps then
    self.manager:GuideError(self.data.guide)
    return
  end
  if steps and #steps <= 0 then
    local str = "新手引导配置异常 cfg_guide->guideId:" .. self.data.id .. "没有步骤"
    ToastManager.ShowToast(str)
    return
  end
  table.sort(steps, table.asc("step"))
  local allSteps = {}
  for i = 1, #steps do
    if self:_CheckPlatform(steps[i]) then
      local step = GuideStep:New(self, steps[i], i == #steps)
      table.insert(allSteps, step)
      if not self.backStep and step:IsBack() then
        self.backStep = i
      end
    end
  end
  self.allSteps = allSteps
  self.currStep = nil
  self.lockScreen = steps and steps[1].lockScreen or false
  self.inited = true
end

function Guide:SetData(data)
  self.data = data
end

function Guide:SetYieldTT(TT)
  self.TT = TT
end

function Guide:GetYieldTT()
  return self.TT
end

function Guide:CallYieldCallBack()
end

function Guide:GetID()
  return self.data.guide
end

function Guide:IsLockScreen()
  return self.currStep and self.currStep:IsLockScreen()
end

function Guide:SetCount(count)
  self.count = count
  Log.debug("[guide] set guide ", self.data.guide, " count: ", count)
end

function Guide:GetCount()
  return self.count
end

function Guide:GetTotalCount()
  return self.data.count or 1
end

function Guide:IsAct()
  return self.act > 0
end

function Guide:IsDone()
  return self.done
end

function Guide:NoAct()
  if self:CheckGuide() then
    return
  end
  self.act = os.time()
  self.done = false
  return true
end

function Guide:Done(remain)
  if self.done then
    return
  end
  self.done = true
  self.act = 0
  self.count = self.count + 1
  if not self.inited then
    return true
  end
  if not remain then
    for i = 1, #self.allSteps do
      self.allSteps[i]:Clear()
    end
  end
  return true
end

function Guide:Clear(isDispose)
  if not self.inited then
    return
  end
  self.act = 0
  self.count = 0
  for i = 1, #self.allSteps do
    self.allSteps[i]:Clear(isDispose)
  end
end

function Guide:Complete(remain)
  self.manager:DoneGuide(self.data.guide, true, remain)
end

function Guide:CheckGuide()
  if self.act and self.act > 0 then
    return true
  end
  if self.done then
    if self:GetCount() < self:GetTotalCount() then
      return false
    end
    return true
  end
end

function Guide:CheckShow()
  local UI = GameGlobal.UIStateManager()
  if UI:IsShow("UnLockUI") then
    return false
  end
  if UI:IsShow("LevelUpUI") then
    return false
  end
  if not self.inited then
    return false
  end
  return true
end

function Guide:Show()
  if not self.inited then
    self:Init()
  end
  local allSteps = self.allSteps
  local length = #allSteps
  local step
  for i = self.backStep or 1, length do
    local s = allSteps[i]
    if s:HasTargetGuide() then
      if not s:IsDone() and s:CanShow() then
        step = s
      end
      break
    elseif not s:IsDone() then
      if s:CanShow() then
        step = s
      end
      break
    end
  end
  if self.currStep == nil or self.currStep ~= step then
    if self.currStep then
      self.currStep:Hide()
    end
    self.currStep = step
    if self.currStep then
      local l_data = self.currStep:GetGuidData()
      if l_data then
        GameGlobal.UAReportForceGuideEvent("GuideStepStart", {
          l_data.guide,
          l_data.step
        })
      end
    end
  end
  if self.currStep then
    self.currStep:Show()
    if GuideDebug.Enable then
      local debugData = self.currStep:GetGuidData()
      GuideDebug.LogGuide(debugData.guide)
      GuideDebug.LogStep(debugData.step)
    end
  end
end

function Guide:Hide()
  if self.currStep then
    self.currStep:Hide()
  end
end

function Guide:SetIsCoreGameGuide(is)
  self.isCoreGameGuide = is
end

function Guide:IsCoreGameGuide()
  return self.isCoreGameGuide
end

function Guide:GetCurStep()
  return self.currStep
end

function Guide:_CheckPlatform(cfg)
  if not cfg.platform then
    return true
  end
  for _, value in pairs(cfg.platform) do
    if value == PLATFORM:ToInt() then
      return true
    end
  end
  return false
end
