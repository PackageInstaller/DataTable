local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayEntityBindEffect,effectID=160219118,trapID=16021913; PlayEntityBindEffect,effectID=160219118,trapID=16021914; PlayEntityBindEffect,effectID=160219118,trapID=16021917; PlayEntityBindEffect,effectID=160219118,trapID=16021918; PlayEntityBindEffect,effectID=160219118,trapID=160219111; PlayEntityBindEffect,effectID=160219118,trapID=160219112; PlayEntityBindEffect,effectID=160219118,trapID=160219115; PlayEntityBindEffect,effectID=160219118,trapID=160219116; PlayEntityBindEffect,effectID=160219118,trapID=160219117; PlayEntityBindEffect,effectID=160219118,trapID=160219118; PlayAudio,audioID = 160219103,audioType=1; Wait,waitTime=300; PlayReplaceTrapModel,trapID=16021913|16021914|16021917|16021918|160219111|160219112|160219115|160219116|160219117|160219118,replacePrefab=16021911.prefab; PlayEntityBindEffect,effectID=160219115,trapID=16021913; PlayEntityBindEffect,effectID=160219115,trapID=16021914; PlayEntityBindEffect,effectID=160219115,trapID=16021917; PlayEntityBindEffect,effectID=160219115,trapID=16021918; PlayEntityBindEffect,effectID=160219115,trapID=160219111; PlayEntityBindEffect,effectID=160219115,trapID=160219112; PlayEntityBindEffect,effectID=160219115,trapID=160219115; PlayEntityBindEffect,effectID=160219115,trapID=160219116; PlayEntityBindEffect,effectID=160219115,trapID=160219117; PlayEntityBindEffect,effectID=160219115,trapID=160219118;Wait,waitTime=200; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
