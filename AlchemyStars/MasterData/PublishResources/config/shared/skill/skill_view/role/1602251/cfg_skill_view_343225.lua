LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/role/1602251/cfg_skill_view_343225.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �A �  AB  �� ˂  ��D��B@�+A�K��� �� � A�  �B  �B � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam                PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1501351,waitTime = 2000;� PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID = 3221; Wait,waitTime=1600; PlayCasterBoneRotationByPickSector,bone=Root,absAngle=45,duration=2000; Wait,waitTime=1000; +       audioIDO	      
audioType@      ��       DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=14,sortParam=9|45; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=3222,turnToTarget=1,deathClear=0,label=playRangeEffect1; Wait,waitTime=320; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect1;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV