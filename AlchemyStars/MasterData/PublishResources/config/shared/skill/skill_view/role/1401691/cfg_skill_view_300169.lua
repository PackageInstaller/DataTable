LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1130/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1401691/cfg_skill_view_300169.lua         G     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  �� ��  �B� +A�K��� ��  A�  �B  �B � A� +C� kA����A B A ��  �B  C K� �� kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir                PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1500551,waitTime = 2000; �&       PlayTurnToPickUpDirection; PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 2547,audioType=1; PlayCasterBindEffect,effectID=140169108; PlayCasterBindEffect,effectID=140169111; Wait,waitTime=700; PlayCasterBindEffect,effectID=140169109; Wait,waitTime=1000; PlayModifyTimeScale,type=0; �      � DataSelectDamage,damageStageIndex=1,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; �      �       DataSelectDamage,damageStageIndex=2,damageIndex=1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=140169110,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=10011,label=buffAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain;         G                                                                                                                                                                                                         	   	   	   	   	      key	   G   configB   G      _ENV