local UINFormationChoiceItem = class("UINFormationChoiceItem", UIBaseNode)
local base = UIBaseNode
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local UINFmtHeroHpBarItem = require("Game.Formation.UI.2DFormation.UINFmtHeroHpBarItem")
local FmtEnum = require("Game.Formation.FmtEnum")

function UINFormationChoiceItem:ctor(fmtCtrl, enterFmtData)
  self.fmtCtrl = fmtCtrl
  self.enterFmtData = enterFmtData
end

function UINFormationChoiceItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.heroCardItem = UINHeroCardItem.New()
  self.heroCardItem:Init(self.ui.uINHeroItem)
  local eventTrigger = CS.EventTriggerListener.Get(self.heroCardItem.gameObject)
  eventTrigger:onBeginDrag("+", BindCallback(self, self.OnBeginDrag))
  eventTrigger:onDrag("+", BindCallback(self, self.OnDrag))
  eventTrigger:onEndDrag("+", BindCallback(self, self.OnEndDrag))
end

function UINFormationChoiceItem:InitChoiceItem(heroData, resloader, beginDragAct, onDragAct, endDragAct, clickAct)
  self.beginDragAct = beginDragAct
  self.onDragAct = onDragAct
  self.endDragAct = endDragAct
  self.heroData = heroData
  self.heroCardItem:Show()
  self.heroCardItem:InitHeroCardItem(heroData, resloader, clickAct)
  self:OnShowChoiceRedTip()
  self:OnShowChoiceNorTip()
  self:RefreshSpecialGameHero()
  self.ui.obj_Selected:SetActive(false)
end

function UINFormationChoiceItem:SetShowInOtherFmt(bool)
  self.heroCardItem:SetSelectActive(bool, false, false)
end

function UINFormationChoiceItem:OnBeginDrag(go, eventData)
  if self.beginDragAct ~= nil then
    self.beginDragAct(eventData, self)
  end
end

function UINFormationChoiceItem:OnDrag(go, eventData)
  if self.onDragAct ~= nil then
    self.onDragAct(eventData, self)
  end
end

function UINFormationChoiceItem:OnEndDrag(go, eventData)
  if self.endDragAct ~= nil then
    self.endDragAct(eventData, self)
  end
end

function UINFormationChoiceItem:SetSelectedState(flag)
  self.ui.obj_Selected:SetActive(flag)
end

function UINFormationChoiceItem:OnShowChoiceRedTip()
  if self.heroData.isFriendSupport or self.heroData.isOfficialSupport then
    self.heroCardItem:SetRedDotActive(false)
    return
  end
  if self.heroData ~= nil then
    local ok, redNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.heroData.dataId, RedDotStaticTypeId.HeroStarUp)
    if ok then
      self.heroCardItem:SetRedDotActive(redNode:GetRedDotCount() > 0)
      return
    end
  end
  self.heroCardItem:SetRedDotActive(false)
end

function UINFormationChoiceItem:OnShowChoiceNorTip()
  if self.ui.obj_CanLevelUp == nil then
    return
  end
  self.ui.obj_CanLevelUp:SetActive(false)
  if self.heroData == nil then
    return
  end
  if not self.heroData:AbleUpLevel() then
    return
  end
  local isCanLevelup, _ = self.heroData:GenHeroCanQuickLevelUp()
  self.ui.obj_CanLevelUp:SetActive(isCanLevelup)
end

function UINFormationChoiceItem:UpdFmtHeroChoiceItemHp(hpPer)
  if self.hpBarItem == nil then
    self.hpBarItem = UINFmtHeroHpBarItem.New()
    self.hpBarItem:Init(self.ui.hPBar)
    self.hpBarItem:Show()
  end
  local maxHp = self.heroData:GetAttr(eHeroAttr.maxHp)
  self.hpBarItem:InitFmtHeroHpBarItem(hpPer, maxHp)
  self:UpdateIsWoundMask(hpPer)
  self:UpdateIsCanBattle(hpPer, nil)
end

function UINFormationChoiceItem:RefreshSpecialGameHero()
  if self.enterFmtData == nil then
    return
  end
  local gameTypeAdapter = ExplorationEnum.SpecGameTypeAdapter.None
  local heroId = self.heroData.dataId
  if self.enterFmtData:IsFmtTdSpecHero(heroId) then
    gameTypeAdapter = ExplorationEnum.SpecGameTypeAdapter.TD
  elseif self.heroData.isOfficialSupport then
    gameTypeAdapter = ExplorationEnum.SpecGameTypeAdapter.OfficialSupport
  elseif self.enterFmtData:IsFmtHeroRecommend(heroId) then
    gameTypeAdapter = ExplorationEnum.SpecGameTypeAdapter.Recommend
  end
  self.heroCardItem:SetSpecialGameHeroActive(gameTypeAdapter)
end

function UINFormationChoiceItem:UpdateIsCanBattle(hpPer, bannedDic)
  self:UpdateIsCanBattleMask(hpPer, bannedDic)
  self:UpdateIsCanBattleText(hpPer)
end

function UINFormationChoiceItem:UpdateIsCanBattleMask(hpPer, bannedDic)
  local cantBattleActive = false
  if hpPer == 0 and not cantBattleActive then
    cantBattleActive = true
  end
  if bannedDic ~= nil and self.heroData ~= nil and bannedDic[self.heroData.dataId] and not cantBattleActive then
    cantBattleActive = true
  end
  self.ui.cantBattle:SetActive(cantBattleActive)
end

function UINFormationChoiceItem:UpdateIsCanBattleText(hpPer)
  local texCanNotBattleIndex = -1
  if hpPer == 0 then
    texCanNotBattleIndex = 0
  end
  if self.heroData ~= nil and not self.heroData.isFriendSupport then
    if self.enterFmtData and self.enterFmtData:GetFmtCtrlFromModule() == FmtEnum.eFmtFromModule.CardSet then
      texCanNotBattleIndex = 1
    end
    if self.enterFmtData and self.enterFmtData:GetFmtCtrlFromModule() == FmtEnum.eFmtFromModule.ActBlackHole then
      texCanNotBattleIndex = 2
    end
    if self.enterFmtData and self.enterFmtData:IsBondModule() then
      texCanNotBattleIndex = 3
    end
  end
  if texCanNotBattleIndex ~= -1 then
    self.ui.tex_CanNotBattle:SetIndex(texCanNotBattleIndex)
  end
end

function UINFormationChoiceItem:UpdateIsWoundMask(hpPer)
  local isWoundActive = false
  if hpPer <= 2000 and not isWoundActive then
    isWoundActive = true
  end
  self.ui.isWound:SetActive(isWoundActive)
end

function UINFormationChoiceItem:OnDelete()
  if self.hpBarItem ~= nil then
    self.hpBarItem:Delete()
  end
  self.heroCardItem:Delete()
  base.OnDelete(self)
end

return UINFormationChoiceItem
