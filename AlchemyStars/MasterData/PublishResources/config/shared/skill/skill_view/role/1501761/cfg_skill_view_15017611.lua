LuaS �

xV           (w@]@../PublishResources/config/shared/skill/skill_view/role/1501761/cfg_skill_view_15017611.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� B  AB  �� �� � �B� +A�K��� �� � AB  �� � � AC +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =150176103; PlayCasterBindEffect,effectID =150176104; PlayCasterBindEffect,effectID =150176105; PlayAudio,audioID = 2558,audioType=1; Wait,waitTime=3300; �      � DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=150176106,randomDir=1,randomMin=0,randomMax=180,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; �      � DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,deathClear=0,label=doAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; �        PlayChangeBuffLayer;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV