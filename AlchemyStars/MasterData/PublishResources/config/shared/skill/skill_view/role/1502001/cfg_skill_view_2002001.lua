LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1502001/cfg_skill_view_2002001.lua         <     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � �A  B  A� �� �� �B� �@��AA �A � B  AB  � �� C �B� +A�K��� ��  AB  �B  �� � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               ��       PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2640,audioType=1; PlayCasterBindEffect,effectID = 150200103; PlayCasterBindEffect,effectID = 150200106; Wait,waitTime = 2000; DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 150200105,flyTime = 750,flyTrace = 1,isBlock =0,overtakeDis=0.5,finalWaitTime = 1000,label=hitAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=hitAgain; Wait,waitTime = 1600; �
      � DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayTargetBeHitEffect,hitEffectID=150200104,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; �      � DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime = 1000; �      � DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=150200114,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime = 1000;         <                                                                                                                                                                                          key	   <   config7   <      _ENV