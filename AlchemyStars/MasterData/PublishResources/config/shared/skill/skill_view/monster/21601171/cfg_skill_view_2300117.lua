LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/21601171/cfg_skill_view_2300117.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� ��  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� B  A�  �B �� � �B� +A�K��� �� � A�  �B �� � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ' PlayAudio,audioID = 2330,audioType=1;� PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=2913; PlayCasterBindEffect,effectID=2914; Wait,waitTime=800; �
      �       DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phase2; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect1; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect1; DataSelectScopeGridRange,effectType=1,damageInfoIndex=2,label=phase2; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,damageStageIndex=2,label=playRangeEffect2; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect2; DataSelectBuff,buffIndex=1; PlayAddBuffView,buffEffectType=430117,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=1000;  PlayModifyTimeScale,type=0;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV