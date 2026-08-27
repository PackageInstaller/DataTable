local CherkerGeneralDungeon = {}

function CherkerGeneralDungeon.LengthCheck(param)
  if 2 <= #param then
    return true
  end
  return false
end

function CherkerGeneralDungeon.IsPassDungeon(levelID)
  if levelID == 0 then
    return true
  end
  local levelBattleTimeCfg = PlayerDataCenter.dungeonTotalBattleTimes[levelID]
  if levelBattleTimeCfg == nil then
    return false
  end
  if 0 < levelBattleTimeCfg then
    return true
  end
  return false
end

function CherkerGeneralDungeon.ParamsCheck(param)
  local ok = CherkerGeneralDungeon.IsPassDungeon(param[2])
  return ok
end

function CherkerGeneralDungeon.GetUnlockInfo(param)
  local levelId = param[2]
  local stageCfg = ConfigData.battle_dungeon[levelId]
  if stageCfg == nil then
    error("Cant't find battleDungeon cfg,id = " .. tostring(levelId))
  end
  return string.format(ConfigData:GetTipContent(TipContent.FunctionUnlockDescription_BattleDungeon), LanguageUtil.GetLocaleText(stageCfg.name))
end

return CherkerGeneralDungeon
