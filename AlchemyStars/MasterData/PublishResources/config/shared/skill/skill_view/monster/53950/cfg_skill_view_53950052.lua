LuaS �

xV           (w@^@../PublishResources/config/shared/skill/skill_view/monster/53950/cfg_skill_view_53950052.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A� �� � �B� �@��AA �A �� B  AB  �B �� � �B� +A�K��� �� � AB  �B  �� � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterTurnToTargetGrid; PlayCasterAnimation,animName = Skill01; PlayCasterBindEffect,effectID =200380101; PlayAudio,audioID = 5081,audioType=1; Wait,waitTime=1100; PlayCasterBindEffect,effectID =200380104; Wait,waitTime=500; �9       DataSelectDamage,damageIndex=1,damageStageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayTargetBeHitEffect,hitEffectID=200380102,label=doAgain; Wait,waitTime=1100; PlayTargetBeHitEffect,hitEffectID=200380103; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; X      �S       DataSelectDamage,damageIndex = 1,damageStageIndex=1; DataSelectDamageInfo,damageInfoIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=350; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; � DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=5395011,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV