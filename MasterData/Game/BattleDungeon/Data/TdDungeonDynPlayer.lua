local base = require("Game.BattleDungeon.Data.DungeonDynPlayer")
local TdDungeonDynPlayer = class("TdDungeonDynPlayer", base)
local CS_BattleManager = CS.BattleManager.Instance

function TdDungeonDynPlayer.CreateTdDungeonPlayer(roles, playerData, dungeonCfg, lastDeployData, treeId)
  local player = TdDungeonDynPlayer.New()
  player.__lastHeroPos = lastDeployData and lastDeployData.hero_pos or nil
  player:InitDunDynPlayer(roles, dungeonCfg, playerData, treeId)
  return player
end

function TdDungeonDynPlayer:InitDunDynPlayer(roles, dungeonCfg, playerData, treeId)
  local heroDatas = {}
  for k, v in pairs(roles) do
    heroDatas[v.stc.dataId] = v.stc
  end
  self:InitHeroTeam(roles)
  self.playerSkillMp = playerData.dyc.mp
  self.playerUltSkillMp = playerData.dyc.hmp
  self.playerTDMp = playerData.dyc.tdmp
  local benchX = ConfigData.buildinConfig.BenchX
  for k, dynHero in pairs(self.heroList) do
    dynHero:SetCoord(roles[dynHero.uid].dyc.coordination, benchX)
  end
  self:UpdateHeroAttr(heroDatas)
end

function TdDungeonDynPlayer:ApplyPlayerDungeonRoleHpPer(csPlayerDungeonRoleHpPerDic)
  if csPlayerDungeonRoleHpPerDic == nil or csPlayerDungeonRoleHpPerDic.Count <= 0 then
    return
  end
  self.dungeonRoleHpPerDic = {}
  for k, v in pairs(csPlayerDungeonRoleHpPerDic) do
    self.dungeonRoleHpPerDic[k] = v
  end
end

return TdDungeonDynPlayer
