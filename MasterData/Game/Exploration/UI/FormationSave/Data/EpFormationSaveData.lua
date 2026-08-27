local EpFormationSaveData = class("EpFormationSaveData")
local DynBuff = require("Game.Exploration.Data.DynBuff")
local ChipData = require("Game.PlayerData.Item.ChipData")
local EpRoleHeroData = require("Game.Formation.Data.EpRoleHeroData")
local DynFairyData = require("Game.Exploration.Data.DynFairyData")
local DynChipSuitMgr = require("Game.Exploration.Data.ChipSuit.DynChipSuitMgr")

function EpFormationSaveData.CreateFmtSvData(heroDataList, fairyData, buffList, waitSelectChipList, sectorStageId, infiniteCoe, score)
  local data = EpFormationSaveData.New()
  data:InitFmtSaveDataEpResult(heroDataList, fairyData, buffList, waitSelectChipList, sectorStageId, infiniteCoe, score)
  return data
end

function EpFormationSaveData.CreateDefaultFmtSvData(envCfg)
  local assistId = envCfg.assis_id
  local cfg = ConfigData.act_general_ep_save_fmt_assist[assistId]
  if cfg == nil then
    error("cant get act_general_ep_save_fmt_assist,assistId:" .. tostring(assistId))
    return
  end
  local assistTeamCfg = ConfigData.assist_team[cfg.team_id]
  if assistTeamCfg == nil then
    error("cant get assist_team,team_id:" .. tostring(cfg.team_id))
    return
  end
  local fixedHeroDataList = {}
  local FixedFmtHeroData = require("Game.PlayerData.Hero.FixedFmtHeroData")
  for k, heroId in ipairs(assistTeamCfg.param1) do
    local assistLv = assistTeamCfg.assist_lvs[k]
    local assistLvCfg = ConfigData.assist_level[assistLv]
    local skinId = assistTeamCfg.override_skin[k]
    local heroName = LanguageUtil.GetLocaleText(assistTeamCfg.override_name[k])
    local heroData = FixedFmtHeroData.FixedFmtHeroData(heroId, assistLvCfg, skinId, heroName)
    table.insert(fixedHeroDataList, heroData)
  end
  local chipList = {}
  for chipId, num in pairs(cfg.func_group) do
    local chipData = ChipData.New(chipId, num)
    table.insert(chipList, chipData)
  end
  local epBuffList = {}
  for _, buffId in ipairs(cfg.proto_group) do
    local epBuff = DynBuff.CreateByEpBuffId(buffId)
    table.insert(epBuffList, epBuff)
  end
  local data = EpFormationSaveData.New()
  data.heroDataList = fixedHeroDataList
  data.buffList = epBuffList
  data:SetFmtSvChipDataList(chipList)
  data.infinityAddition = 0
  data.score = cfg.score_num
  data.envCfg = envCfg
  data.isDefault = true
  return data
end

function EpFormationSaveData.CreateFmtSvDataByMsg(msg, envCfg)
  if msg.epRoleDyc == nil or msg.epRoleDyc.role == nil or msg.epRoleStc == nil then
    local data = EpFormationSaveData.CreateDefaultFmtSvData(envCfg)
    data.commandTrees = msg.commandTrees
    data.treeId = ConfigData.game_config.FormationDefaultCommanderSkillTree
    return data
  end
  local heroList = {}
  local heroIdxMap = {}
  for fmtIdx, uid in pairs(msg.data) do
    local heroElem = msg.epRoleStc.heroes[uid]
    local heroId = heroElem.dataId
    local heroData
    if msg.epRoleDyc.role.role[uid].roleType == proto_object_EplBattleRoleType.BattleRoleNormal then
      heroData = PlayerDataCenter.heroDic[heroId]
    else
      local heroCfg = ConfigData.hero_data[heroElem.dataId]
      heroData = EpRoleHeroData.New({
        basic = {
          id = heroElem.dataId,
          level = heroElem.level,
          exp = 0,
          star = heroElem.rank,
          potentialLvl = heroElem.potential,
          ts = -1,
          career = heroCfg.career,
          company = heroCfg.camp,
          skinId = heroElem.skinId,
          cat = heroElem.cat,
          serverModel = msg.epRoleDyc.role.role[uid].dync.texture,
          name = heroElem.name
        },
        spWeapon = heroElem.specWeapon,
        vow = {
          vowTime = heroElem.vowed and 1 or 0,
          name = heroElem.name
        }
      })
      heroData:SetEpRoleHeroData(heroElem)
    end
    table.insert(heroList, heroData)
    heroIdxMap[heroData] = fmtIdx
  end
  table.sort(heroList, function(a, b)
    return heroIdxMap[a] < heroIdxMap[b]
  end)
  local fairyData
  if msg.epRoleStc.fairy then
    fairyData = DynFairyData.GenDynFairyData(msg.epRoleStc.fairy)
  end
  local chipList = {}
  for chipId, num in pairs(msg.alg) do
    local chipData = ChipData.New(chipId, num)
    table.insert(chipList, chipData)
  end
  local epBuffList = {}
  for _, buffId in ipairs(msg.buff) do
    local epBuff = DynBuff.CreateByEpBuffId(buffId)
    table.insert(epBuffList, epBuff)
  end
  local data = EpFormationSaveData.New()
  data.heroDataList = heroList
  data.fairyData = fairyData
  data:SetFmtSvChipDataList(chipList)
  data.buffList = epBuffList
  data.infinityAddition = msg.inifiniteCoe
  data.score = msg.score
  data.envCfg = envCfg
  if table.IsEmptyTable(msg.commandTrees) then
    data.commandTrees = msg.epRoleStc.player.commandTrees
  else
    data.commandTrees = msg.commandTrees
  end
  data.treeId = msg.epRoleStc.player.tree
  return data
end

function EpFormationSaveData:InitFmtSaveDataEpResult(heroDataList, fairyData, buffList, waitSelectChipList, sectorStageId, infiniteCoe, score)
  self.heroDataList = heroDataList
  self.fairyData = fairyData
  self.buffList = buffList
  self:SetFmtSvChipDataList(waitSelectChipList)
  self.sectorStageId = sectorStageId
  local envId = ConfigData.act_general_ep_env.actGenrEpEnvIdStageIdMap[sectorStageId]
  self.envCfg = ConfigData.act_general_ep_env[envId]
  self.infinityAddition = infiniteCoe
  self.score = score
end

function EpFormationSaveData:SetFmtSvChipDataList(chipDataList)
  self.chipDataList = chipDataList
  self._chipSuitMgr = DynChipSuitMgr.New()
  self._chipSuitMgr:UpdateAllChipSuitNoDynPlayer(chipDataList)
end

function EpFormationSaveData:GetFmtSvChipDataList()
  return self.chipDataList
end

function EpFormationSaveData:GetFmtSvChipSuitMgr()
  return self._chipSuitMgr
end

function EpFormationSaveData:GetFmtSvSelectedChipList()
  return self.selectedChipList
end

function EpFormationSaveData:SetFmtSvSelectedChipList(chipDataList)
  self.selectedChipList = chipDataList
end

function EpFormationSaveData:SetFmtSvChipNumLimit(chipNumLimit)
  self._chipNumLimit = chipNumLimit
end

function EpFormationSaveData:GetFmtSvDorpChipIdData()
  if self._chipNumLimit == nil then
    return table.emptytable, table.emptytable
  end
  if self._dropChipIdList then
    return self._dropChipIdList, self._dropChipIdDic
  end
  local chipDataList = {}
  for k, v in ipairs(self.chipDataList) do
    if not v:IsConsumeSkillChip() then
      table.insert(chipDataList, v)
    end
  end
  if self._chipNumLimit > #chipDataList then
    return table.emptytable, table.emptytable
  end
  table.sort(chipDataList, function(a, b)
    local lvA = a:GetChipCount()
    local lvB = b:GetChipCount()
    if lvA ~= lvB then
      return lvA < lvB
    end
    return a.dataId < b.dataId
  end)
  local dropNum = #chipDataList - self._chipNumLimit
  local chipIdList = {}
  local chipIdDic = {}
  for i = 1, dropNum do
    local chipData = chipDataList[i]
    table.insert(chipIdList, chipData.dataId)
    chipIdDic[chipData.dataId] = true
  end
  self._dropChipIdList = chipIdList
  self._dropChipIdDic = chipIdDic
  return chipIdList, chipIdDic
end

function EpFormationSaveData:GetFmtSvFairyData()
  return self.fairyData
end

function EpFormationSaveData:GetFmtSvHeroDataList()
  return self.heroDataList
end

function EpFormationSaveData:GetFmtSvHeroDataById(heroId)
  for _, heroData in pairs(self.heroDataList) do
    if heroData.dataId == heroId then
      return heroData
    end
  end
end

function EpFormationSaveData:GetFmtSvBuffList()
  return self.buffList
end

function EpFormationSaveData:GetFmtSvSaveChipMaxNum()
  return self.envCfg.save_function
end

function EpFormationSaveData:GetFmtSvEnvCfg()
  return self.envCfg
end

function EpFormationSaveData:GetFmtSvInfinityAddition()
  return self.infinityAddition
end

function EpFormationSaveData:GetFmtSvScore()
  return self.score
end

function EpFormationSaveData:GetFmtSvScoreCompare(isAdd)
  local result = self.score * self.envCfg.tip_score / 100 * (isAdd and 1 or -1) + self.score
  return result
end

function EpFormationSaveData:GetFmtSvStageId()
  return self.sectorStageId
end

function EpFormationSaveData:CreateDefualtFmtSaveData()
  return EpFormationSaveData.CreateDefaultFmtSvData(self.envCfg)
end

function EpFormationSaveData:IsDefualtFmtSaveData()
  return self.isDefault
end

function EpFormationSaveData:SetFmtSaveDataEpIsWin(epIsWin)
  self._epIsWin = epIsWin
end

function EpFormationSaveData:IsEpWinFmtSaveData()
  return self._epIsWin
end

function EpFormationSaveData:GetFmtSaveCSTData()
  return self.commandTrees, self.treeId
end

return EpFormationSaveData
