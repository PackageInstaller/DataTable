LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1602061/cfg_skill_view_3002061.lua         R     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  �� ��  �B� +A�K��� ��  A�  �B  �� � AC +C� kA����A B A ��  �B  � K� �� kC� �A���� A� � ��  C  A� �� � �C� �A�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               ~PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600061,waitTime = 2000;x PlayCasterBindEffect,effectID = 160206105; PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 2669,audioType=1;        dPlayCameraEffect,effectID=160206109; PlayEffectAtPickUpIndexGrid,effectID=160206106,pickUpIndex=1; ��      DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; PlayEffectOffsetScopeCenter,effectID=160206107,offset=0|0; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160206108,label=playRangeEffect; PlayGridRangeEffect,effectID=160206111; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; DataSortScopeGridRange,sortType=6; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=160206110; DataSelectScopeGridRangeLast; PlayGridRangeEffect,effectID=160206110,offset=0|1; �      � DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0,label=doAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; ��      DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=18; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; PlayGridRangeEffect,effectID=160206104; Wait,waitTime=50; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1000;        R                                                                                                                                                                                                                                       	   
   
   
   
   
      key	   R   configM   R      _ENV