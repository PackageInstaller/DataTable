local GuideGroup_16 = class("GuideGroup_16")
local mapEventConfig = {
  [EventId.ClosePanel] = "OnEvent_ClosePanel",
  RogueBossGuideFinish = "OnEvent_RogueBossGuideFinish",
  Guide_OpenRogueBossInfo = "OnEvent_Guide_OpenRogueBossInfo"
}
local groupId = 16
local totalStep = 3
local current = 1
local isCloseAuto = false

function GuideGroup_16:Init(parent, runStep)
  self:BindEvent()
  self.tabChar = {}
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_16:BindEvent()
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

function GuideGroup_16:UnBindEvent()
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

function GuideGroup_16:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_16:Clear()
  isCloseAuto = false
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  self.tabChar = nil
end

function GuideGroup_16:Step_1()
  self.msg = {
    BindIcon = "RogueBossSelect/----SafeAreaRoot----/rtBossList/svList",
    Size = {1500, 750},
    Deviation = {0, 10},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_16_1",
    DescDeviation = {0, -400},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.waitAnimTime = 0.6
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    if isCloseAuto then
      self.parent:ClearCurGuide(false)
      return
    end
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_16:Step_2()
  self.msg = {
    BindIcon = "RogueBossSelect/----SafeAreaRoot----/rtBossList/svList/Viewport/ContentTemp/gridTemp2/AnimRoot/btnGrid",
    Deviation = {0, 0},
    HandRotation = -180,
    HandDeviation = {0, 420},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.1
end

function GuideGroup_16:Step_3()
  self.msg = {
    BindIcon = "RogueBossSelect/----SafeAreaRoot----/rtBossInfo/rtBoss/titleReward",
    Size = {520, 240},
    Deviation = {4, -70},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_16_3",
    DescDeviation = {-220, -280},
    Type = GameEnum.guidetype.Introductory
  }
  current = 3
  self.waitAnimTime = 0.5
end

function GuideGroup_16:OnEvent_ClosePanel(nPanelId)
  if type(nPanelId) == "number" and nPanelId == PanelId.RogueBossLevel and current == 1 then
    self.parent:ClearCurGuide(true)
  end
end

function GuideGroup_16:OnEvent_Guide_OpenRogueBossInfo()
  if current == 2 then
    self:Step_3()
    if self.waitAnimTime ~= 0 then
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.5))
        
        self.parent:PlayTypeMask(self.msg)
      end
      
      cs_coroutine.start(wait)
    end
  end
end

function GuideGroup_16:FinishCurrentStep()
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
    table.insert(tab, {"action", "0"})
    table.insert(tab, {
      "normal_tutorial_id",
      "4"
    })
    NovaAPI.UserEventUpload("normal_tutorial", tab)
  elseif current == 2 then
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {"action", "1"})
    table.insert(tab, {
      "normal_tutorial_id",
      "4"
    })
    NovaAPI.UserEventUpload("normal_tutorial", tab)
  end
  if current == 2 then
    self:SendGuideStep(-1)
  end
  if current == totalStep then
    self.parent:ClearCurGuide(true)
    return
  end
  if current ~= 2 then
    local funName = "Step_" .. current + 1
    local func = handler(self, self[funName])
    func()
  end
  if self.openPanelId == nil and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_16:OnEvent_RogueBossGuideFinish()
  isCloseAuto = true
end

return GuideGroup_16
