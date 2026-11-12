local GuideGroup_18 = class("GuideGroup_18")
local mapEventConfig = {
  InfinityTowerPanelOpenFinish = "OnEvent_InfinityTowerPanelOpenFinish",
  [EventId.TransAnimOutClear] = "OnEvent_TransAnimOutClear"
}
local groupId = 18
local totalStep = 4
local current = 1

function GuideGroup_18:Init(parent, runStep)
  self:BindEvent()
  self.tabChar = {}
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_18:BindEvent()
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

function GuideGroup_18:UnBindEvent()
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

function GuideGroup_18:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_18:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  self.tabChar = nil
  EventManager.Hit("Guide_DisableScrollView", false)
end

function GuideGroup_18:Step_1()
  current = 1
  self.parent:ActiveHide(true)
end

function GuideGroup_18:Step_2()
  self.msg = {
    BindIcon = "InfinityTowerSelectT/----SafeAreaRoot----/towerList/item_1",
    Size = {820, 200},
    Deviation = {0, 5},
    Head = "Icon/Head/head_917302",
    Desc = "Guide_18_1",
    DescDeviation = {-100, -320},
    HandDeviation = {0, -180},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.5
end

function GuideGroup_18:Step_3()
  self.msg = {
    BindIcon = "InfinityTowerSelectT/----SafeAreaRoot----/diffListView/goContent/diffList/Viewport/Content/0/AnimRoot/diff_btn",
    Size = {900, 200},
    Deviation = {-4, 0},
    Head = "Icon/Head/head_917402",
    Desc = "Guide_18_2",
    DescDeviation = {-500, -350},
    HandDeviation = {0, -200},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 1
end

function GuideGroup_18:Step_4()
  current = 4
  self.nEntryId = 201201
end

function GuideGroup_18:OnEvent_InfinityTowerPanelOpenFinish(nPageType)
  if current == 1 then
    if nPageType ~= 1 then
      self.parent:ClearCurGuide(false)
      return
    end
    self:Step_2()
    if self.waitAnimTime ~= 0 then
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
        
        self.parent:PlayTypeMask(self.msg)
      end
      
      cs_coroutine.start(wait)
    end
  end
end

function GuideGroup_18:OnEvent_TransAnimOutClear()
  if current == 4 and self.nEntryId ~= nil then
    EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, self.nEntryId)
    self:FinishCurrentStep()
  end
end

function GuideGroup_18:FinishCurrentStep()
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
    table.insert(tab, {"action", "0"})
    table.insert(tab, {
      "normal_tutorial_id",
      "5"
    })
    NovaAPI.UserEventUpload("normal_tutorial", tab)
  elseif current == 3 then
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {"action", "1"})
    table.insert(tab, {
      "normal_tutorial_id",
      "5"
    })
    NovaAPI.UserEventUpload("normal_tutorial", tab)
  end
  if current == 3 then
    EventManager.Hit("Guide_DisableScrollView", false)
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
      if current == 3 then
        EventManager.Hit("Guide_DisableScrollView", true)
      end
    end
    
    cs_coroutine.start(wait)
  end
end

return GuideGroup_18
