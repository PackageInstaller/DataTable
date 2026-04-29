local StoryShowType = {
  None = 0,
  BeginAfterCreateScene = 1,
  BeginAfterBoardShow = 2,
  BeginAfterMonsterShow = 3,
  WaveAndRoundBeginPlayerRound = 4,
  WaveAndRoundAfterPlayerRound = 5,
  WaveAndRoundBeginMonsterRound = 6,
  WaveAndRoundAfterMonsterRound = 7,
  AfterAllMonsterDeadBeginExitGame = 8,
  BeginMonsterShow = 9,
  AfterMonsterDead = 10,
  MonsterCastSkill = 11,
  BeginAfterMasterShowBeginTeamShow = 12
}
_enum("StoryShowType", StoryShowType)
local StoryTipsSpeakerType = {
  None = 0,
  Pet = 1,
  Monster = 2
}
_enum("StoryTipsSpeakerType", StoryTipsSpeakerType)
local StoryMonsterShowType = {
  None = 0,
  AfterShow = 1,
  BeginDeadAnimation = 2
}
_enum("StoryMonsterShowType", StoryMonsterShowType)
local StoryBannerShowType = {
  None = 0,
  Normal = 1,
  HalfPortrait = 2,
  HomelandGuide = 3
}
_enum("StoryBannerShowType", StoryBannerShowType)
