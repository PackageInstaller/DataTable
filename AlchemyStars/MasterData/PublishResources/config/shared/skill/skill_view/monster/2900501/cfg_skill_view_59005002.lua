LuaS 

xV           (w@@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2900501/cfg_skill_view_59005002.lua         %   À 
@@
À@
@A
ÀA
@B
ÀB
@CK   Á@  A  A A  Á  K Â kB «@Ë Á  AÁ   ÁA  B  A  ÁB «B ë@k@   Á      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam                PlayCasterAnimation,animName = Skill01; PlayAudio,audioID = 6030,audioType=1; PlayCasterBindEffect,effectID=PARAM.Skill01ffectId;       ÿí      DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=PARAM.Skill01SlotffectId,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;        %                                                                                                                     key   %   config    %      _ENV