LuaS �

xV           (w@Y@../PublishResources/config/shared/skill/skill_view/autobead/cfg_skill_view_20050029.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K�  JBD�JB@��@�� ��  A�  �� �A  B  A� �� �� �B� �@��AA �A �� B  AB  � �� C �B� +A�K��� �� � AB  �B  � � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       +               audioID�#      
audioType@ PlayEffectAtCasterPos,effectID=200500108; Wait,waitTime=1500; �      � DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=10021,label=buffAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV