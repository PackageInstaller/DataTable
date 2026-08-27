local base = require("Game.Exploration.Data.DynPlayer")
local GuardProfessorDynPlayer = class("GuardProfessorDynPlayer", base)

function GuardProfessorDynPlayer:ApplyPlayerDungeonRoleHpPer(csPlayerDungeonRoleHpPerDic)
  if csPlayerDungeonRoleHpPerDic == nil or csPlayerDungeonRoleHpPerDic.Count <= 0 then
    return
  end
  self.dungeonRoleHpPerDic = {}
  for k, v in pairs(csPlayerDungeonRoleHpPerDic) do
    self.dungeonRoleHpPerDic[k] = v
  end
end

return GuardProfessorDynPlayer
