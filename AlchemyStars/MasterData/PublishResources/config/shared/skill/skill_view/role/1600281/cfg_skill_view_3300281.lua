LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1600281/cfg_skill_view_3300281.lua         L     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A �� �  AB  � ˂  �BE��B@�+A�K��� �� � A�  �B  � C  K�  ��  �C��A�J��JǍ
C��kA����A B A ��  �B  C K� �� kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir                PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600281,waitTime = 2000;�$       PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=1854; PlayCasterBindEffect,effectID=1855; PlayCasterBindEffect,effectID=1858; Wait,waitTime=800; PlayCasterVisible,visible=0; Wait,waitTime = 2500; PlayCasterVisible,visible=1; PlayCasterAnimation,animName = AtkUlt1; PlayCasterBindEffect,effectID=1861; Wait,waitTime = 1800; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,label=checkbuff; PlayTargetAddBuff,buffEffectType =443028; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff; +       audioID�      
audioType<       gridPosxy	effectIDC      �      ��       DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=10; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,label=playRangeEffect; PlayGridRangeEffect,effectID=1860; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;        L                                                                                                                                                                                                                        	   	   	   	   	      key	   L   configG   L      _ENV