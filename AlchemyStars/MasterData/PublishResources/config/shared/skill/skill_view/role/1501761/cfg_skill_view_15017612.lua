LuaS �

xV           (w@]@../PublishResources/config/shared/skill/skill_view/role/1501761/cfg_skill_view_15017612.lua         R     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � B  A�  �� ��  �B� +A�K��� ��  AB  ��  �B � A� +C� kA����A � A �B  ��  C K� �� kC� �A���� AB � �B  �  AC �� � �C� �A�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1601431,waitTime = 2000; � PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2559,audioType=1; PlayCasterBindEffect,effectID=150176108; PlayCasterBindEffect,effectID=150176109; �      � DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=150176110,randomDir=1,randomMin=0,randomMax=180,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; �      � DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; PlayChangeBuffLayer;#PlayTargetAddBuff,buffID=15017619;        R                                                                                                                                                                                                                                       	   
   
   
   
   
      key	   R   configM   R      _ENV