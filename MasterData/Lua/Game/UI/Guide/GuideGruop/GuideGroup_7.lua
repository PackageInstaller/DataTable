local GuideGroup_7 = class("GuideGroup_7")
local mapEventConfig = {
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById",
  Guide_LevelMenuOpen = "OnEvent_GuideLevelMenuOpen"
}
local groupId = 7
local totalStep = 6
local current = 1

function GuideGroup_7:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_7:BindEvent()
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

function GuideGroup_7:UnBindEvent()
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

function GuideGroup_7:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_7:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_7:Step_1()
  self.msg = {
    BindIcon = "MainViewPanel/----SafeAreaRoot----/HideRoot/--BottomRight--/btnMap",
    CloseObj = "MainViewPanel/----SafeAreaRoot----/HideRoot/--BottomRight--/btnMap/anti_scale",
    Size = {330, 200},
    Deviation = {10, -8},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_7_1",
    DescDeviation = {-750, 60},
    HandDeviation = {0, 180},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_7:Step_2()
  self.msg = {
    BindIcon = "LevelMenuPanel/----SafeAreaRoot----/imgPhoneBg/PhoneContent/LevelMenu/btnResource",
    Size = {450, 270},
    Deviation = {0, 130},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_7_2",
    DescDeviation = {-800, -40},
    HandDeviation = {-300, 160},
    HandRotation = -90,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 2
end

function GuideGroup_7:Step_3()
  self.msg = {
    BindIcon = "LevelMenuPanel/----SafeAreaRoot----/---Resource---/svResource/Viewport/Content/btnTimes",
    ScrollView = "LevelMenuPanel/----SafeAreaRoot----/---Resource---/svResource",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_7_3",
    DescDeviation = {860, -210},
    HandDeviation = {0, 200},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.55
end

function GuideGroup_7:Step_4()
  self.msg = {
    BindIcon = "LevelMenuPanel/----SafeAreaRoot----/imgPhoneBg/PhoneContent/SecondMenu/Resource/btnResourceGoto",
    Size = {800, 430},
    Deviation = {0, 120},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_7_4",
    DescDeviation = {-1000, 0},
    HandDeviation = {-500, 160},
    HandRotation = -90,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 4
  self.waitAnimTime = 0.5
end

function GuideGroup_7:Step_5()
  self.msg = {
    BindIcon = "DailyInstanceLevelSelectEx/----SafeAreaRoot----/rt_DailyInstanceInfo/right/rtChangeReward/btnChange",
    Size = {680, 200},
    Deviation = {-230, 40},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_7_5",
    DescDeviation = {-900, -200},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 5
  self.openPanelId = PanelId.DailyInstanceLevelSelect
  self.waitAnimTime = 0.2
end

function GuideGroup_7:Step_6()
  self.msg = {
    BindIcon = "DailyInstanceLevelSelectEx/----SafeAreaRoot----/rt_DailyInstanceInfo/btnGo",
    Deviation = {0, 2},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_7_6",
    DescDeviation = {-730, 80},
    HandDeviation = {0, 100},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 6
  self.waitAnimTime = 0.24
end

function GuideGroup_7:OnEvent_PanelOnEnableById(_panelId)
  if self.openPanelId and self.openPanelId == _panelId and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.5))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_7:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 2 then
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {
      "newbie_tutorial_id",
      "23"
    })
    NovaAPI.UserEventUpload("newbie_tutorial", tab)
  end
  if current < totalStep then
    self:SendGuideStep(current)
  elseif current == totalStep then
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
    return
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

function GuideGroup_7:OnEvent_GuideLevelMenuOpen()
  if current == 2 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.7))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

return GuideGroup_7
