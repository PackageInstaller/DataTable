local base = require("Game.Exploration.Data.DynPlayer")
local TowerDefenceDynPlayer = class("TowerDefenceDynPlayer", base)
local CS_BattleManager = CS.BattleManager.Instance

function TowerDefenceDynPlayer:UpdateFormationDetail(epRoleDyc)
  if epRoleDyc.player ~= nil then
    if self.playerUltSkillMp ~= epRoleDyc.player.hmp then
      self.playerUltSkillMp = epRoleDyc.player.hmp
      local playerCtrl = CS_BattleManager:GetBattlePlayerController()
      if playerCtrl ~= nil then
        playerCtrl.UltSkillHandle:UpdateUltMpFromItem(self.playerUltSkillMp)
      end
    end
    if self.playerSkillMp ~= epRoleDyc.player.mp then
      self.playerSkillMp = epRoleDyc.player.mp
    end
    if self.playerTDMp ~= epRoleDyc.player.tdmp then
      self.playerTDMp = epRoleDyc.player.tdmp
    end
    CS_BattleManager:UpdatePlayerData()
  end
  if epRoleDyc.role ~= nil then
    local benchX = ConfigData.buildinConfig.BenchX
    for k, v in pairs(epRoleDyc.role.role) do
      local dynHero = self:GetDynHeroByUid(k)
      if dynHero == nil then
        error("Can't find dynHero, id = " .. tostring(k))
      else
        dynHero:UpdateHpPer(v.dync.hpPer)
        if epRoleDyc.role.initial then
          dynHero:SetCoordXY(benchX, 0, benchX)
        else
          dynHero:SetCoord(v.dync.coordination, benchX)
        end
      end
    end
    CS_BattleManager:UpdateBattleRoleData()
    MsgCenter:Broadcast(eMsgEventId.OnEpPlayerHeroDataChange)
    self:RefreshCacheFightPower()
  end
end

function TowerDefenceDynPlayer:InitPlayerSkill(playerSkillInfo)
end

function TowerDefenceDynPlayer:ApplyPlayerDungeonRoleHpPer(csPlayerDungeonRoleHpPerDic)
  if csPlayerDungeonRoleHpPerDic == nil or csPlayerDungeonRoleHpPerDic.Count <= 0 then
    return
  end
  self.dungeonRoleHpPerDic = {}
  for k, v in pairs(csPlayerDungeonRoleHpPerDic) do
    self.dungeonRoleHpPerDic[k] = v
  end
end

return TowerDefenceDynPlayer
