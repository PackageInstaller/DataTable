LuaS �

xV           (w@O@../PublishResources/config/shared/skill/skill_view/cfg_skill_view_5000251.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A� �� � �B� �@��AA �A �� B  A�  �� �� C �B� +A�K��� �� � A�  �B �� � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterEffectHolder,effHolderType=Idle,isShow=0; PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=280; Wait,waitTime=1000; � DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=283,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; ��        Wait,waitTime=50; DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=283,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1500; K PlayCasterTrapRound; PlayCasterEffectHolder,effHolderType=Idle,isShow=1;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV