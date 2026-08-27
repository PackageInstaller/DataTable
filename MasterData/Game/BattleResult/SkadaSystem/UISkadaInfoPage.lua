local UISkadaInfoPage = class("UISkadaInfoPage", UIBaseNode)
local base = UIBaseNode
local SkadaEnum = require("Game.BattleResult.SkadaSystem.SkadaEnum")
local UINRoleHeadItem = require("Game.CommonUI.Hero.UINRoleHeadItem")
local UINSkadaInfoItem = require("Game.BattleResult.SkadaSystem.UINSkadaInfoItem")
local dpsSkillColorType = {
  [0] = 1,
  [1] = 2,
  [2] = 2,
  [3] = 4
}

function UISkadaInfoPage:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.OnBtnReturnClicked)
  UIUtil.AddButtonListener(self.ui.btn_Befor, self, self.OnBtnBeforClicked)
  UIUtil.AddButtonListener(self.ui.btn_After, self, self.OnBtnAfterClicked)
  self.ui.skadaInfoList.onInstantiateItem = BindCallback(self, self.__SkadaInfoInitItem)
  self.ui.skadaInfoList.onChangeItem = BindCallback(self, self.__SkadaInfoItemChanged)
  self.skadaInfoItemDic = {}
  self.roleHeadItem = UINRoleHeadItem.New()
  self.roleHeadItem:Init(self.ui.roleHeadItem)
end

function UISkadaInfoPage:OnSkadaTypeChanged(skadaType)
  self.skadaType = skadaType
  if self.active then
    self:RefreshSkadaInfoUI()
  end
end

function UISkadaInfoPage:FirstInitSkadaInfoPage(resloader, battleStatistics)
  self.resloader = resloader
  self.battleStatistics = battleStatistics
end

function UISkadaInfoPage:ShowSkadaInfoPage(roleIndex, teamSkada, belongPlayer, returnAction)
  self.selectRoleIndex = roleIndex
  self.teamSkada = teamSkada
  self.belongPlayer = belongPlayer
  self.returnAction = returnAction
  self:Show()
  local roleSkada = self.teamSkada.list[self.selectRoleIndex]
  local roleSkadaDetail = self:GenRoleSkadaDetail(roleSkada, self.belongPlayer)
  self:ShowRoleSkada(roleSkadaDetail)
end

function UISkadaInfoPage:ShowRoleSkada(roleSkadaDetail)
  self.roleSkadaDetail = roleSkadaDetail
  if roleSkadaDetail.isCommander then
    self.ui.tex_HeroName.text = ConfigData:GetTipContent(TipContent.CommanderDPSName)
    self.roleHeadItem:InitCommanderHeadItem(self.resloader, nil)
  else
    self.ui.tex_HeroName.text = roleSkadaDetail.role.name
    local dynRole = roleSkadaDetail.role.character
    self.roleHeadItem:InitRoleHeadItem(dynRole, self.resloader, nil, self.belongPlayer)
  end
  self:RefreshSkadaInfoUI()
end

function UISkadaInfoPage:RefreshSkadaInfoUI()
  self.ui.tex_Count.gameObject:SetActive(self.skadaType == SkadaEnum.eSkadaType.Damage)
  self.ui.tex_Name:SetIndex(self.skadaType - 1)
  local valueTextIndex = 0
  if self.skadaType == SkadaEnum.eSkadaType.Heal then
    valueTextIndex = 1
  end
  self.ui.tex_Value:SetIndex(valueTextIndex)
  self:__ReFillSkadaInfoList()
end

function UISkadaInfoPage:__ReFillSkadaInfoList()
  local detailList = self.roleSkadaDetail[self.skadaType]
  self.ui.skadaInfoList.totalCount = #detailList
  self.ui.skadaInfoList:RefillCells()
end

function UISkadaInfoPage:__SkadaInfoInitItem(go)
  local skadaInfoItem = UINSkadaInfoItem.New()
  skadaInfoItem:Init(go)
  self.skadaInfoItemDic[go] = skadaInfoItem
end

function UISkadaInfoPage:__SkadaInfoItemChanged(go, index)
  local skadaInfoItem = self.skadaInfoItemDic[go]
  if skadaInfoItem == nil then
    error("Can't find Item by gameObject")
    return
  end
  index = index + 1
  local detailList = self.roleSkadaDetail[self.skadaType]
  local skadaValueData = detailList[index]
  if skadaValueData == nil then
    error("Can't find skadaValueData by index, index = " .. tonumber(index))
  end
  local count
  local csDetail = skadaValueData.csDetail
  local name = csDetail.name
  local color = Color.white
  local value = 0
  if self.skadaType == SkadaEnum.eSkadaType.Damage then
    count = csDetail.count
    local colorIndex = dpsSkillColorType[csDetail.skillTag]
    color = self.ui["infoColor" .. tostring(colorIndex)]
    value = csDetail.damage
  elseif self.skadaType == SkadaEnum.eSkadaType.TakeDamage then
    value = csDetail.damage
    color = self.ui.color_TakeDamage
  elseif self.skadaType == SkadaEnum.eSkadaType.Heal then
    value = csDetail.heal
    color = self.ui.color_heal
  end
  skadaInfoItem:InitSkadaInfoItem(color, name, count, value, skadaValueData.proportion)
end

function UISkadaInfoPage:OnSwitchPlayer(isLeft)
  self.selectRoleIndex = (isLeft and -1 or 1) + self.selectRoleIndex
  local listCount = #self.teamSkada.list
  if self.selectRoleIndex < 1 then
    self.selectRoleIndex = listCount
  elseif listCount < self.selectRoleIndex then
    self.selectRoleIndex = 1
  end
  local roleSkada = self.teamSkada.list[self.selectRoleIndex]
  local roleSkadaDetail = self:GenRoleSkadaDetail(roleSkada, self.belongPlayer)
  self:ShowRoleSkada(roleSkadaDetail)
end

function UISkadaInfoPage:GenRoleSkadaDetail(roleSkada, belongPlayer)
  local roleSkadaDetail = {}
  if roleSkada.isCommander then
    roleSkadaDetail.isCommander = true
    local damage = {}
    roleSkadaDetail[SkadaEnum.eSkadaType.Damage] = damage
    local damageDetail = self.battleStatistics.cmderDamage
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
    roleSkadaDetail[SkadaEnum.eSkadaType.TakeDamage] = {}
    local heal = {}
    roleSkadaDetail[SkadaEnum.eSkadaType.Heal] = heal
    local healDetail = self.battleStatistics.cmderHeal
    for k, v in pairs(healDetail.healDic) do
      local detail = {}
      detail.csDetail = v
      detail.proportion = v.heal / healDetail.heal
      table.insert(heal, detail)
    end
    table.sort(heal, function(heal1, heal2)
      return heal1.proportion > heal2.proportion
    end)
    return roleSkadaDetail
  end
  roleSkadaDetail.isCommander = false
  roleSkadaDetail.role = roleSkada.role
  local damage = {}
  roleSkadaDetail[SkadaEnum.eSkadaType.Damage] = damage
  local damageDic = belongPlayer and self.battleStatistics.playerDamage or self.battleStatistics.enemyDamage
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
  roleSkadaDetail[SkadaEnum.eSkadaType.TakeDamage] = takeDamage
  local takeDamageDic = belongPlayer and self.battleStatistics.playerTakeDamage or self.battleStatistics.enemyTakeDamage
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
  roleSkadaDetail[SkadaEnum.eSkadaType.Heal] = heal
  local healDic = belongPlayer and self.battleStatistics.playerHeal or self.battleStatistics.enemyHeal
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

function UISkadaInfoPage:OnBtnBeforClicked()
  self:OnSwitchPlayer(true)
end

function UISkadaInfoPage:OnBtnAfterClicked()
  self:OnSwitchPlayer(false)
end

function UISkadaInfoPage:OnBtnReturnClicked()
  self:Hide()
  if self.returnAction ~= nil then
    self.returnAction()
  end
end

function UISkadaInfoPage:OnDelete()
  base.OnDelete(self)
end

return UISkadaInfoPage
