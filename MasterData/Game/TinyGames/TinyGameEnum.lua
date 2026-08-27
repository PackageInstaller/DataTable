local TinyGameEnum = {}
TinyGameEnum.eType = {
  flappyBird = 1,
  game2048 = 2,
  damie = 3,
  ballMerge = 4,
  snake = 5,
  penguins = 6,
  brotato = 7,
  mashdown = 9
}
TinyGameEnum.eClassType = {
  [TinyGameEnum.eType.flappyBird] = "Game.ActivityHistoryTinyGame.HTGPlayer.FlappyBirdPlayer",
  [TinyGameEnum.eType.game2048] = "Game.ActivityHistoryTinyGame.HTGPlayer._2048Player",
  [TinyGameEnum.eType.damie] = "Game.ActivityHistoryTinyGame.HTGPlayer.DamiePlayer",
  [TinyGameEnum.eType.ballMerge] = "Game.ActivityHistoryTinyGame.HTGPlayer.BallMergePlayer"
}
return TinyGameEnum
