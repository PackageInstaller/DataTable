LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1602311/cfg_skill_view_3002311.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� �  AB  �B �� � �B� +A�K��� �� � A�  �B  �� � A +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1601451,waitTime = 2000;� PlayAudio,audioID = 160231103,audioType=1; PlayCasterAnimation,animName=AtkUlt; PlayCasterBindEffect,effectID=160231106; Wait,waitTime=3500; �      �M       DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160231108,randomRotateList=0|90|180|270,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=doAgain; PlayTargetAddBuff,buffID=10021; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; T      �       DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlaySummonTrap,trapID=2803501,label=playRangeEffect; PlayGridRangeConvert,dataSource=4; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV