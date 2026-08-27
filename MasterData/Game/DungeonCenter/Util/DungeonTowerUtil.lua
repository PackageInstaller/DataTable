local DungeonTowerUtil = {}

function DungeonTowerUtil.TowerHasRecommendFormation(stageId)
  local towerLevelCfg = ConfigData.dungeon_tower[stageId]
  if towerLevelCfg == nil then
    return false
  end
  return towerLevelCfg.team_record
end

return DungeonTowerUtil
