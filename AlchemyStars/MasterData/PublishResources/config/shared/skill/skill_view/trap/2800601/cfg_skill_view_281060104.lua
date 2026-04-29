local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7
}
local config = {
  {
    1,
    1,
    0,
    1,
    0,
    0,
    {
      " PlayMoveBoard,sceneRoot1=scxt_stage_01,sceneRoot2=scxt_stage_02,dirX=0,dirY=1,times=1; "
    }
  }
}
return config, "ID", key
