local GuideGroup_17 = class("GuideGroup_17")
local mapEventConfig = {}
local groupId = 17
local totalStep = 1
local current = 1

function GuideGroup_17:Init(parent, runStep)
  self:BindEvent()
  self.tabChar = {}
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_17:BindEvent()
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

function GuideGroup_17:UnBindEvent()
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

function GuideGroup_17:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_17:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  self.tabChar = nil
end

function GuideGroup_17:Step_1()
  self.msg = {
    BindIcon = "LevelMenuPanel/----SafeAreaRoot----/imgPhoneBg/PhoneContent/LevelMenu/rtFunctionBg/btnInfinity",
    Size = {210, 186},
    Deviation = {0, 0},
    Head = "Icon/Head/head_917402",
    Desc = "Guide_17_1",
    DescDeviation = {-700, -200},
    HandDeviation = {-180, 0},
    HandRotation = -90,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 1
  self.waitAnimTime = 0.5
  if self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  else
    self.parent:PlayTypeMask(self.msg)
  end
end

function GuideGroup_17:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == totalStep then
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
    return
  end
end

return GuideGroup_17
