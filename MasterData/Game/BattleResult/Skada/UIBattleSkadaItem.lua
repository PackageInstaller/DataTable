local UIBattleSkadaItem = class("UIBattleSkadaItem", UIBaseNode)
local base = UIBaseNode
local UIBattleSkadaValueItem = require("Game.BattleResult.Skada.UIBattleSkadaValueItem")
local BattleSkadaEnum = require("Game.BattleResult.Skada.BattleSkadaEnum")

function UIBattleSkadaItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_HeroPic, self, self.OnClickHeroPic)
  self.ui.valueItem:SetActive(false)
end

function UIBattleSkadaItem:InitSkadaItem(resLoader, clickCallback)
  if self.__init then
    return
  end
  self.__init = true
  self.resLoader = resLoader
  self.OnClickHeroPicEvent = clickCallback
  self.valueItems = {}
  for k, id in pairs(BattleSkadaEnum.eBattleSkadaType) do
    local go = self.ui.valueItem:Instantiate()
    go:SetActive(true)
    local valueItem = UIBattleSkadaValueItem.New()
    valueItem:Init(go)
    valueItem:InitSkadaValueItem(self:__GetValueItemColor(id))
    self.valueItems[id] = valueItem
  end
end

function UIBattleSkadaItem:RefreshSkadaItem(roleIndex, roleSkada, sortType, belongPlayer)
  self.roleIndex = roleIndex
  self.roleSkada = roleSkada
  local path = belongPlayer and PathConsts:GetCharacterPicPath(roleSkada.role.character:GetResPicName()) or PathConsts:GetCharacterSmallPicPath(roleSkada.role.character:GetResPicName())
  self.ui.img_HeroPic.texture = self.resLoader:LoadABAsset(path)
  local uvRect = self.ui.img_HeroPic.uvRect
  if belongPlayer then
    uvRect:Set(0, 0.5, 0.5, 0.5)
  else
    uvRect:Set(0, 0, 1, 1)
  end
  self.ui.img_HeroPic.uvRect = uvRect
  for k, v in ipairs(self.valueItems) do
    local detail = roleSkada.detail[k]
    v:SetSkadaValue(detail.proportion, detail.value)
    if sortType ~= k then
      v.transform:SetAsLastSibling()
    end
  end
end

function UIBattleSkadaItem:__GetValueItemColor(skadaType)
  if skadaType == BattleSkadaEnum.eBattleSkadaType.Damage then
    return self.ui.damageColor
  elseif skadaType == BattleSkadaEnum.eBattleSkadaType.TakeDamage then
    return self.ui.takeDamageColor
  elseif skadaType == BattleSkadaEnum.eBattleSkadaType.Heal then
    return self.ui.healColor
  end
end

function UIBattleSkadaItem:OnClickHeroPic()
  if self.OnClickHeroPicEvent ~= nil then
    self.OnClickHeroPicEvent(self.roleSkada, self.roleIndex)
  end
end

function UIBattleSkadaItem:OnDelete()
  for k, v in pairs(self.valueItems) do
    v:Delete()
  end
  base.OnDelete(self)
end

return UIBattleSkadaItem
