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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1600021,waitTime = 2000; "
    }
  },
  {
    2,
    2,
    0,
    2,
    0,
    0,
    {
      " PlayAudio,audioID = 3063,audioType=1; PlayCasterBindEffect,effectID =1691; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID =1690; Wait,waitTime=2500; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; Wait,waitTime=800; PlayRoleTeleport,type=6, onlySelf=1; PlayRoleTeleport,type=9, onlySelf=1; PlayCasterAnimation,animName = AtkUlt2; PlayCasterBindEffect,effectID =1692; Wait,waitTime=2000; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " DataSelectBuff,buffIndex=1; PlayAddBuffView,buffEffectType=400058,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; PlayCasterLineRenderer,group=Monster,targerEffectType=400058,lineEffectID=1694,lineTarget=Bone001,lineCurrent=Hit,targetEffect=1693; Wait,waitTime=3000; PlayShowLineRenderer,show=0; "
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    500,
    {
      " PlayAddHpTextMerge; "
    }
  },
  {
    5,
    5,
    0,
    2,
    4,
    500,
    {
      " PlayCasterRefreshBuffView,buffID=300257; "
    }
  }
}
return config, "ID", key
