LuaS �

xV           (w@W@../PublishResources/config/shared/skill/skill_view/role/1600281/cfg_skill_view_49.lua         F   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �A �  AB  �� ˂  ��D��B@�+A�K��� �� � A�  �B  �� � AC +C� kA����A B A� ��  �B  � K� �� kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam                PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600281,waitTime = 2000;e PlayCasterAnimation,animName = AtkUlt01; Wait,waitTime=2300; PlayDisplayAddHP; Wait,waitTime=2700; +       audioID�      
audioTypeHPlayCasterBindEffect,effectID=223; PlayCasterBindEffect,effectID=1775; �	      ��       DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,label=playRangeEffect; PlayGridRangeEffect,effectID=224; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;        F                                                                                                                                                                                                      	   	   	   	   	      key   F   configA   F      _ENV