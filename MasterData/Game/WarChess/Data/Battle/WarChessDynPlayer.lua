local DynPlayer = require("Game.Exploration.Data.DynPlayer")
local WarChessDynPlayer = class("WarChessDynPlayer", DynPlayer)
local ChipData = require("Game.PlayerData.Item.ChipData")
local DeployTeamUtil = require("Game.Exploration.Util.DeployTeamUtil")
local CS_BattleManager = CS.BattleManager.Instance

function WarChessDynPlayer:ctor()
end

function WarChessDynPlayer.CreateDungeonPlayer(formationRuleCfg)
  local player = WarChessDynPlayer.New()
  player:SetPlayerFormationRuleCfg(formationRuleCfg)
  return player
end

function WarChessDynPlayer:WCRefillTeamDynHeros(teamData, dynHeroDic)
  local oldHeroDic = self.heroDic
  local diffHeroList = {}
  self.heroList = {}
  self.heroDic = {}
  for index, heroId in pairs(teamData:GetWCTeamOrderDic()) do
    local dynHero = dynHeroDic[heroId]
    table.insert(self.heroList, dynHero)
    self.heroDic[heroId] = dynHero
    if oldHeroDic == nil or oldHeroDic[heroId] == nil then
      table.insert(diffHeroList, dynHero)
    end
  end
  self:InitMirrorHeroTeam()
  return function()
    if 0 < #diffHeroList then
      self:ExecuteAllChip2NewHeroList(diffHeroList)
    end
    local fairy = teamData:GetWCTeamWaidInitFairyData()
    if fairy ~= nil then
      self:UpdataDynFairyData(fairy)
    end
  end
end

function WarChessDynPlayer:UpdateDynHerosDeployPos()
  local battleRoleCount = self:GetEnterFiledNum()
  local benchX = ConfigData.buildinConfig.BenchX
  for k, heroData in pairs(self.heroList) do
    heroData:InitDynHeroBenchByFmtIdx(battleRoleCount)
  end
  local size_row, size_col, deploy_rows = WarChessManager:GetEpSceneBattleFieldSize()
  DeployTeamUtil.DeployHeroTeam(self.heroList, size_row, size_col, deploy_rows)
end

function WarChessDynPlayer:UpdatePlayerDyc(dyc)
  self.playerSkillMp = dyc.mp
  self.playerUltSkillMp = dyc.hmp
  self.playerTDMp = dyc.tdmp
  CS_BattleManager:UpdatePlayerData()
end

function WarChessDynPlayer:GetMoneyIconId()
  local cfg = ConfigData.item[ConstGlobalItem.WCMoney]
  return cfg ~= nil and cfg.icon or nil
end

function WarChessDynPlayer:RefreshCacheFightPower()
  if not self.__isHeroInitReady then
    return
  end
  local curPower = self:GetTotalFightingPower()
  if self.__cacheFightPower == curPower then
    return
  end
  self.__cacheFightPower = curPower
end

function WarChessDynPlayer:__UpdateAllChip(chipUpdate, chipDelete, tmpChipUpdate, tmpChipDelete, tmpBuffUpdate, tmpBuffDelete)
  local chipShowDel = {}
  local chipShowAdd = {}
  if chipDelete ~= nil then
    for chipId, v in pairs(chipDelete) do
      local chipData = self.chipDic[chipId]
      if chipData ~= nil then
        self:__RollBackChipInternal(chipData)
      end
      self.chipDic[chipId] = nil
      chipShowDel[chipId] = true
    end
  end
  if tmpChipDelete ~= nil then
    for chipId, num in pairs(tmpChipDelete) do
      local buffChip = self.epBuffChipDic[chipId]
      if buffChip ~= nil then
        self:__RollBackBuffChip(buffChip)
      end
      self.epBuffChipDic[chipId] = nil
    end
  end
  if tmpBuffDelete ~= nil then
    for chipId, num in pairs(tmpBuffDelete) do
      local chipData = self.tmpBuffChipDic[chipId]
      if chipData ~= nil then
        self:__RollBackChipInternal(chipData)
      end
      self.tmpBuffChipDic[chipId] = nil
      chipShowDel[chipId] = true
    end
  end
  if chipUpdate ~= nil then
    for chipId, num in pairs(chipUpdate) do
      local chipData = self.chipDic[chipId]
      if chipData ~= nil then
        self:__RollBackChipInternal(chipData)
        chipData:SetCount(num)
        self:__ExecuteChipInternal(chipData)
      else
        local chipData = ChipData.New(chipId, num)
        self.chipDic[chipId] = chipData
        self:__ExecuteChipInternal(chipData)
        chipShowAdd[chipId] = true
      end
    end
  end
  if tmpChipUpdate ~= nil then
    for chipId, num in pairs(tmpChipUpdate) do
      local buffChip = self.epBuffChipDic[chipId]
      if buffChip ~= nil then
        self:__RollBackBuffChip(buffChip)
        buffChip:SetCount(num)
        self:__ExecuteBuffChip(buffChip)
      else
        local buffChip = ChipData.New(chipId, num)
        self.epBuffChipDic[chipId] = buffChip
        self:__ExecuteBuffChip(buffChip)
      end
    end
  end
  if tmpBuffUpdate ~= nil then
    for chipId, num in pairs(tmpBuffUpdate) do
      local chipData = self.tmpBuffChipDic[chipId]
      if chipData ~= nil then
        self:__RollBackChipInternal(chipData)
        chipData:SetCount(num)
        self:__ExecuteChipInternal(chipData)
      else
        local chipData = ChipData.New(chipId, num)
        chipData:SetIsShowTemp(true)
        self.tmpBuffChipDic[chipId] = chipData
        self:__ExecuteChipInternal(chipData)
        chipShowAdd[chipId] = true
      end
    end
  end
  local chipList = {}
  for chipId, chipData in pairs(self.chipDic) do
    table.insert(chipList, chipData)
  end
  for k, chipData in pairs(self.tmpBuffChipDic) do
    table.insert(chipList, chipData)
  end
  self.chipList = chipList
  self:__SortChipList()
  self:UpdateChipLimitNum()
  self:__UpdateChipSuitDiff(chipShowDel, chipShowAdd)
  CS_BattleManager:UpdateBattleRoleData()
  self:RefreshCacheFightPower()
  MsgCenter:Broadcast(eMsgEventId.WC_ChipChange, self.chipList, self)
end

function WarChessDynPlayer:ClearAlg()
  self.epBuffChipDic = {}
end

function WarChessDynPlayer:UpDateWCDynPlayerChipLimit(limit)
  self.chipLimitInfo.limit = limit
  MsgCenter:Broadcast(eMsgEventId.OnChipLimitChange)
end

function WarChessDynPlayer:GetChipUpgradeLimitPrice()
  local shopId = WarChessManager:GetWCLevelShopId()
  local shopRareCfg = ConfigData.warchess_shop_rare[shopId]
  local costItemId = shopRareCfg.item2
  local costItemNum = 0
  local levelCfg = shopRareCfg.upgrade_level
  local scaleValuesCfg = shopRareCfg.upgrade_scale
  local levelCount = #levelCfg
  local curCapacity = self:GetChipDiscardLimit()
  for i = 1, levelCount do
    if i <= 1 then
      if curCapacity <= levelCfg[1] then
        costItemNum = scaleValuesCfg[1]
      end
    elseif i >= levelCount then
      if curCapacity >= levelCfg[i - 1] then
        costItemNum = scaleValuesCfg[i]
      end
    elseif curCapacity >= levelCfg[i - 1] and curCapacity < levelCfg[i] then
      costItemNum = scaleValuesCfg[i]
    end
  end
  return costItemId, costItemNum
end

function WarChessDynPlayer:ApplyPlayerDungeonRoleHpPer(csPlayerDungeonRoleHpPerDic)
  if csPlayerDungeonRoleHpPerDic == nil or csPlayerDungeonRoleHpPerDic.Count <= 0 then
    return
  end
  self.dungeonRoleHpPerDic = {}
  for k, v in pairs(csPlayerDungeonRoleHpPerDic) do
    self.dungeonRoleHpPerDic[k] = v
  end
end

return WarChessDynPlayer
