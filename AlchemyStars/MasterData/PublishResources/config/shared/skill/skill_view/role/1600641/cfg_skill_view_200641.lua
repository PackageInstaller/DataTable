LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1600641/cfg_skill_view_200641.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� B  AB  �� �� � �B� +A�K��� �� � AB  �B � � AC +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               j PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =1790; PlayAudio,audioID = 2213; �      �       DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1791,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=200; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=2000; �      � DataSelectResult,effectType=80,index=1; PlaySplashDamage,hitAnimName=Hit,hitEffectID=0,turnToTarget=true,gridEffectID=1791,label=splashAgain; DataSelectNextResult,effectType=80; Jump,condition=CheckEffectResultIndex,param=80,goto=splashAgain; �      PlayAudio,audioID = 7003;        ;                                                                                                                                                                                       key   ;   config6   ;      _ENV