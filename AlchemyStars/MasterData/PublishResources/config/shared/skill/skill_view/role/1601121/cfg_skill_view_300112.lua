LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/190/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1601121/cfg_skill_view_300112.lua         F   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� �  AB  �� �� C �B� +A�K��� �� � A�  �B  �� � A� +C� kA����A B A� ��  �B   K� �C kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ~ PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1601121,waitTime = 2000;' PlayAudio,audioID = 2322,audioType=1;� PlayGridDark,darkType=0; PlayTurnToPickUpDirection; PlayCasterAnimation,animName = AtkUlt; PlayCameraEffect,effectID=2532; Wait,waitTime=150; PlayTeleportAsMoving,time=500; �      ��       PlayCasterBindEffect,effectID =2535; Wait,waitTime=1700; DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=0,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=2534,turnToTarget=1,deathClear=0; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; |      ��      DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=10; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=wait; PlayGridRangeConvert,dataSource=58,dataSourceHigher=62,label=playRangeEffect; PlayGridRangeEffect,effectID=2533; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; PlayGridDark,darkType=1; Wait,waitTime=2000,label=wait;         F                                                                                                                                                                                                      	   	   	   	   	      key   F   configA   F      _ENV