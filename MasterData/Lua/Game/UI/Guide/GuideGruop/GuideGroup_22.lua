local GuideGroup_22 = class("GuideGroup_22")
local mapEventConfig = {
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById",
  Guide_SendTowerGrowthSuccess = "OnEvent_SendTowerGrowthSuccess",
  Guide_SendTowerGrowthSelectGroupId = "OnEvent_SendTowerGrowthSelectGroupId",
  [EventId.ClosePanel] = "OnEvent_ClosePanel"
}
local groupId = 22
local totalStep = 8
local current = 1

function GuideGroup_22:Init(parent, runStep)
  self:BindEvent()
  self.tabChar = {}
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_22:BindEvent()
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

function GuideGroup_22:UnBindEvent()
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

function GuideGroup_22:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_22:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  self.tabChar = nil
end

function GuideGroup_22:Step_1()
  self.msg = {
    BindIcon = "LevelMenuPanel/----SafeAreaRoot----/---StarTower---/btnTask",
    Size = {150, 150},
    Deviation = {0, -14},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_22_1",
    DescDeviation = {880, 0},
    HandDeviation = {0, 150},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 1
  self.waitAnimTime = 0.7
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

function GuideGroup_22:Step_2()
  self.msg = {
    BindIcon = "StarTowerQuestPanel/----SafeAreaRoot----/svQuest/Viewport/Content",
    Size = {940, 600},
    Deviation = {470, -290},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_22_2",
    DescDeviation = {470, -710},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.4
  self.openPanelId = PanelId.StarTowerQuest
end

function GuideGroup_22:Step_3()
  self.msg = {
    BindIcon = "StarTowerQuestPanel/----SafeAreaRoot----/btnReceiveAll",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_22_3",
    DescDeviation = {-700, 150},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_22:Step_4()
  self.msg = {
    BindIcon = "StarTowerQuestPanel/----SafeAreaRoot----/btnGrowth",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_22_4",
    DescDeviation = {-700, 150},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 4
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_22:Step_5()
  self.msg = {
    BindIcon = "StarTowerGrowthPanel/----SafeAreaRoot----/svNode/Viewport/NodeContent/NormalNodeList(Clone)",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_22_5",
    DescDeviation = {750, -210},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 5
  self.waitAnimTime = 0.4
  self.openPanelId = PanelId.StarTowerGrowth
  if self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
      
      local tempRoot = GameObject.Find("---- UI ----").transform
      local svNode = tempRoot:Find("StarTowerGrowthPanel/----SafeAreaRoot----/svNode"):GetComponent("ScrollRect")
      NovaAPI.SetHorizontalNormalizedPosition(svNode, 0)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_22:Step_6()
  self.msg = {
    BindIcon = "StarTowerGrowthPanel/----SafeAreaRoot----/btnActiveAll",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_22_6",
    DescDeviation = {-700, 150},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 6
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_22:Step_7()
  self.msg = {
    BindIcon = "StarTowerGrowthPanel/----SafeAreaRoot----/btnQuest",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_22_7",
    DescDeviation = {-700, 150},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 7
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_22:Step_8()
  self.msg = {
    BindIcon = "StarTowerQuestPanel/----SafeAreaRoot----/Cube",
    Size = {700, 780},
    Deviation = {0, -140},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_22_8",
    DescDeviation = {900, -300},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 8
  self.waitAnimTime = 0.4
  self.openPanelId = PanelId.StarTowerQuest
end

function GuideGroup_22:OnEvent_PanelOnEnableById(nPanelId)
  if self.openPanelId and self.openPanelId == nPanelId and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
      
      self.parent:PlayTypeMask(self.msg)
      if current == 2 then
        EventManager.Hit("GuideSelectNote", 1, 3)
      end
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_22:OnEvent_SendTowerGrowthSuccess()
  if current == 6 then
    self:Step_7()
  end
end

function GuideGroup_22:OnEvent_SendTowerGrowthSelectGroupId(nId)
  self.SelectGroupId = nId
end

function GuideGroup_22:OnEvent_ClosePanel(nPanelId)
  if type(nPanelId) == "number" and nPanelId == PanelId.ReceivePropsTips and current == 3 then
    self:Step_4()
  end
end

function GuideGroup_22:FinishCurrentStep()
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
      "7"
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
      "7"
    })
    NovaAPI.UserEventUpload("normal_tutorial", tab)
  end
  if current == 1 then
    self:SendGuideStep(-1)
  elseif current == 2 then
    local tbCore, tbNormal = PlayerData.Quest:GetStarTowerQuestData()
    local bClear = true
    for _, v in pairs(tbNormal) do
      if v.nStatus == 1 then
        bClear = false
        break
      end
    end
    for _, v in pairs(tbCore) do
      if v.nStatus == 1 then
        bClear = false
        break
      end
    end
    if not bClear then
      self:Step_3()
    else
      self:Step_4()
    end
    return
  elseif current == 3 then
    return
  elseif current == 5 then
    local bAble, sTip = PlayerData.StarTower:CheckGroupReady(self.SelectGroupId)
    if bAble then
      self:Step_6()
    else
      self:Step_7()
    end
    return
  elseif current == 6 then
    return
  elseif current == totalStep then
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

return GuideGroup_22
