LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/role/1400481/cfg_skill_view_300048.lua         `   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  ��  ��  B  A� �� �BD���D���C���Ê��C��B���@��AA �A � �  AB  �B ˂  ��F��B@�+A�K��� �� � A�  �B  �B � A� +C� kA����A B A� ��  �B  � K� � kC� �A���� A� �� ��  C  AC �� �� �C� �A��AB �B �� �  AC  �C �� � �C� +B�k@�� � �      �  & � $   ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1400481,waitTime = 2000;effectparam501castAnimationNameAtkUltfinishDelayTimebuffDelayTimebuffNeedImmediatelyEffectrotateToCenter+       B       audioID�      
audioType�      } PlayFlyEffectCasterToTarget,flyEffectID = 1055,flyTime = 150,flyTrace = 1,originalBoneName= Bone070,targetPos= EffectSlot;       � PlaySelectCenterGridEffect,effectID=503,intervalTime=0; Wait,waitTime=1150; PlaySelectCenterGridEffect,effectID=50301,intervalTime=0; �      � DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=50300,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=50300,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;         `                                                                                                                                                                                                                                                   	   	   	   	   	   	   	   	   	   	   
                     key   `   config[   `      _ENV