LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1601531/cfg_skill_view_2001531.lua         F   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� B  AB  �� �� � �B� +A�K��� �� � AB  �B  �� � A +C� kA����A B A� �B  �B  C K� �� kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �g       PlayAudio,audioID = 2461,audioType=1; PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID=160153101; PlayCasterBindEffect,effectID=160153102; Wait,waitTime=1000; PlayShaderSetGlobalFloat,paramName=H3DDarkLevel,value=0.5,duration=200; Wait,waitTime=950; PlayCameraEffect,effectID=160153105; Wait,waitTime=1500; PlayModifyTimeScale,type=0; �      �!       DataSelectDamage,damageIndex=1,damageStageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayTargetBeHitEffect,hitEffectID=160153103,hitEffectIDBodyAreaMoreThanOne=160153104,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; `	      �       DataSelectDamage,damageIndex=1,damageStageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � DataSelectDamage,damageIndex=1,damageStageIndex = 2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; �      I PlayShaderSetGlobalFloat,paramName=H3DDarkLevel,value=0,duration=1200;         F                                                                                                                                                                                                      	   	   	   	   	      key   F   configA   F      _ENV