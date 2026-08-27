local DormFightConst = {}
DormFightConst.CharacterType = {
  Undefined = 0,
  Player = 1,
  Npc = 2
}
DormFightConst.FeatureEnum = {
  ModelController = 1,
  InputController = 2,
  AnimatorController = 3,
  AiController = 4,
  VitalityController = 5,
  PropertyController = 6,
  SceneUiController = 7
}
DormFightConst.PropertyEnum = {
  MoveSpeed = 1,
  RunSpeed = 2,
  AcceleratedVelocity = 3,
  NegativeAcceleratedVelocity = 4,
  HitShieldTime = 5,
  MaxVitality = 6,
  InitialVitality = 7,
  IdleVitalityResumeRate = 8,
  WalkVitalityResumeRate = 9,
  RunVitalityResumeRate = 10,
  AttackVitalityResumeRate = 11,
  HitVitalityResumeRate = 12,
  KnockOutVitalityResumeRate = 13,
  AttackedVitalityLoss = 14,
  HitWallVitalityLoss = 15,
  KnockOutVitalityRate = 16,
  HitForceStrength = 17,
  KnockOutForceStrength = 18,
  KnockOutLieDownInterval = 19,
  RotateRatio = 20,
  AttackShieldInterval = 21,
  AttackAutoAdjustSqrDistance = 22,
  KnockOutGetUpInterval = 23,
  KnockOutBasicRatio = 24,
  KnockOutRatioUpRate = 25
}
DormFightConst.StateEnum = {
  Undefined = 0,
  MovementLayer_Born = 1,
  MovementLayer_Idle = 2,
  MovementLayer_Drop = 3,
  MovementLayer_Jump = 4,
  MovementLayer_Move = 5,
  MovementLayer_Hit = 6,
  MovementLayer_KnockOut = 7,
  MovementLayer_Run = 8,
  AttackLayer_Born = 9,
  AttackLayer_Idle = 10,
  AttackLayer_Drop = 11,
  AttackLayer_Attack = 12,
  AttackLayer_Hit = 13,
  AttackLayer_KnockOut = 14
}
DormFightConst.EventEnum = {
  Undefined = 0,
  Jump = 1,
  Move = 2,
  StopMoving = 3,
  Hit = 4,
  KnockOut = 5,
  Attack = 6,
  Run = 7
}
DormFightConst.KnockOutShieldInterval = 0.5
DormFightConst.DormFightComp = {Myself = 1, Enemy = 2}
DormFightConst.DormFightResult = {
  Win = 1,
  Loss = 2,
  Tie = 3
}
DormFightConst.SceneUiType = {
  Undefined = 0,
  VitalityBar = 1,
  NamePlate = 2
}
DormFightConst.CameraStateEnum = {RotateScene = 1, FollowCharacter = 2}
DormFightConst.MaxScore = 3
DormFightConst.FightDuration = 180
DormFightConst.StartCountdown = 3
DormFightConst.MaleProfessorIdDefine = -1
DormFightConst.FemaleProfessorIdDefine = -2
DormFightConst.BornPositions = {
  Vector3.New(1, 0.8, 1),
  Vector3.New(1, 0.8, 0),
  Vector3.New(-1, 0.8, 1.25),
  Vector3.New(-1, 0.8, -1)
}
return DormFightConst
