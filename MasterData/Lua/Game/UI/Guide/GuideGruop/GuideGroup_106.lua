local GuideGroup_106 = class("GuideGroup_106")
local mapEventConfig = {}
local groupId = 106
local totalStep = 2
local current = 1

function GuideGroup_106:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_106:BindEvent()
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

function GuideGroup_106:UnBindEvent()
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

function GuideGroup_106:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_106:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_106:Step_1()
  self.msg = {
    BindIcon = "StarTowerMenu/----SafeAreaRoot----/imgCoinBg",
    Size = {200, 60},
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_106_1",
    DescDeviation = {-630, -100},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
    CS.AdventureModuleHelper.PauseLogic()
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_106:Step_2()
  self.msg = {
    BindIcon = "StarTowerMenu/----SafeAreaRoot----/imgCoinBg",
    Size = {0, 0},
    Deviation = {400, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_106_2",
    DescDeviation = {-900, -450},
    Type = GameEnum.guidetype.Introductory,
    isNoMiddle = true
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_106:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  if current == totalStep then
    CS.AdventureModuleHelper.ResumeLogic()
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

return GuideGroup_106
