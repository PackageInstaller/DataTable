local GuideGroup_42 = class("GuideGroup_42")
local mapEventConfig = {
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById"
}
local groupId = 42
local totalStep = 2
local current = 1

function GuideGroup_42:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_42:BindEvent()
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

function GuideGroup_42:UnBindEvent()
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

function GuideGroup_42:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_42:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_42:Step_1()
  self.msg = {
    BindIcon = "MainViewPanel/----SafeAreaRoot----/HideRoot/--BottomRight--/btnMainline",
    Size = {140, 140},
    Deviation = {0, 0},
    Desc = "Guide_42_1",
    DescDeviation = {-830, 0},
    HandDeviation = {-150, 0},
    HandRotation = -90,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 1
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_42:Step_2()
  self.msg = {
    BindIcon = "StoryEntrancePanel/----SafeAreaRoot----/goMainline",
    Size = {950, 730},
    Deviation = {0, -25},
    Desc = "Guide_42_2",
    DescDeviation = {1000, 0},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.openPanelId = PanelId.StoryEntrance
  self.waitAnimTime = 0.2
end

function GuideGroup_42:OnEvent_PanelOnEnableById(_panelId)
  if self.openPanelId and self.openPanelId == _panelId and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.5))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_42:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == totalStep then
    PlayerData.Base:UserEventUpload_PC("pc_tutorial_complete")
    self.parent:ClearCurGuide(true)
    return
  elseif current == 1 then
    self:SendGuideStep(-1)
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

return GuideGroup_42
