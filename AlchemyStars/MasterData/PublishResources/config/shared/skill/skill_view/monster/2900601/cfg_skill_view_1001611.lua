LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2900601/cfg_skill_view_1001611.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ��       PlayCasterAnimation,animName = Skill01; PlayAudio,audioID =6061,audioType=1; PlayCasterBindEffect,effectID=PARAM.effectID1; PlayCasterBindEffect,effectID=PARAM.effectID4; PlayCasterBindEffect,effectID=PARAM.effectID5; Wait,waitTime=1900; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=9; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=PARAM.effectID2,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=50; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; PlayMultiTraction; H      � DataSelectScopeGridRange,effectType=82; DataSortScopeGridRange,sortType=9; DataSelectScopeGridRangeIndex,index=2; PlayIslandConvert,patternEffectID=PARAM.effectID3; Wait,waitTime=2000;         %                                                                                                                     key   %   config    %      _ENV