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
      " Jump,condition=CheckIsAllWeak,result=0,goto=phaseEnd; Jump,condition=CheckIsFirstP5PetInTeam,result=0,param=1601581,goto=phaseEnd; PlayModifyTimeScale,type=1,timeScale=1; PlayEffectAGridPos,effectID=3774,gridPosX=5,gridPosY=4; PlayShowPersonaTopUi,show=1,tarCamera=UIEffCamera,petHead=n19p5_chujue_tx01,petWord=str_voice_1601581_58,anim=uieff_UIBattlePersonaSkillEffTop_In; Wait,waitTime=600; PlayAudio,audioID = 9043,audioType=1; PlayVoice,voiceID=15800058; Wait,waitTime=2300; PlayAudio,audioID = 9041,audioType=1; Wait,waitTime=900; PlayAudio,audioID = 9042,audioType=1; Wait,waitTime=5400; PlayShowPersonaTopUi,show=0; PlayModifyTimeScale,type=0; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=4001581,remove=1,label=doAgain2;; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain2; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      "Jump,condition=CheckIsAllWeak,goto=phaseEnd; Jump,condition=CheckIsFirstP5PetInTeam,result=0,param=1601581,goto=phaseEnd; PlayModifyTimeScale,type=1,timeScale=1; PlayEffectAGridPos,effectID=3778,gridPosX=5,gridPosY=4; PlayShowPersonaTopUi,show=1,tarCamera=UIEffCamera,petHead=n19p5_chujue_tx01,petWord=str_voice_1601581_58,anim=uieff_UIBattlePersonaSkillEffTop01_In; Wait,waitTime=600; PlayAudio,audioID = 9043,audioType=1; PlayVoice,voiceID=15800058; Wait,waitTime=2400; Wait,waitTime=500; PlayShowPersonaTopUi,show=0; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=4001581,remove=1,label=doAgain2;; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain2; PlayModifyTimeScale,type=0;"
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " Jump,condition=CheckIsAllWeak,result=0,goto=phaseEnd; Jump,condition=CheckIsFirstP5PetInTeam,result=0,param=1601591,goto=phaseEnd; PlayModifyTimeScale,type=1,timeScale=1; PlayEffectAGridPos,effectID=3748,gridPosX=5,gridPosY=4; PlayShowPersonaTopUi,show=1,tarCamera=UIEffCamera,petHead=n19p5_chujue_tx03,petWord=str_voice_1601591_58,anim=uieff_UIBattlePersonaSkillEffTop_In; Wait,waitTime=600; PlayAudio,audioID = 9043,audioType=1; PlayVoice,voiceID=15900058; Wait,waitTime=2300; PlayAudio,audioID = 9041,audioType=1; Wait,waitTime=800; PlayAudio,audioID = 9042,audioType=1; Wait,waitTime=1800; Wait,waitTime=3700; PlayShowPersonaTopUi,show=0; PlayModifyTimeScale,type=0; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=4001581,remove=1,label=doAgain2;; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain2; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    0,
    {
      "Jump,condition=CheckIsAllWeak,goto=phaseEnd; Jump,condition=CheckIsFirstP5PetInTeam,result=0,param=1601591,goto=phaseEnd; PlayModifyTimeScale,type=1,timeScale=1; PlayEffectAGridPos,effectID=3778,gridPosX=5,gridPosY=4; PlayShowPersonaTopUi,show=1,tarCamera=UIEffCamera,petHead=n19p5_chujue_tx03,petWord=str_voice_1601591_58,anim=uieff_UIBattlePersonaSkillEffTop_In; Wait,waitTime=600; PlayAudio,audioID = 9043,audioType=1; PlayVoice,voiceID=15900058; Wait,waitTime=500; Wait,waitTime=2400; PlayShowPersonaTopUi,show=0; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=4001581,remove=1,label=doAgain2;; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain2; PlayModifyTimeScale,type=0;"
    }
  },
  {
    5,
    5,
    0,
    1,
    1,
    0,
    {
      " Jump,condition=CheckIsAllWeak,result=0,goto=phaseEnd; Jump,condition=CheckIsFirstP5PetInTeam,result=0,param=1501601,goto=phaseEnd; PlayModifyTimeScale,type=1,timeScale=1; PlayEffectAGridPos,effectID=3775,gridPosX=5,gridPosY=4; PlayShowPersonaTopUi,show=1,tarCamera=UIEffCamera,petHead=n19p5_chujue_tx05,petWord=str_voice_1501601_58,anim=uieff_UIBattlePersonaSkillEffTop_In,anim=uieff_UIBattlePersonaSkillEffTop_In; Wait,waitTime=600; PlayAudio,audioID = 9043,audioType=1; PlayVoice,voiceID=16000058; Wait,waitTime=2200; PlayAudio,audioID = 9041,audioType=1; Wait,waitTime=600; PlayAudio,audioID = 9042,audioType=1; Wait,waitTime=1800; Wait,waitTime=4200; PlayShowPersonaTopUi,show=0; PlayModifyTimeScale,type=0; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=4001581,remove=1,label=doAgain2;; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain2;"
    }
  },
  {
    6,
    6,
    0,
    1,
    1,
    0,
    {
      "Jump,condition=CheckIsAllWeak,goto=phaseEnd; Jump,condition=CheckIsFirstP5PetInTeam,result=0,param=1501601,goto=phaseEnd; PlayModifyTimeScale,type=1,timeScale=1; PlayEffectAGridPos,effectID=3778,gridPosX=5,gridPosY=4; PlayShowPersonaTopUi,show=1,tarCamera=UIEffCamera,petHead=n19p5_chujue_tx05,petWord=str_voice_1501601_58,anim=uieff_UIBattlePersonaSkillEffTop01_In; Wait,waitTime=600; PlayAudio,audioID = 9043,audioType=1; PlayVoice,voiceID=16000058; Wait,waitTime=2400; Wait,waitTime=500; PlayShowPersonaTopUi,show=0; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=4001581,remove=1,label=doAgain2;; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain2; PlayModifyTimeScale,type=0;"
    }
  },
  {
    7,
    7,
    0,
    1,
    1,
    0,
    {
      " Jump,condition=CheckIsAllWeak,result=0,goto=phaseEnd; Jump,condition=CheckIsFirstP5PetInTeam,result=0,param=1501611,goto=phaseEnd; PlayModifyTimeScale,type=1,timeScale=1; PlayEffectAGridPos,effectID=3776,gridPosX=5,gridPosY=4; PlayShowPersonaTopUi,show=1,tarCamera=UIEffCamera,petHead=n19p5_chujue_tx02,petWord=str_voice_1501611_58,anim=uieff_UIBattlePersonaSkillEffTop_In; Wait,waitTime=600; PlayAudio,audioID = 9043,audioType=1; PlayVoice,voiceID=16100058; Wait,waitTime=2300; PlayAudio,audioID = 9041,audioType=1; Wait,waitTime=600; PlayAudio,audioID = 9042,audioType=1; Wait,waitTime=1600; Wait,waitTime=4100; PlayShowPersonaTopUi,show=0; PlayModifyTimeScale,type=0; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=4001581,remove=1,label=doAgain2;; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain2; "
    }
  },
  {
    8,
    8,
    0,
    1,
    1,
    0,
    {
      "Jump,condition=CheckIsAllWeak,goto=phaseEnd; Jump,condition=CheckIsFirstP5PetInTeam,result=0,param=1501611,goto=phaseEnd; PlayModifyTimeScale,type=1,timeScale=1; PlayEffectAGridPos,effectID=3778,gridPosX=5,gridPosY=4; PlayShowPersonaTopUi,show=1,tarCamera=UIEffCamera,petHead=n19p5_chujue_tx02,petWord=str_voice_1501611_58,anim=uieff_UIBattlePersonaSkillEffTop01_In; Wait,waitTime=600; PlayAudio,audioID = 9043,audioType=1; PlayVoice,voiceID=16100058; Wait,waitTime=2400; Wait,waitTime=500; PlayShowPersonaTopUi,show=0; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=4001581,remove=1,label=doAgain2;; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain2; PlayModifyTimeScale,type=0;"
    }
  },
  {
    9,
    9,
    0,
    1,
    1,
    0,
    {
      " Jump,condition=CheckIsAllWeak,result=0,goto=phaseEnd; Jump,condition=CheckIsFirstP5PetInTeam,result=0,param=1501621,goto=phaseEnd; PlayModifyTimeScale,type=1,timeScale=1; PlayEffectAGridPos,effectID=3777,gridPosX=5,gridPosY=4; PlayShowPersonaTopUi,show=1,tarCamera=UIEffCamera,petHead=n19p5_chujue_tx04,petWord=str_voice_1501621_58,anim=uieff_UIBattlePersonaSkillEffTop_In; Wait,waitTime=600; PlayAudio,audioID = 9043,audioType=1; PlayVoice,voiceID=16200058; Wait,waitTime=2300; PlayAudio,audioID = 9041,audioType=1; Wait,waitTime=2400; Wait,waitTime=3900; PlayShowPersonaTopUi,show=0; PlayModifyTimeScale,type=0; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=4001581,remove=1,label=doAgain2;; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain2;"
    }
  },
  {
    10,
    10,
    0,
    1,
    1,
    0,
    {
      "Jump,condition=CheckIsAllWeak,goto=phaseEnd; Jump,condition=CheckIsFirstP5PetInTeam,result=0,param=1501621,goto=phaseEnd; PlayModifyTimeScale,type=1,timeScale=1; PlayEffectAGridPos,effectID=3778,gridPosX=5,gridPosY=4; PlayShowPersonaTopUi,show=1,tarCamera=UIEffCamera,petHead=n19p5_chujue_tx04,petWord=str_voice_1501621_58,anim=uieff_UIBattlePersonaSkillEffTop01_In; Wait,waitTime=600; PlayAudio,audioID = 9043,audioType=1; PlayVoice,voiceID=16200058; Wait,waitTime=2400; Wait,waitTime=500; PlayShowPersonaTopUi,show=0; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=4001581,remove=1,label=doAgain2;; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain2; PlayModifyTimeScale,type=0;"
    }
  }
}
return config, "ID", key
