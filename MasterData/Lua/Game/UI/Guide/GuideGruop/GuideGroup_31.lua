local GuideGroup_31 = class("GuideGroup_31")
local mapEventConfig = {}
local groupId = 31
local totalStep = 1
local current = 1

function GuideGroup_31:Init(parent, runStep)
  self:BindEvent()
  self.tabChar = {}
  self.parent = parent
  if PlayerData.Base:GetWorldClass() >= 6 then
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
    return
  end
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_31:BindEvent()
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

function GuideGroup_31:UnBindEvent()
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

function GuideGroup_31:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_31:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  self.tabChar = nil
end

function GuideGroup_31:Step_1()
  self.msg = {
    BindIcon = "MainViewPanel/----SafeAreaRoot----/HideRoot/--TopRight--/trBtnList/btnTask",
    Size = {120, 120},
    Deviation = {0, 0},
    Head = "Icon/Head/head_999901",
    Desc = "Guide_31_1",
    DescDeviation = {-500, -280},
    HandDeviation = {0, -120},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_31:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 1 then
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

return GuideGroup_31
