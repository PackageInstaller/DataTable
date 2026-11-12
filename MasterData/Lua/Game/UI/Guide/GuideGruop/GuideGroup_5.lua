local GuideGroup_5 = class("GuideGroup_5")
local TimerManager = require("GameCore.Timer.TimerManager")
local mapEventConfig = {
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById",
  [EventId.ClosePanel] = "OnEvent_ClosePanel"
}
local groupId = 5
local totalStep = 6
local current = 1

function GuideGroup_5:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_5:BindEvent()
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

function GuideGroup_5:UnBindEvent()
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

function GuideGroup_5:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_5:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  if self.stepTimer then
    TimerManager.Remove(self.stepTimer)
    self.stepTimer = nil
  end
end

function GuideGroup_5:Step_1()
  self.msg = {
    BindIcon = "StarTowerBuildSavePanel/----SafeAreaRoot----/goBuildContent/ContentList/imgBg",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_5_1",
    DescDeviation = {-475, -520},
    Type = GameEnum.guidetype.Introductory
  }
  current = 1
  
  local function run()
    self.parent:PlayTypeMask(self.msg)
    self.stepTimer = nil
  end
  
  self.stepTimer = TimerManager.Add(1, 0.4, nil, run, true, true, true, nil)
end

function GuideGroup_5:Step_2()
  self.msg = {
    BindIcon = "StarTowerBuildSavePanel/----SafeAreaRoot----/goBuildContent/BuildDetail/imgRareScore",
    Size = {140, 160},
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_5_2",
    DescDeviation = {650, 0},
    Type = GameEnum.guidetype.Introductory
  }
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_5:Step_3()
  self.msg = {
    BindIcon = "StarTowerBuildSavePanel/----SafeAreaRoot----/goBuildContent/BuildDetail/imgBg",
    Size = {600, 640},
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_5_3",
    DescDeviation = {850, 200},
    Type = GameEnum.guidetype.Introductory
  }
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_5:Step_4()
  self.msg = {
    BindIcon = "StarTowerBuildSavePanel/----SafeAreaRoot----/goBuildContent/img_BottomBar/btnSave",
    Deviation = {0, 4},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_5_4",
    DescDeviation = {-750, 60},
    HandDeviation = {0, 180},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  current = 4
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_5:Step_5()
  current = 5
  self.nEntryId = 200201
  self.parent:ActiveHide(true)
end

function GuideGroup_5:Step_6()
  self.msg = {
    BindIcon = "StarTowerLevelSelect/----SafeAreaRoot----/TopBarPanel/Area/goBack/btnHome",
    Deviation = {0, 0},
    DescDeviation = {540, -280},
    HandDeviation = {0, -120},
    Type = GameEnum.guidetype.ForcedClick
  }
  current = 6
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_5:OnEvent_PanelOnEnableById(_panelId)
  if current == 5 and _panelId == PanelId.StarTowerLevelSelect then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.44999999999999996))
      
      EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, self.nEntryId)
      self.parent:ActiveHide(false)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_5:OnEvent_ClosePanel(nPanelId)
  if type(nPanelId) == "number" and nPanelId == PanelId.DictionaryEntry and current == 5 then
    self:Step_6()
  end
end

function GuideGroup_5:FinishCurrentStep()
  self.msg = nil
  self.waitAinEnd = nil
  self.runGuide = false
  if current == 4 then
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {
      "newbie_tutorial_id",
      "21"
    })
    NovaAPI.UserEventUpload("newbie_tutorial", tab)
  end
  if current == 1 then
    self:SendGuideStep(-1)
  elseif current == 4 then
    if PanelManager.CheckPanelOpen(PanelId.StarTowerLevelSelect) then
      self:Step_5()
    else
      self.parent:ClearCurGuide(true)
    end
    return
  elseif current == totalStep then
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_5:OnEvent_GuideAniEnd(aniName)
  if self.waitAinEnd and not self.runGuide and self.waitAinEnd == aniName then
    self.runGuide = true
    self.parent:PlayTypeMask(self.msg)
  end
end

return GuideGroup_5
