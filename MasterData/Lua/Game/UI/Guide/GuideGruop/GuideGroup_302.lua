local GuideGroup_302 = class("GuideGroup_302")
local mapEventConfig = {
  [EventId.ClosePanel] = "OnEvent_ClosePanel",
  PenguinCard_RunState_Settlement = "OnEvent_PenguinCardRunStateSettlement"
}
local groupId = 302
local totalStep = 3
local current = 1

function GuideGroup_302:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_302:BindEvent()
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

function GuideGroup_302:UnBindEvent()
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

function GuideGroup_302:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_302:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_302:Step_1()
  self.msg = {
    BindIcon = "PenguinCard_Normal/----SafeAreaRoot----/---Flip---/--Card--",
    Size = {1150, 330},
    Deviation = {0, 0},
    Head = "Icon/Head/head_917401",
    Desc = "Guide_302_1",
    DescDeviation = {0, -320},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_302:Step_2()
  self.msg = {
    BindIcon = "PenguinCard_Normal/----SafeAreaRoot----/---Flip---/--Info--/Image",
    Size = {1050, 180},
    Deviation = {0, 0},
    Head = "Icon/Head/head_917401",
    Desc = "Guide_302_2",
    DescDeviation = {0, -250},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(1))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_302:Step_3()
  self.msg = {
    BindIcon = "PenguinCard_Normal/----SafeAreaRoot----/---Flip---/--Button--/btnShowAll/AnimRoot/Image",
    Deviation = {0, 0},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_302:FinishCurrentStep()
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

function GuideGroup_302:OnEvent_PenguinCardRunStateSettlement()
  if current == 1 then
    self:Step_2()
  end
end

function GuideGroup_302:OnEvent_ClosePanel(nPanelId)
  if type(nPanelId) == "number" and nPanelId == PanelId.PenguinCard and current == 1 then
    self.parent:ClearCurGuide(true)
  end
end

return GuideGroup_302
