LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2900422/cfg_skill_view_290042205.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �`       PlayDeleteWaringArea; PlayAudio,audioID = 6025,audioType=1; Wait,waitTime=1500; DataSelectScopeGridRange,effectType=1,damageStageIndex=1; DataSortScopeGridRange,sortType=7; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=1235,step=4,offset=0.5|0.5,label=playRangeEffect; Wait,waitTime=200; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,damageStageIndex=1; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=500; d       ^ PlayCasterAnimation,animName=Land; Wait,waitTime=500; PlayEffectAtCasterPos, effectID=1236;         %                                                                                                                     key   %   config    %      _ENV