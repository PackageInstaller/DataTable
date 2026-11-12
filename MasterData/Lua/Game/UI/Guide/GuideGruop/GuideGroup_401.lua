local GuideGroup_401 = class("GuideGroup_401")
local mapEventConfig = {}
local groupId = 401
local totalStep = 4
local current = 1

function GuideGroup_401:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_401:BindEvent()
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

function GuideGroup_401:UnBindEvent()
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

function GuideGroup_401:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_401:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_401:Step_1()
  self.msg = {
    BindIcon = "TowerDefenseLevelDetailPanel/----SafeAreaRoot_Detail---/----Content-----/------Team-----/goPanel/TeamCharacter",
    Deviation = {0, 0},
    Desc = "Guide_401_1",
    DescDeviation = {700, 240},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(1))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_401:Step_2()
  self.msg = {
    BindIcon = "TowerDefenseLevelDetailPanel/----SafeAreaRoot_Detail---/----Content-----/------Team-----/goPanel/btn_Team",
    Deviation = {0, 0},
    Desc = "Guide_401_2",
    DescDeviation = {-300, 140},
    HandDeviation = {0, -100},
    HandRotation = 0,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_401:Step_3()
  self.msg = {
    BindIcon = "TowerDefenseLevelDetailPanel/----SafeAreaRoot_Detail---/----Content-----/------Window-----/TowerDefenseTeamPanel/----SafeAreaRoot----/Root/bg_sv",
    Deviation = {0, 0},
    Desc = "Guide_401_3",
    DescDeviation = {0, 400},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(1))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_401:Step_4()
  self.msg = {
    BindIcon = "TowerDefenseLevelDetailPanel/----SafeAreaRoot_Detail---/----Content-----/------Team-----/goPanel/TeamCharacter",
    Deviation = {0, 0},
    Desc = "Guide_401_4",
    DescDeviation = {300, -240},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 4
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_401:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 2 then
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

return GuideGroup_401
