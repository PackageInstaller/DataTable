local GuideGroup_23 = class("GuideGroup_23")
local mapEventConfig = {
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById"
}
local groupId = 23
local totalStep = 5
local current = 1

function GuideGroup_23:Init(parent, runStep)
  self:BindEvent()
  self.tabChar = {}
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_23:BindEvent()
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

function GuideGroup_23:UnBindEvent()
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

function GuideGroup_23:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_23:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  self.tabChar = nil
end

function GuideGroup_23:Step_1()
  self.msg = {
    BindIcon = "MainViewPanel/----SafeAreaRoot----/HideRoot/--TopRight--/trBtnList/btnMenu",
    Size = {100, 110},
    Deviation = {5, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_23_1",
    DescDeviation = {-750, -260},
    HandDeviation = {-150, 0},
    HandRotation = -90,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_23:Step_2()
  self.msg = {
    BindIcon = "MainViewSidePanel/----SafeAreaRoot----/ButtonList1/2/btnCraft",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    HandDeviation = {-300, 0},
    HandRotation = -90,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.2
  self.openPanelId = PanelId.MainViewSide
end

function GuideGroup_23:Step_3()
  self.msg = {
    BindIcon = "CraftingPanel/----SafeAreaRoot----/---MatProduction---/goProductionList",
    Deviation = {-8, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_23_3",
    DescDeviation = {760, -360},
    HandDeviation = {400, 0},
    HandRotation = 90,
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.5
  self.openPanelId = PanelId.Crafting
end

function GuideGroup_23:Step_4()
  self.msg = {
    BindIcon = "CraftingPanel/----SafeAreaRoot----/---MatProduction---/goCraftingContent/btnCraftingItem",
    Size = {600, 550},
    Deviation = {6, 10},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_23_4",
    DescDeviation = {-740, -500},
    HandDeviation = {-400, 0},
    HandRotation = -90,
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 4
  self.waitAnimTime = 0.1
end

function GuideGroup_23:Step_5()
  self.msg = {
    BindIcon = "CraftingPanel/----SafeAreaRoot----/---MatProduction---/goCraftingContent/goMaterialList",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_23_5",
    DescDeviation = {-800, 250},
    HandDeviation = {-450, 0},
    HandRotation = -90,
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 5
  self.waitAnimTime = 0.1
end

function GuideGroup_23:OnEvent_PanelOnEnableById(nPanelId)
  if self.openPanelId and self.openPanelId == nPanelId and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_23:FinishCurrentStep()
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
      "10"
    })
    NovaAPI.UserEventUpload("normal_tutorial", tab)
  elseif current == 2 then
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {"action", "1"})
    table.insert(tab, {
      "normal_tutorial_id",
      "10"
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

return GuideGroup_23
