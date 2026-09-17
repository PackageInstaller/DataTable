L_FishingConst = {}
L_FishingConst.FishingEventType = {
  Egg = 1,
  DriftBottle = 2,
  Dialog = 3,
  Chess = 4,
  Salvage = 9
}
L_FishingConst.State = {
  Idle = 1,
  Start = 2,
  Wait = 3,
  Loop = 4,
  Game = 5,
  Cancel = 6,
  Lost = 7,
  Success = 8
}
L_FishingConst.StateAniName = {
  [L_FishingConst.State.Idle] = "Fishing_Idle",
  [L_FishingConst.State.Start] = "Fishing_Start",
  [L_FishingConst.State.Wait] = "Fishing_Wait",
  [L_FishingConst.State.Loop] = "FishingB_Loop",
  [L_FishingConst.State.Game] = "",
  [L_FishingConst.State.Cancel] = "Fishing_Cancel",
  [L_FishingConst.State.Lost] = "FishingLost",
  [L_FishingConst.State.Success] = "FishingLast_Start"
}
L_FishingConst.StateSoundName = {
  [L_FishingConst.State.Idle] = "",
  [L_FishingConst.State.Start] = "Play_SFX_System_Fishing_Throw",
  [L_FishingConst.State.Wait] = "",
  [L_FishingConst.State.Loop] = "Play_SFX_System_Fishing_Hint",
  [L_FishingConst.State.Game] = "",
  [L_FishingConst.State.Cancel] = "Play_SFX_System_Fishing_Cancel",
  [L_FishingConst.State.Lost] = "Play_SFX_System_Fishing_Fail",
  [L_FishingConst.State.Success] = ""
}
L_FishingConst.EffectName = {
  Bite = "pre_fish_bite",
  Float = "pre_fish_float",
  FloatIntoWater = "pre_fish_floatintowater",
  FloatIntoWaterCancel = "pre_fish_floatintowatercancel",
  Game = "pre_fish_game",
  Wait = "pre_fish_waiting"
}
L_FishingConst.FloatAniName = {
  Idle = "anim_fish_float_idle",
  FloatIntoWater = "anim_fish_floatintowater",
  Game = "anim_fish_float_game",
  FloatIntoWaterCancel = "anim_fish_floatintowatercancel"
}
L_FishingConst.FishMoveDir = {
  Center = 0,
  Front = 1,
  Back = 2,
  Left = 3,
  Right = 4
}
L_FishingConst.FishMoveAniName = {
  [L_FishingConst.FishMoveDir.Front] = "FishingF_Loop",
  [L_FishingConst.FishMoveDir.Back] = "FishingB_Loop",
  [L_FishingConst.FishMoveDir.Left] = "FishingR_Loop",
  [L_FishingConst.FishMoveDir.Right] = "FishingL_Loop"
}
L_FishingConst.HeroFishSize = {
  None = 0,
  High = 1,
  Middle = 2,
  PaMi = 3
}
