local GuideGroup_105 = class("GuideGroup_105")
local TimerManager = require("GameCore.Timer.TimerManager")
local mapEventConfig = {}
local groupId = 105
local totalStep = 1
local current = 1

function GuideGroup_105:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_105:BindEvent()
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

function GuideGroup_105:UnBindEvent()
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

function GuideGroup_105:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_105:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_105:Step_1()
  self.msg = {
    BindIcon = "AdventureMainUI/RootPanel/AutoBattlePanel/btnAutoBattleOpen",
    Size = {160, 140},
    Deviation = {0, 0},
    Desc = "Guide_105_1",
    DescDeviation = {-630, 0},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  TimerManager.Add(1, 2, self, function()
    CS.AdventureModuleHelper.PauseLogic()
    self.parent:PlayTypeMask(self.msg)
  end, true, false, false)
end

function GuideGroup_105:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  if current == totalStep then
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
    CS.AdventureModuleHelper.ResumeLogic()
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

return GuideGroup_105
