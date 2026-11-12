local GuideGroup_43 = class("GuideGroup_43")
local mapEventConfig = {
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById"
}
local groupId = 43
local totalStep = 4
local current = 1

function GuideGroup_43:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_43:BindEvent()
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

function GuideGroup_43:UnBindEvent()
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

function GuideGroup_43:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_43:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_43:Step_1()
  self.msg = {
    BindIcon = "MainViewPanel/----SafeAreaRoot----/HideRoot/--TopRight--/trBtnList/btnPhone",
    Deviation = {0, 0},
    Desc = "Guide_43_1",
    DescDeviation = {-620, -180},
    HandDeviation = {0, -100},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_43:Step_2()
  self.msg = {
    BindIcon = "PhonePanel/goContent/----SafeAreaRoot----/PhoneList/addressBookListLSV/Viewport/Content/0",
    Size = {700, 146},
    Deviation = {310, -73},
    Desc = "Guide_43_2",
    DescDeviation = {1180, -241},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.openPanelId = PanelId.Phone
  self.waitAnimTime = 1
end

function GuideGroup_43:Step_3()
  self.msg = {
    BindIcon = "PhonePanel/goContent/----SafeAreaRoot----/PhoneList/goTab/btnDating",
    Deviation = {0, 0},
    Desc = "Guide_43_3",
    DescDeviation = {680, 0},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_43:Step_4()
  self.msg = {
    BindIcon = "PhonePanel/goContent/----SafeAreaRoot----/PhoneList/goTab/btnGift",
    Deviation = {0, 0},
    Desc = "Guide_43_4",
    DescDeviation = {680, 0},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 4
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_43:OnEvent_PanelOnEnableById(_panelId)
  if self.openPanelId and self.openPanelId == _panelId and current == 2 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_43:FinishCurrentStep()
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

return GuideGroup_43
