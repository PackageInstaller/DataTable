LuaS �

xV           (w@^@../PublishResources/config/shared/skill/skill_view/trap/2800511/cfg_skill_view_400500421.lua         S   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� �  A�  �� �� � �B� +A�K��� �� � A�  �B �� � A� +C� kA����A B A ��  �B � KC  �� �� �C� J����A���� A� �� ��  C A� �� �� �C� �A�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               S PlayCasterBindEffectWithTeleportDir,effectID=3251; PlayTeleportAsMoving,speed=2; �      x PlayAudio,audioID=8005,audioType=1; PlayCasterLaserGunAndExtend,effectID=3250,extendEffectID=3248,extendWaitTime=700; � DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3311,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=20011; PlayTargetAddBuff,buffID=888450042; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; &       effectIDList�       Wait,waitTime=1000;         S                                                                                                                                                                                                                                          	   
   
   
   
   
      key   S   configN   S      _ENV