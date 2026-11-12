local GuideGroup_21 = class("GuideGroup_21")
local mapEventConfig = {}
local groupId = 21
local totalStep = 3
local current = 1

function GuideGroup_21:Init(parent, runStep)
  self:BindEvent()
  self.tabChar = {}
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_21:BindEvent()
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

function GuideGroup_21:UnBindEvent()
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

function GuideGroup_21:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_21:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  self.tabChar = nil
end

function GuideGroup_21:Step_1()
  local LocalData = require("GameCore.Data.LocalData")
  local nIdx = LocalData.GetPlayerLocalData("SavedTeamIdx")
  if nIdx == nil then
    nIdx = 1
  end
  local tmpDisc = PlayerData.Team:GetTeamDiscData(nIdx)
  local haveDis = false
  for i, v in pairs(tmpDisc) do
    if v ~= 0 then
      haveDis = true
      break
    end
  end
  if haveDis then
    local _, tbTeamMemberId = PlayerData.Team:GetTeamData(nIdx)
    
    local function Callback()
      EventManager.Hit("Guide_RefreshDiscFormation")
    end
    
    PlayerData.Team:UpdateFormationInfo(1, tbTeamMemberId, {
      0,
      0,
      0,
      0,
      0,
      0
    }, 0, Callback)
  end
  self.msg = {
    BindIcon = "MainlineFormationDiscPanelEx/----SafeAreaRoot----/rtSelect/rtCur",
    Size = {2100, 690},
    Deviation = {0, 26},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_21_1",
    DescDeviation = {0, -425},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_21:Step_2()
  self.msg = {
    BindIcon = "MainlineFormationDiscPanelEx/----SafeAreaRoot----/bottomBtnList/btnFastFormation",
    Size = {320, 110},
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    HandDeviation = {0, 150},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.1
end

function GuideGroup_21:Step_3()
  self.msg = {
    BindIcon = "MainlineFormationDiscPanelEx/----SafeAreaRoot----/bottomBtnList/btnStartBattle",
    Size = {330, 110},
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_21_3",
    DescDeviation = {-800, 20},
    HandDeviation = {0, 150},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.1
end

function GuideGroup_21:FinishCurrentStep()
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
      "17"
    })
    NovaAPI.UserEventUpload("newbie_tutorial", tab)
  elseif current == 3 then
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {
      "newbie_tutorial_id",
      "18"
    })
    NovaAPI.UserEventUpload("newbie_tutorial", tab)
  end
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

return GuideGroup_21
