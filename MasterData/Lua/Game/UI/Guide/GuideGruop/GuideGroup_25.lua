local GuideGroup_25 = class("GuideGroup_25")
local mapEventConfig = {
  Guide_SelectDisc = "OnEvent_SelectDisc"
}
local groupId = 25
local totalStep = 4
local current = 1
local subSkillCount = 1

function GuideGroup_25:Init(parent, runStep)
  self:BindEvent()
  self.tabChar = {}
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_25:BindEvent()
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

function GuideGroup_25:UnBindEvent()
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

function GuideGroup_25:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_25:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  self.tabChar = nil
end

function GuideGroup_25:Step_1()
  self.msg = {
    BindIcon = "DiscPanel/----SafeAreaRoot----/---Info---/--Left--/goNameInfo",
    Size = {500, 400},
    Deviation = {-8, -130},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_25_1",
    DescDeviation = {850, -280},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_25:Step_2()
  self.msg = {
    BindIcon = "DiscPanel/----SafeAreaRoot----/---Info---/--Right--/DiscSkill/ScrollView/Viewport/Content/goMainSkill",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_25_2",
    DescDeviation = {-900, -50},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.1
end

function GuideGroup_25:Step_3()
  EventManager.Hit("Guide_ShowAllSubSkill")
  self.msg = {
    BindIcon = "DiscPanel/----SafeAreaRoot----/---Info---/--Right--/DiscSkill/ScrollView/Viewport/Content/goSubSkill",
    Deviation = {0, 0},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_25_3",
    DescDeviation = {-900, -100},
    Type = GameEnum.guidetype.Introductory
  }
  if 1 < subSkillCount then
    self.msg.BindIcon = "DiscPanel/----SafeAreaRoot----/---Info---/--Right--/DiscSkill/ScrollView/Viewport/Content/goSubSkill/rtSubBg" .. subSkillCount
  end
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.1
end

function GuideGroup_25:Step_4()
  self.msg = {
    BindIcon = "DiscPanel/----SafeAreaRoot----/TopBarPanel/Area/goBack/btnBack",
    Deviation = {0, 0},
    HandDeviation = {0, -120},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 4
  self.waitAnimTime = 0.1
end

function GuideGroup_25:OnEvent_SelectDisc(nId)
  local bHasSecondarySkill = false
  local mapData = PlayerData.Disc:GetDiscById(nId)
  if mapData ~= nil then
    bHasSecondarySkill = mapData.tbSubSkillGroupId ~= nil and #mapData.tbSubSkillGroupId > 0
  end
  if bHasSecondarySkill then
    subSkillCount = #mapData.tbSubSkillGroupId
    self:Step_3()
  else
    self:Step_4()
  end
  if self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_25:FinishCurrentStep()
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
      "9"
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
      "9"
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
  if current == 2 then
    self.parent:ActiveHide(true)
    EventManager.Hit("Guide_DiscSkill")
  else
    local funName = "Step_" .. current + 1
    local func = handler(self, self[funName])
    func()
  end
  if self.openPanelId == nil and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

return GuideGroup_25
