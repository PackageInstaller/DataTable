local GuideGroup_201 = class("GuideGroup_201")
local mapEventConfig = {
  StoryDialog_DialogEnd = "OnEvent_StoryDialog_DialogEnd",
  Guide_Potential_SelectComplete = "OnEvent_Potential_SelectComplete"
}
local groupId = 201
local totalStep = 2
local current = 1

function GuideGroup_201:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 2
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_201:BindEvent()
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

function GuideGroup_201:UnBindEvent()
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

function GuideGroup_201:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_201:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_201:Step_1()
  local avgId = "BTm00_06"
  current = 1
  self.parent:PlayAvg(avgId)
end

function GuideGroup_201:Step_2()
  self.msg = {
    BindIcon = "PotentialSelectPanel/----SafeAreaRoot----/rtPotentials",
    Size = {1760, 880},
    Deviation = {0, 20},
    Desc = "Guide_201_1",
    DescDeviation = {-530, 440},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_201:OnEvent_StoryDialog_DialogEnd()
  if current == 1 then
    self:SendGuideStep(current)
    self:Step_2()
  end
end

function GuideGroup_201:OnEvent_Potential_SelectComplete()
  if current == 2 then
    self.parent:PlayTypeMask(self.msg)
  end
end

function GuideGroup_201:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  if current == 2 then
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {
      "newbie_tutorial_id",
      "22"
    })
    NovaAPI.UserEventUpload("newbie_tutorial", tab)
  end
  if current < 2 then
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

return GuideGroup_201
