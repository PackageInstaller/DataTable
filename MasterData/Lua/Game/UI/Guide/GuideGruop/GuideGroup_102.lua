local GuideGroup_102 = class("GuideGroup_102")
local mapEventConfig = {}
local groupId = 102
local totalStep = 2
local current = 1

function GuideGroup_102:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_102:BindEvent()
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

function GuideGroup_102:UnBindEvent()
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

function GuideGroup_102:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_102:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_102:Step_1()
  self.msg = {
    BindIcon = "PotentialSelectPanel/----SafeAreaRoot----/rtPotentials",
    Size = {1760, 880},
    Deviation = {0, 20},
    Desc = "Guide_102_2",
    DescDeviation = {-530, 440},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_102:Step_2()
  self.msg = {
    BindIcon = "PotentialSelectPanel/----SafeAreaRoot----/---Title---/goChangeDesc",
    Size = {330, 80},
    Deviation = {0, 0},
    Desc = "Guide_102_3",
    DescDeviation = {-687, -111},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_102:FinishCurrentStep()
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
      "19"
    })
    NovaAPI.UserEventUpload("newbie_tutorial", tab)
  end
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
end

return GuideGroup_102
