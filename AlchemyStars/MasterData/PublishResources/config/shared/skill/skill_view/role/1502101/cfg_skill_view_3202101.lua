LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1502101/cfg_skill_view_3202101.lua         h     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  �� ��  �B� +A�K��� ��  A�  �B  �B � A� +C� kA����A B A ��  �B  C K� �� kC� �A���� A� � ��  C  A �� �C �C� �A��AB �B � �  AC  �� �� � �C� +B�K��� ��  A�  �C  � � AD +D� kB�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir                PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1500551,waitTime = 2000; ��       PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayAudio,audioID = 2689,audioType=1; PlayCasterBindEffect,effectID=150210108; PlayCasterBindEffect,effectID=150210105; PlayCasterBindEffect,effectID=150210106; Wait,waitTime=800; PlayCasterAnimation,animName=AtkUlt; Wait,waitTime=250; PlayTeleportAsMoving,speed=25; PlayRoleTeleport,type=9; PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0,useResultPosCalcDir=1; PlayCasterAnimation,animName=AtkUlt3; Wait,waitTime=2000; R      )PlayCasterBindEffect,effectID=150210109;�      � DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=150210107,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; �       DataSelectDamageIndex,damageIndex=1,damageStageIndex=2; PlayCommonBeHitByDamageIndex,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain1; Wait,waitTime=50; DataSelectNextDamageIndex; Jump,condition=CheckDamageIndex2Valid,goto=doAgain1; Wait,waitTime=500; �      �       DataSelectDamageIndex,damageIndex=1,damageStageIndex=3; PlayCommonBeHitByDamageIndex,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain2; Wait,waitTime=50; DataSelectNextDamageIndex; Jump,condition=CheckDamageIndex2Valid,goto=doAgain2; Wait,waitTime=500; ~      � DataSelectDamage,damageIndex=1,damageStageIndex=3; DataSelectNextDamage,label=doAgain5; Jump,condition=CheckDamageIndexValid,goto=doAgain5; PlayCasterBindEffect,effectID=150210110; Wait,waitTime=500; x      � DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=40021001,label=doAgain6; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain6;         h                                                                                                                                                                                                                                          	   	   	   	   	   	   	   	   	   	   	   
   
   
   
   
   
   
   
   
   
                        key	   h   configc   h      _ENV