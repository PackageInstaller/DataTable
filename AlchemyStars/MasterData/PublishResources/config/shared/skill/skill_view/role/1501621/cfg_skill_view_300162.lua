LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1105/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1501621/cfg_skill_view_300162.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� �  AB  �B �� � �B� +A�K��� �� � A�  �B  �B � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1601341,waitTime = 2000;� PlayPlayerRotateToPickup; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2492,audioType=1; PlayCasterBindEffect,effectID = 3737; Wait,waitTime=800; PlayCasterBindEffect,effectID = 3738; Wait,waitTime=2000; f      � DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=4001624,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV