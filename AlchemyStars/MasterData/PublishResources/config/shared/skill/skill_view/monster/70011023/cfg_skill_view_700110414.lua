LuaS 

xV           (w@b@../PublishResources/config/shared/skill/skill_view/monster/70011023/cfg_skill_view_700110414.lua         1     
@@
Ą@
@A
ĄA
@B
ĄB
@C
ĄCK  Į@  A  A A  Į  K B kB «@Ė Į  AĮ   ĮA  B  A  ĮĀ «B ė@AA A Į B  AB   Ė C ėB +Ak@  Į      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir                PlayCasterAnimation,animName = AtkChain; Wait,waitTime=400; PlayCasterBindEffect,effectID=449,450; PlayAudio,audioID = 2024,audioType=1; Wait,waitTime=4000;        ’       DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=451,label=playRangeEffect; DataSelectNextScopeGridRange; Wait,waitTime=150; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;       ’°       DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect; DataSelectNextScopeGridRange; Wait,waitTime=150; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;         1                                                                                                                                                         key	   1   config,   1      _ENV