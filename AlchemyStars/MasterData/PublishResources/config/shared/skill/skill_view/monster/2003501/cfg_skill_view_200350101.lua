LuaS 

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2003501/cfg_skill_view_200350101.lua         %   À 
@@
À@
@A
ÀA
@B
ÀB
@CK   Á@  A  A A  Á  K Â kB «@Ë Á  AÁ   ÁA  B  A  ÁB «B ë@k@   Á      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam                PlayAudio,audioID=20035011,audioType=1; PlayCasterAnimation,animName=Skill01; PlayCasterBindEffect,effectID=200350103; Wait,waitTime=1100;       ÿ       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,isRotate=1,effectID=200350104,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1,hitBackUseDamageIndex=1; Wait,waitTime=150; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;         %                                                                                                                     key   %   config    %      _ENV