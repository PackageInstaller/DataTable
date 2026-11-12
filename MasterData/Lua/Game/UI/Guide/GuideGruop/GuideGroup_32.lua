local GuideGroup_32 = class("GuideGroup_32")
local TimerManager = require("GameCore.Timer.TimerManager")
local TimerScaleType = require("GameCore.Timer.TimerScaleType")
local mapEventConfig = {
  Guide_StarTowerDepotDisc = "OnEvent_StarTowerDepotDisc"
}
local groupId = 32
local totalStep = 4
local current = 1

function GuideGroup_32:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_32:BindEvent()
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

function GuideGroup_32:UnBindEvent()
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

function GuideGroup_32:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_32:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_32:Step_1()
  self.msg = {
    BindIcon = "StarTowerDepotPanel/----SafeAreaRoot----/---DiscSkill---/goNoteListBtn",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_32_1",
    DescDeviation = {-550, -400},
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

function GuideGroup_32:Step_2()
  self.msg = {
    BindIcon = "StarTowerDepotPanel/----SafeAreaRoot----/---DiscSkill---/svDiscSkill/Viewport/goDiscSkillContent/goHarmonyGrid/HarmonySkillDepotItem(Clone)/btnItem",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_32_2",
    DescDeviation = {0, -200},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.1
end

function GuideGroup_32:Step_3()
  self.msg = {
    BindIcon = "StarTowerDepotPanel/----SafeAreaRoot----/---DiscSkill---/svDiscSkill",
    Size = {0, 0},
    Deviation = {1200, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_32_3",
    DescDeviation = {0, 0},
    Type = GameEnum.guidetype.Introductory,
    isNoMiddle = true
  }
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.1
end

function GuideGroup_32:Step_4()
  self.msg = {
    BindIcon = "StarTowerDepotPanel/----SafeAreaRoot----/TopBarPanel/Area/goBack/btnBack",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_32_4",
    DescDeviation = {870, -400},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 4
  self.waitAnimTime = 0.1
end

function GuideGroup_32:OnEvent_StarTowerDepotDisc(bHasSkill)
  self.bHasSkill = bHasSkill
end

function GuideGroup_32:FinishCurrentStep()
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
  if current ~= 1 then
    local funName = "Step_" .. current + 1
    local func = handler(self, self[funName])
    func()
  elseif current == 1 then
    if self.bHasSkill then
      self:Step_2()
    else
      self:Step_3()
    end
  end
  if self.openPanelId == nil and self.waitAnimTime ~= 0 then
    TimerManager.Add(1, self.waitAnimTime + 0.2, self, function()
      self.parent:PlayTypeMask(self.msg)
    end, true, false, false)
  end
end

return GuideGroup_32
