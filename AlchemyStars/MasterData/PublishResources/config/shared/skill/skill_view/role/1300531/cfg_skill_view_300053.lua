LuaS 

xV           (w@@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1300531/cfg_skill_view_300053.lua         %   À 
@@
À@
@A
ÀA
@B
ÀB
@CK   Á@  A  A A  Á  K Â kB «@Ë Á  AÁ   ÁÁ  B  A  Á «B ë@k@   Á      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam                PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1300531,waitTime = 2000;ÿ        PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 2109,audioType=1; PlayCasterBindEffect,effectID=993; Wait,waitTime=600; DataSelectDamage,damageIndex=1; Jump,condition=CheckTargetCountInScope,param=1,goto=criticalDamageFx,label=damageBegin; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=995; Jump,condition=CheckTrue,goto=damageEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=994,label=criticalDamageFx; Wait,waitTime=33,label=damageEnd; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=damageBegin; Wait,waitTime=1200;         %                                                                                                                     key   %   config    %      _ENV