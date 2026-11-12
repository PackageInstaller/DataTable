local GuideGroup_28 = class("GuideGroup_28")
local mapEventConfig = {}
local groupId = 28
local totalStep = 3
local current = 1

function GuideGroup_28:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local bHasSubDisc = false
  local LocalData = require("GameCore.Data.LocalData")
  local nIdx = LocalData.GetPlayerLocalData("SavedTeamIdx")
  if nIdx == nil then
    nIdx = 1
  end
  local tmpDisc = PlayerData.Team:GetTeamDiscData(nIdx)
  if 3 < #tmpDisc and tmpDisc[4] ~= 0 then
    bHasSubDisc = true
  end
  if not bHasSubDisc then
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_28:BindEvent()
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

function GuideGroup_28:UnBindEvent()
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

function GuideGroup_28:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_28:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_28:Step_1()
  self.msg = {
    BindIcon = "MainlineFormationDiscPanelEx/----SafeAreaRoot----/rtSubDisc",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_28_1",
    DescDeviation = {-950, 250},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_28:Step_2()
  self.msg = {
    BindIcon = "MainlineFormationDiscPanelEx/----SafeAreaRoot----/rtSubDisc/imgNoteInfoBg",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_28_2",
    DescDeviation = {-750, 150},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.1
end

function GuideGroup_28:Step_3()
  self.msg = {
    BindIcon = "MainlineFormationDiscPanelEx/----SafeAreaRoot----/bottomBtnList/btnStartBattle",
    Size = {330, 110},
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_28_3",
    DescDeviation = {-800, 50},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.1
end

function GuideGroup_28:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  self.nStarTowerGroupId = 0
  if current == 1 then
    self:SendGuideStep(-1)
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

return GuideGroup_28
