LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1602301/cfg_skill_view_3002303.lua         <     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  �� ��  �B� +A�K��� ��  A�  �B  �B � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1401371,waitTime = 2000;�T       PlayAudio,audioID = 160230103,audioType=1; PlayCasterAnimation,animName=AtkUlt; PlayCameraEffect,effectID=160230112; PlayCasterBindEffect,effectID=160230105; DataSelectDamage,damageIndex=1; PlayTurnToPickUpDirection; PlayGridDark,darkType=2,duration=0.25,endValue=0.5; Wait,waitTime=700; PlayGridDark,,darkType=2,duration=0.8,endValue=1; �      �       DataSelectDamage,damageIndex=1; PlayFlyEffectCasterToTarget,flyEffectID = 160230109,flyTrace = 1,offsetx=0,offsety=0.84,offsetz=0,flyTime=130,targetPos=Hit,isBlock=0,finalWaitTime=1000,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;:      � DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160230107,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;         <                                                                                                                                                                                          key	   <   config7   <      _ENV