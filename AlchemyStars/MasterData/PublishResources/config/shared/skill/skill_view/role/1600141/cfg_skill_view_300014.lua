LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/b/170/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1600141/cfg_skill_view_300014.lua         F   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� �  A�  �B �� � �B� +A�K��� �� � A�  �B �� � A +C� kA����A B A� ��  �B C K� �� kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1600141,waitTime = 2000; � PlayCasterAnimation,animName = AtkUlt01; PlayAudio,audioID = 2172,audioType=1; PlayCasterBindEffect,effectID =1755; Wait,waitTime=500; PlayCasterBindEffect,effectID =452; PlayCasterVisible,visible=0; �      �"       DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCasterEffectAtTargetPos,effectID=453,randomDir=1,label=doAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=200; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; L      � PlayCasterVisible,visible=1; PlayCasterAnimation,animName = AtkUlt02; PlayCasterBindEffect,effectID =454; Wait,waitTime=3500;       � DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;         F                                                                                                                                                                                                      	   	   	   	   	      key   F   configA   F      _ENV