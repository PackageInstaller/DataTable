local UIBattleSkadaPage = class("UIBattleSkadaPage", UIBaseNode)
local base = UIBaseNode
local UIBattleSkadaItem = require("Game.BattleResult.Skada.UIBattleSkadaItem")
local UIBattleSkadaInfoPage = require("Game.BattleResult.SkadaInfo.UIBattleSkadaInfoPage")
local BattleSkadaEnum = require("Game.BattleResult.Skada.BattleSkadaEnum")
local cs_BattleStatistics
local RoleType = {Player = 0, Enemy = 1}

function UIBattleSkadaPage:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.OnClickReturn)
  self.ui.tog_Player.onValueChanged:AddListener(BindCallback(self, self.OnClickRoleChange, RoleType.Player))
  self.ui.tog_Enemy.onValueChanged:AddListener(BindCallback(self, self.OnClickRoleChange, RoleType.Enemy))
  self.ui.tog_DPS.onValueChanged:AddListener(BindCallback(self, self.OnClickDetail, BattleSkadaEnum.eBattleSkadaType.Damage))
  self.ui.tog_Tank.onValueChanged:AddListener(BindCallback(self, self.OnClickDetail, BattleSkadaEnum.eBattleSkadaType.TakeDamage))
  self.ui.tog_Heal.onValueChanged:AddListener(BindCallback(self, self.OnClickDetail, BattleSkadaEnum.eBattleSkadaType.Heal))
  self.ui.skadaItem:SetActive(false)
  self.skadaItemPool = UIItemPool.New(UIBattleSkadaItem, self.ui.skadaItem)
end

function UIBattleSkadaPage:InitBattleSkadaPage(skadaInfoPage, battleStatistics, playerRoleList, enemyRoleList, resLoader)
  cs_BattleStatistics = battleStatistics
  self.ui.skadaInfoPage = skadaInfoPage
  self.resLoader = resLoader
  self.playerSkada = self:GenSkada(playerRoleList, cs_BattleStatistics.playerDamage, cs_BattleStatistics.playerTakeDamage, cs_BattleStatistics.playerHeal)
  self.enemySkada = self:GenSkada(enemyRoleList, cs_BattleStatistics.enemyDamage, cs_BattleStatistics.enemyTakeDamage, cs_BattleStatistics.enemyHeal)
  self.skadaType = BattleSkadaEnum.eBattleSkadaType.Damage
  self.roleType = RoleType.Player
  self.ui.tog_Player.isOn = true
  self.ui.tog_DPS.isOn = true
  self:RefreshSkadaUI()
end

function UIBattleSkadaPage:GenSkada(roleList, damageDic, takeDamageDic, healDic)
  local skadaList = {}
  local damageTotal = 0
  local takeDamageTotal = 0
  local healTotal = 0
  for i = 0, roleList.Count - 1 do
    local role = roleList[i]
    if not role.character.onBench then
      local skada = {}
      skada.role = role
      skada.detail = {}
      local damage = self:__NewSkadaDetail()
      local ok, damageDetal = damageDic:TryGetValue(role)
      if ok then
        damage.value = damageDetal.damage
        damageTotal = damageTotal + damageDetal.damage
      end
      skada.detail[BattleSkadaEnum.eBattleSkadaType.Damage] = damage
      local takeDamage = self:__NewSkadaDetail()
      local ok, takeDamageDetail = takeDamageDic:TryGetValue(role)
      if ok then
        takeDamage.value = takeDamageDetail.damage
        takeDamageTotal = takeDamageTotal + takeDamageDetail.damage
      end
      skada.detail[BattleSkadaEnum.eBattleSkadaType.TakeDamage] = takeDamage
      local heal = self:__NewSkadaDetail()
      local ok, healDetail = healDic:TryGetValue(role)
      if ok then
        heal.value = healDetail.heal
        healTotal = healTotal + healDetail.heal
      end
      skada.detail[BattleSkadaEnum.eBattleSkadaType.Heal] = heal
      table.insert(skadaList, skada)
    end
  end
  for k, v in ipairs(skadaList) do
    v.detail[BattleSkadaEnum.eBattleSkadaType.Damage].proportion = v.detail[BattleSkadaEnum.eBattleSkadaType.Damage].value / damageTotal
    v.detail[BattleSkadaEnum.eBattleSkadaType.TakeDamage].proportion = v.detail[BattleSkadaEnum.eBattleSkadaType.TakeDamage].value / takeDamageTotal
    v.detail[BattleSkadaEnum.eBattleSkadaType.Heal].proportion = v.detail[BattleSkadaEnum.eBattleSkadaType.Heal].value / healTotal
  end
  local skadaDetail = {}
  skadaDetail.list = skadaList
  skadaDetail.damageTotal = damageTotal
  skadaDetail.takeDamageTotal = takeDamageTotal
  skadaDetail.healTotal = healTotal
  return skadaDetail
end

function UIBattleSkadaPage:__NewSkadaDetail()
  return {value = 0, proportion = 0}
end

local SkadaSortFunc = {
  [BattleSkadaEnum.eBattleSkadaType.Damage] = function(skada1, skada2)
    local damage1 = skada1.detail[BattleSkadaEnum.eBattleSkadaType.Damage].value
    local damage2 = skada2.detail[BattleSkadaEnum.eBattleSkadaType.Damage].value
    if damage1 ~= damage2 then
      return damage1 > damage2
    else
      return skada1.role.roleDataId < skada2.role.roleDataId
    end
  end,
  [BattleSkadaEnum.eBattleSkadaType.TakeDamage] = function(skada1, skada2)
    local takeDamage1 = skada1.detail[BattleSkadaEnum.eBattleSkadaType.TakeDamage].value
    local takeDamage2 = skada2.detail[BattleSkadaEnum.eBattleSkadaType.TakeDamage].value
    if takeDamage1 ~= takeDamage2 then
      return takeDamage1 > takeDamage2
    else
      return skada1.role.roleDataId < skada2.role.roleDataId
    end
  end,
  [BattleSkadaEnum.eBattleSkadaType.Heal] = function(skada1, skada2)
    local heal1 = skada1.detail[BattleSkadaEnum.eBattleSkadaType.Heal].value
    local heal2 = skada2.detail[BattleSkadaEnum.eBattleSkadaType.Heal].value
    if heal1 ~= heal2 then
      return heal1 > heal2
    else
      return skada1.role.roleDataId < skada2.role.roleDataId
    end
  end
}

function UIBattleSkadaPage:OnClickRoleChange(roleType, isOn)
  if isOn then
    self.roleType = roleType
    self:RefreshSkadaUI()
  end
end

function UIBattleSkadaPage:OnClickDetail(skadaType, isOn)
  if isOn then
    self.skadaType = skadaType
    self:RefreshSkadaUI()
  end
end

function UIBattleSkadaPage:RefreshSkadaUI()
  self.skadaItemPool:HideAll()
  local skada
  if self.roleType == RoleType.Player then
    skada = self.playerSkada
  elseif self.roleType == RoleType.Enemy then
    skada = self.enemySkada
  end
  table.sort(skada.list, SkadaSortFunc[self.skadaType])
  for k, v in ipairs(skada.list) do
    local item = self.skadaItemPool:GetOne()
    item:InitSkadaItem(self.resLoader, BindCallback(self, self.OnClickHeroDetail))
    item:RefreshSkadaItem(k, v, self.skadaType, self.roleType == RoleType.Player)
  end
end

function UIBattleSkadaPage:OnClickHeroDetail(roleSkada, roleIndex)
  self.selectRoleIndex = roleIndex
  if self.skadaInfoPage == nil then
    self.skadaInfoPage = UIBattleSkadaInfoPage.New()
    self.skadaInfoPage:Init(self.ui.skadaInfoPage)
  end
  self.skadaInfoPage:Show()
  local belongPlayer = self.roleType == RoleType.Player
  local roleSkadaDetail = self:GenRoleSkadaDetail(roleSkada, belongPlayer)
  self.skadaInfoPage:InitSkadaInfoPage(roleSkadaDetail, belongPlayer, self.resLoader, self.skadaType, BindCallback(self, self.OnSwitchPlayer))
end

function UIBattleSkadaPage:GenRoleSkadaDetail(roleSkada, belongPlayer)
  local roleSkadaDetail = {}
  roleSkadaDetail.role = roleSkada.role
  local damage = {}
  roleSkadaDetail[BattleSkadaEnum.eBattleSkadaType.Damage] = damage
  local damageDic = belongPlayer and cs_BattleStatistics.playerDamage or cs_BattleStatistics.enemyDamage
  local ok, damageDetail = damageDic:TryGetValue(roleSkada.role)
  if ok then
    for k, v in pairs(damageDetail.damageDic) do
      local detail = {}
      detail.csDetail = v
      detail.proportion = v.damage / damageDetail.damage
      table.insert(damage, detail)
    end
    for k, v in pairs(damageDetail.extraDamageDic) do
      local detail = {}
      detail.csDetail = v
      detail.proportion = v.damage / damageDetail.damage
      table.insert(damage, detail)
    end
    table.sort(damage, function(damage1, damage2)
      return damage1.proportion > damage2.proportion
    end)
  end
  local takeDamage = {}
  roleSkadaDetail[BattleSkadaEnum.eBattleSkadaType.TakeDamage] = takeDamage
  local takeDamageDic = belongPlayer and cs_BattleStatistics.playerTakeDamage or cs_BattleStatistics.enemyTakeDamage
  local ok, takeDamageDetail = takeDamageDic:TryGetValue(roleSkada.role)
  if ok then
    for k, v in pairs(takeDamageDetail.takeDamageDic) do
      local detail = {}
      detail.csDetail = v
      detail.proportion = v.damage / takeDamageDetail.damage
      table.insert(takeDamage, detail)
    end
    table.sort(takeDamage, function(takeDamage1, takeDamage2)
      return takeDamage1.proportion > takeDamage2.proportion
    end)
  end
  local heal = {}
  roleSkadaDetail[BattleSkadaEnum.eBattleSkadaType.Heal] = heal
  local healDic = belongPlayer and cs_BattleStatistics.playerHeal or cs_BattleStatistics.enemyHeal
  local ok, healDetail = healDic:TryGetValue(roleSkada.role)
  if ok then
    for k, v in pairs(healDetail.healDic) do
      local detail = {}
      detail.csDetail = v
      detail.proportion = v.heal / healDetail.heal
      table.insert(heal, detail)
    end
    table.sort(heal, function(heal1, heal2)
      return heal1.proportion > heal2.proportion
    end)
  end
  return roleSkadaDetail
end

function UIBattleSkadaPage:OnSwitchPlayer(isLeft)
  local belongPlayer = self.roleType == RoleType.Player
  self.selectRoleIndex = (isLeft and -1 or 1) + self.selectRoleIndex
  local skada = belongPlayer and self.playerSkada or self.enemySkada
  local listCount = #skada.list
  if self.selectRoleIndex < 1 then
    self.selectRoleIndex = listCount
  elseif listCount < self.selectRoleIndex then
    self.selectRoleIndex = 1
  end
  local roleSkada = skada.list[self.selectRoleIndex]
  local roleSkadaDetail = self:GenRoleSkadaDetail(roleSkada, belongPlayer)
  self.skadaInfoPage:SwitchRoleSkada(roleSkadaDetail)
end

function UIBattleSkadaPage:OnClickReturn()
  self:Hide()
end

function UIBattleSkadaPage:OnDelete()
  self.skadaItemPool:DeleteAll()
  if self.skadaInfoPage ~= nil then
    self.skadaInfoPage:Delete()
  end
  base.OnDelete(self)
end

return UIBattleSkadaPage
