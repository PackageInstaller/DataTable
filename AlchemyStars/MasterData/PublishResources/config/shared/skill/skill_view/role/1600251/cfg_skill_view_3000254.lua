LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1600251/cfg_skill_view_3000254.lua         G     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  �� ��  �B� +A�K��� ��  A�  �B  �B � A� +C� kA����A B A ��  �B  � K� � kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               }PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1600251,waitTime = 2000;��       PlayEffectAGridPos,effectID=160025404,gridPosX=5,gridPosY=5; PlayAudio,audioID = 2551,audioType=1; PlayCasterBindEffect,effectID=160025402; Wait,waitTime=2000; PlayCasterVisible,visible=0; PlayCasterHUDVisible,visible=0; Wait,waitTime=4500; PlayEffectByTrainDir, effectID=160025403; Wait,waitTime=2700; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; Wait,waitTime=2000; �       a PlayCasterAnimation,animName=AtkUlt; Wait,waitTime=8950; PlayCasterAnimation,animName=AtkUlt1; �      � PlayTrainEffect, effectID=160025401; Wait,waitTime=3100; PlayTrainAttack, AttackCount=10, OneDamageTime=33, RandomPercent=10; Wait,waitTime=1000;       ��       DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,isRotate=1,label=playRangeEffect; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;         G                                                                                                                                                                                                         	   	   	   	   	      key	   G   configB   G      _ENV