LuaS 

xV           (w@P@../PublishResources/config/shared/skill/skill_view/cfg_skill_view_80060201.lua            Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK   Á@  A  A A  Á  K Â kB Ť@k@   Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ˙ů       PlayCasterBindEffect,effectID=1020; PlayCasterVisible,visible=0; PlayEffectAtCasterPos, effectID=524; Wait,waitTime=200; DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=121,isRotate=1,label=playRangeEffect; Wait,waitTime=100; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=200311,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=500;                                                                                             key      config         _ENV