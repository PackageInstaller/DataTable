LuaS 

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1602211/cfg_skill_view_2002211.lua         0   À 
@@
À@
@A
ÀA
@B
ÀB
@CK  Á@  A  A A  Á  K Â kB «@Ë Á  AÁ   ÁA  B  A  ÁB «B ë@AA A Á B  AB   Ë Ã ëB +Ak@  Á      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam                PlayCasterBindEffect,effectID=160221102; PlayCasterAnimation,animName=AtkChain; PlayAudio,audioID = 160221102,audioType=1; Wait,waitTime=2500;       ÿÆ       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160221103,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=140; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; @      Ò DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=4002211,label=buffAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain;         0                                                                                                                                                      key   0   config+   0      _ENV