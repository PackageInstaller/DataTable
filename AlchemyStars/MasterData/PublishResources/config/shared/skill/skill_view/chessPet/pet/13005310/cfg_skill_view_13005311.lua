LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/180/client/Assets/../PublishResources/config/shared/skill/skill_view/chessPet/pet/13005310/cfg_skill_view_13005311.lua            Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK   Á@  A  A A  Á  K Â kB Ť@k@   Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ˙!       PlayCasterAnimation,animName=Skill01; PlayAudio,audioID = 2109,audioType=1; PlayCasterBindEffect,effectID=993; Wait,waitTime=600; DataSelectDamage,damageIndex=1; Jump,condition=CheckTargetCountInScope,param=1,goto=criticalDamageFx,label=damageBegin; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=995; Jump,condition=CheckTrue,goto=damageEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=994,label=criticalDamageFx; Wait,waitTime=33,label=damageEnd; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=damageBegin; Wait,waitTime=1200;                                                                                             key      config         _ENV