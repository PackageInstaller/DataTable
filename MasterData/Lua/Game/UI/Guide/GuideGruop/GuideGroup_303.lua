local GuideGroup_303 = class("GuideGroup_303")
local mapEventConfig = {}
local groupId = 303
local totalStep = 3
local current = 1

function GuideGroup_303:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_303:BindEvent()
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

function GuideGroup_303:UnBindEvent()
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

function GuideGroup_303:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_303:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_303:Step_1()
  self.msg = {
    BindIcon = "PenguinCard_Normal/----SafeAreaRoot----/---Prepare---/--Info--/fxRotation/imgScoreBg/Image",
    Deviation = {100, -30},
    Size = {380, 160},
    Head = "Icon/Head/head_917301",
    Desc = "Guide_303_1",
    DescDeviation = {-700, -240},
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

function GuideGroup_303:Step_2()
  self.msg = {
    BindIcon = "PenguinCard_Normal/----SafeAreaRoot----/---Prepare---/--Info--/imgTurnBg",
    Deviation = {0, 0},
    Size = {660, 110},
    Head = "Icon/Head/head_917301",
    Desc = "Guide_303_2",
    DescDeviation = {0, -230},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_303:Step_3()
  self.msg = {
    BindIcon = "PenguinCard_Normal/----SafeAreaRoot----/---Prepare---/--Upgrade--",
    Deviation = {0, 70},
    Size = {420, 420},
    Head = "Icon/Head/head_917401",
    Desc = "Guide_303_3",
    DescDeviation = {800, -250},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_303:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 1 then
  elseif current == totalStep then
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

return GuideGroup_303
