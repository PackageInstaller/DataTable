LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/160/client/Assets/../PublishResources/config/shared/skill/skill_view/trap/2800531/cfg_skill_view_281053110.lua         F   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  � A� �� � �B� �@��AA �A �� �  AB  �B �� � �B� +A�K��� �� � A�  �B �� � A� +C� kA����A B A� ��  �B � K� � kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterTrapRoundShow,visible=0,text=!; PlayCasterAnimationCleanTrigger,animName=Skill01; PlayCasterAnimationCleanTrigger,animName=Skill01_Exit; PlayCasterAnimation,animName = Skill01; PlayAudio,audioID=8003,audioType=1; @ PlayTargetAddBuff,buffID=30181,remove=1,label=RemoveBossBuff; �       � PlayCasterBindEffect,effectID=3358; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � DataSelectDamage,damageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=dodamage; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=dodamage; h PlayTargetAddBuff,buffID=28005313; PlayTargetAddBuff,buffID=28005314; PlayTargetAddBuff,buffID=30181;         F                                                                                                                                                                                                      	   	   	   	   	      key   F   configA   F      _ENV