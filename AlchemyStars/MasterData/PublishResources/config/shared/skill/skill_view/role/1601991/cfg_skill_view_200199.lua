LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/role/1601991/cfg_skill_view_200199.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� B  AB  �� �� � �B� +A�K��� �� � AB  �B  � � AC +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �       Wait,waitTime=100; PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =160199104; PlayAudio,audioID = 2633,audioType=1; PlayCasterLineToTarget,lineEffectID=160199105,lineOnCaster=Bip001 Prop1,lineOnTarget=Hit,lineEffectDuration=1600; Wait,waitTime=1850; d       �9       DataSelectDamage,damageIndex=1,damageStageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayTargetBeHitEffect,hitEffectID=160199106,label=doAgain; Wait,waitTime=1530; PlayTargetBeHitEffect,hitEffectID=160199107; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; �      � DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 160199111,flyTime = 130,flyTrace = 1,isBlock =0,targetPos=Hit; DataSelectNextDamage; �      �       DataSelectDamage,damageIndex=1,damageStageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV