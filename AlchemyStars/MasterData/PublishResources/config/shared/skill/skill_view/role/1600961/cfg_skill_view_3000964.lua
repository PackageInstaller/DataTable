LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1600961/cfg_skill_view_3000964.lua         <     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  �� ��  �B� +A�K��� ��  A�  �B  �B � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               ~PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600961,waitTime = 2000;� PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=160096407; PlayCasterBindEffect,effectID=160096408; PlayCameraEffect,effectID=160096409; PlayAudio,audioID = 2267,audioType=1; Wait,waitTime=5000;       �c      DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160096406,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;�      �x      DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; PlaySummonTrap,trapID=14; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;        <                                                                                                                                                                                          key	   <   config7   <      _ENV