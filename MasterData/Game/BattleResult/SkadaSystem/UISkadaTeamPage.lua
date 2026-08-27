local UISkadaTeamPage = class("UISkadaTeamPage", UIBaseNode)
local base = UIBaseNode
local UINSkadaTeamItem = require("Game.BattleResult.SkadaSystem.UINSkadaTeamItem")
local SkadaEnum = require("Game.BattleResult.SkadaSystem.SkadaEnum")
local RoleType = {Player = 0, Enemy = 1}

function UISkadaTeamPage:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_ChangeTeam, self, self.OnBtnChangedTeamClicked)
  self.__OnClickHeroDetail = BindCallback(self, self.OnClickHeroDetail)
  self.__OnInfoPageReturn = BindCallback(self, self.OnInfoPageReturn)
  self.ui.skadaItem:SetActive(false)
  self.skadaItemPool = UIItemPool.New(UINSkadaTeamItem, self.ui.skadaItem)
end

function UISkadaTeamPage:InitSkadaTeamPage(battleStatistics, playerRoleList, enemyRoleList, resLoader, panelSkadaInfoPage)
  self.battleStatistics = battleStatistics
  self.resLoader = resLoader
  self.panelSkadaInfoPage = panelSkadaInfoPage
  self.playerSkada = self:GenSkada(battleStatistics, playerRoleList, battleStatistics.playerDamage, battleStatistics.playerTakeDamage, battleStatistics.playerHeal, true)
  self.enemySkada = self:GenSkada(battleStatistics, enemyRoleList, battleStatistics.enemyDamage, battleStatistics.enemyTakeDamage, battleStatistics.enemyHeal)
  self.roleType = RoleType.Player
  self.ui.tex_ChangeTeam:SetIndex(self.roleType)
end

function UISkadaTeamPage:GenSkada(battleStatistics, roleList, damageDic, takeDamageDic, healDic, containCommander)
  local skadaList = {}
  local damageTotal = 0
  local takeDamageTotal = 0
  local healTotal = 0
  for i = 0, roleList.Count - 1 do
    local role = roleList[i]
    if not role.character.onBench then
      local skada = {}
      skada.isCommander = false
      skada.role = role
      skada.detail = {}
      skada.id = role.roleDataId
      local damage = self:__NewSkadaDetail()
      local ok, damageDetal = damageDic:TryGetValue(role)
      if ok then
        damage.value = damageDetal.damage
        damageTotal = damageTotal + damageDetal.damage
      end
      skada.detail[SkadaEnum.eSkadaType.Damage] = damage
      local takeDamage = self:__NewSkadaDetail()
      local ok, takeDamageDetail = takeDamageDic:TryGetValue(role)
      if ok then
        takeDamage.value = takeDamageDetail.damage
        takeDamageTotal = takeDamageTotal + takeDamageDetail.damage
      end
      skada.detail[SkadaEnum.eSkadaType.TakeDamage] = takeDamage
      local heal = self:__NewSkadaDetail()
      local ok, healDetail = healDic:TryGetValue(role)
      if ok then
        heal.value = healDetail.heal
        healTotal = healTotal + healDetail.heal
      end
      skada.detail[SkadaEnum.eSkadaType.Heal] = heal
      table.insert(skadaList, skada)
    end
  end
  if containCommander then
    local skada = {}
    skada.isCommander = true
    skada.detail = {}
    skada.id = CommonUtil.Int32Max
    local damage = self:__NewSkadaDetail()
    local damageNumber = battleStatistics.cmderDamage.damage
    damage.value = damageNumber
    damageTotal = damageTotal + damageNumber
    skada.detail[SkadaEnum.eSkadaType.Damage] = damage
    local takeDamage = self:__NewSkadaDetail()
    skada.detail[SkadaEnum.eSkadaType.TakeDamage] = takeDamage
    local heal = self:__NewSkadaDetail()
    local healNumber = battleStatistics.cmderHeal.heal
    heal.value = healNumber
    healTotal = healTotal + healNumber
    skada.detail[SkadaEnum.eSkadaType.Heal] = heal
    table.insert(skadaList, skada)
  end
  for k, v in ipairs(skadaList) do
    v.detail[SkadaEnum.eSkadaType.Damage].proportion = damageTotal == 0 and 0 or v.detail[SkadaEnum.eSkadaType.Damage].value / damageTotal
    v.detail[SkadaEnum.eSkadaType.TakeDamage].proportion = takeDamageTotal == 0 and 0 or v.detail[SkadaEnum.eSkadaType.TakeDamage].value / takeDamageTotal
    v.detail[SkadaEnum.eSkadaType.Heal].proportion = healTotal == 0 and 0 or v.detail[SkadaEnum.eSkadaType.Heal].value / healTotal
  end
  local skadaDetail = {}
  skadaDetail.list = skadaList
  skadaDetail.damageTotal = damageTotal
  skadaDetail.takeDamageTotal = takeDamageTotal
  skadaDetail.healTotal = healTotal
  return skadaDetail
end

function UISkadaTeamPage:__NewSkadaDetail()
  return {value = 0, proportion = 0}
end

function UISkadaTeamPage:OnSkadaTypeChanged(skadaType)
  self.skadaType = skadaType
  self:RefreshSkadaUI()
end

function UISkadaTeamPage:RefreshSkadaUI()
  self.skadaItemPool:HideAll()
  local skada
  if self.roleType == RoleType.Player then
    skada = self.playerSkada
  elseif self.roleType == RoleType.Enemy then
    skada = self.enemySkada
  end
  table.sort(skada.list, SkadaEnum.SkadaSortFunc[self.skadaType])
  for k, v in ipairs(skada.list) do
    local item = self.skadaItemPool:GetOne()
    item:InitSkadaItem(self.resLoader, self.__OnClickHeroDetail)
    item:RefreshSkadaItem(k, v, self.skadaType, self.roleType == RoleType.Player)
  end
end

function UISkadaTeamPage:OnClickHeroDetail(roleSkada, roleIndex)
  local belongPlayer = self.roleType == RoleType.Player
  local temaSkada = belongPlayer and self.playerSkada or self.enemySkada
  self.panelSkadaInfoPage:ShowSkadaInfoPage(roleIndex, temaSkada, belongPlayer, self.__OnInfoPageReturn)
  self:Hide()
end

function UISkadaTeamPage:OnBtnChangedTeamClicked()
  self.roleType = 1 - self.roleType
  self.ui.tex_ChangeTeam:SetIndex(self.roleType)
  self:RefreshSkadaUI()
end

function UISkadaTeamPage:OnInfoPageReturn()
  self:Show()
end

return UISkadaTeamPage
