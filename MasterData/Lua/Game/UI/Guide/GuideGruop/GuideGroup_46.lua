local GuideGroup_46 = class("GuideGroup_46")
local mapEventConfig = {
  [EventId.ClosePanel] = "OnEvent_ClosePanel"
}
local groupId = 46
local totalStep = 3
local current = 1

function GuideGroup_46:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_46:BindEvent()
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

function GuideGroup_46:UnBindEvent()
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

function GuideGroup_46:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_46:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_46:Step_1()
  self.msg = {
    BindIcon = "CharDevelopmentPanel/----SafeAreaRoot----/---Upgrade---/NotMax/rtInfo/level",
    Size = {800, 120},
    Deviation = {0, 0},
    Desc = "Guide_46_1",
    DescDeviation = {-900, -100},
    Type = GameEnum.guidetype.Introductory
  }
  current = 1
  self.parent:ActiveHide(true)
  self.waitAnimTime = 1
  if self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  else
    self.parent:PlayTypeMask(self.msg)
  end
end

function GuideGroup_46:Step_2()
  self.msg = {
    BindIcon = "CharDevelopmentPanel/----SafeAreaRoot----/---Upgrade---/NotMax/rtInfo/btnOpenAdInfo1",
    Size = {100, 100},
    Deviation = {0, 0},
    Desc = "Guide_46_2",
    DescDeviation = {-580, -120},
    HandDeviation = {0, -100},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_46:Step_3()
  self.msg = {
    BindIcon = "CharAdvancePreviewInfoPanel/advancePreviewInfo/goContent/InfoBg/AdPre",
    Deviation = {0, 0},
    Desc = "Guide_46_3",
    DescDeviation = {-130, -250},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 1
end

function GuideGroup_46:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 2 then
    self:SendGuideStep(-1)
  elseif current == totalStep then
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
  if self.waitAnimTime ~= 0 and current == 3 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
      
      local tempRoot = GameObject.Find("---- UI ----").transform
      local btn = tempRoot:Find("CharAdvancePreviewInfoPanel/advancePreviewInfo/goContent/AdNodeScrollView/Viewport/AdvanceNodeContent/2/btnNode"):GetComponent("UIButton")
      btn.onClick:Invoke()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

return GuideGroup_46
