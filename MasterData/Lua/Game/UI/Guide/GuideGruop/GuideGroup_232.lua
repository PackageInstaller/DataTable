local GuideGroup_232 = class("GuideGroup_232")
local TimerManager = require("GameCore.Timer.TimerManager")
local TimerScaleType = require("GameCore.Timer.TimerScaleType")
local mapEventConfig = {
  Guide_StarTowerDepotDisc = "OnEvent_StarTowerDepotDisc"
}
local groupId = 232
local totalStep = 1
local current = 1

function GuideGroup_232:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_232:BindEvent()
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

function GuideGroup_232:UnBindEvent()
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

function GuideGroup_232:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_232:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_232:Step_1()
  self.msg = {
    BindIcon = "DiscSkillActivePanel/----SafeAreaRoot----/goSkillCard",
    Deviation = {0, 0},
    Desc = "Guide_232_1",
    DescDeviation = {-460, -370},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.waitAnimTime = 0.3
  if self.waitAnimTime ~= 0 then
    TimerManager.Add(1, self.waitAnimTime + 0.2, self, function()
      self.parent:PlayTypeMask(self.msg)
    end, true, false, false)
  else
    self.parent:PlayTypeMask(self.msg)
  end
end

function GuideGroup_232:OnEvent_StarTowerDepotDisc(bHasSkill)
  self.bHasSkill = bHasSkill
end

function GuideGroup_232:FinishCurrentStep()
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
end

return GuideGroup_232
