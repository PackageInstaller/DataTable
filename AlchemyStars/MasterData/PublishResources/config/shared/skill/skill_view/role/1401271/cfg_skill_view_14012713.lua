LuaS �

xV           (w@]@../PublishResources/config/shared/skill/skill_view/role/1401271/cfg_skill_view_14012713.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  � A� �� � �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �       Jump,condition=CheckOnAbyss,param=1,goto=phaseEnd; PlayCasterBindEffect,effectID=2795; DataSelectResult,effectType=79,index=1; DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeConvert,dataSource=4; ��       Jump,condition=CheckOnAbyss,param=0,goto=phaseEnd; PlayCasterBindEffect,effectID=2795; DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeConvert,dataSource=4; PlayGridVisible,visible=0; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach;         %                                                                                                                     key   %   config    %      _ENV