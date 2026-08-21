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
      " PlayAudio,audioID = 7061,audioType=1; PlayConjurer,monsterClassID=2003301,casterEffectID=200330106,targetEffectID=200330107,animName=skill01,nodeName=2003301_weapon,materialaAnimName=effanim_2003301_skill01,speed=3|4|5|6|7|8,waitHitBackTime=1000,time=3000; "
    }
  }
}
return config, "ID", key
