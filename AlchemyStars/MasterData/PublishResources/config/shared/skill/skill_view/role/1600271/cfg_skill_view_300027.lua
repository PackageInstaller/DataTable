LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/role/1600271/cfg_skill_view_300027.lua         \   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �A �  AB  �� ˂  ��D��B@�+A�K��� �� � A�  �B  �B � A� +C� kA����A B A� ��  �B  � K� � kC� �A���� A� �� ��  C  A� �� �C �C� �A��AB �B �� �  A�  �� �� � �C� +B�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1600271,waitTime = 2000;��       PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayCasterAnimation,animName = AtkUlt1; PlayCasterBindEffect,effectID = 1817; Wait,waitTime = 700; PlayRoleTeleport, type=3; PlayRoleTeleport, type=5, onlySelf=0; Wait,waitTime=33; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0,useResultPosCalcDir=1; PlayCasterAnimation,animName=AtkUlt2; Wait,waitTime=50; PlayCasterBindEffect,effectID = 1819; Wait,waitTime=1950; +       audioID$      
audioTypeX      ; PlayCasterToPickupTrajectory,effectID=1818,flyTime=1000; �      � DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1820,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=4300271,label=doAgain; PlayAddBuffView,buffID=4300272; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;         \                                                                                                                                                                                                                                       	   	   	   	   	   	   	   	   	   	   
                     key   \   configW   \      _ENV