LuaS 

xV           (w@_@../PublishResources/config/shared/skill/skill_view/monster/n41cn12/cfg_skill_view_5411002.lua         0   À 
@@
À@
@A
ÀA
@B
ÀB
@CK  Á@  A  A A  Á  K Â kB «@Ë Á  AÁ   ÁA  B  A  Á «B ë@AA Á Á B  AB  B Ë  ëB +Ak@  Á      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ¼ PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 160223103,audioType=1; PlayCasterBindEffect,effectID=160223105; PlayCasterBindEffect,effectID=160223106; Wait,waitTime=6000; 5 PlaySkillAttackRange,showTime=500,isEffectRange=0;        ÿ·      DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1,label=playRangeEffect; DataSelectNextScopeGridRange,label=selectNextGridRange; Wait,waitTime=100; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;         0                                                                                                                                                      key   0   config+   0      _ENV