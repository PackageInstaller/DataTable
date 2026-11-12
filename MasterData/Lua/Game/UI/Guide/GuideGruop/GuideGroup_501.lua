local GuideGroup_501 = class("GuideGroup_501")
local mapEventConfig = {
  StoryDialog_DialogEnd = "OnEvent_StoryDialog_DialogEnd",
  Guide_Potential_SelectComplete = "OnEvent_Potential_SelectComplete"
}
local groupId = 501
local totalStep = 1
local current = 1

function GuideGroup_501:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_501:BindEvent()
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

function GuideGroup_501:UnBindEvent()
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

function GuideGroup_501:SendGuideStep(step)
  local seasonId = PlayerData.SoldierData:GetCurSelectSeasonId()
  self.parent:SendGuideStep(groupId, step, AllEnum.GuideType.Soldier, seasonId)
end

function GuideGroup_501:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_501:Step_1()
  local avgId = "ST_sys_soldier_intro"
  current = 1
  self.parent:PlayAvg(avgId)
  self:SendGuideStep(-1)
  self.parent:ClearCurGuide(true)
end

function GuideGroup_501:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
end

function GuideGroup_501:OnEvent_StoryDialog_DialogEnd()
end

return GuideGroup_501
