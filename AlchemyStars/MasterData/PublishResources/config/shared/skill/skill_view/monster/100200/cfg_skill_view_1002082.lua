LuaS 

xV           (w@^@../PublishResources/config/shared/skill/skill_view/monster/100200/cfg_skill_view_1002082.lua         0   À 
@@
À@
@A
ÀA
@B
ÀB
@CK  Á@  A  A A  Á  K Â kB «@Ë Á  AÁ   ÁA  B  A  ÁB «B ë@AA A Á B  AB   Ë  ëB +Ak@  Á      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               X PlayEntityLegacyAnimation,animNames=eff_2909401_skill03_out,casterEffectID=290940105; Ü      Ú DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain1; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; ÿ       DataSelectResult,effectType=64,index=1; PlaySummonTrap,trapID=78,label=foreach; PlaySummonTrap,trapID=2000903; DataSelectNextResult,effectType=64; Jump,condition=CheckEffectResultIndex,param=64,goto=foreach; PlayDeleteCasterEffect,effectIDList=290940105;         0                                                                                                                                                      key   0   config+   0      _ENV