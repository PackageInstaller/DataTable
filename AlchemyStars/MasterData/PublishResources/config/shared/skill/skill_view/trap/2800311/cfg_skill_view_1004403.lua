LuaS 

xV           (w@@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/trap/2800311/cfg_skill_view_1004403.lua            Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK   Á@  A  A A  Á  K Â kB Ť@k@   Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ˙       Jump,condition=CheckEffectMultiResultIndex,param=79|1,result=0,goto=phaseEnd; PlayCasterLegacyAnimation,animNames=eff_2800311_skill_main; Wait,waitTime=500; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2658,turnToTarget=0,deathClear=0; Wait,waitTime=100; PlayCasterLegacyAnimation,animNames=eff_2800311_skill_idle;                                                                                             key      config         _ENV