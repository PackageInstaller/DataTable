local GuideGroup_8 = class("GuideGroup_8")
local mapEventConfig = {
  [EventId.ClosePanel] = "OnEvent_ClosePanel",
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById",
  Guide_RegionBossRefresh = "OnEvent_RegionBossRefresh",
  Guide_LoadCharacterSuccess = "OnEvent_LoadCharacterSuccess"
}
local groupId = 8
local totalStep = 3
local current = 1

function GuideGroup_8:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_8:BindEvent()
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

function GuideGroup_8:UnBindEvent()
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

function GuideGroup_8:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_8:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_8:Step_1()
  self.msg = {
    BindIcon = "RegionBossFormationPanel/----SafeAreaRoot----/---None---/SelectTeam/btnAddBuild",
    Size = {760, 500},
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_8_1",
    DescDeviation = {0, -400},
    HandDeviation = {-450, 0},
    HandRotation = -90,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_8:Step_2()
  self.msg = {
    BindIcon = "RegionBossBuildPanel/----SafeAreaRoot----/ExistContent/ListContent/BuildListContent/BuildList/Viewport/Content/0/btn_grid",
    Size = {500, 520},
    Deviation = {-3, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_8_2",
    DescDeviation = {1000, -260},
    HandDeviation = {300, 0},
    HandRotation = 90,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 2
  self.openPanelId = PanelId.RogueBossBuildBrief
  self.waitAnimTime = 0.3
end

function GuideGroup_8:Step_3()
  self.msg = {
    BindIcon = "RegionBossFormationPanel/----SafeAreaRoot----/btnStartBattle",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_8_3",
    DescDeviation = {-550, 160},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 3
end

function GuideGroup_8:OnEvent_PanelOnEnableById(_panelId)
  if self.openPanelId and self.openPanelId == _panelId and current == 3 then
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

function GuideGroup_8:OnEvent_RegionBossRefresh()
  if current == 2 then
    local bHasBuild = PlayerData.Build:CheckHasBuild()
    if not bHasBuild then
      self.parent:ClearCurGuide(true)
      return
    end
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_8:OnEvent_LoadCharacterSuccess()
  if current == 3 then
    self.parent:PlayTypeMask(self.msg)
  end
end

function GuideGroup_8:OnEvent_ClosePanel(nPanelId)
  if type(nPanelId) == "number" and nPanelId == PanelId.RogueBossBuildBrief and current == 1 then
    self.parent:ClearCurGuide(true)
  end
end

function GuideGroup_8:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.waitAnimTime = 0
  self.runGuide = false
  if current == 1 then
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {
      "newbie_tutorial_id",
      "24"
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

return GuideGroup_8
