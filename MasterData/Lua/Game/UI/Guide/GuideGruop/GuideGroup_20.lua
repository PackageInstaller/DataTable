local GuideGroup_20 = class("GuideGroup_20")
local mapEventConfig = {}
local groupId = 20
local totalStep = 3
local current = 1

function GuideGroup_20:Init(parent, runStep)
  self:BindEvent()
  self.tabChar = {}
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_20:BindEvent()
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

function GuideGroup_20:UnBindEvent()
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

function GuideGroup_20:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_20:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  self.tabChar = nil
end

function GuideGroup_20:Step_1()
  self.msg = {
    BindIcon = "SkillInstanceLevelSelect/----SafeAreaRoot----/rt_SkillInstanceInfo/rtToggles/viewPort/rt_Toggle",
    Size = {510, 770},
    Deviation = {-10, -370},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_20_1",
    DescDeviation = {900, -790},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.waitAnimTime = 0.3
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_20:Step_2()
  self.msg = {
    BindIcon = "SkillInstanceLevelSelect/----SafeAreaRoot----/rt_SkillInstanceInfo/right/imgReward",
    Size = {650, 250},
    Deviation = {0, -80},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_20_2",
    DescDeviation = {-500, -320},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.1
end

function GuideGroup_20:Step_3()
  self.msg = {
    BindIcon = "SkillInstanceLevelSelect/----SafeAreaRoot----/rt_SkillInstanceInfo/right/titleReward",
    Size = {520, 240},
    Deviation = {4, -70},
    Head = "Icon/Head/head_11101",
    Desc = "Guide_20_3",
    DescDeviation = {-220, -280},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.1
end

function GuideGroup_20:FinishCurrentStep()
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
      "6"
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
      "6"
    })
    NovaAPI.UserEventUpload("normal_tutorial", tab)
  end
  if current == 1 then
    self:SendGuideStep(-1)
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

return GuideGroup_20
