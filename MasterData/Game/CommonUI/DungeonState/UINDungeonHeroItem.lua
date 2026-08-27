local UINDungeonHeroItem = class("UINDungeonHeroItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
local heroHpPercent = require("Game.Exploration.ExplorationEnum").eHeroHpPercent

function UINDungeonHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.headItem = UINHeroHeadItem.New()
  self.headItem:Init(self.ui.obj_heroHeadItem)
  self.chipList = {}
  self.targetHpPercent = heroHpPercent
  self.__OnHpTweenComplete = BindCallback(self, self.OnHpTweenComplete)
  self.ui.fx_HpRecover:SetActive(false)
end

function UINDungeonHeroItem:InitHeroItem(dynHeroData, resloader, clickCallback)
  self:KillHpChangeTween()
  self.dynHeroData = dynHeroData
  local heroData = dynHeroData.heroData
  self.headItem:InitHeroHeadItem(heroData, resloader, clickCallback)
  self:RefreshHp(true)
  self:UpdateChipList()
  self.ui.isSupport:SetActive(dynHeroData:IsSupport())
  self.ui.obj_isFriendSupport:SetActive(dynHeroData:IsFriendSupport())
end

function UINDungeonHeroItem:RefreshHp(setMin)
  local amount = BattleUtil.CalculateBloodDensity(self.dynHeroData.hpPer / heroHpPercent)
  self.ui.img_hP.fillAmount = amount
  if setMin then
    self.ui.img_hPMin.fillAmount = amount
  end
  if amount <= 0.3 then
    self.ui.obj_img_Wound:SetActive(true)
  else
    self.ui.obj_img_Wound:SetActive(false)
  end
end

function UINDungeonHeroItem:PlayHpChangeAnim()
  local amount = BattleUtil.CalculateBloodDensity(self.dynHeroData.hpPer / heroHpPercent)
  if amount < self.ui.img_hP.fillAmount then
    self:KillHpChangeTween()
    self.ui.img_hP.fillAmount = amount
    local duration = math.abs(self.ui.img_hPMin.fillAmount - amount) * 5
    self.HpTween = self.ui.img_hPMin:DOFillAmount(amount, duration):OnComplete(self.__OnHpTweenComplete)
  elseif amount > self.ui.img_hP.fillAmount then
    self.ui.fx_HpRecover:SetActive(true)
    self:KillHpChangeTween()
    self.ui.img_hPMin.fillAmount = amount
    local duration = math.abs(self.ui.img_hP.fillAmount - amount) * 5
    self.HpTween = self.ui.img_hP:DOFillAmount(amount, duration):OnComplete(self.__OnHpTweenComplete)
  end
  if amount <= 0.3 then
    self.ui.obj_img_Wound:SetActive(true)
  else
    self.ui.obj_img_Wound:SetActive(false)
  end
end

function UINDungeonHeroItem:FakeDead()
  local amount = 0
  self.ui.img_hP.fillAmount = amount
  self.ui.img_hPMin.fillAmount = amount
  self.ui.obj_img_Wound:SetActive(true)
end

function UINDungeonHeroItem:OnHpTweenComplete()
  self.HpTween = nil
  self.ui.img_hPMin.fillAmount = self.ui.img_hP.fillAmount
  self.ui.fx_HpRecover:SetActive(false)
end

function UINDungeonHeroItem:KillHpChangeTween()
  if self.HpTween ~= nil then
    self.HpTween:Kill()
    self.HpTween = nil
  end
end

function UINDungeonHeroItem:SetHpBarActive(bool)
  self.ui.tr_hpBar.gameObject:SetActive(bool)
end

function UINDungeonHeroItem:SetChipSelect(bool, chipColor)
  if bool then
    self.ui.img_Adapter.color = chipColor
    self.ui.img_Adapter.gameObject:SetActive(true)
  else
    self.ui.img_Adapter.gameObject:SetActive(false)
  end
end

function UINDungeonHeroItem:SetSelect(bool)
  if bool then
    self.ui.DoTween_heroItem:DOPlayForward()
    self.ui.obj_onSelect:SetActive(true)
  else
    self.ui.DoTween_heroItem:DOPlayBackwards()
    self.ui.obj_onSelect:SetActive(false)
  end
end

function UINDungeonHeroItem:UpdateChipList()
  local chips = self.dynHeroData:GetOwnedChips()
  for key, _ in pairs(chips) do
    table.insert(self.chipList, key.dataId)
  end
end

function UINDungeonHeroItem:SetTransparent(bool)
  self.headItem:TransparentHeroHeadItem(bool)
end

function UINDungeonHeroItem:OnDelete()
  self:KillHpChangeTween()
  base.OnDelete(self)
end

return UINDungeonHeroItem
