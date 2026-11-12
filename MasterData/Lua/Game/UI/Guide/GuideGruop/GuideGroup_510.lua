local GuideGroup_510 = class("GuideGroup_510")
local mapEventConfig = {}
local groupId = 510
local totalStep = 3
local current = 1

function GuideGroup_510:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_510:BindEvent()
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

function GuideGroup_510:UnBindEvent()
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

function GuideGroup_510:SendGuideStep(step)
  local seasonId = PlayerData.SoldierData:GetCurSelectSeasonId()
  self.parent:SendGuideStep(groupId, step, AllEnum.GuideType.Soldier, seasonId)
end

function GuideGroup_510:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_510:Step_1()
  local index, type = self:GetDeployIndexType()
  local tmpBindIcon = ""
  if type == 1 then
    tmpBindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/MiddleContainer/EntranceContainer/EntranceItemTemplate" .. index .. "/HaveStatus/btn_char"
  elseif type == 2 then
    tmpBindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/MiddleContainer/UpportingContainer/UpportingLayout/UpportingItemTemplate" .. index .. "/HaveStatus/btn_char"
  else
    tmpBindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/DownContainer/WaitingContainer/WaitingCardsLayout/WaitingCardItemTemplate" .. index .. "/HaveStatus/btn_char"
  end
  self.msg = {
    BindIcon = tmpBindIcon,
    Deviation = {0, 0},
    Desc = "Guide_510_1",
    DescDeviation = {600, 220},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
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

function GuideGroup_510:Step_2()
  self.msg = {
    BindIcon = "SoldierCharCardTipsPanel/----SafeAreaRoot----/rtContent/rtTipsPoint/imgTipsBg/TipsView/Viewport/TipsContent/goBaseInfo",
    Size = {600, 300},
    Deviation = {0, -350},
    Desc = "Guide_510_2",
    DescDeviation = {-860, -160},
    Type = GameEnum.guidetype.Introductory,
    isUITop = true
  }
  self.parent:ActiveHide(true)
  current = 2
  self.waitAnimTime = 0.3
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_510:Step_3()
  self.msg = {
    BindIcon = "SoldierCharCardTipsPanel/----SafeAreaRoot----/rtContent/rtTipsPoint/imgTipsBg/TipsView/Viewport/TipsContent/srDesc",
    Size = {600, 300},
    Deviation = {0, -250},
    Desc = "Guide_510_3",
    DescDeviation = {-860, -160},
    Type = GameEnum.guidetype.Introductory,
    isUITop = true
  }
  local tempRoot = GameObject.Find("---- UI TOP ----").transform
  local objTemp = tempRoot:Find(self.msg.BindIcon .. "/ScrollView"):GetComponent("ScrollRect")
  NovaAPI.SetVerticalNormalizedPosition(objTemp, 0)
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.3
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_510:GetDeployIndexType()
  local tmpId = 1
  if PlayerData.SoldierData.tbGuideData[510] ~= nil then
    tmpId = PlayerData.SoldierData:GetGuideData(510)
  end
  local levelData = PlayerData.SoldierData:GetCurLevelData()
  local tbDeploy, tbWaiting, tbOther = levelData:GetDeploy()
  for _, v in ipairs(tbDeploy) do
    if v.nPositionType == GameEnum.SoldierPositionType.FightPosition then
      if v.nId == tmpId then
        return v.nIndex, 1
      end
    elseif v.nId == tmpId then
      return v.nIndex, 2
    end
  end
  for _, v in ipairs(tbDeploy) do
    if v.nId == tmpId then
      return v.nIndex, 3
    end
  end
  return 1, 1
end

function GuideGroup_510:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == totalStep then
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

return GuideGroup_510
