LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2004801/cfg_skill_view_200480103.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ��       PlayAudio,audioID = 6036,audioType=1; PlayCasterBindEffect,effectID=200480102; PlayCasterAnimation,animName=Skill_1; PlayRoleTeleport, type=3; PlayFlyEffectCasterToTarget,flyEffectID=200480104,flyTime=270,flyTrace=1,teleportPosAsTarget=1,finalWaitTime=100,isBlock=0; Wait,waitTime=260; PlayRoleTeleport, type=5,onlySelf=1; PlayRoleTeleport, type=6; PlayCasterAnimation,animName=Skill_2; �       � DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200480103,turnToTarget=1,deathClear=false,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;         %                                                                                                                     key   %   config    %      _ENV