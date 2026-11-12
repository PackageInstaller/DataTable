local GuideGroup_29 = class("GuideGroup_29")
local TimerManager = require("GameCore.Timer.TimerManager")
local TimerScaleType = require("GameCore.Timer.TimerScaleType")
local mapEventConfig = {}
local groupId = 29
local totalStep = 2
local current = 1

function GuideGroup_29:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_29:BindEvent()
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

function GuideGroup_29:UnBindEvent()
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

function GuideGroup_29:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_29:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_29:Step_1()
  self.msg = {
    BindIcon = "DiscSkillActivePanel/----SafeAreaRoot----/goNoteList/noteListSv/Viewport/noteContent/goNoteItem(Clone)",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_29_1",
    DescDeviation = {0, -440},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.waitAnimTime = 0.2
  if self.waitAnimTime ~= 0 then
    TimerManager.Add(1, self.waitAnimTime + 0.2, self, function()
      self.parent:PlayTypeMask(self.msg)
    end, true, false, false)
  else
    self.parent:PlayTypeMask(self.msg)
  end
end

function GuideGroup_29:Step_2()
  self.msg = {
    BindIcon = "DiscSkillActivePanel/----SafeAreaRoot----/---Title---/btnDepot",
    Size = {150, 120},
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_29_2",
    DescDeviation = {800, -400},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.1
end

function GuideGroup_29:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  self.nStarTowerGroupId = 0
  if current == 1 then
    self:SendGuideStep(-1)
  end
  if current == totalStep then
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
  if self.openPanelId == nil and self.waitAnimTime ~= 0 then
    TimerManager.Add(1, self.waitAnimTime + 0.2, self, function()
      self.parent:PlayTypeMask(self.msg)
    end, true, false, false)
  end
end

return GuideGroup_29
