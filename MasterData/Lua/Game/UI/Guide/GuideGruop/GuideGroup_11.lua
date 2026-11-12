local GuideGroup_11 = class("GuideGroup_11")
local mapEventConfig = {
  Positioning_StarTower_Grid = "OnEvent_PositioningStarTowerGrid",
  Guide_InitStarTowerFinish = "OnEvent_Guide_InitStarTowerFinish",
  Guide_LevelMenuOpen = "OnEvent_GuideLevelMenuOpen"
}
local groupId = 11
local totalStep = 4
local current = 1

function GuideGroup_11:Init(parent, runStep)
  self:BindEvent()
  self.tabChar = {}
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_11:BindEvent()
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

function GuideGroup_11:UnBindEvent()
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

function GuideGroup_11:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_11:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  self.tabChar = nil
end

function GuideGroup_11:Step_1()
  self.msg = {
    BindIcon = "MainViewPanel/----SafeAreaRoot----/HideRoot/--BottomRight--/btnMap",
    CloseObj = "MainViewPanel/----SafeAreaRoot----/HideRoot/--BottomRight--/btnMap/anti_scale",
    Size = {330, 200},
    Deviation = {10, -8},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_11_1",
    DescDeviation = {-750, 60},
    HandDeviation = {0, 180},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_11:Step_2()
  self.msg = {
    BindIcon = "LevelMenuPanel/----SafeAreaRoot----/imgPhoneBg/PhoneContent/LevelMenu/bgLeft/btnStarTower",
    Size = {420, 680},
    Deviation = {0, -2},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_11_2",
    DescDeviation = {-750, -250},
    HandDeviation = {-300, 22},
    HandRotation = -90,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 2
  self.openPanelId = PanelId.LevelMenu
  self.waitAnimTime = 0.5
end

function GuideGroup_11:Step_3()
  self.msg = {
    BindIcon = "LevelMenuPanel/----SafeAreaRoot----/---StarTower---/svStarTower/Viewport/Content/0/btnGrid",
    Size = {1030, 220},
    Deviation = {0, 6},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_11_3",
    DescDeviation = {1000, -228},
    HandDeviation = {0, 180},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  self.nStarTowerGroupId = 2
  current = 3
end

function GuideGroup_11:Step_4()
  self.msg = {
    BindIcon = "LevelMenuPanel/----SafeAreaRoot----/imgPhoneBg/PhoneContent/SecondMenu/StarTower/btnStarTowerGoto",
    Size = {420, 150},
    Deviation = {0, 0},
    HandDeviation = {0, 180},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 4
  self.waitAnimTime = 0.2
end

function GuideGroup_11:OnEvent_PositioningStarTowerGrid(nGroupId, gridName)
  if current == 3 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
      
      self.msg.BindIcon = "LevelMenuPanel/----SafeAreaRoot----/---StarTower---/svStarTower/Viewport/Content/" .. gridName .. "/btnGrid"
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_11:OnEvent_Guide_InitStarTowerFinish()
  if current == 3 and self.nStarTowerGroupId ~= nil then
    EventManager.Hit("Guide_PositionStarTowerPos", self.nStarTowerGroupId)
  end
end

function GuideGroup_11:OnEvent_GuideLevelMenuOpen()
  if current == 2 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_11:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
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

return GuideGroup_11
