LuaS 

xV           (w@@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2900611/cfg_skill_view_1001751.lua            Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK   Á@  A  A A  Á  K Â kB Ť@k@   Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ˙š       PlayCasterAnimation,animName = Skill01; PlayAudio,audioID =6071,audioType=1; PlayCasterBindEffect,effectID=PARAM.effectID1; PlayCasterBindEffect,effectID=PARAM.effectID2; Wait,waitTime=2100; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=PARAM.effectID3,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=150; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=2000;                                                                                             key      config         _ENV