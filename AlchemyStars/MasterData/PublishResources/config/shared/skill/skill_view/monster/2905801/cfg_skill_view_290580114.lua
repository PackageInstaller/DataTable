LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2905801/cfg_skill_view_290580114.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A� �� � �B� �@��AA �A �� B  AB  �B �� � �B� +A�K��� �� � AB  �B  �� � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterBindEffect,effectID = 290580109; PlayAudio,audioID =290580105,audioType=1; Wait,waitTime=1150; PlayCameraEffect,effectID=290580110; Wait,waitTime=6000; � PlayCasterAnimation,animName=Atk4; Wait,waitTime=3300; Wait,waitTime=1000; PlayCasterAnimation,animName=Atk4_1; Wait,waitTime=1167; �      � DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=29058014, PlayTargetAddBuff,buffID=29058013,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV