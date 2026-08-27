local DynChipSuit = class("DynChipSuit")
local ChipBattleData = require("Game.PlayerData.Item.ChipBattleData")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function DynChipSuit:ctor(tagId, count)
  self.tagId = tagId
  self.__count = count
  local chipTagCfg = ConfigData.chip_tag[tagId]
  self.chipTagCfg = chipTagCfg
  local tagSuitCfg = ConfigData.chip_tag.tag_suits[tagId]
  self.tagSuitCfg = tagSuitCfg
  self.__suitLevel = {}
end

function DynChipSuit:GetChipSuitCount()
  return self.__count
end

function DynChipSuit:AddChipSuitCount(offset)
  self.__count = self.__count + offset
end

function DynChipSuit:SetChipSuitCount(count)
  self.__count = count
end

function DynChipSuit:GetChipSuitMaxCount()
  return self.chipTagCfg.chip_max_count
end

function DynChipSuit:GetChipSuitIconSprite()
  return CRH:GetSprite(self.chipTagCfg.tag_icon, CommonAtlasType.ExplorationIcon)
end

function DynChipSuit:GetChipSuitName()
  return LanguageUtil.GetLocaleText(self.chipTagCfg.tag_name)
end

function DynChipSuit:GetSuitChipList()
  return self.chipTagCfg.chip_list
end

function DynChipSuit:GetSuitChipInfluence()
  return self.chipTagCfg.influence
end

function DynChipSuit:UpdateChipSuitEffector(dynPlayer)
  for _, tag_suit in pairs(self.tagSuitCfg) do
    if self.__count < tag_suit.number then
      local chipBattleData = self.__suitLevel[tag_suit.number]
      if chipBattleData ~= nil then
        self:__RollBackSuitChip(chipBattleData, dynPlayer)
      end
      self.__suitLevel[tag_suit.number] = nil
    else
      local chipBattleData = self.__suitLevel[tag_suit.number]
      if chipBattleData == nil then
        local chipCfg = ConfigData.chip[tag_suit.chip_id]
        chipBattleData = ChipBattleData.New(chipCfg, 1, eBattleSkillLogicType.TempChip)
        self:__ExecuteSuitChip(chipBattleData, dynPlayer)
        self.__suitLevel[tag_suit.number] = chipBattleData
      end
    end
  end
end

function DynChipSuit:ClearChipSuitEffector(dynPlayer)
  if table.count(self.__suitLevel) <= 0 then
    return
  end
  for k, chipBattleData in pairs(self.__suitLevel) do
    self:__RollBackSuitChip(chipBattleData, dynPlayer)
  end
  self.__suitLevel = {}
end

function DynChipSuit:ExecuteSuitChipForList(heroList, dynPlayer)
  for k, chipBattleData in pairs(self.__suitLevel) do
    local validRoleList = chipBattleData:GetValidRoleList(heroList, eBattleRoleBelong.player, dynPlayer:GetSpecEffectMgr())
    for k, role in pairs(validRoleList) do
      chipBattleData:ExecuteChipBattle(role)
    end
  end
end

function DynChipSuit:__ExecuteSuitChip(chipBattleData, dynPlayer)
  if chipBattleData:IsValidDynPlayer() then
    chipBattleData:ExecuteChipBattle(dynPlayer)
  else
    local validRoleList = chipBattleData:GetValidRoleList(dynPlayer.heroList, eBattleRoleBelong.player, dynPlayer:GetSpecEffectMgr())
    for k, role in pairs(validRoleList) do
      chipBattleData:ExecuteChipBattle(role)
    end
  end
end

function DynChipSuit:__RollBackSuitChip(chipBattleData, dynPlayer)
  if chipBattleData:IsValidDynPlayer() then
    chipBattleData:RollbackChipBattle(dynPlayer)
  else
    local validRoleList = chipBattleData:GetValidRoleList(dynPlayer.heroList, eBattleRoleBelong.player, dynPlayer:GetSpecEffectMgr())
    for k, role in pairs(validRoleList) do
      chipBattleData:RollbackChipBattle(role)
    end
  end
end

function DynChipSuit:GetActivatedAffixCount()
  return table.count(self.__suitLevel)
end

function DynChipSuit:UpdateChipSuitTotalQty(dynPlayer)
  local chipDic = dynPlayer:GetNormalChipDic()
  self.totalQty = 0
  for _, chipId in ipairs(self.chipTagCfg.chip_list) do
    local chipData = chipDic[chipId]
    if chipData ~= nil then
      self.totalQty = self.totalQty + chipData:GetCount()
    end
  end
end

function DynChipSuit:GetSuitLevel()
  return self.__suitLevel
end

function DynChipSuit:GetTotalQty()
  return self.totalQty or 0
end

function DynChipSuit:SetValidRoleList(heroList, specEffectMgr)
  for _, tag_suit in pairs(self.tagSuitCfg) do
    if self.__count < tag_suit.number then
    else
      local chipBattleData = self.__suitLevel[tag_suit.number]
      if chipBattleData == nil then
        local chipCfg = ConfigData.chip[tag_suit.chip_id]
        chipBattleData = ChipBattleData.New(chipCfg, 1, eBattleSkillLogicType.TempChip)
        chipBattleData:GetValidRoleList(heroList, eBattleRoleBelong.player, specEffectMgr)
        self.__suitLevel[tag_suit.number] = chipBattleData
      end
    end
  end
end

function DynChipSuit:UpdateValidRoleList(heroList, dynPlayer)
  for k, chipBattleData in pairs(self.__suitLevel) do
    local validRoleList = chipBattleData:GetValidRoleList(heroList, eBattleRoleBelong.player, dynPlayer:GetSpecEffectMgr())
  end
end

return DynChipSuit
