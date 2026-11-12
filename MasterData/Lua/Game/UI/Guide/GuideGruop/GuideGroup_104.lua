local GuideGroup_104 = class("GuideGroup_104")
local mapEventConfig = {
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById",
  Show_MainView_UI = "ShowMainViewUI",
  [EventId.ClosePanel] = "OnEvent_ClosePanel"
}
local groupId = 104
local totalStep = 5
local current = 1

function GuideGroup_104:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_104:BindEvent()
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

function GuideGroup_104:UnBindEvent()
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

function GuideGroup_104:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_104:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_104:Step_1()
  self.msg = {
    BindIcon = "CharFgPanel/----SafeAreaRoot----/TopBarPanel/Area/goBack/btnHome",
    Deviation = {0, 0},
    Desc = "Guide_104_1",
    DescDeviation = {540, -280},
    HandDeviation = {0, -120},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(false)
  current = 1
end

function GuideGroup_104:Step_2()
  self.msg = {
    BindIcon = "MainViewPanel/----SafeAreaRoot----/HideRoot/--BottomLeft--/trBoardBtnList/btnSwitchActor2D",
    Size = {90, 110},
    Deviation = {0, 0},
    DescDeviation = {650, 60},
    HandDeviation = {0, -120},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(false)
  current = 2
end

function GuideGroup_104:Step_3()
  self.msg = {
    BindIcon = "ChooseHomePageRolePanel/----SafeAreaRoot----/---Right---/goNotEmpty/sv",
    Deviation = {0, 0},
    Desc = "Guide_104_2",
    DescDeviation = {-850, 340},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.openPanelId = PanelId.ChooseHomePageRolePanel
  self.waitAnimTime = 0.24
end

function GuideGroup_104:Step_4()
  self.msg = {
    BindIcon = "ChooseHomePageRolePanel/----SafeAreaRoot----/---Left---/btnChange",
    Deviation = {100, 0},
    Desc = "Guide_104_3",
    DescDeviation = {760, 40},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 4
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_104:Step_5()
  EventManager.Hit("Guide_ChangeCharShowOrder")
  self.msg = {
    BindIcon = "ChooseHomePageRolePanel/----SafeAreaRoot----/---Left---/imgListBg",
    Deviation = {0, 0},
    Desc = "Guide_104_4",
    DescDeviation = {420, 260},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 5
  self.waitAnimTime = 0.5
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_104:OnEvent_ClosePanel(nPanelId)
  if type(nPanelId) == "number" and nPanelId == PanelId.ReceivePropsTips and current == 1 then
    self.parent:ActiveHide(true)
    self.parent:PlayTypeMask(self.msg)
  end
end

function GuideGroup_104:OnEvent_PanelOnEnableById(_panelId)
  if self.openPanelId and self.openPanelId == _panelId and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
      
      EventManager.Hit("Guide_ChangeCharBoardPage", AllEnum.HandBookTab.Skin)
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_104:ShowMainViewUI()
  if current == 2 then
    self.parent:PlayTypeMask(self.msg)
  end
end

function GuideGroup_104:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 1 then
    self:SendGuideStep(-1)
  elseif current == totalStep then
    self.parent:ClearCurGuide(true)
    return
  end
  if current == 3 and PlayerData.Board:CheckSelectBoardChar() == false then
    self:Step_5()
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

return GuideGroup_104
