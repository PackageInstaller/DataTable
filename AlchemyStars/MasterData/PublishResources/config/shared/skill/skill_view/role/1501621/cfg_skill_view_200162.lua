LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1105/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1501621/cfg_skill_view_200162.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� B  AB  �� �� � �B� +A�K��� �� � AB  �B  �� � A +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID=3735; PlayAudio,audioID = 2491,audioType=1; Wait,waitTime=5500; �      � DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=3736,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; �      � DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=4001623,label=doAgain; PlayTargetAddBuff,buffID=4001624; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV