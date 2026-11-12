local GuideGroup_50 = class("GuideGroup_50")
local mapEventConfig = {}
local groupId = 50
local totalStep = 5
local current = 1

function GuideGroup_50:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_50:BindEvent()
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

function GuideGroup_50:UnBindEvent()
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

function GuideGroup_50:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_50:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_50:Step_1()
  self.msg = {
    BindIcon = "CharEquipmentPanel/----SafeAreaRoot----/----FunctionPanel----/EquipmentSlot/btnEquipmentSlot1",
    Deviation = {0, 0},
    Desc = "Guide_50_1",
    DescDeviation = {-690, 0},
    HandDeviation = {0, -200},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 1
  self.waitAnimTime = 0.7
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_50:Step_2()
  self.msg = {
    BindIcon = "EquipmentInfoPanel/----SafeAreaRoot----/window/goContent/--Active--/goMat",
    Deviation = {0, 0},
    Desc = "Guide_50_2",
    DescDeviation = {530, -170},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.7
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_50:Step_3()
  self.msg = {
    BindIcon = "EquipmentInfoPanel/----SafeAreaRoot----/window/goContent/--Active--/btnActive",
    Deviation = {0, 0},
    Desc = "Guide_50_3",
    DescDeviation = {530, 170},
    HandDeviation = {0, -100},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_50:Step_4()
  self.msg = {
    BindIcon = "EquipmentInfoPanel/----SafeAreaRoot----/window/goContent/--Info--/Image",
    Deviation = {0, 0},
    Desc = "Guide_50_4",
    DescDeviation = {460, 210},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 4
  self.waitAnimTime = 0.5
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_50:Step_5()
  self.msg = {
    BindIcon = "EquipmentInfoPanel/----SafeAreaRoot----/window/goContent/--Info--/btnEquip",
    Deviation = {0, 0},
    Desc = "Guide_50_5",
    DescDeviation = {660, 140},
    HandDeviation = {0, -100},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 5
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_50:FinishCurrentStep()
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

return GuideGroup_50
