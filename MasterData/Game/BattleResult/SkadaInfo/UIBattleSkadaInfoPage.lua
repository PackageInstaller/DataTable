local UIBattleSkadaInfoPage = class("UIBattleSkadaInfoPage", UIBaseNode)
local base = UIBaseNode
local UIBattleSkadaInfoItem = require("Game.BattleResult.SkadaInfo.UIBattleSkadaInfoItem")
local UIPie = require("Game.BattleResult.Pie.UIPie")
local BattleSkadaEnum = require("Game.BattleResult.Skada.BattleSkadaEnum")

function UIBattleSkadaInfoPage:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.OnClickReturn)
  UIUtil.AddButtonListener(self.ui.btn_Left, self, self.OnClickLeft)
  UIUtil.AddButtonListener(self.ui.btn_Right, self, self.OnClickRight)
  self.ui.tog_DPS.onValueChanged:AddListener(BindCallback(self, self.OnClickDetail, BattleSkadaEnum.eBattleSkadaType.Damage))
  self.ui.tog_Tank.onValueChanged:AddListener(BindCallback(self, self.OnClickDetail, BattleSkadaEnum.eBattleSkadaType.TakeDamage))
  self.ui.tog_Heal.onValueChanged:AddListener(BindCallback(self, self.OnClickDetail, BattleSkadaEnum.eBattleSkadaType.Heal))
  self.ui.skillItem:SetActive(false)
  self.infoItemPool = UIItemPool.New(UIBattleSkadaInfoItem, self.ui.skillItem)
  self.pie = UIPie.New()
  self.pie:Init(self.ui.pieChartNode)
end

function UIBattleSkadaInfoPage:InitSkadaInfoPage(roleSkadaDetail, belongPlayer, resLoader, skadaType, onSwitchPlayerEvent)
  self.skadaType = skadaType
  self.onSwitchPlayerEvent = onSwitchPlayerEvent
  self.belongPlayer = belongPlayer
  self.resLoader = resLoader
  self:SwitchRoleSkada(roleSkadaDetail)
end

function UIBattleSkadaInfoPage:SwitchRoleSkada(roleSkadaDetail)
  self.roleSkadaDetail = roleSkadaDetail
  self.ui.tex_HeroName.text = roleSkadaDetail.role.name
  local path = self.belongPlayer and PathConsts:GetCharacterPicPath(roleSkadaDetail.role.character:GetResPicName()) or PathConsts:GetCharacterSmallPicPath(roleSkadaDetail.role.character:GetResPicName())
  self.ui.img_HeroPic.texture = self.resLoader:LoadABAsset(path)
  local uvRect = self.ui.img_HeroPic.uvRect
  if self.belongPlayer then
    uvRect:Set(0, 0.5, 0.5, 0.5)
  else
    uvRect:Set(0, 0, 1, 1)
  end
  self.ui.img_HeroPic.uvRect = uvRect
  self.ui.togGroup_Battle:SetAllTogglesOff()
  if self.skadaType == BattleSkadaEnum.eBattleSkadaType.Damage then
    self.ui.tog_DPS.isOn = true
  elseif self.skadaType == BattleSkadaEnum.eBattleSkadaType.TakeDamage then
    self.ui.tog_Tank.isOn = true
  elseif self.skadaType == BattleSkadaEnum.eBattleSkadaType.Heal then
    self.ui.tog_Heal.isOn = true
  end
end

function UIBattleSkadaInfoPage:OnClickDetail(skadaType, isOn)
  if isOn then
    self.skadaType = skadaType
    self:RefreshSkadaInfoUI()
  end
end

function UIBattleSkadaInfoPage:RefreshSkadaInfoUI()
  self.ui.text_count:SetActive(self.skadaType == BattleSkadaEnum.eBattleSkadaType.Damage)
  self.ui.text_skill:SetIndex(self.skadaType - 1)
  self.infoItemPool:HideAll()
  local proportionTab = {}
  if self.skadaType == BattleSkadaEnum.eBattleSkadaType.Damage then
    local detailList = self.roleSkadaDetail[self.skadaType]
    for k, v in ipairs(detailList) do
      local infoItem = self.infoItemPool:GetOne()
      local color = self.pie:GetPieColor(k)
      infoItem:InitSkadaInfoItem(color, v.csDetail.name, v.csDetail.count, v.csDetail.damage, v.proportion)
      table.insert(proportionTab, v.proportion)
    end
  elseif self.skadaType == BattleSkadaEnum.eBattleSkadaType.TakeDamage then
    local detailList = self.roleSkadaDetail[self.skadaType]
    for k, v in ipairs(detailList) do
      local infoItem = self.infoItemPool:GetOne()
      local color = self.pie:GetPieColor(k)
      infoItem:InitSkadaInfoItem(color, v.csDetail.name, nil, v.csDetail.damage, v.proportion)
      table.insert(proportionTab, v.proportion)
    end
  elseif self.skadaType == BattleSkadaEnum.eBattleSkadaType.Heal then
    local detailList = self.roleSkadaDetail[self.skadaType]
    for k, v in ipairs(detailList) do
      local infoItem = self.infoItemPool:GetOne()
      local color = self.pie:GetPieColor(k)
      infoItem:InitSkadaInfoItem(color, v.csDetail.name, nil, v.csDetail.heal, v.proportion)
      table.insert(proportionTab, v.proportion)
    end
  end
  self.pie:InitPie(proportionTab)
end

function UIBattleSkadaInfoPage:OnClickLeft()
  if self.onSwitchPlayerEvent ~= nil then
    self.onSwitchPlayerEvent(true)
  end
end

function UIBattleSkadaInfoPage:OnClickRight()
  if self.onSwitchPlayerEvent ~= nil then
    self.onSwitchPlayerEvent(false)
  end
end

function UIBattleSkadaInfoPage:OnClickReturn()
  self:Hide()
end

function UIBattleSkadaInfoPage:OnDelete()
  self.infoItemPool:DeleteAll()
  base.OnDelete(self)
end

return UIBattleSkadaInfoPage
