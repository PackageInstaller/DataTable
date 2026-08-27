local UILineupMessageBox = class("UILineupMessageBox", UIBaseWindow)
local base = UIBaseWindow
local UINCommonRankItemHeroHead = require("Game.CommonUI.Rank.UINCommonRankItemHeroHead")
local UINLineupHeroHeadItem = require("Game.Formation.UI.LineUpRecommend.UINLineupHeroHeadItem")
local FormationUtil = require("Game.Formation.FormationUtil")

function UILineupMessageBox:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_no, self, self.OnClickCancleBtn)
  UIUtil.AddButtonListener(self.ui.btn_yes, self, self.OnClickOkBtn)
  self.heroHeadPool = UIItemPool.New(UINLineupHeroHeadItem, self.ui.obj_Item)
  self.ui.obj_Item:SetActive(false)
end

function UILineupMessageBox:InitLineupMessage(heroIds)
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  if fmtCtrl ~= nil then
    local enterFmtData = fmtCtrl:GetCurEnterFmtData()
    self.heroHeadPool:HideAll()
    local fmtData = fmtCtrl:GetFmtCtrlFmtData()
    local fmtIndex = 0
    for i = 1, 8 do
      local isBan = false
      if enterFmtData:IsFormationIndexEnable(i) then
        fmtIndex = fmtIndex + 1
        local isBench = fmtIndex > enterFmtData:GetFormationMaxStageNum()
        local unlock, lockStr
        if isBench then
          unlock, lockStr = FormationUtil.CheckFmtBenchUnlock(fmtIndex, true)
        end
        if enterFmtData:IsFmtCtrlFiexd() and not enterFmtData:HasFmtFixedHeroIndex(fmtIndex) then
          isBan = true
        end
        if enterFmtData:IsFmtPlatformBan(fmtIndex) then
          isBan = true
        end
        local item = self.heroHeadPool:GetOne()
        local heroData = fmtData:GetFormationHeroData(fmtIndex)
        item:InitHeadItem(heroData, isBench, isBan)
        if not isBench then
          item.transform:SetParent(self.ui.obj_upMainHero.transform)
        else
          item.transform:SetParent(self.ui.obj_upSubHero.transform)
        end
      end
    end
    if enterFmtData:IsFmtInWarChessDeploy() then
      local AllFmtIdDic = {}
      local idOffset = FormationUtil.GetFmtIdOffsetByFmtFromModule(enterFmtData:GetFmtCtrlFromModule())
      local curFmtId = enterFmtData:GetFmtCtrlFmtId()
      local max = enterFmtData:GetFmtTeamSize()
      for i = 1, max do
        local fmtId
        if enterFmtData:IsFmtFixedCouldChangeTeam() then
          fmtId = enterFmtData:GetFmtFixedChangeTeamFmtId(i)
        end
        if fmtId == nil then
          fmtId = idOffset + i
        end
        if fmtId ~= curFmtId then
          AllFmtIdDic[i] = fmtId
        end
      end
      self.otherFmtHeroDic = {}
      for index, fmtId in pairs(AllFmtIdDic) do
        local fmtData = fmtCtrl:GetOtherFormationData(fmtId)
        if fmtData ~= nil then
          local fmtHeroDic = fmtData:GetFormationHeroDic(false)
          for fmtIndex, heroId in pairs(fmtHeroDic) do
            self.otherFmtHeroDic[heroId] = true
          end
        end
      end
    end
    self.cacheHeroDic = {}
    fmtIndex = 0
    local tempIndex = 1
    for i = 1, 8 do
      local isBan = false
      if enterFmtData:IsFormationIndexEnable(i) then
        fmtIndex = fmtIndex + 1
        local isBench = fmtIndex > enterFmtData:GetFormationMaxStageNum()
        local unlock, lockStr
        if isBench then
          unlock, lockStr = FormationUtil.CheckFmtBenchUnlock(fmtIndex, true)
        end
        if isBench and enterFmtData:IsFmtInBattleDeploy() then
          isBan = true
        end
        if enterFmtData:IsFmtCtrlFiexd() and not enterFmtData:HasFmtFixedHeroIndex(fmtIndex) then
          isBan = true
        end
        if enterFmtData:IsFmtPlatformBan(fmtIndex) then
          isBan = true
        end
        local heroData = fmtData:GetFormationHeroData(fmtIndex)
        local isFixedHero = heroData ~= nil and heroData.isFixedFmtHero and enterFmtData:HasFmtFixedExtra()
        local item = self.heroHeadPool:GetOne()
        if not isBan and not isFixedHero and unlock ~= false then
          heroData = nil
          while tempIndex <= #heroIds do
            local heroId = heroIds[tempIndex]
            tempIndex = tempIndex + 1
            local isCanChonse = true
            isCanChonse = isCanChonse and not fmtData:IsFixedHero(heroId)
            if enterFmtData:IsFmtInWarChessDeploy() and isCanChonse then
              isCanChonse = not self.otherFmtHeroDic[heroId]
            end
            if isCanChonse then
              heroData = fmtData:GetHeroDataInFmt(heroId)
              if heroData ~= nil then
                self.cacheHeroDic[fmtIndex] = heroData
                break
              end
            end
          end
        end
        item:InitHeadItem(heroData, isBench, isBan)
        if not isBench then
          item.transform:SetParent(self.ui.obj_downMainHero.transform)
        else
          item.transform:SetParent(self.ui.obj_downSubHero.transform)
        end
      end
    end
  end
end

function UILineupMessageBox:OnClickCancleBtn()
  self:Delete()
end

function UILineupMessageBox:OnClickOkBtn()
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  if fmtCtrl == nil then
    self:Delete()
    return
  end
  local fmtData = fmtCtrl:GetFmtCtrlFmtData()
  fmtData:CleanFormation()
  local enterFmtData = fmtCtrl:GetCurEnterFmtData()
  for k, v in pairs(self.cacheHeroDic) do
    local isZeroHpChar = false
    if enterFmtData:IsFmtInBattleDeploy() then
      local fmtDungeonDyncData = enterFmtData:GetFmtDungeonDyncData()
      local hpPer = fmtDungeonDyncData:GetDungeonDyncHeroHpPer(v)
      if hpPer <= 0 then
        isZeroHpChar = true
      end
    end
    if v.isFriendSupport then
      local dailyUseLastHero = false
      if enterFmtData:IsFmtInBattleDeploy() then
        dailyUseLastHero = enterFmtData:GetFmtDungeonDyncData():HasDgDyncLastAstHero()
      end
      fmtData:SetSupportHeroData(v, k, dailyUseLastHero)
    elseif v.isOfficialSupport then
      fmtData:SetOfficialSupportHeroData(v, k)
    elseif isZeroHpChar then
      fmtData:SetHero2Formation(k, nil)
    else
      fmtData:SetHero2Formation(k, v.dataId)
    end
  end
  fmtCtrl:ModifyFormation(fmtData, nil, true)
  fmtCtrl:RefreshFmtShow()
  self.cacheHeroDic = nil
  self:Delete()
  UIManager:DeleteWindow(UIWindowTypeID.LineupRecommend)
end

function UILineupMessageBox:OnDelete()
  self.heroHeadPool:DeleteAll()
  self.cacheHeroDic = nil
  base.OnDelete(self)
end

return UILineupMessageBox
