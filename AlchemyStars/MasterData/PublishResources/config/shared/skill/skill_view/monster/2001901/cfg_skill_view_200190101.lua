LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1140/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2001901/cfg_skill_view_200190101.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� B  A�  �� �� � �B� +A�K��� �� � A�  �B �� � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterTurnToPlayer; PlayCasterAnimation,animName=Skill01_a; PlayCasterBindEffect,effectID=200190101; Wait,waitTime=400; PlayAudio,audioID =7014,audioType=1; Wait,waitTime=1000; PlayCasterAnimation,animName=Skill01_b; PlayTeleportAsMoving,speed=25; @      � DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200190102,turnToTarget=1,deathClear=0; PlayCasterAnimation,animName=Skill01_c; Wait,waitTime=1000; � DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1,remove=1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; �N       DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID2; PlayTargetAddBuff,buffID=PARAM.buffID3; PlayTargetAddBuff,buffID=PARAM.buffID4; PlayTargetAddBuff,buffID=PARAM.buffID5; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV