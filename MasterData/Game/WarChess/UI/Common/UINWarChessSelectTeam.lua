local UINWarChessSelectTeam = class("UINWarChessSelectTeam", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
local UINChipDetailSuitItem = require("Game.CommonUI.Chip.UINChipDetailSuitItem")
local WarChessHelper = require("Game.WarChess.WarChessHelper")

function UINWarChessSelectTeam:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Equip, self, self._OnClickWCTeamEquip)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self._OnClickWCTeamBuy)
  UIUtil.AddButtonListener(self.ui.btn_Chip, self, self._OnClickChipBag)
  self.ui.heroHeadItem:SetActive(false)
  self.heroHeadPool = UIItemPool.New(UINHeroHeadItem, self.ui.heroHeadItem)
end

function UINWarChessSelectTeam:InitWCSelectTeamGetChip(teamData, chipData, resloader)
  self._resloader = resloader
  self:_InitWCTeamUIBase(teamData)
  local dynPlayer = teamData:GetTeamDynPlayer()
  self:_InitTeamHeroList(chipData, dynPlayer)
  self:_InitTeamFightPower(chipData, dynPlayer)
  local isHasChip = dynPlayer.chipDic[chipData.dataId] ~= nil
  self._hasThisChip = isHasChip
  self.ui.tex_Equip:SetIndex(isHasChip and 1 or 0)
  local _, count, limit = dynPlayer:IsChipOverLimitNum()
  if not isHasChip and limit <= count then
    self.ui.tex_ChipCount:SetIndex(1, tostring(count), tostring(limit))
  else
    self.ui.tex_ChipCount:SetIndex(0, tostring(count), tostring(limit))
  end
  local chipReturnMoney = WarChessHelper.GetChipReturnMoney(dynPlayer, chipData.dataId, chipData:GetCount())
  if 0 < chipReturnMoney then
    self.ui.ccReturn:SetActive(true)
    self.ui.tex_Return.text = tostring(chipReturnMoney)
  else
    self.ui.ccReturn:SetActive(false)
  end
end

function UINWarChessSelectTeam:InitWCSelectTeamBuyChip(teamData, chipData, resloader, price)
  self:InitWCSelectTeamGetChip(teamData, chipData, resloader)
  self.ui.text_price.text = tostring(price)
  self.ui.btn_Buy.gameObject:SetActive(true)
  self.ui.btn_Equip.gameObject:SetActive(false)
  self.ui.tex_Buy:SetIndex(self._hasThisChip and 1 or 0)
end

function UINWarChessSelectTeam:BindWCSelectTeamEvent(equipEvent, buyEvent)
  self._equipEvent = equipEvent
  self._buyEvent = buyEvent
end

function UINWarChessSelectTeam:_InitTeamHeroList(chipData, dynPlayer)
  local isToPlayer = chipData:IsValidDynPlayer()
  self.ui.obj_TacticNode:SetActive(isToPlayer)
  self.ui.obj_heroList:SetActive(not isToPlayer)
  if isToPlayer then
    self:_SetTacticNodeActive(chipData:IsConsumeSkillChip() and 1 or 0)
    return
  end
  local heroList = {}
  for index, dynHeroData in ipairs(dynPlayer.heroList) do
    if not dynHeroData:IsBench() then
      table.insert(heroList, dynHeroData)
    end
  end
  local validCharacters = chipData:GetValidRoleList(heroList, eBattleRoleBelong.player, dynPlayer:GetSpecEffectMgr())
  self.heroHeadPool:HideAll()
  for _, dynHero in pairs(validCharacters) do
    local heroHeadItem = self.heroHeadPool:GetOne()
    heroHeadItem:InitHeroHeadItem(dynHero.heroData, self._resloader)
    heroHeadItem:Show()
  end
end

function UINWarChessSelectTeam:_InitTeamFightPower(chipData, dynPlayer, powerType, isOwnData)
  if dynPlayer == nil then
    self.ui.tex_Power:SetIndex(0, "0")
    return
  end
  self.fightPower = 0
  if powerType == eChipDetailPowerType.Add or powerType == nil then
    self.fightPower = dynPlayer:GetChipCombatEffect(chipData, isOwnData)
    self.ui.tex_Power:SetIndex(0, GetPreciseDecimalStr(self.fightPower, 1))
  elseif powerType == eChipDetailPowerType.Subtract then
    self.fightPower = dynPlayer:GetChipDiscardFightPower(chipData)
    self.ui.tex_Power:SetIndex(1, GetPreciseDecimalStr(self.fightPower, 1))
  end
end

function UINWarChessSelectTeam:_SetTacticNodeActive(index)
  self.ui.text_TacticNode:SetIndex(index or 0)
  self.ui.textEn_TacticNode:SetIndex(index or 0)
end

function UINWarChessSelectTeam:_InitWCTeamUIBase(teamData)
  self._teamData = teamData
  self.ui.tex_TeamName.text = teamData:GetWCTeamName()
  self.gameObject.name = teamData:GetWCTeamIndex()
end

function UINWarChessSelectTeam:GetWCSelectTeamData()
  return self._teamData
end

function UINWarChessSelectTeam:_OnClickWCTeamEquip()
  if self._equipEvent ~= nil then
    self._equipEvent(self, self._teamData)
  end
end

function UINWarChessSelectTeam:_OnClickWCTeamBuy()
  if self._buyEvent ~= nil then
    self._buyEvent(self, self._teamData)
  end
end

function UINWarChessSelectTeam:_OnClickChipBag()
  local successOpenChipBag = WarChessHelper.OpenWCChipBag(self._teamData, function()
    UIManager:ShowWindowOnly(UIWindowTypeID.WarChessSelectChip)
    UIManager:ShowWindowOnly(UIWindowTypeID.WarChessBuyChip)
  end)
  if successOpenChipBag then
    UIManager:HideWindow(UIWindowTypeID.WarChessSelectChip)
    UIManager:HideWindow(UIWindowTypeID.WarChessBuyChip)
  end
end

return UINWarChessSelectTeam
