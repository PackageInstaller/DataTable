LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1502051/cfg_skill_view_2002053.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� B  AB  � �� � �B� +A�K��� �� � A�  �B  �� � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayAudio,audioID = 2660,audioType=1; PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID=150205112; Wait,waitTime=3000; L      � DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � PlayPet1502051ChainTrajectory,trajectoryEffectID=150205113,hitEffectID=0,hitAnimName=Hit,turnToTarget=1,deathClear=0,flyLength=2,singleGridTime=400; �       DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=wait,label=checkbuff; PlayTargetAddBuff,buffEffectType =4202053; PlayTargetAddBuff,buffEffectType =4262053; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff;        ;                                                                                                                                                                                       key   ;   config6   ;      _ENV