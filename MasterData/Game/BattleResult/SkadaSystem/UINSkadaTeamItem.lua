local UINSkadaTeamItem = class("UINSkadaTeamItem", UIBaseNode)
local base = UIBaseNode
local SkadaEnum = require("Game.BattleResult.SkadaSystem.SkadaEnum")
local UINRoleHeadItem = require("Game.CommonUI.Hero.UINRoleHeadItem")
local UINSkadaValueItem = require("Game.BattleResult.SkadaSystem.UINSkadaValueItem")

function UINSkadaTeamItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__OnClickRoleHead = BindCallback(self, self.OnClickRoleHead)
  self.ui.skadaValueItem:SetActive(false)
end

function UINSkadaTeamItem:InitSkadaItem(resLoader, clickCallback)
  if self.__init then
    return
  end
  self.__init = true
  self.resLoader = resLoader
  self.OnClickRoleHeadEvent = clickCallback
  self.roleHeadItem = UINRoleHeadItem.New()
  self.roleHeadItem:Init(self.ui.roleHeadItem)
  self.valueItems = {}
  for id = 1, SkadaEnum.MaxSkadaTypeNum do
    local go = self.ui.skadaValueItem:Instantiate()
    go:SetActive(true)
    local valueItem = UINSkadaValueItem.New()
    valueItem:Init(go)
    valueItem:InitSkadaValueItem(self:__GetValueItemColor(id))
    self.valueItems[id] = valueItem
  end
end

function UINSkadaTeamItem:RefreshSkadaItem(roleIndex, roleSkada, skadaType, belongPlayer)
  self.roleIndex = roleIndex
  self.roleSkada = roleSkada
  if roleSkada.isCommander then
    self.ui.tex_HeroName.text = ConfigData:GetTipContent(TipContent.CommanderDPSName)
    self.roleHeadItem:InitCommanderHeadItem(self.resLoader, self.__OnClickRoleHead)
  else
    local dynRole = roleSkada.role.character
    self.roleHeadItem:InitRoleHeadItem(dynRole, self.resLoader, self.__OnClickRoleHead, belongPlayer)
    self.ui.tex_HeroName.text = dynRole:GetName()
  end
  for k, v in ipairs(self.valueItems) do
    local detail = roleSkada.detail[k]
    local alpha = 1
    if k ~= skadaType then
      alpha = self.ui.normal_alpha
    end
    v:SetSkadaValue(detail.proportion, detail.value, alpha)
    if skadaType ~= k then
      v.transform:SetAsLastSibling()
    end
  end
end

function UINSkadaTeamItem:__GetValueItemColor(skadaType)
  if skadaType == SkadaEnum.eSkadaType.Damage then
    return self.ui.damageColor
  elseif skadaType == SkadaEnum.eSkadaType.TakeDamage then
    return self.ui.takeDamageColor
  elseif skadaType == SkadaEnum.eSkadaType.Heal then
    return self.ui.healColor
  end
end

function UINSkadaTeamItem:OnClickRoleHead(roleData, isCommander)
  if self.OnClickRoleHeadEvent ~= nil then
    self.OnClickRoleHeadEvent(self.roleSkada, self.roleIndex)
  end
end

return UINSkadaTeamItem
