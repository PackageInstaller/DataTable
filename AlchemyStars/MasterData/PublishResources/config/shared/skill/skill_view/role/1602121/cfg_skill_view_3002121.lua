LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1602121/cfg_skill_view_3002121.lua         G     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  �� ��  �B� +A�K��� ��  A�  �B  �B � A� +C� kA����A B A ��  �B  C K� �� kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1601381,waitTime = 2000; ��       PlayAudio,audioID = 160212103,audioType=1; ScreenShotSetTestureForAnton,effectID=160212107,duration=5300,block=0; PlayGridDark,darkType=0; PlayHUDVisible,visible=0; PlayTeamHUDVisible,visible=0; UiBattleVisible,visible=0; PlayCasterAnimation,animName = AtkUlt; Wait,waitTime=7000; PlayHUDVisible,visible=1; UiBattleVisible,visible=1; PlayTeamHUDVisible,visible=1; PlayGridDark,darkType=1;       � PlayEffectAtPickUpIndexGrid,effectID=160212108,pickUpIndex=1; Wait,waitTime=100; PlayEffectAtPickUpIndexGrid,effectID=160212108,pickUpIndex=2; �      ��      DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160212109,label=playRangeEffect; PlayGridRangeConvert,dataSource=4; PlaySummonTrap,trapID=14; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;� DataSelectResult,effectType=36,index=1; Jump,condition=IsAddBloodValueGreaterThan,param=0,result=0,goto=phaseEnd; PlayCasterMaterialAnim,animName=eff_1602121_atkult_main; PlayCasterBindEffect,effectID =160212110; PlayDisplayAddHP;         G                                                                                                                                                                                                         	   	   	   	   	      key	   G   configB   G      _ENV