LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/role/1600051/cfg_skill_view_281001.lua         ]   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� �  AB  �� �� C �B� +A�K��� �� � A�  �B  �� � A� +C� kA����A B A ��  �� C K� J�C�JC��JCF�J�F�JCG�J�G�J�C�J�ÐJ�H�JCI��A���� A� ��	 �B  C A�	 �� �CJ���J���Õ�CK���K��L��A�k@ � � �      �  & � 1   ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1600051,waitTime = 2000;�       Jump,condition=CheckMiyaPhase2,result=1,goto=phaseEnd; PlayCasterAnimation,animName = AtkUlt01; PlayAudio,audioID = 2190,audioType=1; Wait,waitTime=1000; PlayCasterBindEffect,effectID=354; Wait,waitTime=700; Wait,waitTime=1400; Wait,waitTime=1200; Wait,waitTime=1400; �U       Jump,condition=CheckMiyaPhase2,result=0,goto=phaseEnd; PlayCasterAnimation,animName = AtkUlt02; PlayAudio,audioID = 2190,audioType=1; Wait,waitTime=1000; PlayCasterBindEffect,effectID=354; Wait,waitTime=1400; Wait,waitTime=1200; PlayCasterBindEffect,effectID=355; Wait,waitTime=1700; PlayCasterBindEffect,effectID=356; Wait,waitTime=3300; �      ��       DataSelectScopeGridRange; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=357,isRotate=1,label=playRangeEffect; PlayPopStarResult; Wait,waitTime=33; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;        �       targetTypetrajectoryTypegridEffectIDg      
startHigh      �?endHigh333333�?flyTotalTimed       finishDelayTimedeltaAnglecastEndEffectIDf      audioID�             �      hitAnimHit�      audioWaitTimehitEffectIde      attackIntervalTime^      �              ]                                                                                                                                                                                                                                                                        	   
   
   
   
   
      key   ]   configX   ]      _ENV