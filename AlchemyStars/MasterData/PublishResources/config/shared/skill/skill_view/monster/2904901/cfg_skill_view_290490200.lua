LuaS 

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2904901/cfg_skill_view_290490200.lua            Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK   Á@  A  A A  Á  K Â kB Ť@k@   Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ˙á       PlayAudio,audioID=6252,audioType=1; PlayHorsemanIntro,introModel=2904900.prefab,introAnimateTrigger=Birth,introMaterialAnimateName=eff_2904900_birth_xiaoshi,introEffectID=290490101,introStateTimeMs=1600,realIntroEffectID=290490102,realStateTimeMs=500,realMaterialAnimateName=eff_2904900_birth_chuxian; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; DataSelectBuff,buffIndex=1; Wait,waitTime=2000; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; PlayTargetAddBuff,buffID=PARAM.buffID2; PlayTargetAddBuff,buffID=PARAM.buffID3; PlayTargetAddBuff,buffID=PARAM.buffID4; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; Wait,waitTime=1000;                                                                                             key      config         _ENV