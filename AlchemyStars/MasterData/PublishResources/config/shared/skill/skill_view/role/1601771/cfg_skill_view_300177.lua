LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/role/1601771/cfg_skill_view_300177.lua         1     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  �� ��  �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1601551,waitTime = 2000;��       PlayCasterBindEffect,effectID =160177108; PlayCasterAnimation,animName = AtkUlt; PlayEffectAGridPos,effectID=160177109,gridPosX=5,gridPosY=4; PlayCasterBindEffect,effectID =160177110; PlayCameraEffect, effectID=160177111; PlayAudio,audioID = 2571,audioType=1; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=wait,label=checkbuff; PlayTargetAddBuff,buffEffectType =3001770; PlayTargetAddBuff,buffEffectType =300177; PlayTargetAddBuff,buffEffectType =330177; PlayTargetAddBuff,buffEffectType =3301771; PlayTargetAddBuff,buffEffectType =3001777; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff; Wait,waitTime=5000; �      �H       DataSelectScopeGridRange,effectType=11; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=160177104,label=playRangeEffect; PlaySummonTrap,trapID=14; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1000;         1                                                                                                                                                         key	   1   config,   1      _ENV