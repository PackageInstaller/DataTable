local GuideGroup_504 = class("GuideGroup_504")
local mapEventConfig = {}
local groupId = 504
local totalStep = 9
local current = 1

function GuideGroup_504:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_504:BindEvent()
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

function GuideGroup_504:UnBindEvent()
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

function GuideGroup_504:SendGuideStep(step)
  local seasonId = PlayerData.SoldierData:GetCurSelectSeasonId()
  self.parent:SendGuideStep(groupId, step, AllEnum.GuideType.Soldier, seasonId)
end

function GuideGroup_504:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_504:Step_1()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----",
    Deviation = {0, 0},
    Desc = "Guide_504_1",
    DescDeviation = {0, -180},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_504:Step_2()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/TopContainer/NodeContainers/NodeLayout",
    Size = {674, 100},
    Deviation = {0, -50},
    Desc = "Guide_504_2",
    DescDeviation = {170, -230},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_504:Step_3()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/TopContainer/NodeContainers/ImageReputationIcon",
    Size = {200, 100},
    Deviation = {50, 0},
    Desc = "Guide_504_3",
    DescDeviation = {0, -230},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_504:Step_4()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/DownContainer/ImageWaitingBg",
    Size = {1468, 204},
    Deviation = {0, 0},
    Desc = "Guide_504_4",
    DescDeviation = {-210, 300},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 4
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_504:Step_5()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/MiddleContainer/ImgSandboxChess",
    Size = {1150, 620},
    Deviation = {0, 0},
    Desc = "Guide_504_5",
    DescDeviation = {350, 400},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 5
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_504:Step_6()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/MiddleContainer/EntranceContainer",
    Size = {496, 218},
    Deviation = {0, 0},
    Desc = "Guide_504_6",
    DescDeviation = {120, -230},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 6
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_504:Step_7()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/MiddleContainer/UpportingContainer",
    Size = {1046, 210},
    Deviation = {0, 0},
    Desc = "Guide_504_7",
    DescDeviation = {120, -230},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 7
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_504:Step_8()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/DownContainer/WaitingContainer/WaitingCardsLayout/WaitingCardItemTemplate1/HaveStatus/SoldierCharacterCardItem/btnItem/AnimRoot/goChar/imgPosition",
    Size = {40, 56},
    Deviation = {-20, -28},
    Desc = "Guide_504_8",
    DescDeviation = {570, 190},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 8
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_504:Step_9()
  current = 9
  local nEntryId = 400902
  EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, nEntryId)
  self.parent:FinishCurrentStep()
end

function GuideGroup_504:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
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
end

return GuideGroup_504
