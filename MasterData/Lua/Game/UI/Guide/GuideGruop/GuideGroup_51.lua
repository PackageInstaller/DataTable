local GuideGroup_51 = class("GuideGroup_51")
local mapEventConfig = {}
local groupId = 51
local totalStep = 4
local current = 1

function GuideGroup_51:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_51:BindEvent()
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

function GuideGroup_51:UnBindEvent()
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

function GuideGroup_51:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_51:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_51:Step_1()
  self.msg = {
    BindIcon = "CharacterRelationPanel/----SafeAreaRoot----/Favorability/imgFavourHeartBg/imgHeartBg",
    Size = {300, 170},
    Deviation = {0, 40},
    Desc = "Guide_51_1",
    DescDeviation = {680, -120},
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

function GuideGroup_51:Step_2()
  self.msg = {
    BindIcon = "CharacterRelationPanel/----SafeAreaRoot----/Favorability/goFavourTask",
    Size = {160, 160},
    Deviation = {0, 0},
    Desc = "Guide_51_2",
    DescDeviation = {680, 0},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_51:Step_3()
  self.msg = {
    BindIcon = "CharacterRelationPanel/----SafeAreaRoot----/Favorability/goFavourReward",
    Size = {160, 160},
    Deviation = {0, 0},
    Desc = "Guide_51_3",
    DescDeviation = {680, 0},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_51:Step_4()
  self.msg = {
    BindIcon = "CharacterRelationPanel/----SafeAreaRoot----/CharRecordInfoRoot/PlotRoot/---PlotList---/sv/Viewport/Content/2",
    Deviation = {460, -98},
    Desc = "Guide_51_4",
    DescDeviation = {-570, -98},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 4
  local tempRoot = GameObject.Find("---- UI ----").transform
  local btn = tempRoot:Find("CharacterRelationPanel/----SafeAreaRoot----/CharRecordInfoRoot/tcGroup/recordTog3"):GetComponent("UIButton")
  btn.onClick:Invoke()
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_51:FinishCurrentStep()
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

return GuideGroup_51
