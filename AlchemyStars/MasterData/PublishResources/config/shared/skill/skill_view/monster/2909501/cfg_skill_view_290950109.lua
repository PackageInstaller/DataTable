LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2909501/cfg_skill_view_290950109.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ��       PlayCasterAnimation,animName = Skill1_2; PlayAudio,audioID = 29095015,audioType=1; Wait,waitTime=1000; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=7; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=290950105,step=4,offset=0.5|0.5,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; �      �9       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=7; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeHit; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeHit;         %                                                                                                                     key   %   config    %      _ENV