LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/role/1601111/cfg_skill_view_300111.lua         G     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  �� ��  �B� +A�K��� ��  A�  �B  �� � AC +C� kA����A B A �B  �B  � K� �� kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1601111,waitTime = 2000;� PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2319,audioType=1; PlayCasterBindEffect, effectID=2641; PlayCameraEffect, effectID=2642; Wait,waitTime=5200; �      � DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=2643,label=doAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; �
      � DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=wait,label=checkbuff; PlayTargetAddBuff,buffEffectType =43011121; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff;        G                                                                                                                                                                                                         	   	   	   	   	      key	   G   configB   G      _ENV