LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1140/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2903401/cfg_skill_view_290340204.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A �� �B �B� �@��AA �A �� �  A�  �� �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayAllHitBack; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; �       �?       PlayAudio,audioID =6240,audioType=1; DataSelectScopeGridRange,effectType=11; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=290340104,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;        V PlaySummonTrap,trapID=PARAM.trapID1; PlayTrapAreaOutline,effectID=3601,trapType=17;         0                                                                                                                                                      key   0   config+   0      _ENV