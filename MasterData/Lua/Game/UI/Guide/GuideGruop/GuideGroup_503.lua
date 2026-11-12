local GuideGroup_503 = class("GuideGroup_503")
local mapEventConfig = {}
local groupId = 503
local totalStep = 5
local current = 1

function GuideGroup_503:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_503:BindEvent()
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

function GuideGroup_503:UnBindEvent()
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

function GuideGroup_503:SendGuideStep(step)
  local seasonId = PlayerData.SoldierData:GetCurSelectSeasonId()
  self.parent:SendGuideStep(groupId, step, AllEnum.GuideType.Soldier, seasonId)
end

function GuideGroup_503:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_503:Step_1()
  self.msg = {
    BindIcon = "SoldierBossTemplateSelect/----SafeAreaRoot----",
    Deviation = {0, 0},
    Desc = "Guide_503_1",
    DescDeviation = {0, 0},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_503:Step_2()
  self.msg = {
    BindIcon = "SoldierBossTemplateSelect/----SafeAreaRoot----/sv_BossTemplate/Viewport/Content/0/btnGrid",
    Size = {500, 824},
    Deviation = {0, 0},
    Desc = "Guide_503_2",
    DescDeviation = {800, 450},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_503:Step_3()
  self.msg = {
    BindIcon = "SoldierBossTemplateSelect/----SafeAreaRoot----/sv_BossTemplate/Viewport/Content/2/btnGrid",
    Size = {1512, 824},
    Deviation = {0, 0},
    Desc = "Guide_503_3",
    DescDeviation = {-160, 450},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_503:Step_4()
  self.msg = {
    BindIcon = "SoldierBossTemplateSelect/----SafeAreaRoot----/sv_BossTemplate/Viewport/Content/0/btnGrid",
    Size = {500, 824},
    Deviation = {0, 10},
    Desc = "Guide_503_4",
    DescDeviation = {800, 450},
    HandDeviation = {0, 450.0},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 4
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_503:Step_5()
  self.msg = {
    BindIcon = "SoldierBossTemplateSelect/----SafeAreaRoot----/sv_BossTemplate/Viewport/Content/0/btnGrid/AnimRoot/rtBossTemplate/AnimRootMain/btnConfirm",
    Size = {300, 100},
    Deviation = {0, -23},
    Desc = "Guide_503_5",
    DescDeviation = {800, 30},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 5
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_503:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  if current == totalStep then
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

return GuideGroup_503
