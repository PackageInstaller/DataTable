local GuideGroup_305 = class("GuideGroup_305")
local mapEventConfig = {
  [EventId.ClosePanel] = "OnEvent_ClosePanel",
  PenguinCard_RunState_Start = "OnEvent_PenguinCardRunStateStart",
  PenguinCard_RunState_Prepare = "OnEvent_PenguinCardRunStatePrepare"
}
local groupId = 305
local totalStep = 5
local current = 1

function GuideGroup_305:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_305:BindEvent()
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

function GuideGroup_305:UnBindEvent()
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

function GuideGroup_305:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_305:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_305:Step_1()
  self.msg = {
    BindIcon = "PenguinCardSelectPanel/----SafeAreaRoot---/sv/Viewport/LevelContent/goEndlessLevel(Clone)/btnLevel",
    ScrollView = "PenguinCardSelectPanel/----SafeAreaRoot---/sv",
    Size = {620, 322},
    Deviation = {0, 0},
    Head = "Icon/Head/head_917401",
    Desc = "Guide_305_1",
    DescDeviation = {-848, 306},
    HandDeviation = {0, 220},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_305:Step_2()
  self.msg = {
    BindIcon = "PenguinCard_Endless/----SafeAreaRoot----/---Start---/imgBg",
    Size = {1290, 425},
    Deviation = {0, 32},
    Head = "Icon/Head/head_917301",
    Desc = "Guide_305_2",
    DescDeviation = {0, -316},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_305:Step_3()
  self.msg = {
    BindIcon = "PenguinCard_Endless/----SafeAreaRoot----/---Start---/imgBg/imgBg2",
    Size = {1000, 100},
    Deviation = {0, 0},
    Head = "Icon/Head/head_917301",
    Desc = "Guide_305_3",
    DescDeviation = {0, -200},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_305:Step_4()
  self.msg = {
    BindIcon = "PenguinCard_Endless/----SafeAreaRoot----/---Start---/btnStart1",
    Deviation = {0, 0},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 4
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_305:Step_5()
  self.msg = {
    BindIcon = "PenguinCard_Endless/----SafeAreaRoot----/---Prepare---/--Aide--",
    Size = {800, 400},
    Deviation = {0, 4},
    Head = "Icon/Head/head_917301",
    Desc = "Guide_305_5",
    DescDeviation = {0, -342},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 5
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_305:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 1 then
    return
  elseif current == totalStep then
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_305:OnEvent_PenguinCardRunStateStart()
  if current == 1 then
    self:Step_2()
  end
end

function GuideGroup_305:OnEvent_PenguinCardRunStatePrepare()
  if current == 4 then
    self:Step_5()
  end
end

function GuideGroup_305:OnEvent_ClosePanel(nPanelId)
  if type(nPanelId) == "number" and nPanelId == PanelId.PenguinCardEndless and current == 1 then
    self.parent:ClearCurGuide(true)
  end
end

return GuideGroup_305
