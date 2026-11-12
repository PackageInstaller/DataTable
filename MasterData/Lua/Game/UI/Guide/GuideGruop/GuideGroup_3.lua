local GuideGroup_3 = class("GuideGroup_3")
local mapEventConfig = {
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById"
}
local groupId = 3
local totalStep = 2
local current = 1
local NewBieId = 5

function GuideGroup_3:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  if PlayerData.Gacha:GetGachaNewbieData(NewBieId).Receive == false then
    local function callback()
      if PlayerData.Gacha:GetGachaNewbieData(NewBieId).Receive == false then
        current = 1
      else
        current = 2
      end
      local funName = "Step_" .. current
      local func = handler(self, self[funName])
      func()
    end
    
    PlayerData.Gacha:GetGachaNewbieInfomation(callback)
    return
  else
    current = 2
  end
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_3:BindEvent()
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

function GuideGroup_3:UnBindEvent()
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

function GuideGroup_3:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_3:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_3:Step_1()
  local function confirmCallback()
    self:Step_2()
  end
  
  local function cancelCallback()
    local function func()
      EventManager.Hit(EventId.OpenPanel, PanelId.GachaSpin, 5)
    end
    
    EventManager.Hit(EventId.SetTransition, 6, func, AllEnum.MainViewCorner.Recruit)
    self.parent:ClearCurGuide(false)
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Guide_3_1"),
    callbackConfirm = confirmCallback,
    callbackCancel = cancelCallback
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
  self.parent:ActiveHide(true)
  current = 1
end

function GuideGroup_3:Step_2()
  self.msg = {
    BindIcon = "MainViewPanel/----SafeAreaRoot----/HideRoot/--BottomRight--/btnMap",
    CloseObj = "MainViewPanel/----SafeAreaRoot----/HideRoot/--BottomRight--/btnMap/anti_scale",
    Size = {330, 200},
    Deviation = {10, -8},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_3_2",
    DescDeviation = {-750, 60},
    HandDeviation = {0, 180},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_3:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 2 then
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
  end
  if self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

return GuideGroup_3
