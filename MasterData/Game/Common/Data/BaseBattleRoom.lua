local BaseBattleRoom = class("BaseBattleRoom")
local DynMonster = require("Game.Exploration.Data.DynMonster")
local DynDungeonRole = require("Game.Exploration.Data.DynDungeonRole")
local DynEffectGrid = require("Game.Exploration.Data.DynEffectGrid")
local DynEnemy = require("Game.Exploration.Data.DynEnemy")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function BaseBattleRoom:__InitMonsterOrNeutralData(groupData)
  if self.battleMap == nil then
    error("battle map not initialization")
    return
  end
  self.occupyCoords = {}
  self.battleMap.monsterList:Clear()
  self.monsterList = {}
  self.pdungeonList = nil
  self.battleMap.stageMonsterDic:Clear()
  self.stageMonsterDic = {}
  local stageMonRootUidList = {}
  local normalMonsterDic = {}
  self.battleMap.waitToCasterMonsterList:Clear()
  local waitToCasterMonsterList = {}
  self.battleMap.neutralList:Clear()
  local neutralList = {}
  self.battleMap.pdungeonRoleList:Clear()
  local pdungeonRoleList = {}
  self.dynEnemy = DynEnemy.New()
  for k, v in pairs(groupData) do
    if v.stc.cat ~= nil then
      if v.stc.cat == ExplorationEnum.EnemyRoleType.monster then
        local monster = DynMonster.New(v)
        if monster:IsStageMonster() then
          local stageMonsterList = self.stageMonsterDic[monster.parentUid]
          if stageMonsterList == nil then
            self.stageMonsterDic[monster.parentUid] = {}
            stageMonsterList = self.stageMonsterDic[monster.parentUid]
            table.insert(stageMonRootUidList, monster.parentUid)
          end
          table.insert(stageMonsterList, monster)
        else
          table.insert(self.monsterList, monster)
          normalMonsterDic[monster.uid] = monster
        end
        self.occupyCoords[monster.coordination] = true
      elseif v.stc.cat == ExplorationEnum.EnemyRoleType.neutral then
        local neutral = DynDungeonRole.New(v)
        table.insert(neutralList, neutral)
        self.occupyCoords[neutral.coordination] = true
      elseif v.stc.cat == ExplorationEnum.EnemyRoleType.player then
        local summoenr = DynDungeonRole.New(v)
        summoenr:SetSummonerBelong(eBattleRoleBelong.player)
        table.insert(pdungeonRoleList, summoenr)
        self.occupyCoords[summoenr.coordination] = true
      elseif v.stc.cat == ExplorationEnum.EnemyRoleType.towerSumMonster then
        local monsterSummoner = DynMonster.New(v)
        table.insert(waitToCasterMonsterList, monsterSummoner)
      elseif v.stc.cat == ExplorationEnum.EnemyRoleType.templateMonster then
        local monsterSummoner = DynMonster.New(v)
        table.insert(waitToCasterMonsterList, monsterSummoner)
      end
    end
  end
  if #self.monsterList > 0 then
    table.sort(self.monsterList, function(a, b)
      return a.coordination < b.coordination
    end)
    for i = 1, #self.monsterList do
      local monster = self.monsterList[i]
      local bloodNum = monster:GetBossBloodNum()
      if 0 < bloodNum then
        self.battleMap:SetBossBlood(i - 1, bloodNum)
      end
      self:TrySetMonsterSpecailDeployTarget(monster)
      self.battleMap.monsterList:Add(monster)
    end
  end
  if 0 < #neutralList then
    table.sort(neutralList, function(a, b)
      return a.coordination < b.coordination
    end)
    for i = 1, #neutralList do
      self.battleMap.neutralList:Add(neutralList[i])
    end
  end
  if 0 < #pdungeonRoleList then
    table.sort(pdungeonRoleList, function(a, b)
      return a.coordination < b.coordination
    end)
    for i = 1, #pdungeonRoleList do
      self.battleMap.pdungeonRoleList:Add(pdungeonRoleList[i])
    end
  end
  if 0 < #waitToCasterMonsterList then
    table.sort(waitToCasterMonsterList, function(a, b)
      return a.uid < b.uid
    end)
    for i = 1, #waitToCasterMonsterList do
      local waitToCasterMonster = waitToCasterMonsterList[i]
      self.battleMap.waitToCasterMonsterList:Add(waitToCasterMonster)
      table.insert(self.monsterList, waitToCasterMonsterList[i])
    end
  end
  table.sort(stageMonRootUidList)
  for k, uid in ipairs(stageMonRootUidList) do
    local stageMonsterList = self.stageMonsterDic[uid]
    table.sort(stageMonsterList, function(a, b)
      return a.stage < b.stage
    end)
    local maxStage = #stageMonsterList + 1
    local sourceMon = normalMonsterDic[uid]
    sourceMon:SetMonsterHasMoreStage(maxStage)
    self.battleMap:AddStageMonster(sourceMon)
    for k, v in ipairs(stageMonsterList) do
      self.battleMap:AddStageMonster(v)
      v:SetMonsterHasMoreStage(maxStage)
      table.insert(self.monsterList, v)
    end
  end
end

function BaseBattleRoom:__InitBattleGrid(grids)
  self.effectGridList = {}
  if grids ~= nil then
    for k, v in pairs(grids) do
      local effectGrid = DynEffectGrid.New(k, v)
      table.insert(self.effectGridList, effectGrid)
    end
  end
  table.sort(self.effectGridList, function(a, b)
    local p1 = a:GetGridPriority()
    local p2 = b:GetGridPriority()
    if p1 ~= p2 then
      return p1 < p2
    end
    return a.coord < b.coord
  end)
end

function BaseBattleRoom:ExecuteMonsterChip(dynPlayer)
  local chipList = self.monsterChipList
  if chipList ~= nil then
    for k, chipData in pairs(chipList) do
      self:__ExecuteMonsterChip(chipData, true)
    end
  end
  self:ExecutePlayerChipForMonster(dynPlayer)
end

function BaseBattleRoom:ExecuteDungeonRoleChip(dynPlayer)
  if self.battleMap == nil then
    return
  end
  if self.pdungeonList == nil then
    self.pdungeonList = {}
    for i = 0, self.battleMap.pdungeonRoleList.Count - 1 do
      table.insert(self.pdungeonList, self.battleMap.pdungeonRoleList[i])
    end
  end
  local chipList = dynPlayer:GetChipList()
  for k, chipData in pairs(chipList) do
    if chipData:IsForHeroIDChipBattle() then
      local validRoleList = chipData:GetValidRoleList(self.pdungeonList, eBattleRoleBelong.player)
      for k, v in pairs(validRoleList) do
        local ownerChipData = v:GetOwnedChipsById(chipData.dataId)
        if ownerChipData ~= nil then
          if ownerChipData:GetChipCount() == chipData:GetChipCount() then
            goto lbl_61
          end
          ownerChipData:RollbackChipData(v)
        end
        chipData:ExecuteChipData(v)
        ::lbl_61::
      end
    end
  end
  local epBuffChipList = dynPlayer:GetEpBuffChipDic()
  for k, buffChip in pairs(epBuffChipList) do
    if buffChip:IsForHeroIDChipBattle() then
      local validRoleList = buffChip:GetValidRoleList(self.pdungeonList, eBattleRoleBelong.player)
      for k, v in pairs(validRoleList) do
        local ownerBuffData = v:GetOwnedChipsById(buffChip.dataId)
        if ownerBuffData ~= nil then
          if ownerBuffData:GetChipCount() == buffChip:GetChipCount() then
            goto lbl_101
          end
          ownerBuffData:RollbackBuffChip(v)
        end
        buffChip:ExecuteBuffChip(v)
        ::lbl_101::
      end
    end
  end
end

function BaseBattleRoom:ExecutePlayerChipForMonster(dynPlayer)
  local chipList = dynPlayer:GetChipList()
  for k, chipData in pairs(chipList) do
    if chipData:IsForEnemyChip() then
      self:__ExecuteMonsterChip(chipData)
    end
  end
end

function BaseBattleRoom:RollbackPlayerChipForMonster(dynPlayer)
  local chipList = dynPlayer:GetChipList()
  for k, chipData in pairs(chipList) do
    if chipData:IsForEnemyChip() then
      self:__RollbackMonsterChip(chipData)
    end
  end
end

function BaseBattleRoom:RollbackAllPlayerChipForMonster(dynPlayer)
  local chipList = dynPlayer:GetChipList()
  for k, chipData in pairs(chipList) do
    if chipData:IsForEnemyChip() then
      self:__RollbackMonsterChip(chipData)
    end
  end
  local epBuffChipDic = dynPlayer:GetEpBuffChipDic()
  for k, buffChip in pairs(epBuffChipDic) do
    if buffChip:IsForEnemyChipBattle() then
      self:__RollbackMonsterBuffChip(buffChip)
    end
  end
end

function BaseBattleRoom:__ExecuteMonsterChip(chipData, isRelative)
  local isForDynEnemy = chipData:IsForDynEnemyChip()
  if isForDynEnemy then
    chipData:ExecuteChipData(self.dynEnemy)
    return
  end
  local belong = eBattleRoleBelong.enemy
  if isRelative then
    belong = eBattleRoleBelong.player
  end
  local validRoleList = chipData:GetValidRoleList(self.monsterList, belong)
  for k, role in pairs(validRoleList) do
    chipData:ExecuteChipData(role)
  end
end

function BaseBattleRoom:__RollbackMonsterChip(chipData)
  local isForDynEnemy = chipData:IsForDynEnemyChip()
  if isForDynEnemy then
    chipData:RollbackChipData(self.dynEnemy)
    return
  end
  for k, role in pairs(self.monsterList) do
    chipData:RollbackChipData(role)
  end
end

function BaseBattleRoom:__ExecuteMonsterBuffChip(buffChip)
  local isForDynEnemy = buffChip:IsForDynEnemyChipBattle()
  if isForDynEnemy then
    buffChip:ExecuteBuffChip(self.dynEnemy)
    return
  end
  local validRoleList = buffChip:GetValidRoleList(self.monsterList, eBattleRoleBelong.enemy)
  for k, role in pairs(validRoleList) do
    buffChip:ExecuteBuffChip(role)
  end
end

function BaseBattleRoom:__RollbackMonsterBuffChip(buffChip)
  local isForDynEnemy = buffChip:IsForDynEnemyChipBattle()
  if isForDynEnemy then
    buffChip:RollbackBuffChip(self.dynEnemy)
    return
  end
  for k, role in pairs(self.monsterList) do
    buffChip:RollbackBuffChip(role)
  end
end

function BaseBattleRoom:ExecuteMonsterTempChip(chipTemporaryDic)
  for k, buffData in pairs(chipTemporaryDic) do
    self:__ExecuteMonsterBuffChip(buffData)
  end
end

function BaseBattleRoom:RollbackMonsterTempChip(chipTemporaryDic)
  for k, buffData in pairs(chipTemporaryDic) do
    self:__RollbackMonsterBuffChip(buffData)
  end
end

function BaseBattleRoom:GetSceneId()
end

function BaseBattleRoom:GetIsInWeeklyChallenge()
  return false
end

function BaseBattleRoom:GetIsInBigBossRoom()
  return false
end

function BaseBattleRoom:IsInTDBattle()
  return false
end

function BaseBattleRoom:IsBrotatoBattle()
  return false
end

function BaseBattleRoom:IsGuardTDBattle()
  return false
end

function BaseBattleRoom:IsDailyDungeon()
  return self.dungeonType == proto_csmsg_DungeonType.DungeonType_Daily or self.dungeonType == proto_csmsg_DungeonType.DungeonType_WinterHard
end

function BaseBattleRoom:GetEnemyItemSkillList()
  return self.dynEnemy:GetItemSkillList()
end

function BaseBattleRoom:TryInitSpecailDeployGrid(specailDeployId, redeploy)
  self.reSpecialDeploy = redeploy
  if specailDeployId == nil or specailDeployId <= 0 then
    return
  end
  local deployCfg = ConfigData.room_special_deploy[specailDeployId]
  if deployCfg == nil then
    error("cant get room_special_deploy, id:" .. tostring(specailDeployId))
    return
  end
  self.roomSpecialDeployCfg = deployCfg
  self.battleMap:SetSpecialDeployId(specailDeployId)
  if self.battleMap.specialDeployGrids then
    self.battleMap.specialDeployGrids:Clear()
  end
  if self.battleMap.specialDeployGriSet then
    self.battleMap.specialDeployGriSet:Clear()
  end
  for k, v in pairs(self.battleMap.tiles) do
    local ableDeploy = deployCfg.deployGridDic[k.x] ~= nil and deployCfg.deployGridDic[k.x][k.y] ~= nil
    v.ableDeploy = ableDeploy
    if ableDeploy then
      self.battleMap:AddSpecialDeployGrid(k.x, k.y)
    end
  end
end

function BaseBattleRoom:TrySetMonsterSpecailDeployTarget(dynMonster)
  if self.roomSpecialDeployCfg == nil then
    return
  end
  local minDistance = math.maxinteger
  local tarX, tarY = 0, 0
  for x, tab in pairs(self.roomSpecialDeployCfg.deployGridDic) do
    for y, _ in pairs(tab) do
      local distance = BattleUtil.BattleHexDistance(dynMonster.x, dynMonster.y, x, y)
      if minDistance > distance then
        minDistance = distance
        tarX = x
        tarY = y
      end
    end
  end
  dynMonster:SetDynMonTargetDeployPos(tarX, tarY)
end

return BaseBattleRoom
