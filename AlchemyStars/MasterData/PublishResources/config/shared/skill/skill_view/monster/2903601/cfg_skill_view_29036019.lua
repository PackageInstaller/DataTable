LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2903601/cfg_skill_view_29036019.lua         0   ภ 
@@
ภ@
@A
ภA
@B
ภB
@CK  ม@  A  A A  ม  K ย kB ซ@ห ม  Aม   มม  B  A  ม ซB ๋@AA A ม B  A  ห C ๋B +Ak@  ม      ฆ  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ๎ Wait,waitTime=2000; PlayChangeBodyArea; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; พ DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=doAgain; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=doAgain; Wait,waitTime=1000; อ DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=doAgain; PlayAddBuffView,buffID=29036014; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;         0                                                                                                                                                      key   0   config+   0      _ENV