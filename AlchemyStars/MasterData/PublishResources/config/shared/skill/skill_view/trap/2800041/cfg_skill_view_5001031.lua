LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/trap/2800041/cfg_skill_view_5001031.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A� �� � �B� �@��AA �A �� B  A�  �� �� C �B� +A�K��� �� � AB  �B �� � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterAnimation,animName = Atk; PlayAudio,audioID = 5076,audioType=1; PlayCasterBoneSRT, bone=Control, SRT=T, to=0|0|0, duration=100; PlayAudio,audioID=2056; PlayCasterBindEffect,effectID=534; PlayCasterBindEffect,effectID=533; Wait,waitTime=500; � DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0, label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0, label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � PlayCasterEffectHolder,effHolderType=Idle,isShow=1; PlayCasterEffectHolder,effHolderType=Charge,isShow=0; Wait,waitTime=1000; PlayCasterTrapRound;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV