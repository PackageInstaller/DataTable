LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/role/1601531/cfg_skill_view_200153.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� B  AB  �� �� � �B� +A�K��� �� � AB  �B  � � AC +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �g       PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID=160153101; PlayCasterBindEffect,effectID=160153102; PlayAudio,audioID = 2461,audioType=1; Wait,waitTime=1000; PlayShaderSetGlobalFloat,paramName=H3DDarkLevel,value=0.5,duration=200; Wait,waitTime=950; PlayCameraEffect,effectID=160153105; Wait,waitTime=1500; PlayModifyTimeScale,type=0; �      � DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=160153103,hitEffectIDBodyAreaMoreThanOne=160153104,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; `	      � DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; �      I PlayShaderSetGlobalFloat,paramName=H3DDarkLevel,value=0,duration=1200;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV