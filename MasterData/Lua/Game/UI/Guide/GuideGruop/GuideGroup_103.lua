local GuideGroup_103 = class("GuideGroup_103")
local mapEventConfig = {
  StoryDialog_DialogEnd = "OnEvent_StoryDialog_DialogEnd",
  Guide_FateCard_SelectComplete = "OnEvent_FateCard_SelectComplete"
}
local groupId = 103
local totalStep = 2
local current = 1

function GuideGroup_103:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_103:BindEvent()
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

function GuideGroup_103:UnBindEvent()
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

function GuideGroup_103:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_103:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_103:Step_1()
  self.msg = {
    BindIcon = "FateCardSelectPanel/----SafeAreaRoot----/rtFateCards",
    Size = {1700, 800},
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_3_8",
    DescDeviation = {-930, 300},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_103:Step_2()
  self.msg = {
    BindIcon = "StarTowerRoomInfo/----SafeAreaRoot----/FateCard/goFateCardList",
    Size = {300, 200},
    Deviation = {-100, 40},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_3_8",
    DescDeviation = {-930, 300},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(false)
  current = 2
end

function GuideGroup_103:OnEvent_FateCard_SelectComplete()
  if current == 2 then
    self.parent:PlayTypeMask(self.msg)
  end
end

function GuideGroup_103:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  if current < 1 then
    self:SendGuideStep(current)
  else
    self:SendGuideStep(-1)
  end
  if current == totalStep then
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

return GuideGroup_103
