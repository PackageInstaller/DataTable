LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/1705/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2901911/cfg_skill_view_290191130.lua         ;   Ą 
@@
Ą@
@A
ĄA
@B
ĄB
@CK   Į@  A  A A  Į  K Ā kB «@Ė Į  AĮ   ĮĮ  B  A  Į «B ė@AA A Į Ā  AĀ   Ė C ėB +AKĮ ĮĮ  AĀ  B Į  A +C kAk@   Į      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam                PlayCasterAnimation,animName = Skill03; PlayAudio,audioID=6176,audioType=1; PlayCasterBindEffect,effectID=3437; PlayCasterBindEffect,effectID=3440; ’       Wait,waitTime=500; PlayCasterBindEffect,effectID=3438; PlayCasterVisible,visible=0; PlayCasterHUDVisible,visible=0; Wait,waitTime=2200; PlayTeleportAsMoving,time=100; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; PlayCasterAnimation,animName = Skill032; Wait,waitTime=300; DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1; DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1; ’       DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=10; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,label=playConvert; PlayGridRangeEffect,effectID=480; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playConvert; e Wait,waitTime=300; PlayCasterBindEffect,effectID=3439; PlayChangePetTeamOrder; Wait,waitTime=1000;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV