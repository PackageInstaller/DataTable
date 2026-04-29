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
      " PlayCasterVisible,visible=1; PlayCasterAnimation,animName =Birth; PlayAudio,audioID = 5008,audioType=1; PlayCasterBindEffect,effectID=871; PlayCasterAddBuff, buffEffectType =3022; "
    }
  },
  {
    2,
    2,
    34,
    1,
    1,
    2000,
    {
      gridEffectID = 873,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0,
      showTimeDelay = 300
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    2500,
    {
      " PlayCasterAttachEffectHolder,effHolderType=Permanent,effId=976; PlayCasterLineRenderer,group=Monster|Trap,targerEffectType=3026,lineEffectID=888,lineTarget=Hit,lineCurrent=Hit; "
    }
  }
}
return config, "ID", key
