local GuideGroup_45 = class("GuideGroup_45")
local mapEventConfig = {}
local groupId = 45
local totalStep = 4
local current = 1

function GuideGroup_45:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_45:BindEvent()
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

function GuideGroup_45:UnBindEvent()
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

function GuideGroup_45:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_45:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_45:Step_1()
  self.msg = {
    BindIcon = "CharDevelopmentPanel/----SafeAreaRoot----/---Advance---/rtInfo/rtUp",
    Size = {840, 460},
    Deviation = {0, 20},
    Desc = "Guide_45_1",
    DescDeviation = {-840, -280},
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

function GuideGroup_45:Step_2()
  self.msg = {
    BindIcon = "CharDevelopmentPanel/----SafeAreaRoot----/---Advance---/rtInfo/rtUp",
    Size = {840, 240},
    Deviation = {0, 10},
    Desc = "Guide_45_2",
    DescDeviation = {-840, -280},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_45:Step_3()
  self.msg = {
    BindIcon = "CharDevelopmentPanel/----SafeAreaRoot----/---Advance---/rtMat/svMat/Viewport/Content/goMat1",
    Deviation = {0, 0},
    Desc = "Guide_45_3",
    DescDeviation = {-620, -50},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_45:Step_4()
  self.msg = {
    BindIcon = "CharDevelopmentPanel/----SafeAreaRoot----/---Advance---/btnAdvance",
    Deviation = {0, 0},
    Desc = "Guide_45_4",
    DescDeviation = {-880, -20},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 4
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_45:FinishCurrentStep()
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

return GuideGroup_45
