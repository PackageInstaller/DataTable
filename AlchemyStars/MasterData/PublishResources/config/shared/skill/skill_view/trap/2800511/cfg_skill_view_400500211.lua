LuaS �

xV           (w@^@../PublishResources/config/shared/skill/skill_view/trap/2800511/cfg_skill_view_400500211.lua         `   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� �  A�  �� �� � �B� +A�K��� �� � A�  ��  �� � A� +C� kA����A B A ��  �B � KC  �� �� �C� J����A���� A� �� ��  C A� �� �� �C� �A��AB �B � �  A�  �� � ʃƌʃÍ�CG�ʃC�+B�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               S PlayCasterBindEffectWithTeleportDir,effectID=3251; PlayTeleportAsMoving,speed=2; �      x PlayAudio,audioID=8005,audioType=1; PlayCasterLaserGunAndExtend,effectID=3249,extendEffectID=3247,extendWaitTime=700; � DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3310,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=PARAM.buffID1,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; &       effectIDList�       Wait,waitTime=1000; $       gridEffectID�D�    gridEffectDelayTimegridIntervalTime
       showTimeDelay        `                                                                                                                                                                                                                                             	   	   	   	   	   	   	   	   	   	   	   	   
                     key   `   config[   `      _ENV