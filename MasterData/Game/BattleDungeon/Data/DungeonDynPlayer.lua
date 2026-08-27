local DynPlayer = require("Game.Exploration.Data.DynPlayer")
local DungeonDynPlayer = class("DungeonDynPlayer", DynPlayer)
local DynHero = require("Game.Exploration.Data.DynHero")
local ChipData = require("Game.PlayerData.Item.ChipData")
local DynEpBuffChip = require("Game.Exploration.Data.DynEpBuffChip")
local HeroData = require("Game.PlayerData.Hero.HeroData")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local DynBuff = require("Game.Exploration.Data.DynBuff")
local DeployTeamUtil = require("Game.Exploration.Util.DeployTeamUtil")

function DungeonDynPlayer:ctor()
  self.dungeonBuffList = {}
  self.dungeonBuffCfgList = {}
  self.dungeonBuffDataList = {}
end

function DungeonDynPlayer.CreateDungeonPlayer(lastDeployData, formationRuleCfg)
  local player = DungeonDynPlayer.New()
  player.__lastHeroPos = lastDeployData and lastDeployData.hero_pos or nil
  player:SetPlayerFormationRuleCfg(formationRuleCfg)
  return player
end

function DungeonDynPlayer:InitDunDynPlayer(roles, dungeonCfg, playerData, treeId)
  local heroDatas = {}
  for k, v in pairs(roles) do
    heroDatas[v.stc.dataId] = v.stc
  end
  self:InitHeroTeam(roles)
  self.playerSkillMp = playerData.dyc.mp
  self.playerUltSkillMp = playerData.dyc.hmp
  self:InitPlayerSkill(playerData.stc)
  DeployTeamUtil.DeployHeroTeam(self.heroList, dungeonCfg.size_row, dungeonCfg.size_col, dungeonCfg.deploy_rows, self.__lastHeroPos)
  self:__UpdateCoordInBattleEditor()
  self:UpdateHeroAttr(heroDatas)
end

function DungeonDynPlayer:InitHeroTeam(roles)
  self.heroList = {}
  self.heroDic = {}
  local tmpHeroIndexDic = {}
  local battleRoleCount = self:GetEnterFiledNum()
  for uid, battleRole in pairs(roles) do
    local heroTeamIndex = battleRole.dyc.formationIdx
    local roleType = battleRole.roleType
    local heroCfg = ConfigData.hero_data[battleRole.stc.dataId]
    local heroData = HeroData.New({
      basic = {
        id = battleRole.stc.dataId,
        level = battleRole.stc.level,
        exp = 0,
        star = battleRole.stc.rank,
        potentialLvl = battleRole.stc.potential,
        ts = -1,
        career = heroCfg.career,
        company = heroCfg.camp,
        skinId = battleRole.stc.skinId,
        cat = battleRole.stc.cat,
        serverModel = battleRole.dyc.texture
      },
      spWeapon = battleRole.stc.specWeapon,
      vow = {
        vowTime = battleRole.stc.vowed and 1 or 0,
        name = battleRole.stc.name
      }
    })
    for k, v in pairs(battleRole.stc.skillGroup) do
      if heroData.skillDic[k] ~= nil then
        heroData.skillDic[k]:UpdateSkill(v)
      end
    end
    local dynHeroData = DynHero.New(heroData, battleRole.stc.uid, roleType)
    dynHeroData:SetDynHeroFmtIdx(heroTeamIndex)
    dynHeroData:SetDynHeroTalentLevel(battleRole.stc.talent)
    dynHeroData:SetExtraFixedPower(battleRole.stc.talentEfficiency)
    dynHeroData:InitDynHeroBenchByFmtIdx(battleRoleCount)
    dynHeroData:UpdateHpPer(battleRole.dyc.hpPer)
    self.heroDic[heroData.dataId] = dynHeroData
    tmpHeroIndexDic[dynHeroData] = heroTeamIndex
    table.insert(self.heroList, dynHeroData)
  end
  table.sort(self.heroList, function(hero1, hero2)
    return tmpHeroIndexDic[hero1] < tmpHeroIndexDic[hero2]
  end)
  self:InitMirrorHeroTeam()
end

function DungeonDynPlayer:InitPlayerSkillCustom(playerSkillDic, CSTId)
  self.playerOriginSkillList = {}
  self.playerExtraSkillDic = {}
  self.CSTId = CSTId
  if playerSkillDic ~= nil then
    for k, skillId in pairs(playerSkillDic) do
      local data = DynBattleSkill.New(skillId, 1, eBattleSkillLogicType.Original)
      table.insert(self.playerOriginSkillList, data)
    end
  end
end

function DungeonDynPlayer:__UpdateCoordInBattleEditor()
  if BattleEditorManager ~= nil and BattleEditorManager.DeployFormation then
    BattleEditorManager:DeployTeam(self.heroList)
  end
end

function DungeonDynPlayer:UpdateDungeonBuff(buffGroupMsg)
  if buffGroupMsg == nil then
    return
  end
  local buffList = {}
  for dunBuffId, dunBuffNum in pairs(buffGroupMsg) do
    table.insert(buffList, dunBuffId)
  end
  self.dungeonBuffCfgList = {}
  self.dungeonBuffDataList = {}
  self.dungeonBuffList = buffList
  for _, dunBuffId in ipairs(buffList) do
    local buffCfg = ConfigData.dungeon_buff[dunBuffId]
    if buffCfg == nil then
      error("can't get dunbuffCfg with id" .. tostring(dunBuffId))
    else
      table.insert(self.dungeonBuffCfgList, buffCfg)
      local dynBuffData = DynBuff.CreateByDungeonLevel(dunBuffId, buffCfg)
      table.insert(self.dungeonBuffDataList, dynBuffData)
    end
  end
end

function DungeonDynPlayer:GetDungeonBuff()
  return self.dungeonBuffList, self.dungeonBuffCfgList
end

function DungeonDynPlayer:GetDungeonBuffDataList()
  return self.dungeonBuffDataList
end

return DungeonDynPlayer
