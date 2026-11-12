local GuideGroup_30 = class("GuideGroup_30")
local mapEventConfig = {
  Guide_OpenStarTowerDepot = "OnEvent_OpenStarTowerDepot"
}
local groupId = 30
local totalStep = 3
local current = 1

function GuideGroup_30:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  if PlayerData.Base:GetWorldClass() >= 6 then
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
    return
  end
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_30:BindEvent()
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

function GuideGroup_30:UnBindEvent()
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

function GuideGroup_30:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_30:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_30:Step_1()
  EventManager.Hit("Guide_SelectQuestPage", AllEnum.QuestPanelTab.WorldClass)
  self.msg = {
    BindIcon = "QuestPanel/----SafeAreaRoot----/rtWorldClass/rtLevel",
    Size = {500, 500},
    Deviation = {0, -138},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_30_1",
    DescDeviation = {850, -370},
    Type = GameEnum.guidetype.Introductory
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
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_30:Step_2()
  self.msg = {
    BindIcon = "QuestPanel/----SafeAreaRoot----/rtWorldClass/rtWorldClassList/worldClassLsv/Viewport/Content/1/btnGrid",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_30_2",
    DescDeviation = {-770, -370},
    HandDeviation = {0, -150},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.4
end

function GuideGroup_30:Step_3()
  self.msg = {
    BindIcon = "QuestPanel/----SafeAreaRoot----/rtWorldClass/rtLevelInfo/rtQuestLsv/questLsv/Viewport/Content",
    Size = {970, 400},
    Deviation = {490, -200},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_30_3",
    DescDeviation = {-480, -450},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.3
end

function GuideGroup_30:OnEvent_OpenStarTowerDepot()
  if current == 2 then
    EventManager.Hit("Guide_SelectDepotTog", 3)
    self:Step_3()
    if self.waitAnimTime ~= 0 then
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
        
        self.parent:PlayTypeMask(self.msg)
      end
      
      cs_coroutine.start(wait)
    else
      self.parent:PlayTypeMask(self.msg)
    end
  end
end

function GuideGroup_30:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  self.nStarTowerGroupId = 0
  if current == 2 then
    self:SendGuideStep(-1)
  elseif current < 2 then
    self:SendGuideStep(current)
  end
  if current == totalStep then
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

return GuideGroup_30
