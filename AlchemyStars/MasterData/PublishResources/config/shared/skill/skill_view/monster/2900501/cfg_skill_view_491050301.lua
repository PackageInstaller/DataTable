LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2900501/cfg_skill_view_491050301.lua         0   Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK  Á@  A  A A  Á  K Â kB Ť@Ë Á  AÁ   ÁA  B  A  ÁB ŤB ë@AA A Á B  AÂ   Ë  ëB +Ak@  Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam                PlayCasterAnimation,animName = Skill01; PlayAudio,audioID = 6030,audioType=1; PlayCasterBindEffect,effectID=PARAM.Skill01ffectId;       ˙í      DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=PARAM.Skill01SlotffectId,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;Ź DataSelectScopeGridRange,effectType=82; DataSortScopeGridRange,sortType=9; DataSelectScopeGridRangeIndex,index=2; PlayIslandConvert,patternEffectID=PARAM.IslandEffectId;         0                                                                                                                                                      key   0   config+   0      _ENV