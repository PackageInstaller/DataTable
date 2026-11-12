local GuideGroup_12 = class("GuideGroup_12")
local mapEventConfig = {
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById",
  Guide_OpenStarTowerLevelGroup = "OnEvent_OpenStarTowerLevelGroup"
}
local groupId = 12
local totalStep = 6
local current = 1

function GuideGroup_12:Init(parent, runStep)
  self:BindEvent()
  self.tabChar = {}
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_12:BindEvent()
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

function GuideGroup_12:UnBindEvent()
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

function GuideGroup_12:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_12:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  self.tabChar = nil
end

function GuideGroup_12:Step_1()
  self.msg = {
    BindIcon = "StarTowerLevelSelect/----SafeAreaRoot----/rt_StarTowerInfo/rt_Toggle",
    Size = {530, 870},
    Deviation = {-40, 0},
    Desc = "Guide_12_1",
    DescDeviation = {900, -200},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.waitAnimTime = 0.2
end

function GuideGroup_12:Step_2()
  self.msg = {
    BindIcon = "StarTowerLevelSelect/----SafeAreaRoot----/rt_StarTowerInfo/rt_Info/TMPStarTowerName",
    Size = {800, 300},
    Deviation = {370, -102},
    Desc = "Guide_12_2",
    DescDeviation = {112, -576},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.2
end

function GuideGroup_12:Step_3()
  self.msg = {
    BindIcon = "StarTowerLevelSelect/----SafeAreaRoot----/rt_StarTowerInfo/rt_Info/btnGo",
    Deviation = {0, 4},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_12_3",
    DescDeviation = {-800, 20},
    HandDeviation = {0, 180},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.32
end

function GuideGroup_12:Step_4()
  self.msg = {
    BindIcon = "MainlineFormationScenePanel/----SafeAreaRoot----/----Char----/goChar1/btnSelect",
    Size = {600, 280},
    Deviation = {0, -140},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_12_4",
    DescDeviation = {-77, -362},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 4
  self.openPanelId = PanelId.MainlineFormation
  self.waitAnimTime = 0.2
end

function GuideGroup_12:Step_5()
  self.msg = {
    BindIcon = "MainlineFormationScenePanel/----SafeAreaRoot----/btnFastFormation",
    Deviation = {0, 0},
    Desc = "Guide_12_5",
    DescDeviation = {-800, 200},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 5
  self.waitAnimTime = 0.2
end

function GuideGroup_12:Step_6()
  self.msg = {
    BindIcon = "MainlineFormationScenePanel/----SafeAreaRoot----/btnStartBattle",
    Deviation = {0, 2},
    Head = "Icon/Head/head_11101",
    HandDeviation = {0, 120},
    Desc = "Guide_12_6",
    DescDeviation = {-800, 200},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 6
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_12:OnEvent_PanelOnEnableById(_panelId)
  if self.openPanelId and self.openPanelId == _panelId and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.5))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_12:OnEvent_OpenStarTowerLevelGroup(nGroup)
  if nGroup ~= 2 then
    self.parent:ClearCurGuide(false)
    return
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_12:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  self.nStarTowerGroupId = 0
  if current == 2 then
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {"action", "0"})
    table.insert(tab, {
      "normal_tutorial_id",
      "2"
    })
    NovaAPI.UserEventUpload("normal_tutorial", tab)
  elseif current == 7 then
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {"action", "1"})
    table.insert(tab, {
      "normal_tutorial_id",
      "2"
    })
    NovaAPI.UserEventUpload("normal_tutorial", tab)
  end
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

return GuideGroup_12
