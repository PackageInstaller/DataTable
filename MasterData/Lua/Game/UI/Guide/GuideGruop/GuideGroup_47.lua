local GuideGroup_47 = class("GuideGroup_47")
local mapEventConfig = {
  [EventId.ClosePanel] = "OnEvent_ClosePanel"
}
local groupId = 47
local totalStep = 3
local current = 1

function GuideGroup_47:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_47:BindEvent()
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

function GuideGroup_47:UnBindEvent()
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

function GuideGroup_47:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_47:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_47:Step_1()
  self.msg = {
    BindIcon = "StarTowerGrowthPanel/----SafeAreaRoot----/svNode/Viewport/NodeContent/KeyNodeList(Clone)",
    Size = {414, 400},
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_47_1",
    DescDeviation = {200, -300},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.waitAnimTime = 0.6
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.1))
    local tempRoot = GameObject.Find("---- UI ----").transform
    local btn = tempRoot:Find("StarTowerGrowthPanel/----SafeAreaRoot----/--Tab--/tab1/btnTab1"):GetComponent("UIButton")
    btn.onClick:Invoke()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_47:Step_2()
  self.msg = {
    BindIcon = "StarTowerGrowthPanel/----SafeAreaRoot----/TopBarPanel/Area/goBack/btnBack",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_47_2",
    DescDeviation = {650, -150},
    HandDeviation = {0, -100},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_47:Step_3()
  self.msg = {
    BindIcon = "LevelMenuPanel/----SafeAreaRoot----/---StarTower---/svStarTower",
    AutoDeviationCenter = true,
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_47_3",
    DescDeviation = {1620, -540},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_47:OnEvent_ClosePanel(nPanelId)
  if type(nPanelId) == "number" and nPanelId == PanelId.StarTowerGrowth and current == 2 then
    self.parent:ActiveHide(true)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
      self:Step_3()
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_47:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 1 then
    self:SendGuideStep(-1)
  elseif current == 2 then
    return
  elseif current == totalStep then
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

return GuideGroup_47
