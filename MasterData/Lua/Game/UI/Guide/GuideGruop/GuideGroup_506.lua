local GuideGroup_506 = class("GuideGroup_506")
local TimerManager = require("GameCore.Timer.TimerManager")
local mapEventConfig = {}
local groupId = 506
local totalStep = 7
local current = 1

function GuideGroup_506:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_506:BindEvent()
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

function GuideGroup_506:UnBindEvent()
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

function GuideGroup_506:SendGuideStep(step)
  local seasonId = PlayerData.SoldierData:GetCurSelectSeasonId()
  self.parent:SendGuideStep(groupId, step, AllEnum.GuideType.Soldier, seasonId)
end

function GuideGroup_506:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  CS.AdventureModuleHelper.SetGuideLogicTimeScale(1)
end

function GuideGroup_506:Step_1()
  CS.AdventureModuleHelper.SetGuideLogicTimeScale(0)
  self.msg = {
    BindIcon = "SoldierRoomInfo/----SafeAreaRoot----/btnAutoBattleClose",
    Size = {120, 120},
    Deviation = {0, 0},
    Desc = "Guide_506_1",
    DescDeviation = {-410, -230},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_506:Step_2()
  self.msg = {
    BindIcon = "SoldierRoomInfo/----SafeAreaRoot----/btn_speed",
    Size = {120, 120},
    Deviation = {0, 0},
    Desc = "Guide_506_2",
    DescDeviation = {-410, -230},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_506:Step_3()
  self.msg = {
    BindIcon = "SoldierRoomInfo/----SafeAreaRoot----/goCharList/goMainChar2",
    Size = {420, 180},
    Deviation = {0, 0},
    Desc = "Guide_506_3",
    DescDeviation = {40, 250},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_506:Step_4()
  self.msg = {
    BindIcon = "SoldierRoomInfo/----SafeAreaRoot----/goCharList/goSubChar3",
    Size = {840, 180},
    Deviation = {70, 0},
    Desc = "Guide_506_4",
    DescDeviation = {40, 250},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 4
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_506:Step_5()
  self.msg = {
    BindIcon = "SoldierRoomInfo/----SafeAreaRoot----/goCharList/goSubChar3",
    Size = {840, 180},
    Deviation = {70, 0},
    Desc = "Guide_506_5",
    DescDeviation = {40, 250},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 5
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_506:Step_6()
  local levelData = PlayerData.SoldierData:GetCurLevelData()
  local tabM, tabS, tabO = levelData:GetDeploy()
  local tmpIndex = 0
  for _, v in ipairs(tabM) do
    if v.nPositionType == GameEnum.SoldierPositionType.FightPosition and v.nId ~= 0 then
      tmpIndex = v.nIndex
      break
    end
  end
  self.msg = {
    BindIcon = "SoldierRoomInfo/----SafeAreaRoot----/goCharList/goMainChar" .. tmpIndex .. "/btnItem",
    Size = {140, 180},
    Deviation = {0, 0},
    Desc = "Guide_506_6",
    DescDeviation = {610, 0},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 6
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_506:Step_7()
  self.msg = {
    BindIcon = "SoldierCharCardTipsPanel/----SafeAreaRoot----/rtContent/rtTipsPoint/imgTipsBg",
    Size = {630, 917},
    Deviation = {0, 440},
    Desc = "Guide_506_7",
    DescDeviation = {-890, 280},
    Type = GameEnum.guidetype.Introductory,
    isUITop = true
  }
  self.parent:ActiveHide(true)
  current = 7
  self.waitAnimTime = 0.3
  
  local function wait()
    self.parent:PlayTypeMask(self.msg)
  end
  
  TimerManager.Add(1, self.waitAnimTime, self, wait, true, false, false, nil)
end

function GuideGroup_506:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  if current < totalStep then
    self:SendGuideStep(current)
  elseif current == totalStep then
    self:SendGuideStep(-1)
    CS.AdventureModuleHelper.SetGuideLogicTimeScale(1)
    self.parent:ClearCurGuide(true)
    EventManager.Hit(EventId.ClosePanel, PanelId.SoldierCharCardTips)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

return GuideGroup_506
