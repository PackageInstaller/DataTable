local GuideGroup_54 = class("GuideGroup_54")
local mapEventConfig = {}
local groupId = 54
local totalStep = 4
local current = 1

function GuideGroup_54:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_54:BindEvent()
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

function GuideGroup_54:UnBindEvent()
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

function GuideGroup_54:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_54:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_54:Step_1()
  self.msg = {
    BindIcon = "ChooseHomePageRolePanel/----SafeAreaRoot----/---Right---/goNotEmpty/sv",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_104_3",
    DescDeviation = {-850, 340},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.waitAnimTime = 0.5
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_54:Step_2()
  self.msg = {
    BindIcon = "ChooseHomePageRolePanel/----SafeAreaRoot----/---Left---/btnSkin",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_104_4",
    DescDeviation = {660, 40},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_54:Step_3()
  self.msg = {
    BindIcon = "ChooseHomePageRolePanel/----SafeAreaRoot----/---Left---/btnChange",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_104_4",
    DescDeviation = {660, 40},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_54:Step_4()
  self.msg = {
    BindIcon = "ChooseHomePageRolePanel/----SafeAreaRoot----/---Left---/btnOrderArrow",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_104_4",
    DescDeviation = {660, 40},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 4
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_54:OnEvent_ClosePanel(nPanelId)
  if type(nPanelId) == "number" and nPanelId == PanelId.ReceivePropsTips and current == 1 then
    self.parent:ActiveHide(true)
    self.parent:PlayTypeMask(self.msg)
  end
end

function GuideGroup_54:OnEvent_PanelOnEnableById(_panelId)
  if self.openPanelId and self.openPanelId == _panelId and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_54:ShowMainViewUI()
  if current == 2 then
    self.parent:PlayTypeMask(self.msg)
  end
end

function GuideGroup_54:FinishCurrentStep()
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
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

return GuideGroup_54
