LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1602111/cfg_skill_view_4062111.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �u      DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160211109,label=playRangeEffect; Wait,waitTime=50; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;      ��      DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; PlaySummonTrap,trapID=2803501; Wait,waitTime=50; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;        %                                                                                                                     key   %   config    %      _ENV