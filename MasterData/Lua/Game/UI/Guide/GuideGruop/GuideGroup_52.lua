local LocalData = require("GameCore.Data.LocalData")
local GuideGroup_52 = class("GuideGroup_52")
local mapEventConfig = {
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById",
  OnEvent_SetNewQuestTaskIndex = "OnEvent_SetNewQuestTaskIndex"
}
local groupId = 52
local totalStep = 5
local current = 1
local taskId = 100101

function GuideGroup_52:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_52:BindEvent()
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

function GuideGroup_52:UnBindEvent()
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

function GuideGroup_52:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_52:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_52:Step_1()
  self.msg = {
    BindIcon = "MainViewPanel/----SafeAreaRoot----/HideRoot/--TopRight--/trBtnList/btnQuestNewbie",
    Size = {120, 120},
    Deviation = {0, 0},
    Desc = "Guide_52_1",
    DescDeviation = {-500, -280},
    HandDeviation = {0, -120},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
  LocalData.SetPlayerLocalData("TeamFormationQuestSelected", nil)
end

function GuideGroup_52:Step_2()
  self.msg = {
    BindIcon = "QuestNewbiePanel/----SafeAreaRoot----/rtTeamFormation/goTeamSelect/goFixTeams/btnTeam1",
    Deviation = {0, 2},
    Desc = "Guide_52_2",
    DescDeviation = {780, -350},
    HandDeviation = {0, -320},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 2
  self.openPanelId = PanelId.QuestNewbie
  self.waitAnimTime = 0.24
end

function GuideGroup_52:Step_3()
  self.msg = {
    BindIcon = "QuestNewbiePanel/----SafeAreaRoot----/rtTeamFormation/goQuestList/goCharList/imgCharListBg",
    Deviation = {0, 2},
    Desc = "Guide_52_3",
    DescDeviation = {920, -120},
    HandDeviation = {200, 0},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.4
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_52:Step_4()
  self.msg = {
    BindIcon = "QuestNewbiePanel/----SafeAreaRoot----/rtTeamFormation/goQuestList/goQuestGridList/questList/imgBg",
    Deviation = {0, 2},
    Desc = "Guide_52_4",
    DescDeviation = {-1000, -140},
    HandDeviation = {0, -120},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 4
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_52:Step_5()
  self.msg = {
    BindIcon = "QuestNewbiePanel/----SafeAreaRoot----/rtTeamFormation/goQuestList/goQuestGridList/questList/formationQuestLSV/Viewport/Content/0/btnGrid/AnimRoot/btnJump",
    Deviation = {0, 2},
    Desc = "Guide_52_5",
    DescDeviation = {-730, 0},
    HandDeviation = {0, -120},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 5
end

function GuideGroup_52:OnEvent_PanelOnEnableById(_panelId)
  if self.openPanelId and self.openPanelId == _panelId and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.5))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_52:OnEvent_SetNewQuestTaskIndex(index)
  if current == 5 then
    self.msg.BindIcon = "QuestNewbiePanel/----SafeAreaRoot----/rtTeamFormation/goQuestList/goQuestGridList/questList/formationQuestLSV/Viewport/Content/" .. index .. "/btnGrid/AnimRoot/btnJump"
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.1))
      self.parent:PlayTypeMask(self.msg)
      local tempRoot = GameObject.Find("---- UI ----").transform
      local tmpLS = tempRoot:Find("QuestNewbiePanel/----SafeAreaRoot----/rtTeamFormation/goQuestList/goQuestGridList/questList/formationQuestLSV"):GetComponent("LoopScrollView")
      tmpLS.enabled = false
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_52:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 1 then
    self:SendGuideStep(-1)
  end
  if current == totalStep then
    local tempRoot = GameObject.Find("---- UI ----").transform
    local tmpLS = tempRoot:Find("QuestNewbiePanel/----SafeAreaRoot----/rtTeamFormation/goQuestList/goQuestGridList/questList/formationQuestLSV"):GetComponent("LoopScrollView")
    tmpLS.enabled = true
    self.parent:ClearCurGuide(true)
    return
  elseif current == 4 then
    local mapAllTeamFormationQuestStatus = PlayerData.Quest:GetTeamFormationQuestData()
    local mapStatus = mapAllTeamFormationQuestStatus[taskId]
    if mapStatus ~= nil and mapStatus.nStatus == 0 then
      self:Step_5()
      EventManager.Hit("Guide_GetNewQuestTaskIndex", taskId)
    else
      self.parent:ClearCurGuide(true)
    end
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

return GuideGroup_52
