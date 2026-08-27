local base = require("Game.BattleDungeon.Data.DungeonDynPlayer")
local GuardDungeonDynPlayer = class("GuardDungeonDynPlayer", base)
local CS_BattleManager = CS.BattleManager.Instance

function GuardDungeonDynPlayer.CreateGuardDungeonPlayer(roles, playerData, dungeonCfg, lastDeployData, treeId)
  local player = GuardDungeonDynPlayer.New()
  player.__lastHeroPos = lastDeployData and lastDeployData.hero_pos or nil
  player:InitDunDynPlayer(roles, dungeonCfg, playerData, treeId)
  return player
end

function GuardDungeonDynPlayer:ApplyPlayerDungeonRoleHpPer(csPlayerDungeonRoleHpPerDic)
  if csPlayerDungeonRoleHpPerDic == nil or csPlayerDungeonRoleHpPerDic.Count <= 0 then
    return
  end
  self.dungeonRoleHpPerDic = {}
  for k, v in pairs(csPlayerDungeonRoleHpPerDic) do
    self.dungeonRoleHpPerDic[k] = v
  end
end

return GuardDungeonDynPlayer
