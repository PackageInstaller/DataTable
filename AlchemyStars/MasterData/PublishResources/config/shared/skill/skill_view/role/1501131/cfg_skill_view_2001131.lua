LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1501131/cfg_skill_view_2001131.lua         5     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K ��  �@  A  A �A  �  K� �B kB� � �� � �B �@ � ��  A�  � �A  B  A �� �B �B� �@��AA �A � B  AB  �� �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               u PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2312,audioType=1; PlayCasterBindEffect,effectID=2624; 0,-1�
      �~       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=2625,isRotate=1,label=playRangeEffect; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "      ��       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=2626,turnToTarget=1,deathClear=0,label=playRangeHit; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeHit; Wait,waitTime=1000;         5                                                                                                                                                                     key	   5   config0   5      _ENV