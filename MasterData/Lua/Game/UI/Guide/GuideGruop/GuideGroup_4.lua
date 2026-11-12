local GuideGroup_4 = class("GuideGroup_4")
local mapEventConfig = {
  Positioning_Char_Grid = "OnEvent_PositioningCharGrid",
  Guide_LoadFormationSuccess = "OnEvent_LoadFormationSuccess",
  Guide_LoadCharacterSuccess = "OnEvent_LoadCharacterSuccess",
  Guide_InitStarTowerFinish = "OnEvent_Guide_InitStarTowerFinish"
}
local groupId = 4
local totalStep = 13
local current = 1

function GuideGroup_4:Init(parent, runStep)
  self:BindEvent()
  self.tabChar = {}
  self.parent = parent
  current = 1
  self.parent:ActiveHide(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(1.2))
    local funName = "Step_" .. current
    local func = handler(self, self[funName])
    func()
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_4:BindEvent()
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

function GuideGroup_4:UnBindEvent()
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

function GuideGroup_4:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_4:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  self.tabChar = nil
end

function GuideGroup_4:Step_1()
  local tbOption = {
    AllEnum.ChooseOption.Char_Element,
    AllEnum.ChooseOption.Char_Rarity,
    AllEnum.ChooseOption.Char_PowerStyle,
    AllEnum.ChooseOption.Char_AffiliatedForces,
    AllEnum.ChooseOption.Char_TacticalStyle
  }
  PlayerData.Filter:Reset(tbOption)
  self.msg = {
    BindIcon = "LevelMenuPanel/----SafeAreaRoot----/imgPhoneBg/PhoneContent/LevelMenu/bgLeft/btnStarTower",
    Size = {420, 680},
    Deviation = {0, -2},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_4_1",
    DescDeviation = {-750, -250},
    HandDeviation = {-300, 22},
    HandRotation = -90,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(false)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_4:Step_2()
  self.msg = {
    BindIcon = "LevelMenuPanel/----SafeAreaRoot----/imgPhoneBg/PhoneContent/SecondMenu/StarTower/btnStarTowerGoto",
    Size = {420, 150},
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_4_2",
    DescDeviation = {-900, 20},
    HandDeviation = {0, -270},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 2
end

function GuideGroup_4:Step_3()
  self.msg = {
    BindIcon = "StarTowerLevelSelect/----SafeAreaRoot----/rt_StarTowerInfo/rt_Info/btnGo",
    Deviation = {0, 4},
    Head = "Icon/Head/head_11101",
    HandDeviation = {0, 160},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  local _, tbTeamMemberId = PlayerData.Team:GetTeamData(1)
  if tbTeamMemberId ~= nil then
    local tmpDisc = PlayerData.Team:GetTeamDiscData(1)
    PlayerData.Team:UpdateFormationInfo(1, {
      0,
      0,
      0
    }, tmpDisc, 0)
  end
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.32
end

function GuideGroup_4:Step_4()
  self.msg = {
    BindIcon = "MainlineFormationScenePanel/----SafeAreaRoot----/----Char----/goChar1/btnSelect",
    Size = {180, 180},
    Deviation = {0, 100},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_4_4",
    DescDeviation = {-430, 300},
    HandDeviation = {0, -70},
    Type = GameEnum.guidetype.ForcedClick,
    CallB = function()
      EventManager.Hit("OnEvent_OpenSelectTeamMemberList", 1)
      EventManager.Hit("Guide_FormationChar_OpenList", 1, true)
    end
  }
  self.parent:ActiveHide(true)
  current = 4
end

function GuideGroup_4:Step_5()
  self.msg = {
    BindIcon = "MainlineFormationScenePanel/----SafeAreaRoot----/--CharList--/sv",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_4_5",
    DescDeviation = {-930, 300},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 5
  self.waitAnimTime = 0.25
end

function GuideGroup_4:Step_6()
  self.msg = {
    BindIcon = "MainlineFormationScenePanel/----SafeAreaRoot----/--CharList--/sv/Viewport/rtCharListContent/0/btnGrid",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_4_6",
    DescDeviation = {-730, 80},
    HandDeviation = {0, -200},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 6
  EventManager.Hit("Guide_PositionCharPos", 103)
end

function GuideGroup_4:Step_7()
  self.msg = {
    BindIcon = "MainlineFormationScenePanel/----SafeAreaRoot----/----Char----/goChar1/btnSelect",
    Deviation = {0, 50},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_4_7",
    DescDeviation = {870, 330},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 7
end

function GuideGroup_4:Step_8()
  self.msg = {
    BindIcon = "MainlineFormationScenePanel/----SafeAreaRoot----/--CharList--/sv/Viewport/rtCharListContent/0/btnGrid",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_4_8",
    DescDeviation = {-730, 80},
    HandDeviation = {0, -200},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 8
  EventManager.Hit("Guide_PositionCharPos", 111)
end

function GuideGroup_4:Step_9()
  self.msg = {
    BindIcon = "MainlineFormationScenePanel/----SafeAreaRoot----/--CharList--/sv/Viewport/rtCharListContent/0/btnGrid",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_4_9",
    DescDeviation = {-730, 80},
    HandDeviation = {0, -200},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 9
  EventManager.Hit("Guide_PositionCharPos", 112)
end

function GuideGroup_4:Step_10()
  self.msg = {
    BindIcon = "MainlineFormationScenePanel/----SafeAreaRoot----/----Char----/goChar2/btnSelect",
    Size = {520, 850},
    Deviation = {15, 50},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_4_10",
    DescDeviation = {870, 330},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 10
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_4:Step_11()
  self.msg = {
    BindIcon = "MainlineFormationScenePanel/----SafeAreaRoot----/--CharList--/btnConfirm",
    Deviation = {0, 4},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_4_11",
    DescDeviation = {-580, 180},
    HandDeviation = {0, 140},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 11
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_4:Step_12()
  local tmpDisc = PlayerData.Team:GetTeamDiscData(1)
  local haveDis = false
  for i, v in pairs(tmpDisc) do
    if v ~= 0 then
      haveDis = true
      break
    end
  end
  if haveDis then
    local _, tbTeamMemberId = PlayerData.Team:GetTeamData(1)
    PlayerData.Team:UpdateFormationInfo(1, tbTeamMemberId, {
      0,
      0,
      0,
      0,
      0,
      0
    }, 0)
  end
  self.msg = {
    BindIcon = "MainlineFormationScenePanel/----SafeAreaRoot----/btnStartBattle",
    Deviation = {0, 4},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_4_12",
    DescDeviation = {-580, 180},
    HandDeviation = {0, 140},
    HandDeviation = {0, 140},
    HandRotation = 180,
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 12
  self.waitAnimTime = 0.2
end

function GuideGroup_4:Step_13()
  self.msg = {
    BindIcon = "MainlineFormationScenePanel/----SafeAreaRoot----/btnFastFormation",
    Deviation = {0, 4},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_4_13",
    DescDeviation = {-580, 180},
    HandDeviation = {0, 140},
    HandDeviation = {0, 140},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 13
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_4:OnEvent_PositioningCharGrid(charId, gridName)
  if self.tabChar == nil then
    self.tabChar = {}
  end
  self.tabChar[charId] = gridName
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if current == 6 or current == 8 or current == 9 or current == 10 then
      self.msg.BindIcon = "MainlineFormationScenePanel/----SafeAreaRoot----/--CharList--/sv/Viewport/rtCharListContent/" .. gridName .. "/btnGrid"
      self.parent:PlayTypeMask(self.msg)
    end
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_4:OnEvent_LoadFormationSuccess()
  if current == 4 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.8))
      
      EventManager.Hit("Guide_FormationChar_OpenList", 1, false)
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_4:OnEvent_LoadCharacterSuccess()
  if current == 7 then
    self.parent:PlayTypeMask(self.msg)
  end
end

function GuideGroup_4:OnEvent_OpenStarTowerLevelMenu()
  if current == 1 then
    self.parent:ActiveHide(true)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(1))
      self:Step_2()
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_4:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 1 then
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {
      "newbie_tutorial_id",
      "15"
    })
    NovaAPI.UserEventUpload("newbie_tutorial", tab)
  elseif current == 12 then
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {
      "newbie_tutorial_id",
      "16"
    })
    NovaAPI.UserEventUpload("newbie_tutorial", tab)
  end
  if current < 12 then
    self:SendGuideStep(current)
    local funName = "Step_" .. current + 1
    local func = handler(self, self[funName])
    func()
  elseif current == 12 then
    self:SendGuideStep(-1)
    local charCount = PlayerData.Char:GetAllCharCount()
    if charCount <= 3 then
      self.parent:ClearCurGuide(true)
    else
      self:Step_13()
    end
    return
  elseif current == 13 then
    self.parent:ClearCurGuide(true)
    return
  end
  if self.openPanelId == nil and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_4:OnEvent_Guide_InitStarTowerFinish()
  if current == 2 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(1.2))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

return GuideGroup_4
