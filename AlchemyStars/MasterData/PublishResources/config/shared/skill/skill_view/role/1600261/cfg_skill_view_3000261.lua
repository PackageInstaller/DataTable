LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1600261/cfg_skill_view_3000261.lua         a   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �A B  A�  �� �B  �  K�  JCB�JC
C��
�E����+A�K��� �� � AB  ��  � � AC +C� kA����A B A� �B  ��  � K� �� kC� �A���� A� �� �B  �  A �� �C �C� �A��AB �B �� C  A�  �� �� � �C� +B�k@�� � �      �  & �     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam                PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1600261,waitTime = 2000; �{       PlayGridDark,darkType=0; PlayTrapVisible,visible = 0; PlayShowLineRenderer,show=0,isTrap=1,selfAll=1; UiHudVisible,visible=0; UiBattleVisible,visible=0; PlayAudio,audioID = 2181,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=727; Wait,waitTime = 600; PlayCasterVisible,visible=0; Wait,waitTime = 600; PlayCasterAnimation,animName = AtkUlt01; <       �      gridPosxy	effectIDA      �      % PlayCasterBindEffect,effectID=479; %      ��      DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=10; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,dataSourceHigher=62,label=playRangeEffect; PlayGridRangeEffect,effectID=480; Wait,waitTime=150; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;)      e PlayCasterAnimation,animName = AtkUlt02; PlayCasterBindEffect,effectID=3394; Wait,waitTime = 1000; �,      � PlayCasterVisible,visible=1; PlayTrapVisible,visible = 1; PlayShowLineRenderer,show=1,isTrap=1,selfAll=1; UiHudVisible,visible=1; UiBattleVisible,visible=1; Wait,waitTime = 1300;         a                                                                                                                                                                                                                                                      	   	   	   	   	   	   	   	   	   	   
                     key   a   config\   a      _ENV