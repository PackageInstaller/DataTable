LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1600771/cfg_skill_view_3000773.lua         1     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � B  A�  �� ��  �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600771,waitTime = 2000; �H       PlayAudio,audioID = 2566,audioType=1; PlayCasterBindEffect,effectID =160077307; PlayCasterAnimation,animName = AtkUlt; PlayCasterSubMaterialAnim,nodeName=1600773_weapon,animName=eff_1600773_atkult_weapon_s; PlayEffectAGridPos,effectID=160077306,gridPosX=5,gridPosY=4; PlayCameraEffect, effectID=160077308; Wait,waitTime=7800; H      ��      DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; PlayAudio,audioID = 2567,audioType=1; PlayGridRangeEffect,effectID=160077305; Wait,waitTime=600; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;         1                                                                                                                                                         key	   1   config,   1      _ENV