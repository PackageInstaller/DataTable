LuaS �

xV           (w@Y@../PublishResources/config/shared/skill/skill_view/trap/1115/cfg_skill_view_1004408.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A �� �B �B� �@��AA ��  �� �  AB  �� �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               < PlayMoveBoard,dirX=0,dirY=-1,times=2; Wait,waitTime=1000; �      �.       DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; �      � DataSelectResult,effectType=64,index=1; PlaySummonTrap,trapID=793,label=foreach; DataSelectNextResult,effectType=64; Jump,condition=CheckEffectResultIndex,param=64,goto=foreach; PlayTrapAreaOutline,effectID=3601,trapType=17; Wait,waitTime=800;         0                                                                                                                                                      key   0   config+   0      _ENV