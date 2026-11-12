local GuideGroup_27 = class("GuideGroup_27")
local mapEventConfig = {}
local groupId = 27
local totalStep = 2
local current = 1

function GuideGroup_27:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_27:BindEvent()
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

function GuideGroup_27:UnBindEvent()
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

function GuideGroup_27:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_27:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_27:Step_1()
  self.msg = {
    BindIcon = "MainlineFormationDiscPanelEx/----SafeAreaRoot----/bottomBtnList/btnFastFormation",
    Deviation = {0, 2},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_27_1",
    DescDeviation = {-800, 10},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_27:Step_2()
  self.msg = {
    BindIcon = "MainlineFormationDiscPanelEx/----SafeAreaRoot----/rtSelect/rtCur/rtMainDisc/rtDisc1/rtDisc/btnDetail",
    Deviation = {0, 2},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_27_2",
    DescDeviation = {720, 50},
    HandDeviation = {0, -120},
    HandRotation = 0,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.2
end

function GuideGroup_27:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  self.nStarTowerGroupId = 0
  if current == totalStep then
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
    return
  elseif current < totalStep then
    self:SendGuideStep(current)
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
  if self.openPanelId == nil and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

return GuideGroup_27
