LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1601051/cfg_skill_view_2301051.lua         R     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � �A  B  A �� �� �B� �@��AA �A � B  AB  � �� � �B� +A�K��� ��  AB  �B  � � AC +C� kA����A B A ��  �� � K� �� kC� �A���� A� � ��  C A �� �C �C� �A�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               � PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID=160105104; PlayCasterBindEffect,effectID=160105106; PlayAudio,audioID = 2297,audioType=1; Wait,waitTime=5000; 5 PlaySkillAttackRange,showTime=700,isEffectRange=0; ��       DataSelectDamage,damageIndex=1,damageStageIndex = 1; DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160105102,isRotate=1,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; �      ��       DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,damageStageIndex=1,deathClear=0,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;       ��      DataSelectScopeGridRange,effectType=1,damageInfoIndex=2; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,damageStageIndex=2,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; �      ��       DataSelectScopeGridRange,effectType=1,damageInfoIndex=3; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,damageStageIndex=3,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;        R                                                                                                                                                                                                                                       	   
   
   
   
   
      key	   R   configM   R      _ENV