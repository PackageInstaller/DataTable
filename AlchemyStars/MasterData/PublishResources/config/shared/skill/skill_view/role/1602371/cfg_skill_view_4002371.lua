LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1602371/cfg_skill_view_4002371.lua         &     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � �A  B  A� �� �� �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               ^ PlayCasterLegacyAnimation,animNames=effanim_1602371_beidong_main_out; Wait,waitTime = 1000; d       �'       DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 160237103,flyTime = 300,flyTrace = 1,offsety=0.77,targetoffsety=0.77,isBlock =0,label=hitAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=hitAgain; Wait,waitTime = 170; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160237104,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime = 200; DataSelectResult,effectType=79,index=1; PlayDestroyTrap;         &                                                                                                                        key	   &   config!   &      _ENV