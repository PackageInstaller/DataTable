LuaS 

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2905601/cfg_skill_view_290560101.lua         %   À 
@@
À@
@A
ÀA
@B
ÀB
@CK   Á@  A  A A  Á  K Â kB «@Ë Á  AÁ   ÁÁ  B  A  Á «B ë@k@   Á      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ÿ       PlayAudio,audioID=290560105,audioType=1; PlayCasterAnimation,animName=Skill01; PlayCasterBindEffect,effectID =290560105; PlayCasterBindEffect,effectID =290560106; PlayCasterBindEffect,effectID =290560107; PlayCasterBindEffect,effectID =290560108; PlayCasterBindEffect,effectID =290560109; Wait,waitTime=1700; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=290560110,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=70; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;  DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow;         %                                                                                                                     key   %   config    %      _ENV