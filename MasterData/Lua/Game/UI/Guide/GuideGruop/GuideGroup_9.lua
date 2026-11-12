local GuideGroup_9 = class("GuideGroup_9")
local mapEventConfig = {
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById",
  [EventId.ClosePanel] = "OnEvent_ClosePanel",
  Guide_ReceiveWorldClassReward = "OnEvent_ReceiveWorldClassReward"
}
local groupId = 9
local totalStep = 4
local current = 1

function GuideGroup_9:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_9:BindEvent()
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

function GuideGroup_9:UnBindEvent()
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

function GuideGroup_9:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_9:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  EventManager.Hit("Guide_DisableScrollView", false)
end

function GuideGroup_9:Step_1()
  self.msg = {
    BindIcon = "QuestPanel/----SafeAreaRoot----/rtGuideQuest/imgChapterBg",
    Deviation = {0, 0},
    Desc = "Guide_9_1",
    DescDeviation = {-500, -280},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.4))
    EventManager.Hit("Guide_SelectQuestPage", AllEnum.QuestPanelTab.GuideQuest)
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.1))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_9:Step_2()
  self.msg = {
    BindIcon = "QuestPanel/----SafeAreaRoot----/rtTab/trTabOff/tab4/btnTab4",
    Deviation = {0, 0},
    Desc = "Guide_9_2",
    DescDeviation = {0, 350},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.1
end

function GuideGroup_9:Step_3()
  EventManager.Hit("Guide_DisableScrollView", true)
  self.msg = {
    BindIcon = "QuestPanel/----SafeAreaRoot----/rtWorldClass/rtLevelInfo/rtLevelLsv/levelLsv/Viewport/Content/1/btnGrid/AnimRoot/imgBg/goLevel/btnReceive",
    Deviation = {0, 0},
    Desc = "Guide_9_3",
    DescDeviation = {-800, -130},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.5
end

function GuideGroup_9:Step_4()
  self.msg = {
    BindIcon = "QuestPanel/----SafeAreaRoot----/rtWorldClass/rtLevel",
    Size = {350, 380},
    Deviation = {0, -30},
    Desc = "Guide_9_4",
    DescDeviation = {550, -210},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 4
  self.waitAnimTime = 0.2
end

function GuideGroup_9:OnEvent_PanelOnEnableById(_panelId)
  if self.openPanelId and self.openPanelId == _panelId and current == 2 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_9:OnEvent_ClosePanel(nPanelId)
  if nPanelId ~= nil and nPanelId == PanelId.Quest then
    self.parent:ClearCurGuide(true)
  end
end

function GuideGroup_9:OnEvent_ReceiveWorldClassReward()
  if current == 3 then
    self:Step_4()
    if self.waitAnimTime ~= 0 then
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
        
        self.parent:PlayTypeMask(self.msg)
      end
      
      cs_coroutine.start(wait)
    end
  end
end

function GuideGroup_9:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 3 then
    self:SendGuideStep(-1)
  elseif current < 3 then
    self:SendGuideStep(current)
  end
  if current == totalStep then
    self.parent:ClearCurGuide(true)
    return
  end
  if current == 2 then
    local bUnReceive = PlayerData.Base:GetWorldClassState(2)
    if not bUnReceive then
      self:SendGuideStep(-1)
      self.parent:ClearCurGuide(true)
      return
    end
  elseif current == 3 then
    EventManager.Hit("Guide_DisableScrollView", false)
  end
  if current ~= 3 then
    local funName = "Step_" .. current + 1
    local func = handler(self, self[funName])
    func()
  end
  if self.openPanelId == nil and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

return GuideGroup_9
