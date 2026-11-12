local GuideGroup_508 = class("GuideGroup_508")
local mapEventConfig = {}
local groupId = 508
local totalStep = 5
local current = 1

function GuideGroup_508:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_508:BindEvent()
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

function GuideGroup_508:UnBindEvent()
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

function GuideGroup_508:SendGuideStep(step)
  local seasonId = PlayerData.SoldierData:GetCurSelectSeasonId()
  self.parent:SendGuideStep(groupId, step, AllEnum.GuideType.Soldier, seasonId)
end

function GuideGroup_508:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_508:Step_1()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/LeftContainer/PartnerList",
    Size = {300, 500},
    AutoDeviationCenter = true,
    Deviation = {120, -240},
    Desc = "Guide_508_1",
    DescDeviation = {921.0, -379.0},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_508:Step_2()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/LeftContainer/PartnerList/PartnerContainer/Viewport/Content/0",
    Size = {220, 100},
    Deviation = {170, -40},
    Desc = "Guide_508_2",
    DescDeviation = {920, -140},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_508:Step_3()
  self.msg = {
    BindIcon = "SoldierPartnerTipsPanel/----SafeAreaRoot----/rtContent/rtTipsPoint/imgTipsBg/TipsView/Viewport/TipsContent/goPartnerTitle/btnTrace",
    Deviation = {-60, 30},
    Desc = "Guide_508_3",
    DescDeviation = {570, -200},
    Type = GameEnum.guidetype.Introductory,
    isUITop = true
  }
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.3
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_508:Step_4()
  self.msg = {
    BindIcon = "SoldierPartnerTipsPanel/----SafeAreaRoot----/rtContent/rtTipsPoint/imgTipsBg",
    Deviation = {0, 0},
    Desc = "Guide_508_4",
    DescDeviation = {570, 0},
    Type = GameEnum.guidetype.Introductory,
    isUITop = true,
    AutoDeviationTop = true
  }
  self.parent:ActiveHide(true)
  current = 4
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_508:Step_5()
  current = 5
  local nEntryId = 400903
  EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, nEntryId)
  self.parent:FinishCurrentStep()
end

function GuideGroup_508:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 3 then
    self:SendGuideStep(-1)
  elseif current == 4 then
    EventManager.Hit(EventId.ClosePanel, PanelId.SoldierPartnerTips)
  elseif current == totalStep then
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

return GuideGroup_508
