local GuideGroup_2 = class("GuideGroup_2")
local mapEventConfig = {
  Guide_GachaFinish = "OnEvent_Guide_GachaFinish",
  Guide_GachaOpen = "OnEvent_Guide_GachaOpen",
  [EventId.ClosePanel] = "OnEvent_ClosePanel",
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById"
}
local groupId = 2
local totalStep = 4
local current = 1
local itemId = 503

function GuideGroup_2:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_2:BindEvent()
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

function GuideGroup_2:UnBindEvent()
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

function GuideGroup_2:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_2:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_2:Step_1()
  current = 1
  self.parent:ActiveHide(true)
  
  local function callback()
    self.openPanelId = PanelId.GachaSpin
    
    local function func()
      EventManager.Hit(EventId.OpenPanel, PanelId.GachaSpin, 5)
    end
    
    EventManager.Hit(EventId.SetTransition, 6, func, AllEnum.MainViewCorner.Recruit)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.Gacha, callback)
end

function GuideGroup_2:Step_2()
  current = 2
  self.msg = {
    BindIcon = "GachaPanel/----SafeAreaRoot----/btn_NewBieJump",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_2_1",
    DescDeviation = {-800, 40},
    HandDeviation = {0, 200},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  self.waitAnimTime = 0.8
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_2:Step_3()
  EventManager.Hit("Guide_GachaStart", false)
  self.msg = {
    BindIcon = "GachaPanel/----GachaNewbie----/GachaNewBieShowResult/----SafeareaRoot----/right_down/btn_newbie_save",
    Deviation = {0, 0},
    Desc = "Guide_2_2",
    DescDeviation = {-730, 50},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.8
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_2:Step_4()
  self.msg = {
    BindIcon = "GachaPanel/----GachaNewbie----/GachaNewBieShowResult/----SafeareaRoot----/left_down/btn_newbie_record",
    Deviation = {0, 0},
    Desc = "Guide_2_3",
    DescDeviation = {800, 0},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 4
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_2:OnEvent_Guide_GachaOpen()
  if current == 1 then
    self:Step_2()
  end
end

function GuideGroup_2:OnEvent_Guide_GachaFinish()
  if current == 2 then
    self:Step_3()
  end
end

function GuideGroup_2:OnEvent_ClosePanel(nPanelId)
end

function GuideGroup_2:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 2 then
    self:SendGuideStep(-1)
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    NovaAPI.UserEventUpload("first_gacha10", tab)
    local tab_1 = {}
    table.insert(tab_1, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab_1, {
      "newbie_tutorial_id",
      "14"
    })
    NovaAPI.UserEventUpload("newbie_tutorial", tab_1)
    EventManager.Hit("Guide_GachaStart", true)
  elseif current == 3 then
    self:Step_4()
  elseif current == 4 then
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

return GuideGroup_2
