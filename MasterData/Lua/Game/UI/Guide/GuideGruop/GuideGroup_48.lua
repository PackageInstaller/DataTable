local GuideGroup_48 = class("GuideGroup_48")
local mapEventConfig = {
  Guide_SelectTowerSweepHard = "OnEvent_SelectTowerSweepHard"
}
local groupId = 48
local totalStep = 3
local current = 1
local selectIndex = 1

function GuideGroup_48:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_48:BindEvent()
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

function GuideGroup_48:UnBindEvent()
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

function GuideGroup_48:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_48:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_48:Step_1()
  self.msg = {
    BindIcon = "StarTowerLevelSelect/----SafeAreaRoot----/---Sweep---/goSweepTickets",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_48_1",
    DescDeviation = {-700, -120},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.waitAnimTime = 0.5
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_48:Step_2()
  self.msg = {
    BindIcon = "StarTowerLevelSelect/----SafeAreaRoot----/rt_StarTowerInfo/rt_Toggle/Viewport/rt_ToggleContent/tog" .. selectIndex,
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_48_2",
    DescDeviation = {940, -150},
    HandDeviation = {0, -100},
    Type = GameEnum.guidetype.ForcedClick
  }
  local tempRoot = GameObject.Find("---- UI ----").transform
  local btn = tempRoot:Find(self.msg.BindIcon):GetComponent("UIButton")
  btn.onClick:Invoke()
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_48:Step_3()
  self.msg = {
    BindIcon = "StarTowerLevelSelect/----SafeAreaRoot----/---Sweep---/btnSweep",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_48_3",
    DescDeviation = {-310, 190},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_48:OnEvent_SelectTowerSweepHard(nHard)
  selectIndex = nHard
end

function GuideGroup_48:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 1 then
    self:SendGuideStep(-1)
  elseif current == totalStep then
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

return GuideGroup_48
