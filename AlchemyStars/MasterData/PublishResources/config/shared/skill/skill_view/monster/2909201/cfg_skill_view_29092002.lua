LuaS �

xV           (w@`@../PublishResources/config/shared/skill/skill_view/monster/2909201/cfg_skill_view_29092002.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� B  AB  � �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �       PlayAudio,audioID = 290920103,audioType=1; PlayCasterAnimation,animName=Atk02; Wait,waitTime=567; PlayCasterBindEffect,effectID=290920101; PlayTeleportAsMoving,speed=33; PlayRoleTeleport,type=9; Wait,waitTime=100; PlayCasterAnimation,animName=Atk02_2; Wait,waitTime=2000; �      � DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290920112,turnToTarget=0,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; �DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=29092006,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=1000;        0                                                                                                                                                      key   0   config+   0      _ENV