LuaS 

xV           (w@@C:/depot_matchsrpg/matchsrpg/b/170/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1500971/cfg_skill_view_200971.lua         I   Ą 
@@
Ą@
@A
ĄA
@B
ĄB
@CK  Į@  A  AĮ  A  Į  KB JÄJÄJÅJÅJĆ«@Ė Į  AĮ   ĮA  B  A  Į «B ė@AA A Į B  AB  B Ė  ėB +AKĮ ĮĮ  AB  B  ĮĀ  A +C kAĮA B A B  ĮB  C K  kC «Ak@  Į      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               effectparam2253castAnimationName	AtkChainfinishDelayTime	      buffDelayTime      buffNeedImmediatelyEffect'PlayAudio,audioID = 2252,audioType=1;        ’`       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=2254,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; ,      ’’        DataSelectDamage,damageIndex = 1; PlayTargetAnimatiorSpeed,speed=0,label=doAgain; PlayTargetBeHitEffect,hitEffectID=2255; PlayTargetMaterialAnim,animName=eff_1500971_atkchain_ice; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;       č DataSelectDamage,damageIndex = 1; PlayTargetAnimatiorSpeed,speed=1,label=doAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;         I                                                                                                                                                                                                               	   	   	   	   	      key   I   configD   I      _ENV