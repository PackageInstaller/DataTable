local PlayerLevelData = class("PlayerLevelData")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local NoticeData = require("Game.Notice.NoticeData")
local cs_playerData = CS.PlayerDataCenter.Instance
local cs_MicaSDKManager = CS.MicaSDKManager

function PlayerLevelData:ctor()
  self:_SetLevel(1)
  self.exp = 0
end

function PlayerLevelData:_SetLevel(level)
  self.level = level
  cs_playerData.playerLevel = level
end

function PlayerLevelData:UpdatePlayerLevelData(level, exp, isInit)
  level = level or 1
  exp = exp or 0
  if self.level == level and self.exp == exp then
    return
  end
  if self.level ~= level then
    self:__AddLevelBunos(level)
    self:_SetLevel(level)
    PlayerDataCenter.achivLevelData:UpdateLevelRewardRedDot()
    PlayerDataCenter.battlepassData:UpdatePlayerLevel(level)
    if not isInit then
      self:_LevelChangeTrackEvent(level)
    end
  end
  self.exp = exp
  MsgCenter:Broadcast(eMsgEventId.UpdatePlayerLevel, false, true)
  MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.PlayerLevel)
  MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.PlayerLevelUpLimit)
end

function PlayerLevelData:GetNextLevelExp()
  local cfg = self:GetAchivLevelCfg(self.level)
  return cfg.exp
end

function PlayerLevelData:GetAchivLevelCfg(level)
  local cfg = ConfigData.achievement_level[level]
  if cfg == nil then
    error("can't find achievement_level by level, level = " .. tostring(level))
    return
  end
  return cfg
end

function PlayerLevelData:__AddLevelBunos(level)
  local levelCfg = self:GetAchivLevelCfg(level)
  for k, logic in ipairs(levelCfg.logic) do
    local para1 = levelCfg.para1[k]
    local para2 = levelCfg.para2[k]
    local para3 = levelCfg.para3[k]
    PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement, 0, logic, para1, para2, para3)
  end
  PlayerDataCenter.playerBonus:CheckPlayerBonusBroadcast()
end

local overseaTrackCfg = {
  [10] = "level_10",
  [15] = "level_15",
  [20] = "level_20",
  [25] = "level_25",
  [30] = "level_30"
}

function PlayerLevelData:_LevelChangeTrackEvent(level)
  if not cs_MicaSDKManager.Instance:IsUseSdk() then
    return
  end
  if Consts.GameChannelType.IsOversea() then
    cs_MicaSDKManager.Instance:StatsEventPreSetUid("level_up")
    local lvParam = overseaTrackCfg[level]
    if lvParam ~= nil then
      cs_MicaSDKManager.Instance:StatsEventPreSetUid(lvParam)
    end
  end
end

return PlayerLevelData
