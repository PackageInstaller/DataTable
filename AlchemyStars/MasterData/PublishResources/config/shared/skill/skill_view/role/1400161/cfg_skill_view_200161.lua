LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/b/170/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1400161/cfg_skill_view_200161.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� B  A�  �� �� � �B� +A�K��� �� � AB  �B �� � A +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               j PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =1064; PlayAudio,audioID = 3008; 	      � DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1065,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=200; �       DataSelectResult,effectType=80,index=1; PlaySplashDamage,hitAnimName=Hit,hitEffectID=1065,turnToTarget=true,gridEffectID=1064,label=splashAgain; DataSelectNextResult,effectType=80; Jump,condition=CheckEffectResultIndex,param=80,goto=splashAgain; Wait,waitTime=1100; �      PlayAudio,audioID = 7003;        ;                                                                                                                                                                                       key   ;   config6   ;      _ENV