LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/role/1602291/cfg_skill_view_300229.lua         G     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � B  A�  �� ��  �B� +A�K��� ��  AB  ��  �� � AC +C� kA����A B A �B  ��  � K� �� kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               ~PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600961,waitTime = 2000;� PlayAudio,audioID = 160227104,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=160227110; PlayEffectAGridPos,effectID=160227109,gridPosX=5,gridPosY=4; �      ��      DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160227111,label=playRangeEffect,bindCaster=1; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;��      DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlaySummonTrap,trapID=2803501,label=playRangeEffect; PlayGridRangeConvert,dataSource=4; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=3000; � DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=doAgain; PlayTargetAddBuff,buffID=410227107; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;         G                                                                                                                                                                                                         	   	   	   	   	      key	   G   configB   G      _ENV