LuaS 

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2003501/cfg_skill_view_200350103.lua         F   Ą 
@@
Ą@
@A
ĄA
@B
ĄB
@CK  Į@  A  A A  Į  K Ā kB «@Ė Į  AĮ   ĮA  B  A  ĮB «B ė@AA A Į B  AB   Ė Ć ėB +AKĮ ĮA  AB  B  Į  A +C kAĮA Ā A B  ĮB   K C kC «Ak@  Į      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               Ó PlayAudio,audioID=20035013,audioType=1; PlayCasterTurnToTargetNormal; PlayCasterAnimation,animName=Skill03; PlayCasterBindEffect,effectID=200350101; PlayCasterBindEffect,effectID=200350102; Wait,waitTime=800; X      . PlayTeleportAsMoving,time=500,notifyBuff=1; ¶      ’3       DataSelectDamage,damageIndex=1,damageStageIndex=1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200350106,turnToTarget=1,deathClear=false,damageStageIndex=1,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; ’5       DataSelectDamage,damageIndex=1,damageStageIndex=2; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200350106,turnToTarget=1,deathClear=false,damageStageIndex = 2,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;  DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=10011,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;         F                                                                                                                                                                                                      	   	   	   	   	      key   F   configA   F      _ENV