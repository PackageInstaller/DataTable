LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2905801/cfg_skill_view_290580102.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterAnimation,animName=Atk2; PlayAudio,audioID =290580103,audioType=1; PlayCasterBindEffect,effectID=290580104; Wait,waitTime=3200; :      �V       DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 290580105,flyTime=200,flyTrace = 1,offsetx=-0.134,offsety=1.529,offsetz=0.33,targetPos=Root ; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290580106,turnToTarget=0,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;         %                                                                                                                     key   %   config    %      _ENV