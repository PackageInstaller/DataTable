local MonsterRefreshPosType = {
  None = 0,
  Position = 1,
  Random = 2,
  PositionTable = 3,
  PositionHitBack = 4,
  PositionAndOffSet = 5,
  SelectFirstCanUse = 6,
  FarFormPlayerAndInterval = 7,
  PlayerCentered = 8,
  MonsterCentered = 9,
  PositionAndOffSetMultiBoard = 10,
  PositionOnExtraBoard = 11,
  MAX = 99
}
_enum("MonsterRefreshPosType", MonsterRefreshPosType)
local MonsterWaveInternalRefreshType = {
  None = 0,
  AfterMonsterDead = 1,
  EveryRoundCount = 2,
  WatchTarget = 3,
  AllMonsterDead = 4,
  TargetRound = 5,
  RoundResultWatchTarget = 6,
  RoundResultCheckMonsterCount = 7,
  CompareMonsterNumber = 8,
  OnlySpecifiedMonsterSurvival = 9,
  AssignRefreshTypeAndTime = 100
}
_enum("MonsterWaveInternalRefreshType", MonsterWaveInternalRefreshType)
local MonsterWaveInternalTime = {
  None = 0,
  ActiveSkill = 1,
  MonsterTurn = 2,
  RoundResult = 3,
  ChainAttack = 4
}
_enum("MonsterWaveInternalTime", MonsterWaveInternalTime)
local MonsterRefreshExceptionType = {
  None = 0,
  Random = 1,
  ValidRing = 2,
  BackupTable = 3,
  ValidRingNoRandom = 4
}
_enum("MonsterRefreshExceptionType", MonsterRefreshExceptionType)
local MonsterPosType = {
  None = 0,
  Position = 1,
  OffSet = 2
}
_enum("MonsterPosType", MonsterPosType)
local WaveRefreshModeType = {Cumulate = -1}
_enum("WaveRefreshModeType", WaveRefreshModeType)
local LevelCompleteAssignWaveParamExp = {
  AssignWaveEnd = 1,
  BaseRefreshProb = 2,
  RefreshUpProb = 3,
  RoundNum = 4,
  BaseLevelCompleteCond = 5,
  BaseCondParam = 6
}
_enum("LevelCompleteAssignWaveParamExp", LevelCompleteAssignWaveParamExp)
local ConditionCompareType = {
  Equal = 1,
  NotEqual = 2,
  Greater = 3,
  NotLess = 4,
  Less = 5,
  NotGreater = 6
}
_enum("ConditionCompareType", ConditionCompareType)

function CompareFunByType(type, a, b)
  if type == ConditionCompareType.Equal then
    return a == b
  elseif type == ConditionCompareType.NotEqual then
    return a ~= b
  elseif type == ConditionCompareType.Greater then
    return b < a
  elseif type == ConditionCompareType.NotLess then
    return b <= a
  elseif type == ConditionCompareType.Less then
    return a < b
  elseif type == ConditionCompareType.NotGreater then
    return a <= b
  end
  return false
end
