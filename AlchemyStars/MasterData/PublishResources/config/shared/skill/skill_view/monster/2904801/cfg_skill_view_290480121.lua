LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2904801/cfg_skill_view_290480121.lua         1   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A�  �A  �� � K�  JćJ�ĈJ�É�@�� ��  A�  �� �A  B  A� �� � �B� �@��AA �A �� �  A�  �� �� C �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               effectparam580,581castAnimationNameSkill01finishDelayTime�       PlayAudio,audioID = 5095,audioType=1; Wait,waitTime=1400; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=0,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=120; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; ��       DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playConvert; PlayGridRangeEffect,effectID=480; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playConvert;         1                                                                                                                                                         key   1   config,   1      _ENV