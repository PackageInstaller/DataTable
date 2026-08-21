local GetMatchTypeType = {
  NoLinkLine = 1,
  CalcBattleResult = 2,
  PopStarProNoRelic = 3,
  WorldBossBattle = 4,
  SeasonMazeWorldBoss = 5,
  GameMode = 6
}
_enum("GetMatchTypeType", GetMatchTypeType)

function MainWorld:RegisterMatchTypeProgressFunc()
  self._matchTypeProgressFunc = {}
  self._matchTypeProgressFunc[GetMatchTypeType.NoLinkLine] = self.GetNoLinkLineMatchType
  self._matchTypeProgressFunc[GetMatchTypeType.CalcBattleResult] = self.CalcBattleResultGetMatchType
  self._matchTypeProgressFunc[GetMatchTypeType.PopStarProNoRelic] = self.PopStarProNoRelicMatchType
  self._matchTypeProgressFunc[GetMatchTypeType.WorldBossBattle] = self.WorldBossBattle
  self._matchTypeProgressFunc[GetMatchTypeType.SeasonMazeWorldBoss] = self.SeasonMazeWorldBoss
  self._matchTypeProgressFunc[GetMatchTypeType.GameMode] = self.GetGameModeMatchType
end

function MainWorld:GetGameModeMatchType()
  if self._matchType == MatchType.MT_SeasonMaze and self._subMatchType == MatchType.MT_WorldBoss then
    return MatchType.MT_SeasonMaze
  end
  return self._subMatchType
end

function MainWorld:SeasonMazeWorldBoss()
  return self._matchType, self._subMatchType
end

function MainWorld:WorldBossBattle()
  if self._matchType == MatchType.MT_SeasonMaze and self._subMatchType == MatchType.MT_WorldBoss then
    return MatchType.MT_WorldBoss
  end
  return self._matchType
end

function MainWorld:PopStarProNoRelicMatchType()
  return self._matchType
end

function MainWorld:CalcBattleResultGetMatchType()
  if self._matchType == MatchType.MT_SeasonMaze and self._subMatchType == MatchType.MT_WorldBoss then
    return MatchType.MT_SeasonMaze
  end
  return self._matchType
end

function MainWorld:GetNoLinkLineMatchType()
  return self._subMatchType
end

function MainWorld:MatchType(getMatchTypeType)
  if not getMatchTypeType then
    return self._subMatchType
  end
  local func = self._matchTypeProgressFunc[getMatchTypeType]
  if func then
    return func(self, getMatchTypeType)
  end
  return self._matchType
end

function MainWorld:GetGameMode()
  return self.game_mode
end

function MainWorld:SetGameModeType()
  self.game_mode = MatchType2GameMode.GetGameModeByMatchType(self:MatchType(GetMatchTypeType.GameMode))
end
