local GuideGroup_502 = class("GuideGroup_502")
local mapEventConfig = {
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById"
}
local groupId = 502
local totalStep = 3
local current = 1

function GuideGroup_502:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_502:BindEvent()
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

function GuideGroup_502:UnBindEvent()
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

function GuideGroup_502:SendGuideStep(step)
  local seasonId = PlayerData.SoldierData:GetCurSelectSeasonId()
  self.parent:SendGuideStep(groupId, step, AllEnum.GuideType.Soldier, seasonId)
end

function GuideGroup_502:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_502:Step_1()
  self.msg = {
    BindIcon = "SoldierMainViewPanel/----SafeAreaRoot---/AnimRoot/btn_Go",
    Deviation = {0, 0},
    Head = "Icon/Head/head_npc915201",
    Desc = "Guide_502_1",
    DescDeviation = {-860, 50},
    HandDeviation = {0, 150},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 1
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_502:Step_2()
  self.msg = {
    BindIcon = "SoldierLevelSelectPanel/----SafeAreaRoot---/AnimRoot/rtList/ScrollView/Viewport/Content/0/imgBg",
    Deviation = {0, 0},
    Head = "Icon/Head/head_npc915201",
    Desc = "Guide_502_2",
    DescDeviation = {0, -300},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  self.openPanelId = PanelId.SoldierLevelSelectPanel
  self.waitAnimTime = 0.2
  current = 2
end

function GuideGroup_502:Step_3()
  self.msg = {
    BindIcon = "SoldierLevelSelectPanel/----SafeAreaRoot---/AnimRoot/btn_Start",
    Deviation = {0, 0},
    Head = "Icon/Head/head_npc915201",
    Desc = "Guide_502_3",
    DescDeviation = {-700, 120},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_502:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  if current == totalStep then
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_502:OnEvent_PanelOnEnableById(_panelId)
  if self.openPanelId and self.openPanelId == _panelId and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
      
      local tempRoot = GameObject.Find("---- UI ----").transform
      local sv = tempRoot:Find("SoldierLevelSelectPanel/----SafeAreaRoot---/AnimRoot/rtList/ScrollView"):GetComponent("LoopScrollView")
      sv:SetScrollPos(0, 0.1)
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
      local max = sv:GetMaxUseGridIndex()
      self.msg.BindIcon = "SoldierLevelSelectPanel/----SafeAreaRoot---/AnimRoot/rtList/ScrollView/Viewport/Content/" .. max .. "/imgBg"
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

return GuideGroup_502
