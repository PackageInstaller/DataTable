_class("MatchType2GameMode", Object)
MatchType2GameMode = MatchType2GameMode

function MatchType2GameMode.GetGameModeByMatchType(matchType)
  if MatchType.MT_Maze and MatchType.MT_Maze == matchType then
    return GameModeType.MazeBattleMode
  elseif MatchType.MT_Chess and MatchType.MT_Chess == matchType then
    return GameModeType.ChessBattleMode
  elseif MatchType.MT_PopStar and MatchType.MT_PopStar == matchType then
    return GameModeType.PopStarMode
  elseif MatchType.MT_PopStarPro and MatchType.MT_PopStarPro == matchType then
    return GameModeType.PopStarProMode
  elseif MatchType.MT_SeasonMaze and MatchType.MT_SeasonMaze == matchType then
    return GameModeType.SeasonMazeBattleMode
  else
    return GameModeType.NormalBattleMode
  end
end
