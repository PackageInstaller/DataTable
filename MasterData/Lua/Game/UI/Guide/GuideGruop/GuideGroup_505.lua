local GuideGroup_505 = class("GuideGroup_505")
local mapEventConfig = {
  SoldierSandtableCharItemDragStart = "OnEvent_SoldierSandtableCharItemDragStart",
  SoldierSandtableCharItemDragEnd = "OnEvent_SoldierSandtableCharItemDragEnd",
  Guide_SwapSoldierSuccess = "OnEvent_Guide_SwapSoldierSuccess"
}
local groupId = 505
local totalStep = 6
local current = 1

function GuideGroup_505:Init(parent, runStep)
  self.isDragSuccess = false
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_505:BindEvent()
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

function GuideGroup_505:UnBindEvent()
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

function GuideGroup_505:SendGuideStep(step)
  local seasonId = PlayerData.SoldierData:GetCurSelectSeasonId()
  self.parent:SendGuideStep(groupId, step, AllEnum.GuideType.Soldier, seasonId)
  if step == -1 and self.fingerFx ~= nil then
    self.fingerFx:SetActive(false)
    self.posFx:SetActive(false)
  end
end

function GuideGroup_505:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  self.posFx = nil
  self.fingerFx = nil
end

function GuideGroup_505:Step_1()
  local levelData = PlayerData.SoldierData:GetCurLevelData()
  local tabM, tabS, tabO = levelData:GetDeploy()
  local nId = 0
  for _, v in ipairs(tabS) do
    nId = v.nId
    break
  end
  local soldierCharConfig = ConfigTable.GetData("SoldierCharacter", nId)
  local tempRoot = GameObject.Find("---- UI ----").transform
  local tmpObj = tempRoot:Find("SoldierSandtablePanel/----SafeAreaRoot----/DownContainer/WaitingContainer/WaitingCardsLayout/WaitingCardItemTemplate1/HaveStatus/btn_char").gameObject
  tmpObj:SetActive(false)
  self.CharType = soldierCharConfig.Type
  local tmpDes = ""
  self.posFx = ""
  self.fingerFx = tempRoot:Find("SoldierSandtablePanel/rtGuide").gameObject
  self.fingerFx:SetActive(true)
  if soldierCharConfig.Type == GameEnum.ChessType.Balance or soldierCharConfig.Type == GameEnum.ChessType.Vanguard then
    tmpDes = "Guide_22_2"
    self.posFx = tempRoot:Find("SoldierSandtablePanel/----SafeAreaRoot----/MiddleContainer/EntranceContainer/EntranceItemTemplate1/ImgGuide").gameObject
    self.fingerFx:GetComponent("Animator"):Play("CardGuide_Pos1")
  else
    tmpDes = "Guide_22_2"
    self.posFx = tempRoot:Find("SoldierSandtablePanel/----SafeAreaRoot----/MiddleContainer/UpportingContainer/UpportingLayout/UpportingItemTemplate1/ImgGuide").gameObject
    self.fingerFx:GetComponent("Animator"):Play("CardGuide_Pos2")
  end
  self.posFx:SetActive(true)
  self.parent.GuideUIHelpCS:AddCanvas(self.posFx)
  self.parent.GuideUIHelpCS:AddCanvas(self.fingerFx)
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/DownContainer/WaitingContainer/WaitingCardsLayout/WaitingCardItemTemplate1",
    Size = {40, 56},
    Deviation = {-20, -28},
    Desc = "Guide_505_1",
    DescDeviation = {800, 800},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.PopPicture
  }
  self.parent:ActiveHide(true)
  current = 1
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
    self.parent:PlayTypeMask_505(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_505:Step_2()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/LeftContainer/PartnerList",
    Size = {300, 500},
    AutoDeviationCenter = true,
    Deviation = {120, -240},
    Desc = "Guide_505_2",
    DescDeviation = {921.0, -379.0},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_505:Step_3()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/LeftContainer/PartnerList/PartnerContainer/Viewport/Content/0",
    Size = {220, 100},
    Deviation = {170, -40},
    Desc = "Guide_505_3",
    DescDeviation = {920, -140},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_505:Step_4()
  self.msg = {
    BindIcon = "SoldierPartnerTipsPanel/----SafeAreaRoot----/rtContent/rtTipsPoint/imgTipsBg",
    Deviation = {0, 0},
    Desc = "Guide_505_4",
    DescDeviation = {900, 400},
    Type = GameEnum.guidetype.Introductory,
    isUITop = true,
    AutoDeviationTop = true
  }
  self.parent:ActiveHide(true)
  current = 4
  self.waitAnimTime = 0.3
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_505:Step_5()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/MiddleContainer/ImgSandboxChess",
    Size = {1150, 620},
    Deviation = {0, 0},
    Desc = "Guide_505_5",
    DescDeviation = {350, 400},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 5
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_505:Step_6()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/RightContainer/btnGo",
    Deviation = {0, 0},
    Desc = "Guide_505_6",
    DescDeviation = {-700, 300},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 6
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_505:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  if current == 4 then
    EventManager.Hit(EventId.ClosePanel, PanelId.SoldierPartnerTips)
  end
  if current == totalStep then
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_505:OnEvent_SoldierSandtableCharItemDragStart()
  self.parent:ActiveHide(false)
  self.parent._mapNode.typeMask:SetActive(false)
  self.parent._mapNode.btnCount.gameObject:SetActive(false)
  self.fingerFx:SetActive(false)
  if self.CharType == GameEnum.ChessType.Balance or self.CharType == GameEnum.ChessType.Vanguard then
    EventManager.Hit("Guide_505_EnableDrag", false, AllEnum.SoldierPositionType.Fight)
  else
    EventManager.Hit("Guide_505_EnableDrag", false, AllEnum.SoldierPositionType.Support)
  end
end

function GuideGroup_505:OnEvent_SoldierSandtableCharItemDragEnd()
  self.parent:ActiveHide(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
    if self.isDragSuccess then
    else
      self.parent._mapNode.btnCount.gameObject:SetActive(true)
      self.parent._mapNode.typeMask:SetActive(true)
      self.fingerFx:SetActive(true)
      self:Step_1()
    end
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_505:OnEvent_Guide_SwapSoldierSuccess()
  self.isDragSuccess = true
  EventManager.Hit("Guide_505_EnableDrag", true, AllEnum.SoldierPositionType.Other)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
    if self.isDragSuccess then
      self:SendGuideStep(-1)
      self:Step_2()
      self.parent.GuideUIHelpCS:RemoveCanvas(self.posFx)
      self.posFx:SetActive(false)
      self.fingerFx:SetActive(false)
    end
  end
  
  cs_coroutine.start(wait)
end

return GuideGroup_505
