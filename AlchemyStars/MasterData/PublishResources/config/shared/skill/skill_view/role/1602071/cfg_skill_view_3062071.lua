LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1602071/cfg_skill_view_3062071.lua         R     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  �� ��  �B� +A�K��� ��  A�  �B  �B � A� +C� kA����A � A ��  �B  C K� �� kC� �A���� AB � ��  C  A �� �C �C� �A�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               ~PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1601201,waitTime = 2000;�       PlayAudio,audioID = 2673,audioType=1; PlayCasterBindEffect,effectID=160207104; PlayCasterBindEffect,effectID=160207105; PlayCasterSubMaterialAnim,nodeName=1602071_body02,animName=effanim_1602071_atkult; PlayCasterAnimation,animName=AtkUlt; Wait,waitTime=1800; l      T PlayEffectAtPickUpDirByCount,effectID=160207107,pickUpIndex=1,dirX=-1|0,dirY=0|1;       ��      DataSelectScopeGridRange,effectType=211; DataSortScopeGridRange,sortType=18; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160207106,isRotate=0,label=playRangeEffect; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=650; ��      DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=650; `	        PlayPickUpGridTogetherEffect;         R                                                                                                                                                                                                                                       	   
   
   
   
   
      key	   R   configM   R      _ENV