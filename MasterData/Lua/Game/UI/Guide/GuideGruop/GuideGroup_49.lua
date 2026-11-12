local GuideGroup_49 = class("GuideGroup_49")
local mapEventConfig = {}
local groupId = 49
local totalStep = 5
local current = 1
local selectIndex = 1

function GuideGroup_49:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_49:BindEvent()
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

function GuideGroup_49:UnBindEvent()
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

function GuideGroup_49:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_49:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_49:Step_1()
  self.msg = {
    BindIcon = "CharSkillPanel/----ContentRoot----/----SafeAreaRoot----/--Upgrade--/goSkillBtn/goSkill1/AnimRoot/Select",
    Deviation = {0, 0},
    Desc = "Guide_49_1",
    DescDeviation = {800, -180},
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

function GuideGroup_49:Step_2()
  local tempRoot = GameObject.Find("---- UI ----").transform
  local tmpBtn = tempRoot:Find("CharSkillPanel/----ContentRoot----/----SafeAreaRoot----/--Upgrade--/goSkillBtn/goSkill2"):GetComponent("UIButton")
  tmpBtn.onClick:Invoke()
  self.msg = {
    BindIcon = "CharSkillPanel/----ContentRoot----/----SafeAreaRoot----/--Upgrade--/goSkillBtn/goSkill2/AnimRoot/Select",
    Deviation = {0, 0},
    Desc = "Guide_49_2",
    DescDeviation = {940, 0},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.2
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_49:Step_3()
  local tempRoot = GameObject.Find("---- UI ----").transform
  local tmpBtn = tempRoot:Find("CharSkillPanel/----ContentRoot----/----SafeAreaRoot----/--Upgrade--/goSkillBtn/goSkill3"):GetComponent("UIButton")
  tmpBtn.onClick:Invoke()
  self.msg = {
    BindIcon = "CharSkillPanel/----ContentRoot----/----SafeAreaRoot----/--Upgrade--/goSkillBtn/goSkill3/AnimRoot/Select",
    Deviation = {0, 0},
    Desc = "Guide_49_3",
    DescDeviation = {940, 0},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.2
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_49:Step_4()
  local tempRoot = GameObject.Find("---- UI ----").transform
  local tmpBtn = tempRoot:Find("CharSkillPanel/----ContentRoot----/----SafeAreaRoot----/--Upgrade--/goSkillBtn/goSkill4"):GetComponent("UIButton")
  tmpBtn.onClick:Invoke()
  self.msg = {
    BindIcon = "CharSkillPanel/----ContentRoot----/----SafeAreaRoot----/--Upgrade--/goSkillBtn/goSkill4/AnimRoot/Select",
    Deviation = {0, 0},
    Desc = "Guide_49_4",
    DescDeviation = {940, 190},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 4
  self.waitAnimTime = 0.2
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_49:Step_5()
  self.msg = {
    BindIcon = "CharSkillPanel/----ContentRoot----/----SafeAreaRoot----/--Upgrade--/goRoot/goMaterial/goMat1/btnMat1",
    Deviation = {0, 0},
    Desc = "Guide_49_5",
    DescDeviation = {-680, 0},
    HandDeviation = {0, -100},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 5
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_49:FinishCurrentStep()
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

return GuideGroup_49
