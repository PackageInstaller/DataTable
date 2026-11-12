local GuideGroup_19 = class("GuideGroup_19")
local mapEventConfig = {
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById"
}
local groupId = 19
local totalStep = 4
local current = 1

function GuideGroup_19:Init(parent, runStep)
  self:BindEvent()
  self.tabChar = {}
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_19:BindEvent()
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

function GuideGroup_19:UnBindEvent()
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

function GuideGroup_19:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_19:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  self.tabChar = nil
end

function GuideGroup_19:Step_1()
  self.msg = {
    BindIcon = "LevelMenuPanel/----SafeAreaRoot----/imgPhoneBg/PhoneContent/LevelMenu/btnResource",
    Size = {450, 360},
    Deviation = {0, 170},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_19_1",
    DescDeviation = {-800, -40},
    HandDeviation = {-300, 160},
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

function GuideGroup_19:Step_2()
  self.msg = {
    BindIcon = "LevelMenuPanel/----SafeAreaRoot----/---Resource---/svResource/Viewport/Content/btnEquipment",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_19_2",
    DescDeviation = {760, -360},
    HandDeviation = {0, 200},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.4
end

function GuideGroup_19:Step_3()
  self.msg = {
    BindIcon = "LevelMenuPanel/----SafeAreaRoot----/imgPhoneBg/PhoneContent/SecondMenu/Resource/btnResourceGoto",
    Size = {870, 410},
    Deviation = {0, 140},
    Head = "Icon/Head/head_11101",
    HandDeviation = {0, 450},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.1
end

function GuideGroup_19:Step_4()
  self.msg = {
    BindIcon = "SkillInstanceLevelSelect/----SafeAreaRoot----/rt_SkillInstanceSelect/---LevelList---",
    Size = {1500, 750},
    Deviation = {-501, 13},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_19_4",
    DescDeviation = {-500, -400},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  self.openPanelId = PanelId.SkillInstanceLevelSelect
  current = 4
  self.waitAnimTime = 0.3
end

function GuideGroup_19:OnEvent_PanelOnEnableById(_panelId)
  if self.openPanelId and self.openPanelId == _panelId and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_19:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current < totalStep then
    self:SendGuideStep(current)
  elseif current == totalStep then
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
    return
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

return GuideGroup_19
