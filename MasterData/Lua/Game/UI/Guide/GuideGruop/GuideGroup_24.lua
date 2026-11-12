local GuideGroup_24 = class("GuideGroup_24")
local mapEventConfig = {
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById"
}
local groupId = 24
local totalStep = 5
local current = 1

function GuideGroup_24:Init(parent, runStep)
  self:BindEvent()
  self.tabChar = {}
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_24:BindEvent()
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

function GuideGroup_24:UnBindEvent()
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

function GuideGroup_24:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_24:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  self.tabChar = nil
end

function GuideGroup_24:Step_1()
  self.msg = {
    BindIcon = "MainViewPanel/----SafeAreaRoot----/HideRoot/--TopRight--/trBtnList/btnDispatch",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_24_1",
    DescDeviation = {-600, -250},
    HandDeviation = {-150, 0},
    HandRotation = -90,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_24:Step_2()
  self.msg = {
    BindIcon = "DispatchPanel/----SafeAreaRoot----/goDispatchInfo/goRequireInfo/imgBg",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_24_2",
    DescDeviation = {-600, -300},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.6
  self.openPanelId = PanelId.DispatchPanel
end

function GuideGroup_24:Step_3()
  self.msg = {
    BindIcon = "DispatchPanel/----SafeAreaRoot----/goDispatchInfo/goRequireInfo/goRequireList",
    Size = {720, 300},
    Deviation = {330, -35},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_24_3",
    DescDeviation = {-260, -350},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.1
end

function GuideGroup_24:Step_4()
  self.msg = {
    BindIcon = "DispatchPanel/----SafeAreaRoot----/goDispatchInfo/goBtnRoot/btnOneClick",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_24_4",
    DescDeviation = {-550, -160},
    HandDeviation = {-400, 0},
    HandRotation = -90,
    HandDeviation = {0, 150},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 4
  self.waitAnimTime = 0.1
end

function GuideGroup_24:Step_5()
  self.msg = {
    BindIcon = "DispatchPanel/----SafeAreaRoot----/goDispatchInfo/goRequireInfo/goDispatchTimeGroup",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_24_5",
    DescDeviation = {-660, -240},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 5
  self.waitAnimTime = 0.1
end

function GuideGroup_24:OnEvent_PanelOnEnableById(nPanelId)
  if self.openPanelId and self.openPanelId == nPanelId and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_24:FinishCurrentStep()
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
      "8"
    })
    NovaAPI.UserEventUpload("normal_tutorial", tab)
  elseif current == 4 then
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {"action", "1"})
    table.insert(tab, {
      "normal_tutorial_id",
      "8"
    })
    NovaAPI.UserEventUpload("normal_tutorial", tab)
  end
  if current == 1 then
    self:SendGuideStep(-1)
  end
  if current == totalStep then
    self.parent:ClearCurGuide(true)
    return
  end
  if current == 3 then
    local tempRoot = GameObject.Find("---- UI ----").transform
    local tmpBtnOneClick = tempRoot:Find("DispatchPanel/----SafeAreaRoot----/goDispatchInfo/goBtnRoot/btnOneClick").gameObject
    if tmpBtnOneClick.activeSelf == false then
      self.parent:ClearCurGuide(true)
      return
    end
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
  if self.openPanelId == nil and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

return GuideGroup_24
