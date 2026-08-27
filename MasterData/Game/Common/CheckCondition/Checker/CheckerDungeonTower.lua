local CheckerDungeonTower = {}

function CheckerDungeonTower.LengthCheck(param)
  if 3 <= #param then
    return true
  end
  return false
end

function CheckerDungeonTower.ParamsCheck(param)
  local towerId = param[2]
  local floorId = param[3]
  local ok = floorId <= PlayerDataCenter.dungeonTowerSData:GetTowerCompleteLevel(towerId)
  return ok
end

function CheckerDungeonTower.GetUnlockInfo(param)
  local towerId = param[2]
  local floorId = param[3]
  local towerCfg = ConfigData.dungeon_tower_type[towerId]
  if towerCfg == nil then
    error("Cant't find dungeon tower type cfg,id = " .. tostring(towerId))
    return ""
  end
  local stageId = towerCfg.tower_list[floorId]
  if stageId == nil then
    return ""
  end
  local stageCfg = ConfigData.battle_dungeon[stageId]
  if stageCfg == nil then
    error("Cant't find battleDungeon cfg,id = " .. tostring(stageId))
    return ""
  end
  return string.format(ConfigData:GetTipContent(TipContent.FunctionUnlockDescription_BattleDungeon), LanguageUtil.GetLocaleText(stageCfg.name))
end

return CheckerDungeonTower
