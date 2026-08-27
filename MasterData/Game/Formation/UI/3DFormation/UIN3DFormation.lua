local UIN3DFormation = class("UIN3DFormation", UIBaseNode)
local base = UIBaseNode
local UINFmtPlatform = require("Game.Formation.UI.3DFormation.UINFmtPlatform")
local UINFmtPlatform4Fairy = require("Game.Formation.UI.3DFormation.UINFmtPlatform4Fairy")
local FmtEnum = require("Game.Formation.FmtEnum")
local UIN3DFormationWarningNode = require("Game.Formation.UI.3DFormation.UIN3DFormationWarningNode")
local FormationUtil = require("Game.Formation.FormationUtil")
local FairyHelper = require("Game.Fairy.FairyHelper")

function UIN3DFormation:ctor(fmtCtrl, enterFmtData)
  self.fmtCtrl = fmtCtrl
  self.enterFmtData = enterFmtData
end

function UIN3DFormation:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.warningNode = UIN3DFormationWarningNode.New(self.fmtCtrl)
  self.warningNode:Init(self.ui.periodicWarning)
  self.warningNode:Hide()
  local enterFmtData = self.fmtCtrl:GetCurEnterFmtData()
  self.platformDic = {}
  local fmtIndex = 0
  for idx, go in ipairs(self.ui.platform) do
    local isBan = false
    if not self.enterFmtData:IsFormationIndexEnable(idx) then
      go:SetActive(false)
    else
      fmtIndex = fmtIndex + 1
      local isBench = fmtIndex > enterFmtData:GetFormationMaxStageNum()
      local unlock, lockStr
      if isBench then
        unlock, lockStr = FormationUtil.CheckFmtBenchUnlock(fmtIndex, true)
      end
      if isBench and self.enterFmtData:IsFmtInBattleDeploy() then
        isBan = true
      end
      if self.enterFmtData:IsFmtCtrlFiexd() and not self.enterFmtData:HasFmtFixedHeroIndex(fmtIndex) then
        isBan = true
      end
      if self.enterFmtData:IsFmtPlatformBan(fmtIndex) then
        isBan = true
      end
      local plat = UINFmtPlatform.New(self.fmtCtrl, self.enterFmtData)
      plat:Init(go)
      plat:InitFmtPlatform(fmtIndex, isBench, lockStr, isBan)
      if self.brotatoSpecialIndex ~= nil and fmtIndex == self.brotatoSpecialIndex then
        plat:SetLocalPos(self.brotatoLocalPos)
      end
      plat:SetItemParents(self.ui.parentList)
      self.platformDic[fmtIndex] = plat
    end
  end
  self.fairyPlat = UINFmtPlatform4Fairy.New(self.fmtCtrl, self.enterFmtData)
  self.fairyPlat:Init(self.ui.go_fairyPlatform)
  self.fairyPlat:SetItemParents(self.ui.parentList)
  local isFairyUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_fairy)
  if not isFairyUnlock or not self.enterFmtData:GetFmtIsShowFairy() then
    self.fairyPlat:Hide()
  end
end

function UIN3DFormation:GetPlotformItemDic()
  return self.platformDic
end

function UIN3DFormation:SetPlatFormPosByBrotato(index, pos)
  self.brotatoSpecialIndex = index
  self.brotatoLocalPos = pos
end

function UIN3DFormation:Init3DFormation()
end

function UIN3DFormation:Refresh3DFmt()
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  local totalFtPower, totalBenchPower = self.fmtCtrl:CalculatePower(formationData)
  for index, platItem in pairs(self.platformDic) do
    local heroData = formationData:GetFormationHeroData(index)
    platItem:RefreshUIFmtPlatform(heroData)
  end
  local fairyData = formationData:GetFmtFairyData()
  self.fairyPlat:RefreshUIFmtPlatform4Fairy(fairyData)
  self:ShowFmtHeroQuickLvUp()
end

function UIN3DFormation:RefreshRefresh3DFmtFightPower()
  local totalFtPower = 0
  local totalBenchPower = 0
  local heroPower = 0
  local heroTotalList = {}
  local fmtNum = 0
  local bunchNum = 0
  for index, platItem in pairs(self.platformDic) do
    heroPower = platItem:GetFmtPlatHeroFtPower()
    if heroPower ~= 0 then
      table.insert(heroTotalList, heroPower)
    end
    if platItem.isBench then
      totalBenchPower = heroPower + totalBenchPower
      bunchNum = bunchNum + 1
    else
      totalFtPower = heroPower + totalFtPower
      fmtNum = fmtNum + 1
    end
  end
  table.sort(heroTotalList, function(a, b)
    return b < a
  end)
  local top5Total = 0
  for i = 1, #heroTotalList do
    if 5 < i then
      break
    end
    top5Total = top5Total + heroTotalList[i]
  end
  local dynPlayerFtPower = self:_GetCommanderPower(totalFtPower)
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  local fairyData = formationData:GetFmtFairyData()
  local fairyPow = 0
  if fairyData ~= nil then
    fairyPow = FairyHelper.GetFairyBattlePow(fairyData)
  end
  totalFtPower = totalFtPower + dynPlayerFtPower + fairyPow * fmtNum
  totalBenchPower = totalBenchPower + fairyPow * bunchNum
  top5Total = top5Total + dynPlayerFtPower + fairyPow * math.min(5, #heroTotalList)
  local window = UIManager:GetWindow(UIWindowTypeID.Formation)
  if window ~= nil then
    window:RefreshUIAboutCurFmtDat(totalFtPower, totalBenchPower, nil, top5Total)
  end
end

function UIN3DFormation:_GetCommanderPower(heroPower)
  if self._commanderPowerTab == nil then
    self._commanderPowerTab = {}
  end
  self._commanderPowerTab.power = heroPower
  local power = ConfigData.GetFormulaValue(eFormulaType.Commander, self._commanderPowerTab)
  power = math.floor(power)
  return power
end

function UIN3DFormation:GetFmtPlatformUI(fmtIndex)
  local platform = self.platformDic[fmtIndex]
  if platform == nil then
    warn("Can't get FmtPlatformUI, fmtIndex = " .. tostring(fmtIndex))
  end
  return platform
end

function UIN3DFormation:RefreshFmtPlatformUI(fmtIndex)
  local platform = self:GetFmtPlatformUI(fmtIndex)
  if platform == nil then
    return
  end
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  local heroData = formationData:GetFormationHeroData(fmtIndex)
  platform:RefreshUIFmtPlatform(heroData)
  platform:RefreshFmtQuickLvUp(heroData, self.ui.fXP_Btn_QuickLevelUp)
end

function UIN3DFormation:RefreshFmtPlatformUI4Fairy()
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  local fairyData = formationData:GetFmtFairyData()
  self.fairyPlat:RefreshUIFmtPlatform4Fairy(fairyData)
end

function UIN3DFormation:ShowFmtHeroQuickLvUp()
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  for index, platItem in pairs(self.platformDic) do
    local heroData = formationData:GetFormationHeroData(index)
    if heroData ~= nil then
      platItem:RefreshFmtQuickLvUp(heroData, self.ui.fXP_Btn_QuickLevelUp)
    end
  end
end

function UIN3DFormation:RefreshFmtHeroQuickLvUpByFmtIndex(fmtIndex)
  local platform = self:GetFmtPlatformUI(fmtIndex)
  if platform == nil then
    return
  end
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  local heroData = formationData:GetFormationHeroData(fmtIndex)
  platform:RefreshFmtQuickLvUp(heroData, self.ui.fXP_Btn_QuickLevelUp)
end

function UIN3DFormation:SetWarningTipState(active)
  if active then
    self.warningNode:Show()
    self.warningNode:OpenWarningTip4WcLevel()
  else
    self.warningNode:Hide()
  end
end

function UIN3DFormation:OnDelete()
  base.OnDelete(self)
end

return UIN3DFormation
