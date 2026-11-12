local GuideGroup_44 = class("GuideGroup_44")
local mapEventConfig = {
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById"
}
local groupId = 44
local totalStep = 2
local current = 1

function GuideGroup_44:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_44:BindEvent()
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Add(nEventId, self, callback)
    end
  end
end

function GuideGroup_44:UnBindEvent()
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Remove(nEventId, self, callback)
    end
  end
end

function GuideGroup_44:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_44:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_44:Step_1()
  self.msg = {
    BindIcon = "MainViewPanel/----SafeAreaRoot----/HideRoot/--TopLeft--/trBtnList/btnActivity",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_44_1",
    DescDeviation = {620, -180},
    HandDeviation = {0, -100},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_44:Step_2()
  self.openPanelId = PanelId.ActivityList
  current = 2
end

function GuideGroup_44:OnEvent_PanelOnEnableById(_panelId)
  if self.openPanelId and self.openPanelId == _panelId and current == 2 then
    local function wait()
      self.parent:ClearCurGuide(true)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_44:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 1 then
    self:SendGuideStep(-1)
    self:Step_2()
  end
end

return GuideGroup_44
