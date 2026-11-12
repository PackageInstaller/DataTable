local GuideGroup_301 = class("GuideGroup_301")
local mapEventConfig = {
  PenguinCard_OpenInfo = "OnEvent_PenguinCardOpenInfo",
  PenguinCard_SelectPenguinCard = "OnEvent_PenguinCardSelectPenguinCard",
  PenguinCard_CloseCardInfo = "OnEvent_PenguinCardSelectPenguinCard"
}
local groupId = 301
local totalStep = 3
local current = 1

function GuideGroup_301:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_301:BindEvent()
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

function GuideGroup_301:UnBindEvent()
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

function GuideGroup_301:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_301:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_301:Step_1()
  self.msg = {
    BindIcon = "PenguinCard_Normal/----SafeAreaRoot----/---Prepare---/--Card--",
    Deviation = {0, 0},
    Head = "Icon/Head/head_917401",
    Desc = "Guide_301_1",
    DescDeviation = {0, -400},
    HandDeviation = {0, -250},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_301:Step_2()
  self.msg = {
    BindIcon = "PenguinCard_Normal/----SafeAreaRoot----/---Slot---/--Card--",
    Size = {1350, 330},
    Deviation = {0, -30},
    Head = "Icon/Head/head_917301",
    Desc = "Guide_301_2",
    DescDeviation = {0, 260},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_301:Step_3()
  self.msg = {
    BindIcon = "PenguinCard_Normal/----SafeAreaRoot----/---Prepare---/btnStartTurn/AnimRoot/Image",
    Deviation = {0, 0},
    Head = "Icon/Head/head_917301",
    Desc = "Guide_301_3",
    DescDeviation = {-740, 80},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_301:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 1 then
    self:SendGuideStep(-1)
    return
  elseif current == totalStep then
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_301:OnEvent_PenguinCardOpenInfo()
  if current == 1 then
    self.parent:FinishCurrentStep()
  end
end

function GuideGroup_301:OnEvent_PenguinCardSelectPenguinCard()
  if current == 1 then
    self:Step_2()
  end
end

return GuideGroup_301
