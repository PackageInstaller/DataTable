LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/b/170/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1601411/cfg_skill_view_2001411.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� �  AB  �� �� C �B� +A�K��� �� � A�  �B  �� � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               v PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =3288; PlayAudio,audioID = 2405,audioType=1; �3       Jump,condition=CheckDamageSkillResultTargetCount,param=2|1,goto=phaseEnd; DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=3290; Jump,condition=CheckDamageIndexValid; Wait,waitTime=1300; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3291,turnToTarget=1,deathClear=0; PlayAudio,audioID = 2406,audioType=1; Wait,waitTime=300; DataSelectNextDamage; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3292,turnToTarget=1,deathClear=0; PlayAudio,audioID = 2406,audioType=1; Wait,waitTime=1000; PlayModifyTimeScale,type=0; �        Jump,condition=CheckDamageSkillResultTargetCount,param=2|2,goto=phaseEnd; DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=3289,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1300; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3291,turnToTarget=1,deathClear=0,label=hitAgain; PlayAudio,audioID = 2406,audioType=1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=hitAgain; Wait,waitTime=1000; PlayModifyTimeScale,type=0; �	       PlayModifyTimeScale,type=0;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV