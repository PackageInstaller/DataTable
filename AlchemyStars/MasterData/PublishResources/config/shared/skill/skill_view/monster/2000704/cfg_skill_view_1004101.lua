LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2000704/cfg_skill_view_1004101.lua         =   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  � ��  B  A� �B  �� � �B� ���@��AA �A �� B  A�  �� ��  �B� +A�K��� �� � A�  �B �� � AC +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �k       Jump,condition=CheckHasTeleport,param=0,goto=phaseEnd; PlayTurnToTeleportNewPos; PlayCasterBindEffect,effectID=2544; PlayCasterAnimation,animName = Skill01; PlayAudio,audioID = 7031,audioType=1; Wait,waitTime=100; PlayCasterBindEffect,effectID=2545; PlayCasterAnimation,animName = Skill01_2; PlayAudio,audioID = 6044,audioType=1; PlayTeleportAsMoving,speed=12; &       effectIDList�	      2       ��       DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCasterTurnToTarget; PlayCasterAnimation,animName = Skill01_3; PlayCasterBindEffect,effectID=2546; Wait,waitTime=1600; PlayFlyEffectCasterToTarget,flyEffectID=2547,flySpeed=150,flyTrace=1,offsety=0.76,offsetz=0.88,flyEaseType=InCirc,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2548,turnToTarget=1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=2000704; Wait,waitTime=1000; & PlayCasterAnimation,animName =Idle;         =                                                                                                                                                                                             key   =   config8   =      _ENV