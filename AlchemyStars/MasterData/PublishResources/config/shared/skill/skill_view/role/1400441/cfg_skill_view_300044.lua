LuaS 

xV           (w@@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1400441/cfg_skill_view_300044.lua         &     
@@
Ą@
@A
ĄA
@B
ĄB
@C
ĄCK   Į@  A  A A  Į  K B kB «@Ė Į  AĮ   ĮĮ  B  A  Į «B ė@k@   Į      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir                PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1400441,waitTime = 2000;’       PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 3034,audioType=1; PlayCasterBindEffect,effectID=1529; PlayCasterBindEffect,effectID=1533; PlayAudio,audioID = 2130,audioType=1; Wait,waitTime=1000; DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 1530,flyTime = 200,flyTrace = 1,isBlock = 0,label=doAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1532,turnToTarget=1,deathClear=1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; DataSelectScopeGridRange,effectType=62; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=62,isRotate=1,label=playRangeEffect; PlayGridRangeEffect,effectID=1531; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=2000;         &                                                                                                                        key	   &   config!   &      _ENV