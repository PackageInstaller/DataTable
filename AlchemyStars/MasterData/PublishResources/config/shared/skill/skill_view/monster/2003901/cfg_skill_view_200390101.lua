LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2003901/cfg_skill_view_200390101.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayAudio,audioID = 20039011,audioType=1; PlayCasterTurnToPlayer; PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=200390103; Wait,waitTime=2000;       � DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200390104,turnToTarget=1,deathClear=false,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;         %                                                                                                                     key   %   config    %      _ENV