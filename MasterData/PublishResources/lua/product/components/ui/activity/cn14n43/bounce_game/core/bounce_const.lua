local BounceCamp = {Player = 0, Monster = 1}
_enum("BounceCamp", BounceCamp)
local BounceMoveDirection = {ToLeft = 0, ToRight = 1}
_enum("BounceMoveDirection", BounceMoveDirection)
local BounceObjState = {
  Alive = 0,
  Deading = 1,
  Deaded = 2,
  Transformation = 3
}
_enum("BounceObjState", BounceObjState)
_class("BounceConst", Object)
BounceConst = BounceConst
BounceConst.CanvasMinX = -1300
BounceConst.CanvasMaxX = 1500
BounceConst.MonsterBeAttackedAniName = "beAttacked"
BounceConst.MonsterAttackAniName = "attack"
BounceConst.MonsterDeadAniName = "dead"
BounceConst.MonsterWalkName = "walk"
BounceConst.MonsterAudioTypeDead = 1
BounceConst.MonsterAudioTypeBeAttacked = 2
BounceConst.GuideFirst = 542008
BounceConst.GuideSecond = 542009
BounceConst.GuideBoss1 = 542010
BounceConst.GuideBoss2 = 542011
BounceConst.GuideBoss3 = 542012
BounceConst.GuideBoss2_BulletPos1 = 400
BounceConst.GuideBoss2_BulletPosKey1 = "guide5420111"
BounceConst.GuideBoss3_BulletPosKey1 = "guide5420121"
