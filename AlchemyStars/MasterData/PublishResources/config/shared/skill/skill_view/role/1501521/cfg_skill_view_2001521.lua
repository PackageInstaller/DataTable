LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/1120/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1501521/cfg_skill_view_2001521.lua         F   À 
@@
À@
@A
ÀA
@B
ÀB
@CK  Á@  A  A A  Á  K Â kB «@Ë Á  AÁ   ÁA  B  A   ÄBÀë@AA A Á B  AB   Ë  ëB +AKÁ ÁÁ  AB   Á  AC +C kAÁA B A B  ÁB   K Ã kC «Ak@  Á      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               x PlayCasterAnimation,animName = AtkChain; Wait,waitTime=450; PlayCasterBindEffect,effectID = 3488; Wait,waitTime=3800; +       audioID[	      
audioType» DataSelectResult,effectType=5,index=1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=41014901,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;  PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2456,audioType=1; PlayCasterBindEffect,effectID = 3513; Wait,waitTime = 3300; x      ÿå       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=3514,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=50; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;         F                                                                                                                                                                                                      	   	   	   	   	      key   F   configA   F      _ENV