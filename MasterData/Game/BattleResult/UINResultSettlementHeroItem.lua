local UINResultSettlementHeroItem = class("UINResultSettlementHeroItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function UINResultSettlementHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.headItem = UINHeroHeadItem.New()
  self.headItem:Init(self.ui.obj_heroHeadItem)
  self.ui.obj_lvUp:SetActive(false)
  self.ui.obj_friendship:SetActive(false)
end

function UINResultSettlementHeroItem:InitCharacterItem(dynHero, resLoader, clickCallback)
  self.heroData = dynHero.heroData
  self.headItem:InitHeroHeadItem(self.heroData, resLoader, clickCallback)
end

function UINResultSettlementHeroItem:RefershExpData(oldLevel, oldExp, addExp)
  local couldAddExpLimit = self.heroData:GetExp2FullLevel()
  local exp = math.min(couldAddExpLimit, addExp)
  local expFromList, expToList = self.heroData:GetUpgradeLevelProcess(oldLevel, oldExp, exp)
  self.expFromList = expFromList
  self.expToList = expToList
  self.progessCount = #expFromList
  self.oldLevel = oldLevel
  self.oldExp = oldExp
  self.upgradeSpeed = self.ui.upgradeSpeed
  if self.progessCount == 1 then
    local curLevelTotalExp = self.heroData:GetExpByLevel(self.oldLevel)
    local ratio = exp / curLevelTotalExp
    local animaTime = ratio / self.upgradeSpeed
    if animaTime < self.ui.upgradeMinTime then
      self.upgradeSpeed = ratio / self.ui.upgradeMinTime
    end
  end
  if self.progessCount <= 0 then
    self.isAniComplete = true
    self:RefreshLevelUI(self.heroData.level, exp, self.heroData:GetExpRatio())
    return
  end
  self.isAniComplete = false
  self.curGetExp = 0
  self:RefreshLevelProgress(1)
end

function UINResultSettlementHeroItem:RefreshFriendShipData(Value)
  if 0 < Value then
    self.ui.obj_friendship:SetActive(true)
    self.ui.tex_Friendship.text = "+" .. Value
  else
    self.ui.obj_friendship:SetActive(false)
  end
end

function UINResultSettlementHeroItem:RefreshLevelProgress(index)
  if index > #self.expFromList then
    self.isAniComplete = true
    self:RefreshLevelUI(self.curLevel, self.curGetExp, self.curExp / self.curLevelTotalExp)
    return
  end
  if 1 < index then
    self.ui.obj_lvUp:SetActive(true)
  end
  self.curIndex = index
  self.curLevel = self.oldLevel + index - 1
  self.curLevelTotalExp = self.heroData:GetExpByLevel(self.curLevel)
  self.curExp = self.expFromList[index]
  self.curToExp = self.expToList[index]
  self:RefreshLevelUI(self.curLevel, self.curGetExp, self.curExp / self.curLevelTotalExp)
end

function UINResultSettlementHeroItem:RefreshLevelUI(curLevel, curGetExp, fillAmount)
  self.ui.tex_level.text = tostring(curLevel)
  self.ui.tex_addExp:SetIndex(0, tostring(curGetExp))
  self.ui.img_exp.fillAmount = fillAmount
end

function UINResultSettlementHeroItem:UpdateExp()
  if self.isAniComplete then
    return true
  end
  local increase = math.floor(self.curLevelTotalExp * self.upgradeSpeed * Time.unscaledDeltaTime)
  increase = increase == 0 and 1 or increase
  if self.curExp + increase >= self.curToExp then
    self.curGetExp = self.curGetExp - self.curExp + self.curToExp
    self.curExp = self.curToExp
    self:RefreshLevelProgress(self.curIndex + 1)
    return
  else
    self.curGetExp = self.curGetExp + increase
    self.curExp = self.curExp + increase
    self:RefreshLevelUI(self.curLevel, self.curGetExp, self.curExp / self.curLevelTotalExp)
  end
end

function UINResultSettlementHeroItem:OnDelete()
  base.OnDelete(self)
end

return UINResultSettlementHeroItem
